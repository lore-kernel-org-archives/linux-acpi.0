From: David Mosberger <davidm-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>
Subject: minimai ACPI pci_irq.c for ia64
Date: Mon, 14 Jul 2003 22:02:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307150502.h6F524sj026725@napali.hpl.hp.com>
Reply-To: davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Here is a patch for pci_irq.c.  It's the minimum needed to get PCI
irqs to work on ia64.  In the past, we did some irq.link -> irq
translation magic in this file as well, but since I understand that
the acpi_parse_prt() code is supposed to set the irq member instead,
I updated the ia64 code to do just that.

Would it be possible to get this to Linus asap?  I'm hoping to have
the ia64 kernel be buildable from Linus' sources by the time
2.6.0-test2 is out (yeah, maybe wishful thinking... ;-)

Thanks!

	--david

diff -Nru a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c	Mon Jul 14 21:59:32 2003
+++ b/drivers/acpi/pci_irq.c	Mon Jul 14 21:59:32 2003
@@ -24,6 +24,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/config.h>
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -36,6 +38,9 @@
 #ifdef CONFIG_X86_IO_APIC
 #include <asm/mpspec.h>
 #endif
+#ifdef CONFIG_IOSAPIC
+# include <asm/iosapic.h>
+#endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -369,6 +374,10 @@
 		irq_mask |= (1 << dev->irq);
 		eisa_set_level_irq(dev->irq);
 	}
+#endif
+#ifdef CONFIG_IOSAPIC
+	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
+		iosapic_enable_intr(dev->irq);
 #endif
 
 	return_VALUE(dev->irq);


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
