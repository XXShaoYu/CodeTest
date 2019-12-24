=begin
将3x图片生成2x和3x图片，并重新命名成@2x和@3x结尾(icon.png => icon@2x.png, icon@3x.png)。
可带参数，参数为文件夹，将遍历该文件夹下的所有文件。
不带参数时，将遍历脚本所在的文件夹下的所有文件。
=end

require 'fileutils'

def makeImageSize(path)
	Dir.foreach(path) do |entry|
		if entry == '.' || entry == ".." || entry == ".DS_Store" #如果是这几个文件夹则跳过
			next
		end

		p = "#{path}/#{entry}" #完整路径

		if File.file?(p) #是文件
			if entry.include?(".png") #是否是png图片
				if entry.include?("@2x") || entry.include?("@3x") #如果图片名字已经包含@2x或@3x则跳过
					next
				end

				copyP = String.new<<p
				replaceP = String.new<<p
				copyP.insert p.length-".png".length, "@2x"
				replaceP.insert p.length-".png".length, "@3x"

				FileUtils.cp p, copyP #复制文件p到copyP路径
				File::rename p, replaceP #更改p文件名为replaceP

				image = ChunkyPNG::Image.from_file(replaceP) #从replaceP路径获取图片
				width = image.dimension.width
				height = image.dimension.height

				if width > 1
					width = width*2/3
				end

				if height > 1
					height = height*2/3
				end

				system "sips -z " + height.to_s + " " + width.to_s + " " + copyP
			end
        else #是文件夹，递归
            makeImageSize p
		end
	end
end


#ruby中除了false和nil，其他都是true
if ARGV.count > 0 && File.directory?(ARGV[0]) #是否有指定文件夹
	path = Dir.pwd+"/#{ARGV[0]}"
else #没有指定文件夹，将遍历该目录下的所有文件
	path = Dir.pwd
end

makeImageSize path

