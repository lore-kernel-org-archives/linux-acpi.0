From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCH] be more silent if !CONFIG_ACPI_BOOT
Date: Fri, 15 Aug 2003 17:35:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030815153520.GB789@brodo.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A message "ACPI disabled" makes no sense if ACPI isn't even compiled into
the kernel.

	Dominik

--- linux-2.6.0-test3+2/arch/i386/kernel/dmi_scan.c.original	2003-08-15 17:02:04.000000000 +0200
+++ linux-2.6.0-test3+2/arch/i386/kernel/dmi_scan.c	2003-08-15 17:04:42.000000000 +0200
@@ -1014,8 +1014,10 @@
 			else if (year < 1 || (year > 90 && year <= 99))
 				disable = 1; 
 			if (disable && !acpi_force) { 
+#ifdef ACPI_BOOT		
 				printk(KERN_NOTICE "ACPI disabled because your bios is from %s and too old\n", s);
 				printk(KERN_NOTICE "You can enable it with acpi=force\n");
+#endif	// CONFIG_ACPI_BOOT
 				acpi_disabled = 1; 
 			} 
 		}


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
