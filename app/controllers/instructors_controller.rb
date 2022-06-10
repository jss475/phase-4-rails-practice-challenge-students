class InstructorsController < ApplicationController

    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::StatementInvalid, with: :statement_invalid

    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: "instructor not found" }, status: :not_found
    end

    def record_invalid(exception)
        render json: { error: exception}, status: :unprocessable_entity
    end

    def instructor_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def statement_invalid
        render json: { error: "instructor statement invalid"}, status: :invalid
    end

end