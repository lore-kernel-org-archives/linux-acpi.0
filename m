From: Piotr Neuman <sikkh-5tc4TXWwyLM@public.gmane.org>
Subject: Disabling ACPI and latest 2.6.7 patch
Date: Thu, 1 Jul 2004 20:40:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407012040.38978.sikkh@wp.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mqF5AfE0vjLkzMC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_mqF5AfE0vjLkzMC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I downloaded acpi update patch for 2.6.7 kernel 
(acpi-20040326-2.6.7.diff.bz2). There is a problem when disabling acpi in 
kernel configuration ("ACPI Support" menu option) during linux kernel image 
linking phase mp_register_gsi() is reported as undefined.

Attached simple patch to fix it (probably contains mistakes).

--Boundary-00=_mqF5AfE0vjLkzMC
Content-Type: application/x-bzip2;
  name="acpi-20040326-2.6.7.noacpi_fix.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="acpi-20040326-2.6.7.noacpi_fix.patch.bz2"

QlpoOTFBWSZTWarDN+gAASJfgEAwSX//+vvj30Cv7//iQAJV0zDTnBJIhHqn5Sek0DQ09TCAA0DQ
0HlNMgJRTyCIm1PUH6p6QAGgAAAADQZQo9QNNqMTJoAAA0AAAACSgk9NJ6mmQIGg0DEBoNBo0yA0
ai8T1Kb/SMyp0ZcIbuLYdI0pnsQgpJoWLNZubWGqD1UTXgW44g9axbIL70ZyRixa7uQ+mPZF7lxk
NXbVzyudGQkaDQrrx41ZTcwhtvyYrzigYYCdgxHAoQBjCQPDGwWNAKnGYv4TiMH4+dm9eNErtLCZ
oiuWSNvBfyZQw7sRmoJiKLTuFfvcidFbyxSVK6eYLURxvji00BhybjHVEgSyEZqu5Yo3WaOCsiVl
Yzzq/S9KUFcjYZC0fhYZ0uUCpiURxXshU2bdcnwAzShYrwSk85YMOiGFoNyAOBqO4S06c7jSBi5i
ANGjD1SfkAyhr9EJ4l8UakGfUhNcJRaKt1JjjcQmIzIXw5wFSCEwqgvLUEgYGueLguBPZmoAs5rq
HxAY+LQ5OsC0WZwK1m/DOWkyleLdjMs/kSthqholKv091nUE/5zKlFBdUtITI2AaNZpKQdMMS+lV
c2DXhYNoCukLEybQisP5fI+E9tFIwI1uE2Lx0w0aEykoq0OLYr6vhQy8jHJFYVPQhBMwBsiJDpUE
oYA6WwwuAR5yBIKA1AoFZUt6wkhIKi6kEsQVCAh98QrcEIM4rYBFGPpxptgQgSR0NNz2gmAukmWt
LxM4kUkF4iqo6Ey4jjMWOaTIVoWlqNW4T/xdyRThQkKrDN+g

--Boundary-00=_mqF5AfE0vjLkzMC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="acpi-20040326-2.6.7.noacpi_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-20040326-2.6.7.noacpi_fix.patch"

Index: linux/arch/i386/kernel/mpparse.c
===================================================================
--- linux.orig/arch/i386/kernel/mpparse.c	2004-07-01 20:18:14.605251000 +0200
+++ linux/arch/i386/kernel/mpparse.c	2004-07-01 20:27:12.095251000 +0200
@@ -844,7 +844,7 @@ void __init mp_register_lapic (
 	MP_processor_info(&processor);
 }
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
+#ifdef CONFIG_X86_IO_APIC
 
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
@@ -874,6 +874,8 @@ static int mp_find_ioapic (
 	return -1;
 }
 	
+#endif /*CONFIG_X86_IO_APIC*/
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
 
 void __init mp_register_ioapic (
 	u8			id, 
@@ -1026,6 +1028,9 @@ void __init mp_config_acpi_legacy_irqs (
 	}
 }
 
+#endif /*CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER*/
+#ifdef CONFIG_X86_IO_APIC
+
 int (*platform_rename_gsi)(int ioapic, int gsi);
 
 void mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
@@ -1077,5 +1082,5 @@ void mp_register_gsi (u32 gsi, int edge_
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
 }
 
-#endif /*CONFIG_X86_IO_APIC && CONFIG_ACPI_INTERPRETER*/
+#endif /*CONFIG_X86_IO_APIC*/
 #endif /*CONFIG_ACPI_BOOT*/

--Boundary-00=_mqF5AfE0vjLkzMC--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
