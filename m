From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5]Avoid ACPI assign legacy devices' IRQ for PCI devices
Date: Thu, 21 Oct 2004 10:59:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098327558.6132.220.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RYX4IQ3rVIDiea3EYFU3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-RYX4IQ3rVIDiea3EYFU3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
The patch introduces acpi_penalize_isa_irq, its goal is to avoid PCI
devices use IRQ of legacy PNP devices.

Thanks,
Shaohua


Signed-off-by: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

===== include/linux/acpi.h 1.36 vs edited =====
--- 1.36/include/linux/acpi.h	2004-06-02 23:02:20 +08:00
+++ edited/include/linux/acpi.h	2004-09-22 10:09:23 +08:00
@@ -439,6 +439,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_penalize_isa_irq(int irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
===== drivers/acpi/pci_link.c 1.31 vs edited =====
--- 1.31/drivers/acpi/pci_link.c	2004-08-05 03:55:16 +08:00
+++ edited/drivers/acpi/pci_link.c	2004-09-22 10:08:09 +08:00
@@ -786,6 +786,11 @@ static int __init acpi_irq_penalty_updat
 	return 1;
 }
 
+void acpi_penalize_isa_irq(int irq)
+{
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
===== arch/i386/pci/irq.c 1.47 vs edited =====
--- 1.47/arch/i386/pci/irq.c	2004-08-02 16:00:43 +08:00
+++ edited/arch/i386/pci/irq.c	2004-09-22 10:27:30 +08:00
@@ -17,6 +17,7 @@
 #include <asm/smp.h>
 #include <asm/io_apic.h>
 #include <asm/hw_irq.h>
+#include <linux/acpi.h>
 
 #include "pci.h"
 
@@ -989,13 +990,24 @@ static int __init pcibios_irq_init(void)
 subsys_initcall(pcibios_irq_init);
 
 
-void pcibios_penalize_isa_irq(int irq)
+static void pirq_penalize_isa_irq(int irq)
 {
 	/*
 	 *  If any ISAPnP device reports an IRQ in its list of possible
 	 *  IRQ's, we try to avoid assigning it to PCI devices.
 	 */
-	pirq_penalty[irq] += 100;
+	if (irq < 16)
+		pirq_penalty[irq] += 100;
+}
+
+void pcibios_penalize_isa_irq(int irq)
+{
+#ifdef CONFIG_ACPI_PCI
+	if (!acpi_noirq)
+		acpi_penalize_isa_irq(irq);
+	else
+#endif
+		pirq_penalize_isa_irq(irq);
 }
 
 int pirq_enable_irq(struct pci_dev *dev)
===== drivers/pnp/pnpbios/rsparser.c 1.4 vs edited =====
--- 1.4/drivers/pnp/pnpbios/rsparser.c	2004-09-14 08:23:17 +08:00
+++ edited/drivers/pnp/pnpbios/rsparser.c	2004-09-22 10:31:09 +08:00
@@ -7,6 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+#include <linux/pci.h>
 
 #include "pnpbios.h"
 
@@ -58,6 +59,7 @@ pnpbios_parse_allocated_irqresource(stru
 		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
+		pcibios_penalize_isa_irq(irq);
 	}
 }
 


--=-RYX4IQ3rVIDiea3EYFU3
Content-Disposition: attachment; filename=irq-isa.patch
Content-Type: text/x-patch; name=irq-isa.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== include/linux/acpi.h 1.36 vs edited =====
--- 1.36/include/linux/acpi.h	2004-06-02 23:02:20 +08:00
+++ edited/include/linux/acpi.h	2004-09-22 10:09:23 +08:00
@@ -439,6 +439,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_penalize_isa_irq(int irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
===== drivers/acpi/pci_link.c 1.31 vs edited =====
--- 1.31/drivers/acpi/pci_link.c	2004-08-05 03:55:16 +08:00
+++ edited/drivers/acpi/pci_link.c	2004-09-22 10:08:09 +08:00
@@ -786,6 +786,11 @@ static int __init acpi_irq_penalty_updat
 	return 1;
 }
 
+void acpi_penalize_isa_irq(int irq)
+{
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
===== arch/i386/pci/irq.c 1.47 vs edited =====
--- 1.47/arch/i386/pci/irq.c	2004-08-02 16:00:43 +08:00
+++ edited/arch/i386/pci/irq.c	2004-09-22 10:27:30 +08:00
@@ -17,6 +17,7 @@
 #include <asm/smp.h>
 #include <asm/io_apic.h>
 #include <asm/hw_irq.h>
+#include <linux/acpi.h>
 
 #include "pci.h"
 
@@ -989,13 +990,24 @@ static int __init pcibios_irq_init(void)
 subsys_initcall(pcibios_irq_init);
 
 
-void pcibios_penalize_isa_irq(int irq)
+static void pirq_penalize_isa_irq(int irq)
 {
 	/*
 	 *  If any ISAPnP device reports an IRQ in its list of possible
 	 *  IRQ's, we try to avoid assigning it to PCI devices.
 	 */
-	pirq_penalty[irq] += 100;
+	if (irq < 16)
+		pirq_penalty[irq] += 100;
+}
+
+void pcibios_penalize_isa_irq(int irq)
+{
+#ifdef CONFIG_ACPI_PCI
+	if (!acpi_noirq)
+		acpi_penalize_isa_irq(irq);
+	else
+#endif
+		pirq_penalize_isa_irq(irq);
 }
 
 int pirq_enable_irq(struct pci_dev *dev)
===== drivers/pnp/pnpbios/rsparser.c 1.4 vs edited =====
--- 1.4/drivers/pnp/pnpbios/rsparser.c	2004-09-14 08:23:17 +08:00
+++ edited/drivers/pnp/pnpbios/rsparser.c	2004-09-22 10:31:09 +08:00
@@ -7,6 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+#include <linux/pci.h>
 
 #include "pnpbios.h"
 
@@ -58,6 +59,7 @@ pnpbios_parse_allocated_irqresource(stru
 		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
+		pcibios_penalize_isa_irq(irq);
 	}
 }
 

--=-RYX4IQ3rVIDiea3EYFU3--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
