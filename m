From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: How to determine ACPI SF patch version from running kernel?
Date: Mon, 04 Aug 2003 11:11:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F2E2327.4050804@basmevissen.nl>
References: <F760B14C9561B941B89469F59BA3A8470255EEBD@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EEBD-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:

  (ACPI_CA_VERSION)
> It changes every release, except for the most recent one. I should've
> updated it but I was in a hurry to go on vacation and didn't.
> 

 From acpi-20030730-2.4.22-pre8.diff.gz:

diff -Naur -X /root/bin/dontdiff a/include/acpi/acconfig.h 
b/include/acpi/acconfig.h
--- a/include/acpi/acconfig.h	2003-07-30 10:06:09.000000000 -0700
+++ b/include/acpi/acconfig.h	2003-07-30 10:07:29.000000000 -0700
@@ -64,7 +64,7 @@

  /* Version string */

-#define ACPI_CA_VERSION                 0x20030619
+#define ACPI_CA_VERSION                 0x20030714

The ACPI_CA_VERSION did change, but not to the number of the patch. My 
question was how to determine the _patch_ version and not just the 
version of the ACPI_CA stuff.

(Maybe I see it wrong, but I guess that ACPI_CA is just one part of the 
whole patch.)

For debugging it really helps if the _patch_ number can be easely 
retrieved from the source and at runtime.

For example, if you only make a change to the Toshiba-specific stuff, 
then I would say keep the ACPI_CA number the same and just update the 
overall patch number.

> PS this would've been a good question for acpi-support.
> 

If I only were asking for _where_ to find it, it was.

Regards,

Bas.








-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
