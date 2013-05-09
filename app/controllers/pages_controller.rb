class PagesController < ApplicationController

  def index
    @page_number = (params[:next_page].to_i || 0 )
    offset = @page_number * 30
    @posts = Post.order("posted_at DESC").limit(30).offset(offset)
    render :index
  end
    
  def search 
    @page_number = (params[:next_page].to_i || 0 )
    offset = @page_number * 30
    @posts = Post.search(params[:q]).order("posted_at DESC").limit(30).offset(offset)
    render :index
  end

  def show_filters

    @sources = Resource.select(:source).uniq
    @phases = ['Prep', 'Phase 1', 'Phase 2', 'Phase 3', 'Phase 4', 'Alumni']
    
    cohorts = Cohort.select(:name).uniq
    @cohorts = cohorts.sort_by { |cohort| cohort.name }
    
    @num_filters = @sources.length + @phases.length + @cohorts.length
    # @locations = ['San Franciso', 'Chicago']

  end

  def apply_filters

    if params[:source]
      @source = params[:source]
    else
      @source = []
    end

    if params[:cohort]
      @cohort = params[:cohort]
    else
      @cohort = []
    end

    if params[:phase]
      @phase = params[:phase]
    else
      @phase = []
    end

    @all = @source.length + @phase.length + @cohort.length

    if @all == 0

      @posts = Post.order('posted_at DESC').limit(50)

    else

      @posts = Post.where(:source => params[:source], :phase_id => params[:phase], :cohort => params[:cohort]).order('posted_at DESC').limit(50)
    
    end

  end

end






