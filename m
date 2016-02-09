From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert 991de2e59090 ("PCI,
 x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
Date: Tue, 09 Feb 2016 11:58:09 -0600
Message-ID: <20160209175809.23549.41255.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160209175155.23549.35323.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51735 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140AbcBIR6N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Feb 2016 12:58:13 -0500
In-Reply-To: <20160209175155.23549.35323.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>

991de2e59090 appeared in v4.3.  =D0=9E=D0=BB=D0=B5=D0=B3 reported that =
the Elcus-1553 TA1-PCI
driver worked in v4.2 but not v4.3 and bisected it to 991de2e59090.  Su=
njin
reported that the RocketRAID 272x driver worked in v4.2 but not v4.3.  =
In
both cases, booting with "pci=3Droutirq" is a workaround.

I think the problem is that after 991de2e59090, we no longer call
pcibios_enable_irq() for upstream bridges.  Prior to 991de2e59090, when=
 a
driver called pci_enable_device(), we recursively called
pcibios_enable_irq() for upstream bridges via pci_enable_bridge().

After 991de2e59090, we call pcibios_enable_irq() from pci_device_probe(=
)
instead of the pci_enable_device() path, which does *not* call
pcibios_enable_irq() for upstream bridges.

The purpose of 991de2e59090 was to help support IOAPIC hotplug, so
reverting it likely breaks that.

Note: this also reverts 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq
when MSI is enabled").

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D111211
=46ixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pci=
bios_free_irq()")
Reported-by: =D0=9E=D0=BB=D0=B5=D0=B3 =D0=9C=D0=BE=D1=80=D0=BE=D0=B7 <o=
leg.moroz@mcc.vniiem.ru>
Reported-by: Sunjin Yang <fan4326@gmail.com>
Not-yet-signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   27 +++++++++++----------------
 arch/x86/pci/intel_mid_pci.c   |    7 ++-----
 arch/x86/pci/irq.c             |   15 ++++++++++++++-
 drivers/acpi/pci_irq.c         |    8 ++++++++
 5 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_=
x86.h
index 46873fb..d08eacd2 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -93,6 +93,8 @@ extern raw_spinlock_t pci_config_lock;
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
 extern void (*pcibios_disable_irq)(struct pci_dev *dev);
=20
+extern bool mp_should_keep_irq(struct device *dev);
+
 struct pci_raw_ops {
 	int (*read)(unsigned int domain, unsigned int bus, unsigned int devfn=
,
 						int reg, int len, u32 *val);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 2879efc..9df5ab9 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -711,28 +711,23 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
=20
-int pcibios_alloc_irq(struct pci_dev *dev)
+int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	/*
-	 * If the PCI device was already claimed by core code and has
-	 * MSI enabled, probing of the pcibios IRQ will overwrite
-	 * dev->irq.  So bail out if MSI is already enabled.
-	 */
-	if (pci_dev_msi_enabled(dev))
-		return -EBUSY;
+	int err;
=20
-	return pcibios_enable_irq(dev);
-}
+	if ((err =3D pci_enable_resources(dev, mask)) < 0)
+		return err;
=20
-void pcibios_free_irq(struct pci_dev *dev)
-{
-	if (pcibios_disable_irq)
-		pcibios_disable_irq(dev);
+	if (!pci_dev_msi_enabled(dev))
+		return pcibios_enable_irq(dev);
+
+	return 0;
 }
=20
-int pcibios_enable_device(struct pci_dev *dev, int mask)
+void pcibios_disable_device (struct pci_dev *dev)
 {
-	return pci_enable_resources(dev, mask);
+	if (!pci_dev_msi_enabled(dev) && pcibios_disable_irq)
+		pcibios_disable_irq(dev);
 }
=20
 int pci_ext_cfg_avail(void)
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.=
c
index 0d24e7c..354180e 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -256,13 +256,10 @@ static int intel_mid_pci_irq_enable(struct pci_de=
v *dev)
=20
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (pci_has_managed_irq(dev)) {
+	if (!mp_should_keep_irq(&dev->dev) && dev->irq_managed &&
+	    dev->irq > 0) {
 		mp_unmap_irq(dev->irq);
 		dev->irq_managed =3D 0;
-		/*
-		 * Don't reset dev->irq here, otherwise
-		 * intel_mid_pci_irq_enable() will fail on next call.
-		 */
 	}
 }
=20
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 32e7034..6c96cd3 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1256,9 +1256,22 @@ static int pirq_enable_irq(struct pci_dev *dev)
 	return 0;
 }
=20
+bool mp_should_keep_irq(struct device *dev)
+{
+	if (dev->power.is_prepared)
+		return true;
+#ifdef CONFIG_PM
+	if (dev->power.runtime_status =3D=3D RPM_SUSPENDING)
+		return true;
+#endif
+
+	return false;
+}
+
 static void pirq_disable_irq(struct pci_dev *dev)
 {
-	if (io_apic_assign_pci_irqs && pci_has_managed_irq(dev)) {
+	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
+	    dev->irq_managed && dev->irq) {
 		mp_unmap_irq(dev->irq);
 		pci_reset_managed_irq(dev);
 	}
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..20bce3a 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -477,6 +477,14 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!pin || !pci_has_managed_irq(dev))
 		return;
=20
+	/* Keep IOAPIC pin configuration when suspending */
+	if (dev->dev.power.is_prepared)
+		return;
+#ifdef CONFIG_PM
+	if (dev->dev.power.runtime_status =3D=3D RPM_SUSPENDING)
+		return;
+#endif
+
 	entry =3D acpi_pci_irq_lookup(dev, pin);
 	if (!entry)
 		return;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
