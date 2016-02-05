using BinDeps


@BinDeps.setup

deps = [
	libdc1394 = library_dependency("libdc1394")
	]

const version = "2.2.4"

provides(Sources,
	URI("http://sourceforge.net/projects/libdc1394/files/libdc1394-2/$(version)/libdc1394-$(version).tar.gz"),
	libdc1394,
	unpacked_dir="libdc1394-$(version)")

prefix = joinpath(BinDeps.depsdir(libdc1394), "usr")
srcdir = joinpath(BinDeps.depsdir(libdc1394), "src", "libdc1394-$(version)")

provides(SimpleBuild,
	(@build_steps begin
		GetSources(libdc1394)
		@build_steps begin
			ChangeDirectory(srcdir)
				`sh configure --prefix=$prefix`
				`make all`
				`make install`
		end
	end), libdc1394, os = :Darwin)

@BinDeps.install Dict(:libdc1394 => :libdc1394)