class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

    def index
        if params[:instructor_id]
            instructor = find_instructor
            students = instructor.students
        else
            students = Student.all
        end
        render json: students, include: :instructor
    end

    def show
        student = find_student
        render json: student, status: :ok
    end

    def create
        if params[:instructor_id]
            instructor = find_instructor
            student = instructor.students.create!(student_params)
            render json: student, include: :instructor, status: :created
        else
            :render_unprocessable_entity_response
        end
    end

    def update
        if params[:instructor_id]
            student = find_student
            student.update!(student_params)
            render json: student, include: :instructor, status: :accepted
        else
            :render_record_not_found_response
        end
    end

    def destroy
        student = find_student
        student.destroy
        render json: {}, status: :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age)
    end

    def find_student
        Student.find(params[:id])
    end

    def find_instructor
        Instructor.find(params[:instructor_id])
    end

    def render_unprocessable_entity_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_record_not_found_response
        render json: {error: "Record not found"}, status: :not_found
    end
end
