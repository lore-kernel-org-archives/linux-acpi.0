From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: radeon display is blank after resume from S3
Date: Sun, 22 Feb 2004 02:38:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040222013831.GA29988@hell.org.pl>
References: <34137.68.19.7.134.1077396635.squirrel@webmail.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <34137.68.19.7.134.1077396635.squirrel-2RFepEojUI2yzif+TlFmFpQCsf4PZ8us@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ilya Bagrak <reason-ss4n/k5RZhaUArH+D2fLrA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Ilya Bagrak:
> Linux 2.6.3-mm2 on Fujitsu E7110 laptop w/
> 1. radeon mobility 7500 card
> 2. intel 845 pci bridge (i think)

ASUS L3800C, rest pretty much the same.

> The basic problem is that after resuming from S3, the screen remains
> completely blank.  All other devices seem to return to normal, and I can
> communicate with the laptop over the network.  I have experienced this
> same problem since early 2.6.0 test kernels, and I've been actively
> looking for a solution ever since.

In my case, acpi_sleep=s3_bios is enough. If that doesn't work, you may try
the new radeonfb driver from 2.6.3 -- on my box it *at least* manages to
get the backlight on without having to pass acpi_sleep, but then it screws
up some other things so the laptop gets locked anyway.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
