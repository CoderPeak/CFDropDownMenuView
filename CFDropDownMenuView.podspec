
Pod::Spec.new do |s|
s.name         = 'CFDropDownMenuView'
s.version      = '0.0.3'
s.summary      = '简单实用的下拉列表菜单控件'
s.description      = <<-DESC
"下拉列表菜单控件, 支持单列 多列条件选择"
DESC
s.homepage     = 'https://github.com/CoderPeak/CFDropDownMenuView'
s.license      = 'MIT'
s.authors      = {'CoderPeak' => '545486205@qq.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/CoderPeak/CFDropDownMenuView.git' , :tag => s.version.to_s}
s.source_files = 'CFDropDownMenuView/CFDropDownMenuView/**/*.{h,m}'
s.resource     = 'CFDropDownMenuView/CFDropDownMenuView/CFDropDownMenuView.bundle'
s.requires_arc = true
end