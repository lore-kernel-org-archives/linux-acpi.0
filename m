From: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Subject: Satellite 3000 and suspend in 2.4/2.6
Date: Thu, 14 Aug 2003 15:40:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030814154023.A2320@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I just wanted to test a 2.6 kernel for the first time and see how ACPI
evolved with it. But the functionality of ACPI became even worser for me.
2.6.0test3 + ACPI-patch boots and looks almost like on 2.4, but trying any
of Sx states (echo 1 >/proc/acpi/sleep) results in
	Stopping tasks:
and the CPU gets high and the system freezes.

The 2.4-series got worser too. I' running Linux version 2.4.21 
mobile:~ # cat /proc/acpi/info
version:                 20030619
states:                  S0 S1 S3 S4 S5

and now the system freezes sometimes after resuming from S1. Mostly, when X
with the binary nv-drivers is used. With an older version of ACPI and a
2.4.21preX kernel I didn't have such problems.


Anyone out there using 2.6 successful with this notebook? Is S3/S4 working
in 2.6? How to trace back the problems?

Thanks,

Nikolaus Filus


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
