From: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Subject: Export 'acpi_disabled' symbol to modules...
Date: Thu, 12 Jun 2003 11:02:53 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030612090253.GB6337@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The ACPI subsystem can be today (from a driver point of view) in 
three configurations: not compiled (CONFIG_ACPI=n), compiled and 
running or compiled and disabled (with acpi=off).

A driver which wants to use some ACPI exported routines (in my
case it's the sonypi driver which wants to use ec_read/ec_write),
needs to know exactly what the ACPI state is.

The only way to do this today (from what I've seen) is to do:

#ifdef CONFIG_ACPI
	if (!acpi_disabled)
		return ec_write(addr, value);
#endif
	return my_ec_emulated_write(...);

This way on doing things needs however that the 'acpi_disabled' 
variable be exported to modules.

Please apply the attached patch or advise on a better way to know
if ACPI is enabled or not (patch generated against the today 2.5 BK
tree).

Thanks,

Stelian.

===== arch/i386/kernel/setup.c 1.84 vs edited =====
--- 1.84/arch/i386/kernel/setup.c	Sun Jun  8 00:17:53 2003
+++ edited/arch/i386/kernel/setup.c	Tue Jun 10 10:02:00 2003
@@ -61,7 +61,8 @@
 unsigned long mmu_cr4_features;
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
-int acpi_disabled __initdata = 0;
+int acpi_disabled;
+EXPORT_SYMBOL(acpi_disabled);
 
 int MCA_bus;
 /* for MCA, but anyone else can use it if they want */

-- 
Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Alcove - http://www.alcove.com
