From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: Satellite 3000 and suspend in 2.4/2.6
Date: Fri, 15 Aug 2003 14:26:57 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1060914416.1758.14.camel@laptop-linux>
References: <20030814154023.A2320@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030814154023.A2320-u75qzGzWA6cb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

For 2.4 swsusp, there are known issues with the Nvidia drivers. Check
out the HOWTO on swsusp.sourceforge.net for a workaround.

Regards,

Nigel

On Fri, 2003-08-15 at 01:40, Nikolaus Filus wrote:
> Hi,
> 
> I just wanted to test a 2.6 kernel for the first time and see how ACPI
> evolved with it. But the functionality of ACPI became even worser for me.
> 2.6.0test3 + ACPI-patch boots and looks almost like on 2.4, but trying any
> of Sx states (echo 1 >/proc/acpi/sleep) results in
> 	Stopping tasks:
> and the CPU gets high and the system freezes.
> 
> The 2.4-series got worser too. I' running Linux version 2.4.21 
> mobile:~ # cat /proc/acpi/info
> version:                 20030619
> states:                  S0 S1 S3 S4 S5
> 
> and now the system freezes sometimes after resuming from S1. Mostly, when X
> with the binary nv-drivers is used. With an older version of ACPI and a
> 2.4.21preX kernel I didn't have such problems.
> 
> 
> Anyone out there using 2.6 successful with this notebook? Is S3/S4 working
> in 2.6? How to trace back the problems?
> 
> Thanks,
> 
> Nikolaus Filus
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
