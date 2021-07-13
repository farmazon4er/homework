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
    @posts = []
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
    if id[/^\d+$/] && @posts.size >= id.to_i
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
  end

  def update
    puts 'update'
  end

  def destroy
    puts 'destroy'
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
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
