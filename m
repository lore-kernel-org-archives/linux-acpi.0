From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] device states supported by current drivers
Date: Wed, 13 Aug 2003 11:07:35 +0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720AD6@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Bharata B Rao <rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think device states will not be supported in 2.4 kernel, And It could be found in 2.6 kernel. 
Who know the current status? 
Thanks,
Luming

-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
Sent: 2003?8?13? 6:58
To: Bharata B Rao
Cc: Knut Neumann; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] device states supported by current drivers


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
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel
