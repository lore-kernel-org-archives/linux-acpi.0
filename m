From: Andrew Eager <andrew.eager-Pm7dQxmfFcgpAS55Wn97og@public.gmane.org>
Subject: Compaq Presario 2100 (2133AC)
Date: Thu, 03 Jul 2003 02:22:11 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F0306B3.4070803@aes-pl.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Just joined this list cos I need some help and probably have something 
to contribute!

I have just got a Compaq Presario 2100 (2133AC or DF975A) and found that 
the 2.4.21 kernel just hung when booting.
After a day of reading howtos and learning how to use the iasl compiler 
(& language... yuk), I have managed to get the machine to work by:
 - Getting original DSL, debug & recompile
 - Removing  the "PTLTD" from blacklist.c (not sure if this is right or not)
 - Loading the AML code from initrd.

I now have everything working **except** that running hwclock will cause 
the kernel to crash.
(I have to comment hwclock out of rc.sysinit in order for it to boot)

Any ideas where to look?
Assuming I get this thing to work, any use providing the new dsl code to 
the list?

Thanks

Andy.







-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
