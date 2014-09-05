class SessionsController < ApplicationController
  layout :false
  
  
  
  def upload
    
    ShopifyAPI::Base.site = "https://ac99d7fc01be444346f9274b4e63be6e:93b1db77c177019fb19ef7a26867aba5@orthopedist-shop.myshopify.com/admin"

    products = ShopifyAPI::Product.find(:all,:params => {:vendor => 'MS Test', :limit => 250})


    description = params[:description]
    inventory_variants = params[:inventory_variants];
    imagefile = params[:filepath]

    collection = params[:collection]
    tag = params[:tag]
    
    puts("description = #{description}")
    puts("inventory and variants = #{inventory_variants}")
    puts("collection = #{collection}")
    puts("tag = #{tag}")
    
    var = "start using shopify api"
    puts var



    absolutedir = params[:absolutepath];
    sourcedir='c:\Users\slu_000\Desktop'
    
    puts("sourcedir = #{sourcedir}")
    Dir.foreach(sourcedir){
     
    |f|
     
     entry =  "#{absolutedir}#{f}"
     
     
     
     
     if File.directory?(entry) then
       
       puts("#{entry} is a directory")
     else 
        for s in ['.jpg', '.png', '.bmp'] do   
          
           
         
         if entry.include?s then
            puts("#{entry} is a file")
            
       

    description = params[:description]
    type = params[:type];
    vendor = params[:vendor];
    sku = params[:sku];
    price = params[:price];
    collection = params[:collection]
    tag = params[:tag]
    
    title = f.to_str
    title = title.chomp(s)
    puts("new title is #{title}");    
    
    images = []
    image = {}
    
    #image["src"] = "http://i.dailymail.co.uk/i/pix/2012/09/10/article-0-14EE3D4E000005DC-303_634x434.jpg"
    image["src"]=entry
    
    images << image
  
    variant = ShopifyAPI::Variant.new(
      :price                => " #{price} ",
      :inventory_management => 'shopify',
      :inventory_quantity   => 100, 
      :sku => " #{sku} "
    )
    
    product = ShopifyAPI::Product.new(
    :title => " #{title} ",
    :body_html =>  "<strong>#{description}</strong>",
    :vendor => " #{vendor} ",
    :product_type => " #{type} ",
    :images => images,
    :variants => variant
    )
    
    product.save
            
            
            
            end
         end
      
      
      end
      };
      
   
    
    
    
    
    
    
    
    
    products = ShopifyAPI::Product.find(:all,:params => {:vendor => 'MS Test', :limit => 250})
    
        puts products.size
    
    
      
  end
  




  def new
   
   sourcedir='c:\Users\slu_000\Desktop'
   # get directory path and list all of the image files
   Dir.foreach(sourcedir){
     
     |f|
     
     entry = "#{sourcedir}\\#{f}"
     
     
     
     if File.directory?(entry) then
       
       puts("#{entry} is a directory")
     else 
        for s in ['.jpg', '.png', '.bmp'] do   
          
           
         
         if entry.include?s then
            puts("#{entry} is a file")
            end
         end
      
      
      end
      };
      
      end


  def show
    description = params[:description]
    inventory_variants = params[:inventory_variants];
    

    collection = params[:collection]
    tag = params[:tag]
    
    puts("description = #{description}")
    puts("inventory and variants = #{inventory_variants}")
    puts("collection = #{collection}")
    puts("tag = #{tag}")
    
    sourcedir = dirname(params[:filepath])
    Dir.foreach(sourcedir){
     
    
     
     entry =  "#{sourcedir}\\#{f}"
     
     
     
     if File.directory?(entry) then
       
       puts("#{entry} is a directory")
     else 
        for s in ['.jpg', '.png', '.bmp'] do   
          
           
         
         if entry.include?s then
            puts("#{entry} is a file")
            end
         end
      
      
      end
      
    };
    
  end
  
  
  def authenticate
    #
    # Instead of doing a backend redirect we need to do a javascript redirect
    # here. Open the app/views/commom/iframe_redirect.html.erb file to understand why.
    #
    if shop_name = sanitize_shop_param(params)
      @redirect_url = "/auth/shopify?shop=#{shop_name}"
      render "/common/iframe_redirect", :format => [:html], layout: false
    else
      redirect_to return_address
    end
  end
  
  def return_address
    session[:return_to] || root_url
  end
  
  def sanitize_shop_param(params)
    return unless params[:shop].present?
    name = params[:shop].to_s.strip
    name += '.myshopify.com' if !name.include?("myshopify.com") && !name.include?(".")
    name.sub('https://', '').sub('http://', '')
  end
end
