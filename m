From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: swsusp/s3: Assembly interactions need asmlinkage
Date: Wed, 25 Feb 2004 11:11:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040225101100.GA214@elf.ucw.cz>
References: <20040224130051.GA8964@elf.ucw.cz> <20040225083957.GE2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040225083957.GE2869-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > swsusp/s3 assembly parts, and parts called from assembly are not
> > properly marked asmlinkage; that leads to double fault on resume when
> > someone compiles kernel with regparm. Thanks go to Stefan Seyfried for
> > discovering this. Please apply,
> 
> Does acpi_enter_sleep_state_s4bios() have the same issue ?

Yes, it does; I missed that. Thanks. Here's the fix.
								Pavel

--- clean/drivers/acpi/hardware/hwsleep.c	2004-02-05 01:53:59.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-02-25 11:08:15.000000000 +0100
@@ -359,7 +359,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status asmlinkage
 acpi_enter_sleep_state_s4bios (
 	void)
 {


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
