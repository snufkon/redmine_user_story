class UserStoriesController < ApplicationController
  unloadable

  before_filter :find_project

  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
#  include IssuesHelper

  def index
    retrieve_query
    sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
    sort_update(@query.sortable_columns)
        
    logger.info("####################################")
    @stories = []
    @project.issues.each do |issue|
      if issue.tracker.name == "ストーリー"
        @stories << issue
      end
    end

    query = Query.new
    column_names = [:tracker, :status, :priority, :subject, :assigned_to, :updated_on, :done_ratio]
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
