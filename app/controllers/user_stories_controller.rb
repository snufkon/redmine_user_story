class UserStoriesController < ApplicationController
  unloadable

  before_filter :find_project

  helper :queries

  def index
    logger.info("####################################")
    @stories = []
    @project.issues.each do |issue|
      if issue.tracker.name == "ストーリー"
        @stories << issue
      end
      logger.info("issue: #{issue.author}")
    end

    query = Query.new
    column_names = [:tracker, :status, :priority, :subject, :assigned_to, :updated_on]
    @columns = []
    column_names.each do |name|
      query.columns.each do |col|
        logger.info("name: #{col.name.class}")
        if col.name == name
          logger.info("## equal ##")
          @columns << col
        end
      end
    end
    logger.info("size: #{@columns.size}")
    logger.info("####################################")
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
  
end
