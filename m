From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.5.58 hangs at boot
Date: Fri, 17 Jan 2003 12:51:35 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F7E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Dreher <dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(CC-ing acpi-devel, hope that's OK.)

> From: Michael Dreher [mailto:dreher-zyMqRySHjtb72XyCfQbr4BvVK+yQ3ZXh@public.gmane.org] 
> > So...if you take the printks out, does it stop booting again? ;-)
> 
> I try now with 2.5.59. By the way, you are aware of a (small) thread
> in lkml with subject "usb broken in 2.5?" some days ago. Greg 
> said that
> nonworking usb may be due to interrupt routing problems of acpi.
> I had such problems: sometimes my smartmedia reader came up 
> during boot,
> sometimes not.

Does /proc/interrupts show anything different for the USB device ACPI vs
non-ACPI?

I read the thread, and basically the code in this part of the kernel is
very confusing (to me, at least). My strategy right now is to clean
up/modularize the code in question, and then it should be easier to
tackle the lurking issues that people are seeing.

Regards -- Andy


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
