class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  def enroll_existing
  @enrollment = Enrollment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def enroll_new
    @person = Person.new
    @enrollment = Enrollment.new
    @enrollment.student = @person
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.course = @course

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to [@course, @enrollment], notice: 'Enrollment was successfully created.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to [@course, @enrollment], notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to [@course, @enrollment], notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def set_course
      if @enrollment and @enrollment.course_id
        @course = @enrollment.course
      else
        @course = Course.find(params[:course_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      is_new = false
      student = params.require(:enrollment)[:student]
      if student == nil
        student = params.require(:enrollment)[:student_attributes]
        is_new = true
      end
      if !is_new
        student = Person.find(student)
      else
        student = Person.new(student[0])
        student.save
      end
      params.require(:enrollment).permit(student_attributes: [:first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation]).merge(:student => student)
    end
end
