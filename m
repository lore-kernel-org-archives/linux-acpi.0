From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: device states supported by current drivers
Date: Mon, 11 Aug 2003 08:39:07 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0308110834030.14998-100000@cherise>
References: <3F375AE9.1080202@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F375AE9.1080202-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bharata B Rao <rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Ok, I can see that now. Thanks.
> 
> Two more dumb questions (sorry for asking them here in devel list)

Actually, these don't belong on the acpi list at all. You should be asking 
them on the linux-kernel list, as they are driver model questions. :)

> 1. When a particular sleep state (S1 - S5) is entered via 
> /proc/acpi/sleep, the devices are put to one of the D states (D0 - D3)
>  From the code (device_suspend, e100_suspend, pci_set_power_state), it 
> looks like the sleep states (Sx) are directly translated to device 
> states (Dx) when it comes to device suspend. i,e., when I say enter S2, 
> it will lead to device entering to D2. Is this how it should be ?

S2 is not supported on any platform that I've ever seen. But, if it ever 
is, the spec says that devices may enter a low power state, but not 
necesarily D3 (which is what is recommended for S3). By coincidence, the 
states translate directly, but this is not the case on other platforms. 

> 2. Is there no interface exported by ACPI to control the devices 
> independently. i,e., can't I just control the power state of a device 
> from user space ? Currently I can see it only happens via 
> /proc/acpi/sleep, which is for controlling the entire system sleep state.

For now, each device exports a 'power' file in their sysfs directory. The 
interface is pretty bad, and I'm working on a better one as we speak..


	-pat



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
