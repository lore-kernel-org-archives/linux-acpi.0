From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4/7] xen: Utilize the restore_msi_irqs hook.
Date: Wed, 31 Aug 2011 14:31:21 -0400
Message-ID: <1314815484-4668-5-git-send-email-konrad.wilk@oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42989 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1HaSdb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2011 14:33:31 -0400
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jose
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

to make a hypercall to restore the vectors in the MSI/MSI-X
configuration space.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c              |   12 ++++++++++++
 include/xen/interface/physdev.h |    7 +++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index f567965..f140999 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -241,6 +241,17 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 out:
 	return ret;
 }
+
+static void xen_initdom_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	int ret = 0;
+	struct physdev_restore_msi restore;
+
+	restore.bus = dev->bus->number;
+	restore.devfn = dev->devfn;
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi, &restore);
+	WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
+}
 #endif
 #endif
 
@@ -458,6 +469,7 @@ static int __init pci_xen_initial_domain(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index 534cac8..44aefa9 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -144,6 +144,13 @@ struct physdev_manage_pci {
 	uint8_t devfn;
 };
 
+#define PHYSDEVOP_restore_msi            19
+struct physdev_restore_msi {
+	/* IN */
+	uint8_t bus;
+	uint8_t devfn;
+};
+
 #define PHYSDEVOP_manage_pci_add_ext	20
 struct physdev_manage_pci_ext {
 	/* IN */
-- 
1.7.4.1

