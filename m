From: Pavel Machek <pavel-+ZI9xUNit7I=@public.gmane.org>
Subject: Big problems in acpi/event.c (needs seq_printf?)
Date: Mon, 19 Apr 2004 18:51:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040419165103.GA27589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA==@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg==@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA==@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w==@public.gmane.org>
Cc: seife-l3A5Bk7waGM=@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

acpi/event.c needs some heavy facelifting.

This one is needed so that return value (ERESTARTSYS) is propagated
from bus_receive_event(). If this is not done, suspend/resume causes
cat /proc/acpi/event to fail with -EIO. Please apply.

However, there are more problems with event.c:

* it uses spinlock_irq to protect event_is_open(). That's huge
overkill, atomic_t should be enough here, and it is never accessed
from interrupt anyway.

* its racy w.r.t. concurent readers (and yes, you *can* have concurent
readers, think threads). acpi_system_read_event() uses static
variables, without any locking. Probably seq_printf() converstion is
needed.
								Pavel

--- clean/drivers/acpi/event.c	2003-02-15 18:51:16.000000000 +0100
+++ linux/drivers/acpi/event.c	2004-04-19 18:43:58.000000000 +0200
@@ -63,9 +58,8 @@
 			return_VALUE(-EAGAIN);
 
 		result = acpi_bus_receive_event(&event);
-		if (result) {
-			return_VALUE(-EIO);
-		}
+		if (result)
+			return_VALUE(result);
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n", 
 			event.device_class?event.device_class:"<unknown>",

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
