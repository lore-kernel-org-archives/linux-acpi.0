From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: device states supported by current drivers
Date: Mon, 11 Aug 2003 13:40:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1060602039.12455.149.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <3F36F140.6010701@samsung.com>
 <1060586777.12397.3.camel@bacchus.gpphy.uni-duesseldorf.de>
 <3F375AE9.1080202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <3F375AE9.1080202-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mo, 2003-08-11 um 10.59 schrieb Bharata B Rao:
> 1. When a particular sleep state (S1 - S5) is entered via 
> /proc/acpi/sleep, the devices are put to one of the D states (D0 - D3)
>  From the code (device_suspend, e100_suspend, pci_set_power_state), it 
> looks like the sleep states (Sx) are directly translated to device 
> states (Dx) when it comes to device suspend. i,e., when I say enter S2, 
> it will lead to device entering to D2. Is this how it should be ?

Hmm..would have thought so at first. But a quick look at the ACPI spec
shows that its possible to define highest power D-states (p. 204) for
each S-states per device. It mentions as well that the Sx-Dx mapping is
derived from the devices power resource declarations.

> 2. Is there no interface exported by ACPI to control the devices 
> independently. i,e., can't I just control the power state of a device 
> from user space ? Currently I can see it only happens via 
> /proc/acpi/sleep, which is for controlling the entire system sleep state.

AFAI understand this is supposed to be done via sysfs. 

-Knut



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
