From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] 2.6.0-test4 Fix mpparse properly mark 2
Date: Tue, 9 Sep 2003 14:08:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309091408.00619.adq_dvb@lidskialf.net>
References: <200309072130.40200.adq_dvb@lidskialf.net> <200309081607.59047.adq_dvb@lidskialf.net> <20030908152926.GH5826@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030908152926.GH5826-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

How about this patch? I've opted to put the es7000_fix variable in dmi_scan.c for 
the moment 'cos there are already another couple of architecture-switching variables 
defined in there. 

Whoever hooks up the es7000 code can move it to a more appropriate place if they 
don't use DMI for the detection.



--- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.000000000 +0100
+++ linux-2.6.0-test4.es7000fix/arch/i386/kernel/mpparse.c	2003-09-09 13:58:00.839472992 +0100
@@ -1128,9 +1128,11 @@
 		if (ioapic < 0)
 			continue;
 		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
-
-		if (!ioapic && (irq < 16))
-			irq += 16;
+	   
+		if (es7000_plat) {
+			if (!ioapic && (irq < 16))
+				irq += 16;
+		}
 
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
--- linux-2.6.0-test4.null_crs/arch/i386/kernel/dmi_scan.c	2003-08-23 00:54:24.000000000 +0100
+++ linux-2.6.0-test4.es7000fix/arch/i386/kernel/dmi_scan.c	2003-09-09 13:57:22.180350072 +0100
@@ -16,6 +16,7 @@
 
 int is_sony_vaio_laptop;
 int is_unsafe_smbus;
+int es7000_plat = 0;
 
 struct dmi_header
 {
--- linux-2.6.0-test4.null_crs/arch/i386/mach-es7000/es7000.c	2003-08-23 01:00:14.000000000 +0100
+++ linux-2.6.0-test4.es7000fix/arch/i386/mach-es7000/es7000.c	2003-09-09 14:08:00.095372248 +0100
@@ -51,8 +51,6 @@
 int 			mip_port;
 unsigned long		mip_addr, host_addr;
 
-static int		es7000_plat;
-
 /*
  * Parse the OEM Table
  */
--- linux-2.6.0-test4.null_crs/include/asm-i386/system.h	2003-08-23 00:50:53.000000000 +0100
+++ linux-2.6.0-test4.es7000fix/include/asm-i386/system.h	2003-09-09 13:58:29.508114696 +0100
@@ -470,6 +470,7 @@
 
 extern unsigned long dmi_broken;
 extern int is_sony_vaio_laptop;
+extern int es7000_plat;
 
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
