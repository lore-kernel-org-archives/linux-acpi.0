From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
Date: 26 Mar 2004 00:26:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080278805.755.157.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-V6htaBMAzI06OTMadD6T"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6523-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc-Christian Petersen <m.c.p-dPKWvz6skTq4xZncNx1fdg@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Rik van Ballegooijen <sleightofmind-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-V6htaBMAzI06OTMadD6T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> 
> > ACPI: SCI (IRQ22) allocation failed
> >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> Handler, AE_NOT_ACQUIRED
> > ACPI: Unable to start the ACPI Interpreter

> working this issue here:
> http://bugzilla.kernel.org/show_bug.cgi?id=2366

Can somebody with hardware that exhibits this problem
apply the following 1-liner patch to the latest tree
and send me your dmesg and /proc/interrupts,
or attach it to the bug report?
(sorry for the wrap, attachment is non-wrapped).

===== drivers/acpi/bus.c 1.40 vs edited =====
--- 1.40/drivers/acpi/bus.c	Tue Mar 23 01:32:11 2004
+++ edited/drivers/acpi/bus.c	Thu Mar 25 23:50:41 2004
@@ -623,7 +623,8 @@
 		 * now that acpi_fadt is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_fadt.sci_int = acpi_sci_override_gsi;
+		printk("acpi_fadt.sci_int %d acpi_sci_override_gsi %d\n",
+			acpi_fadt.sci_int, acpi_sci_override_gsi);
 	}
 #endif
 

In this example, this will claim IRQ9 for APIC INITIN 0-22
while traditionally we've called this IRQ22.

This brings up the bigger question of what an IRQ or GSI is...
in PIC mode they are wires on the PIC.
In APIC mode you sort of aggregate all the IOAPICS into
one linear list and call the GSI the logical INITIN number.
So why do we call the timer interrupt IRQ0 in this mode
when it is really connected to INTIN 2?  If we're consistent
with that then we should call the SCI IRQ9 instead of IRQ22...

In MSI mode, the GSI is the vector number on the CPU,
unless it is for one of the legacy IRQs, in which case
/proc/interrupts shows the PIC IRQ#.

confusing.

-Len


--=-V6htaBMAzI06OTMadD6T
Content-Disposition: attachment; filename=bus.patch
Content-Type: text/plain; name=bus.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/bus.c 1.40 vs edited =====
--- 1.40/drivers/acpi/bus.c	Tue Mar 23 01:32:11 2004
+++ edited/drivers/acpi/bus.c	Thu Mar 25 23:50:41 2004
@@ -623,7 +623,8 @@
 		 * now that acpi_fadt is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_fadt.sci_int = acpi_sci_override_gsi;
+		printk("acpi_fadt.sci_int %d acpi_sci_override_gsi %d\n",
+			acpi_fadt.sci_int, acpi_sci_override_gsi);
 	}
 #endif
 

--=-V6htaBMAzI06OTMadD6T--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
