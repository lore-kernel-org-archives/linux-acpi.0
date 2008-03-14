From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 11:49:09 +0800
Message-ID: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39555 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbYCNDwX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 23:52:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>

asus_hides_smbus_lpc_ich6() is called with interrupt disabled in resume
time, but ioremap_nocache() and iounmap() can't be called with interrupt
disabled. Below is my debug fix. If you have better fix, please speak. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e571c72..2abb85a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -289,6 +289,9 @@ static int pci_device_suspend(struct device * dev, pm_message_t state)
 		if (pci_dev->current_state == PCI_D0)
 			pci_dev->current_state = PCI_UNKNOWN;
 	}
+
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
 	return i;
 }
 
@@ -334,6 +337,7 @@ static int pci_device_resume(struct device * dev)
 		error = drv->resume(pci_dev);
 	else
 		error = pci_default_resume(pci_dev);
+	pci_fixup_device(pci_fixup_resume_later, pci_dev);
 	return error;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e9a333d..32e9b61 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1100,23 +1100,53 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	as
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc);
 
-static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+/* It appears we just have one such device. If not, we have a warning */
+static void __iomem *asus_rcba_base;
+static void asus_hides_smbus_lpc_ich6_suspend(struct pci_dev *dev)
 {
-	u32 val, rcba;
-	void __iomem *base;
+	u32 rcba;
 
 	if (likely(!asus_hides_smbus))
 		return;
+	WARN_ON(asus_rcba_base);
+
 	pci_read_config_dword(dev, 0xF0, &rcba);
-	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000); /* use bits 31:14, 16 kB aligned */
-	if (base == NULL) return;
-	val=readl(base + 0x3418); /* read the Function Disable register, dword mode only */
-	writel(val & 0xFFFFFFF7, base + 0x3418); /* enable the SMBus device */
-	iounmap(base);
+	/* use bits 31:14, 16 kB aligned */
+	asus_rcba_base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000);
+	if (asus_rcba_base == NULL)
+		return;
+}
+
+static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
+{
+	u32 val;
+
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+	/* read the Function Disable register, dword mode only */
+	val = readl(asus_rcba_base + 0x3418);
+	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418); /* enable the SMBus device */
+}
+
+static void asus_hides_smbus_lpc_ich6_resume_later(struct pci_dev *dev)
+{
+	if (likely(!asus_hides_smbus || !asus_rcba_base))
+		return;
+	iounmap(asus_rcba_base);
+	asus_rcba_base = NULL;
 	dev_info(&dev->dev, "Enabled ICH6/i801 SMBus device\n");
 }
+
+static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+{
+	asus_hides_smbus_lpc_ich6_suspend(dev);
+	asus_hides_smbus_lpc_ich6_resume(dev);
+	asus_hides_smbus_lpc_ich6_resume_later(dev);
+}
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
+DECLARE_PCI_FIXUP_RESUME_LATER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_later);
 
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
@@ -1521,6 +1551,10 @@ extern struct pci_fixup __start_pci_fixups_enable[];
 extern struct pci_fixup __end_pci_fixups_enable[];
 extern struct pci_fixup __start_pci_fixups_resume[];
 extern struct pci_fixup __end_pci_fixups_resume[];
+extern struct pci_fixup __start_pci_fixups_resume_later[];
+extern struct pci_fixup __end_pci_fixups_resume_later[];
+extern struct pci_fixup __start_pci_fixups_suspend[];
+extern struct pci_fixup __end_pci_fixups_suspend[];
 

 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
@@ -1553,6 +1587,16 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		end = __end_pci_fixups_resume;
 		break;
 
+	case pci_fixup_resume_later:
+		start = __start_pci_fixups_resume_later;
+		end = __end_pci_fixups_resume_later;
+		break;
+
+	case pci_fixup_suspend:
+		start = __start_pci_fixups_suspend;
+		end = __end_pci_fixups_suspend;
+		break;
+
 	default:
 		/* stupid compiler warning, you would think with an enum... */
 		return;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f054778..06ac714 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -84,6 +84,12 @@
 		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
 		*(.pci_fixup_resume)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume_later) = .;	\
+		*(.pci_fixup_resume_later)				\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume_later) = .;	\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
+		*(.pci_fixup_suspend)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
 	}								\
 									\
 	/* RapidIO route ops */						\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9010f54..821ad02 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1016,6 +1016,8 @@ enum pci_fixup_pass {
 	pci_fixup_final,	/* Final phase of device fixups */
 	pci_fixup_enable,	/* pci_enable_device() time */
 	pci_fixup_resume,	/* pci_enable_device() time */
+	pci_fixup_suspend,
+	pci_fixup_resume_later,
 };
 
 /* Anonymous variables would be nice... */
@@ -1037,6 +1039,12 @@ enum pci_fixup_pass {
 #define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
 			resume##vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_RESUME_LATER(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_later,			\
+			resume_later##vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_SUSPEND(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,			\
+			suspend##vendor##device##hook, vendor, device, hook)
 

 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);


