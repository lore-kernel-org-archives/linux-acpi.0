From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/3] Revert "PCI,
 x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"
Date: Wed, 17 Feb 2016 12:37:21 -0600
Message-ID: <20160217183721.302.89369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") appeared in v4.3 and helps support IOAPIC hotplug.

=D0=9E=D0=BB=D0=B5=D0=B3 reported that the Elcus-1553 TA1-PCI driver wo=
rked in v4.2 but not
v4.3 and bisected it to 991de2e59090.  Sunjin reported that the RocketR=
AID
272x driver worked in v4.2 but not v4.3.  In both cases booting with
"pci=3Droutirq" is a workaround.

I think the problem is that after 991de2e59090, we no longer call
pcibios_enable_irq() for upstream bridges.  Prior to 991de2e59090, when=
 a
driver called pci_enable_device(), we recursively called
pcibios_enable_irq() for upstream bridges via pci_enable_bridge().

After 991de2e59090, we call pcibios_enable_irq() from pci_device_probe(=
)
instead of the pci_enable_device() path, which does *not* call
pcibios_enable_irq() for upstream bridges.

Revert 991de2e59090 to fix these driver regressions.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D111211
=46ixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pci=
bios_free_irq()")
Reported-by: =D0=9E=D0=BB=D0=B5=D0=B3 =D0=9C=D0=BE=D1=80=D0=BE=D0=B7 <o=
leg.moroz@mcc.vniiem.ru>
Reported-by: Sunjin Yang <fan4326@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   20 +++++++++++---------
 arch/x86/pci/intel_mid_pci.c   |    7 ++-----
 arch/x86/pci/irq.c             |   15 ++++++++++++++-
 drivers/acpi/pci_irq.c         |    9 ++++++++-
 5 files changed, 37 insertions(+), 16 deletions(-)

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
index cb499c5..d34b511 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -711,20 +711,22 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
=20
-int pcibios_alloc_irq(struct pci_dev *dev)
+int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	return pcibios_enable_irq(dev);
-}
+	int err;
=20
-void pcibios_free_irq(struct pci_dev *dev)
-{
-	if (pcibios_disable_irq)
-		pcibios_disable_irq(dev);
+	if ((err =3D pci_enable_resources(dev, mask)) < 0)
+		return err;
+
+	if (!pci_dev_msi_enabled(dev))
+		return pcibios_enable_irq(dev);
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
index 8826ff5..8b93e63 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -256,13 +256,10 @@ static int intel_mid_pci_irq_enable(struct pci_de=
v *dev)
=20
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (dev->irq_managed && dev->irq > 0) {
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
index 72108f0..9bd1154 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1257,9 +1257,22 @@ static int pirq_enable_irq(struct pci_dev *dev)
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
-	if (io_apic_assign_pci_irqs && dev->irq_managed && dev->irq) {
+	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
+	    dev->irq_managed && dev->irq) {
 		mp_unmap_irq(dev->irq);
 		dev->irq =3D 0;
 		dev->irq_managed =3D 0;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 9032db7..c8e169e 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -478,6 +478,14 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (!pin || !dev->irq_managed || dev->irq <=3D 0)
 		return;
=20
+	/* Keep IOAPIC pin configuration when suspending */
+	if (dev->dev.power.is_prepared)
+		return;
+#ifdef	CONFIG_PM
+	if (dev->dev.power.runtime_status =3D=3D RPM_SUSPENDING)
+		return;
+#endif
+
 	entry =3D acpi_pci_irq_lookup(dev, pin);
 	if (!entry)
 		return;
@@ -498,6 +506,5 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	if (gsi >=3D 0) {
 		acpi_unregister_gsi(gsi);
 		dev->irq_managed =3D 0;
-		dev->irq =3D 0;
 	}
 }
