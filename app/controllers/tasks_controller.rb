# coding: utf-8
class TasksController < ApplicationController

=begin
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  #-----#
  # day #
  #-----#
  def day
    @task = Task.new
    @tasks = Task.incomp.where( :user_id => session[:user_id], :span => "day" ).limit( LIST_LIMIT ).order( 'priority DESC, added_at DESC' )
  end
  
  #------#
  # week #
  #------#
  def week
    @task = Task.new
    @tasks = Task.incomp.where( :user_id => session[:user_id], :span => "week" ).limit( LIST_LIMIT ).order( 'priority DESC, added_at DESC' )
  end
  
  #-------#
  # month #
  #-------#
  def month
    @task = Task.new
    @tasks = Task.incomp.where( :user_id => session[:user_id], :span => "month" ).limit( LIST_LIMIT ).order( 'priority DESC, added_at DESC' )
  end
  
  #------#
  # comp #
  #------#
  def comp
    @tasks = Task.comp.where( :user_id => session[:user_id] ).limit( LIST_LIMIT ).order( 'completed_at DESC' )
  end

  #--------#
  # create #
  #--------#
  def create
    @task = Task.new( params[:task] )
    @task.user_id = session[:user_id]
    @task.added_at = Time.now

    unless @task.save
      alert = "タスクの作成に失敗しました。"
    end

    redirect_to :action => @task.span, :alert => alert
  end

  #------#
  # done #
  #------#
  def done
    task = Task.where( :user_id => session[:user_id], :id => params[:id] ).first
    result = task.update_attributes( :complete_flag => true, :completed_at => Time.now )
    
    unless result
      alert = "タスクの完了に失敗しました。"
    end
    
    redirect_to :action => task.span, :alert => alert
  end

  #----------#
  # priority #
  #----------#
  def priority
    task = Task.where( :user_id => session[:user_id], :id => params[:id] ).first
    result = task.update_attributes( :priority => params[:priority] )
    
    unless result
      alert = "更新が失敗しました。"
    end
    
    redirect_to :action => task.span, :alert => alert
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    task = Task.where( :user_id => session[:user_id], :id => params[:id] ).first
    result = task.destroy
    
    unless result
      alert = "タスクの作成に失敗しました。"
    end
    
    redirect_to :action => task.span, :alert => alert
  end

end
