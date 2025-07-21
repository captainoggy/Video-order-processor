class ProjectsController < ApplicationController
  def index
    @projects = @current_client.projects.order(created_at: :desc)
    @projects = @projects.by_video_type(params[:video_type_id]) if params[:video_type_id].present?
    @projects = @projects.by_price_range(params[:min_price], params[:max_price]) if params[:min_price].present? || params[:max_price].present?
    @projects = @projects.by_creation_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? || params[:end_date].present?

    @pagy, @projects = pagy(@projects, items: 6)
  end

  def new
    @project = Project.new
    @video_types = VideoType.all
  end

  def create
    @project = @current_client.projects.new(project_params)
    @project.pm = Pm.first # Assign default PM
    @project.status = "In Progress"

    Project.transaction do
      if @project.save!
        # Associate video types
        video_type_ids = params[:project][:video_type_ids]&.reject(&:blank?)
        @project.video_types = VideoType.where(id: video_type_ids)
        # Create notification for PM
        NotificationJob.perform_now(@project)
        redirect_to projects_path, notice: "Project was successfully created."
      else
        @video_types = VideoType.all
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :footage_link)
  end
end
