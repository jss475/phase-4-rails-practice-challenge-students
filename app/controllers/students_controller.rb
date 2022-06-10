class StudentsController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::StatementInvalid, with: :statement_invalid

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :updated
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: "Student not found" }, status: :not_found
    end

    def record_invalid(exception)
        render json: { error: exception}, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def statement_invalid
        render json: { error: "Student statement invalid"}, status: :invalid
    end

end
