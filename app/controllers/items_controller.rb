class ItemsController < ApplicationController
    def index
        @items = Item.all
    end


    def new
        @item = Item.new
        @categories = Category.select(:id, :name)
        @rarities = ['junk', 'uncommon', 'common', 'rare', 'legendary']
    end

    def create
        if Item.create!(
            :name        => params[:item][:name],
            :code        => params[:item][:name].downcase,
            :image_url   => params[:item][:image_url],
            :description => params[:item][:description],
            :category_id => params[:category_id],
            :rarity      => params[:rarity]
            )
            redirect_to action: "index"
        else
            redirect_to action: "index"
        end
    end

    def edit
        @item = Item.find(params[:id])
        @categories = Category.select(:id, :name)
        @rarities = ['junk', 'uncommon', 'common', 'rare', 'legendary']
    end

    def update
        @item = Item.find(params[:id])

        if @item.update!(
            :name        => params[:item][:name],
            :image_url   => params[:item][:image_url],
            :description => params[:item][:description],
            :category_id => params[:category_id],
            :rarity      => params[:rarity]
            )
            redirect_to action: "index"
        else
            redirect_to action: "index"
        end
    end

    private
    def item_params
      params.require(:item).permit(:name, :image_url, :rarity, :category_id)
    end
end
