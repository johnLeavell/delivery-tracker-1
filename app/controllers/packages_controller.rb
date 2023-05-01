class PackagesController < ApplicationController
  def index
    matching_packages = Package.all

    @list_of_packages = matching_packages.order({ :created_at => :desc })

    @waiting_on = @list_of_packages.where({ :status => "waiting_on" })

    @received = @list_of_packages.where({ :status => "received" })

    render({ :template => "packages/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_packages = Package.where({ :id => the_id })

    @the_package = matching_packages.at(0)

    render({ :template => "packages/show.html.erb" })
  end

  def create
    the_package = Package.new
    the_package.item = params.fetch("query_item")
    the_package.arrival_date = params.fetch("query_arrival_date")
    the_package.details = params.fetch("query_details")
    the_package.status = params.fetch("query_status")
    the_package.user_id = params.fetch("query_user_id")

    if the_package.valid?
      the_package.save
      redirect_to("/", { :notice => "Added to list" })
    else
      redirect_to("/", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.item = params.fetch("query_item")
    the_package.arrival_date = params.fetch("query_arrival_date")
    the_package.details = params.fetch("query_details")
    the_package.status = params.fetch("query_status")
    the_package.user_id = params.fetch("query_user_id")

    if the_package.valid?
      the_package.save
      redirect_to("/", { :notice => "Package updated successfully."} )
    else
      redirect_to("/", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.destroy

    redirect_to("/", { :notice => "Package deleted successfully."} )
  end
end
