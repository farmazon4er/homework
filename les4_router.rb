module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
    extend Resource

  def initialize
    @posts = ["Hello world", "Goob"]
  end

  def index
    if @posts.size > 0
      (0..@posts.size-1).each {|i| puts "#{i}. #{@posts[i]}"}
    else
      puts "No posts yet"
    end
  end

  def show
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @posts.size > id.to_i
      puts "#{id}. #{@posts[id.to_i]}"
    elsif @posts.size.positive?
      puts "Incorrect ID, input 0-#{@posts.size - 1}"
    else
      puts "No posts yet"
    end
  end


  def create
    puts 'Enter a post'
    post = gets.chomp.to_s
    @posts << post
    puts "#{@posts.size-1}. #{post}"
  end

  def update
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @posts.size > id.to_i
      puts "Enter new post"
      @posts[id.to_i] = gets.chomp.to_s
      self.index
       elsif @posts.size.positive?
      puts "Incorrect ID, input 0-#{@posts.size - 1}"
    else
      puts "No posts yet"
    end
  end

  def destroy
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @posts.size > id.to_i
      @posts.delete_at(id.to_i)
    elsif @posts.size.positive?
      puts "Incorrect ID, input 0-#{@posts.size - 1}"
    else
      puts "No posts yet"
    end
  end
end

class CommentsController
  extend Resource

  def initialize
    @comments = []
  end

  def index
    if @comments.size > 0
      (0..@comments.size-1).each {|i| puts "#{i}. #{@comments[i]}"}
    else
      puts "No posts yet"
    end
  end

  def show
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @comments.size > id.to_i
      puts "#{id}. #{@comments[id.to_i]}"
    elsif @comments.size.positive?
      puts "Incorrect ID, input 0-#{@comments.size - 1}"
    else
      puts "No posts yet"
    end
  end


  def create
    puts 'Enter a post'
    post = gets.chomp.to_s
    @comments << post
    puts "#{@comments.size-1}. #{post}"
  end

  def update
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @comments.size > id.to_i
      puts "Enter new post"
      @comments[id.to_i] = gets.chomp.to_s
      self.index
    elsif @comments.size.positive?
      puts "Incorrect ID, input 0-#{@comments.size - 1}"
    else
      puts "No posts yet"
    end
  end

  def destroy
    puts 'Enter post ID'
    id = gets.chomp
    if id[/^\d+$/] && @comments.size > id.to_i
      @comments.delete_at(id.to_i)
    elsif @comments.size > 0
      puts "Incorrect ID, input 0-#{@comments.size - 1}"
    else
      puts "No posts yet"
    end
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
