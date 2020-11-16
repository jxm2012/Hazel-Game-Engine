#pragma once



//in order to use Application class from Hazel, it needs to export 
//HZ_PLATFORM_WINDOWS = only applies to windows
#ifdef HZ_PLATFORM_WINDOWS
	//macro defined for Hazel project, not Sandbox
	#ifdef HZ_BUILD_DLL
		#define HAZEL_API __declspec(dllexport)
	//else  it imports for Sandbox
	#else
		#define HAZEL_API __declspec(dllimport)
	#endif
#else
	#error Hazel only support Windows!
#endif