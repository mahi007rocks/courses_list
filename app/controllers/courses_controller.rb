class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :update, :destroy]

    def index
      @courses = Course.where(user_id: @current_user.id).as_json
      render json: @courses, status: 200
    end

    def show
      render json: @course, status: 200
    end

    def create
      @course = Course.new(course_params)
      @course.user_id = @current_user.id
      if @course.save
        render json: @course, status: 201
      else
        render json: { errors: @course.errors.full_messages }, status: 503
      end
    end

    def update
      if @course.update(course_params)
        render json: @course, status: 200
      else
        render json: { errors: @course.errors.full_messages }, status: 503
      end
    end

    def destroy
      if @course.destroy
        render json: { message: "Course deleted successfully" }
      end
    end

    private
      def course_params
        params.permit(:name)
      end

      def find_course
        @course = Course.find(params[:id])
      end
end
