class SessionsController < ApplicationController
  layout :false
  
  @key=""
  @password=""
  @shop=""
  
  
  def upload
    
    #ShopifyAPI::Base.site = "https://ac99d7fc01be444346f9274b4e63be6e:93b1db77c177019fb19ef7a26867aba5@orthopedist-shop.myshopify.com/admin"

    #ShopifyAPI::Base.site = "https://#{@key}:#{@password}@#{@shop}/admin"

    #products = ShopifyAPI::Product.find(:all,:params => {:vendor => 'MS Test', :limit => 250})


    description = params[:description]
    type = params[:type]
    vendor = params[:vendor];
    #imagefile = params[:filepath]


    distributedsite = params[:distributedsite]
    localsite = params[:localsite]
    
    price = params[:price]
    sku = params[:sku]



    absolutedir = params[:distributedsite];
    sourcedir=localsite
    
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
   
   
    if params[:key] != nil then
    _key = params[:key]
    _password = params[:password]
    _shop = params[:shop]
    #ShopifyAPI::Base.site = "https://ac99d7fc01be444346f9274b4e63be6e:93b1db77c177019fb19ef7a26867aba5@orthopedist-shop.myshopify.com/admin"

    ShopifyAPI::Base.site = "https://#{_key}:#{_password}@#{_shop}/admin"

    products = ShopifyAPI::Product.find(:all,:params => {:vendor => 'MS Test', :limit => 250})

end

   end


  def show
    
    
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
