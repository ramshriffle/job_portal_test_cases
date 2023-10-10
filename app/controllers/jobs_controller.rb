class JobsController < ApplicationController
  before_action :check_job_recruiter
  before_action :set_param, only: [:show, :update, :destroy]
  
  def index
    # jobs = @current_user.jobs.page(params[:page]).per(3)
    # render json: jobs
    @jobs = Job.all
    render json: @jobs
  end
  
  def show
    render json: @job
  end
  
  def create
    job = @current_user.jobs.new(job_param)
    if job.save
      render json: { message:"Job Created!!!", data: job }
    else
      render json: job.errors.full_messages
    end  
  end
  
  def update
    if @job.update(job_param)
      render json: { message:"Job Updated!!!" }
    else
      render json: @job.errors.full_messages
    end 
  end
  
  def destroy
    if @job.destroy
      render json: { message:"Job post Deleted Succefully!!!" }
    else
      render json: @job.errors.full_messages
    end 
  end
  
  private
  def job_param
    params.permit(:job_title, :description, :location, :salary)
  end
  
  private
  def set_param
    @job= @current_user.jobs.find_by_id(params[:id])
    unless @job
      render json: "Job not Found"
    end
  end
end
