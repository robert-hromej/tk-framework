module EngineMethods

  def to_tk_module
    #str = "module Layout\n"
    #
    #components = ['label1', 'label2', 'frame1']
    #
    #str << "\n"
    #str << "  def init_all_component\n"
    #components.each do |component|
    #  str << "    #{component}\n"
    #end
    #str << "  end\n"
    #
    #
    #str << "end\n"
    #
    #create_element @root.children[0].children[0]
    #create_element @root.children[0].children[1]
    #
    #
    #str

    module_template = Liquid::Template.parse File.read('./lib/templates/application.liquid')

    methods = []

    components = []

    @root.to_tk.each do |aaa|
      components << aaa[0]
      methods << aaa[1]
    end

    init_components_template = Liquid::Template.parse File.read('./lib/templates/init_components.liquid')
    methods << init_components_template.render('components' => components.join("\n    "))
    module_template.render('methods' => methods)
  end

  def create_element node
    id = node.value[:attributes]['id']

    type = node.value[:name]
    type = 'frame' if node.value[:name] == 'div'

    parent = node.parent.value[:attributes]['id']

    str = "\n"
    str << "  def #{id}\n"
    str << "    return @#{id} if @#{id}\n\n"
    str << "    @#{id} = #{type.capitalize}.new(#{parent})\n"
    str << "  end\n"

    puts str
  end

  def render_tk_module
    File.open('./app/application.rb', 'w') { |f| f.puts to_tk_module }
  end
end

module Haml
  class Engine
    include EngineMethods
  end
end
