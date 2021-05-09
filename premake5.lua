workspace "Hazel"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}
	-- Build configuration: debug or release, system, architecture
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


	files
	{
		--searches the Hazel project for header and cpp files
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"

	}

	--  sole include directory as of now
	includedirs
	{
		"%{prj.name}/vendor/spdlog/include"
	}


	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.17134.0"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"_WINDLL"
		}

		-- go to bin directory and copy Hazel.dll into sandbox directory
		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} .. /bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"
	
	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		--searches the Hazel project for header and cpp files
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"

	}

	--  sole include directory as of now for Sandbox
	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"
	
	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"