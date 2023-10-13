class JobsController < ApplicationController
  before_action :check_job_recruiter,except: [:index]
  before_action :set_param, only: [:show, :update, :destroy]
  
  def index
    debugger
    @jobs = Job.all
    render json: @jobs
  end
  
  def show
    byebug
    render json: @job, status: 200
  end
  
  def create
    byebug
    job = @current_user.jobs.new(job_param)
    if job.save
      render json: job, status: 200
    else
      render json: job.errors.full_messages, status: 422
    end  
  end
  
  def update
    byebug
    if @job.update(job_param)
      render json: @job, status: 200
    else
      render json: @job.errors.full_messages,status: 422
    end 
  end
  
  def destroy
    byebug
    if @job.destroy
      render json: { message:"Job post Deleted Succefully!!!", status: 200 }
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
