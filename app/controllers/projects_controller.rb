class ProjectsController < ApplicationController
  def index
    @pagy, @projects = pagy(@current_client.projects.order(created_at: :desc), items: 6)
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
      if @project.save
        # Associate video types
        video_type_ids = params[:project][:video_type_ids].reject(&:blank?)
        @project.video_types = VideoType.find(video_type_ids)

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
