From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>
Subject: [PATCH] Revert "x86/xen: Treat SCI interrupt as normal GSI interrupt"
Date: Mon, 16 Feb 2015 00:25:50 +0200
Message-ID: <1424039150-4115-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:41396 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbBOWbS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2015 17:31:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>, Sander Eikelenboom <linux@eikelenboom.it>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>

This reverts commit b568b8601f05a591a7ff09d8ee1cedb5b2e815fe.

The commit in question causes a nasty regression on HP/Compaq
nc6000 where we fail to register the ACPI interrupt, and thus
lose eg. thermal notifications leading a potentially overheated
machine.

wdiff of /proc/interrupts shows:
9:         [-98-]          {+6+}    XT-PIC  [-acpi-]

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
---
 arch/x86/kernel/acpi/boot.c | 26 ++++++++++++-------------
 arch/x86/pci/xen.c          | 47 +++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ae97ed0..5c40e9a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -611,20 +611,20 @@ void __init acpi_pic_sci_set_trigger(unsigned int=
 irq, u16 trigger)
=20
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
 {
-	int rc, irq, trigger, polarity;
-
-	rc =3D acpi_get_override_irq(gsi, &trigger, &polarity);
-	if (rc =3D=3D 0) {
-		trigger =3D trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
-		polarity =3D polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
-		irq =3D acpi_register_gsi(NULL, gsi, trigger, polarity);
-		if (irq >=3D 0) {
-			*irqp =3D irq;
-			return 0;
-		}
-	}
+	int irq;
=20
-	return -1;
+	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_PIC) {
+		*irqp =3D gsi;
+	} else {
+		mutex_lock(&acpi_ioapic_lock);
+		irq =3D mp_map_gsi_to_irq(gsi,
+					IOAPIC_MAP_ALLOC | IOAPIC_MAP_CHECK);
+		mutex_unlock(&acpi_ioapic_lock);
+		if (irq < 0)
+			return -1;
+		*irqp =3D irq;
+	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
=20
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index d22f4b5..3db4de0 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -476,6 +476,52 @@ int __init pci_xen_hvm_init(void)
 }
=20
 #ifdef CONFIG_XEN_DOM0
+static __init void xen_setup_acpi_sci(void)
+{
+	int rc;
+	int trigger, polarity;
+	int gsi =3D acpi_sci_override_gsi;
+	int irq =3D -1;
+	int gsi_override =3D -1;
+
+	if (!gsi)
+		return;
+
+	rc =3D acpi_get_override_irq(gsi, &trigger, &polarity);
+	if (rc) {
+		printk(KERN_WARNING "xen: acpi_get_override_irq failed for acpi"
+				" sci, rc=3D%d\n", rc);
+		return;
+	}
+	trigger =3D trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+	polarity =3D polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+
+	printk(KERN_INFO "xen: sci override: global_irq=3D%d trigger=3D%d "
+			"polarity=3D%d\n", gsi, trigger, polarity);
+
+	/* Before we bind the GSI to a Linux IRQ, check whether
+	 * we need to override it with bus_irq (IRQ) value. Usually for
+	 * IRQs below IRQ_LEGACY_IRQ this holds IRQ =3D=3D GSI, as so:
+	 *  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
+	 * but there are oddballs where the IRQ !=3D GSI:
+	 *  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
+	 * which ends up being: gsi_to_irq[9] =3D=3D 20
+	 * (which is what acpi_gsi_to_irq ends up calling when starting the
+	 * the ACPI interpreter and keels over since IRQ 9 has not been
+	 * setup as we had setup IRQ 20 for it).
+	 */
+	if (acpi_gsi_to_irq(gsi, &irq) =3D=3D 0) {
+		/* Use the provided value if it's valid. */
+		if (irq >=3D 0)
+			gsi_override =3D irq;
+	}
+
+	gsi =3D xen_register_gsi(gsi, gsi_override, trigger, polarity);
+	printk(KERN_INFO "xen: acpi sci %d\n", gsi);
+
+	return;
+}
+
 int __init pci_xen_initial_domain(void)
 {
 	int irq;
@@ -486,6 +532,7 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.restore_msi_irqs =3D xen_initdom_restore_msi_irqs;
 	pci_msi_ignore_mask =3D 1;
 #endif
+	xen_setup_acpi_sci();
 	__acpi_register_gsi =3D acpi_register_gsi_xen;
 	__acpi_unregister_gsi =3D NULL;
 	/* Pre-allocate legacy irqs */
--=20
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
