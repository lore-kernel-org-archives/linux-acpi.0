From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: device states supported by current drivers
Date: Wed, 13 Aug 2003 00:58:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030812225808.GB1417@elf.ucw.cz>
References: <3F36F140.6010701@samsung.com> <1060586777.12397.3.camel@bacchus.gpphy.uni-duesseldorf.de> <3F375AE9.1080202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi!

> >Am Mo, 2003-08-11 um 03.28 schrieb Bharata B Rao:
> >>
> >>Are there any device drivers in 2.4/2.6 kernels which actually support 
> >>different low power states as defined by ACPI ? The reason I ask is I 
> >>can't really see any device actually implementing the new driver model 
> >>suspend routine which is used by ACPI.
> >
> >
> >What about the e100 driver? See drivers/net/e100/e100_main.c
> >
> 
> Ok, I can see that now. Thanks.
> 
> Two more dumb questions (sorry for asking them here in devel list)
> 
> 1. When a particular sleep state (S1 - S5) is entered via 
> /proc/acpi/sleep, the devices are put to one of the D states (D0 - D3)
> From the code (device_suspend, e100_suspend, pci_set_power_state), it 
> looks like the sleep states (Sx) are directly translated to device 
> states (Dx) when it comes to device suspend. i,e., when I say enter S2, 
> it will lead to device entering to D2. Is this how it should be ?

I believe suspend() function parameters are expected to tell you *S*
state we are entering. I do not see code that enables drivers to enter
D0 vs. D1 vs. D2 vs D3. I guess it is not there.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
