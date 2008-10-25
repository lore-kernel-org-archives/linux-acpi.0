From: Matthew Wilcox <matthew@wil.cx>
Subject: Doing _OSC right
Date: Fri, 24 Oct 2008 23:30:29 -0600
Message-ID: <20081025053029.GT26094@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org


Andrew Patterson recently reported a problem where a machine with dozens
of PCIe root bridges would take half an hour just calling _OSC.  The
root cause is the AER code calling:

	pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);

for each bridge.  pcie_osc_support_set() also iterates over each bridge,
so _OSC is called a quadratic number of times.  Obviously, this isn't
hard to fix -- just moving the call to pcie_osc_support_set() to
aer_service_init() would do.

But why should a driver be calling pcie_osc_support_set() anyway?  This
is something the PCI core should be taking care of for it.

The patch below illustrates one possible solution.  I create a new
function (pci_acpi_osc_support()) which is called from pci_root.c before
we call any other methods on the device (as recommended by the ACPI spec).
Since we know what capabilities the system supports, individual modules
do not now need to inform the core of their support for various
capabilities.

I do not think this patch is perfect.  One defect is that there are
now no callers of pci_osc_support_set nor pcie_osc_support_set, so they
could be deleted.

Another problem is that if, for example, MSI is disabled at boot time,
we will incorrectly inform ACPI that we support MSI.  So something more
flexible is needed.

I think all the existing _OSC code should be moved from pci-acpi.c to
pci_root.c.  I also think the acpi_osc_data should be made part of the
acpi_pci_root struct, eliminating a separate allocation.

We could also use an interface that iterates over all existing busses
calling _OSC with new flags.  Shouldn't be hard, once it's integrated
into pci_root.c.

Further ahead, we don't actually check that the bits we asked for (in
'control') were actually granted to us.  The PCI firmware spec is quite
explicit about interdependencies amongst the bits.

We also need to re-evaluate _OSC when coming out of S4.  I'm not much of
a power-management maven so I don't know where to put this call.

Thoughts on the road ahead?

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 1b8f67d..3af9fff 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -210,6 +211,18 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	device->ops.bind = acpi_pci_bind;
 
+	pci_acpi_osc_support(device->handle,
+					OSC_EXT_PCI_CONFIG_SUPPORT |
+					OSC_PCI_SEGMENT_GROUPS_SUPPORT |
+#ifdef CONFIG_PCI_MSI
+					OSC_MSI_SUPPORT |
+#endif
+#ifdef CONFIG_PCIEASPM
+					OSC_ACTIVE_STATE_PWR_SUPPORT |
+					OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
+#endif
+					0);
+
 	/* 
 	 * Segment
 	 * -------
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 74801f7..d281201 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -759,24 +759,3 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->msi_list);
 }
-
-#ifdef CONFIG_ACPI
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-static void __devinit msi_acpi_init(void)
-{
-	if (acpi_pci_disabled)
-		return;
-	pci_osc_support_set(OSC_MSI_SUPPORT);
-	pcie_osc_support_set(OSC_MSI_SUPPORT);
-}
-#else
-static inline void msi_acpi_init(void) { }
-#endif /* CONFIG_ACPI */
-
-void __devinit msi_init(void)
-{
-	if (!pci_msi_enable)
-		return;
-	msi_acpi_init();
-}
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dfe7c8e..3ec5ecc 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -139,28 +139,41 @@ static acpi_status __acpi_query_osc(u32 flags, struct acpi_osc_data *osc_data,
 	return status;
 }
 
-static acpi_status acpi_query_osc(acpi_handle handle,
-				  u32 level, void *context, void **retval)
+/*
+ * acpi_osc_support: Invoke _OSC indicating support for the given feature
+ * flags: Bitmask of flags to support
+ *
+ * See the ACPI spec for the definition of the flags
+ */
+int pci_acpi_osc_support(acpi_handle handle, u32 flags)
 {
+	u32 dummy;
 	acpi_status status;
-	struct acpi_osc_data *osc_data;
-	u32 flags = (unsigned long)context, dummy;
 	acpi_handle tmp;
+	struct acpi_osc_data *osc_data;
+	int rc = 0;
 
 	status = acpi_get_handle(handle, "_OSC", &tmp);
 	if (ACPI_FAILURE(status))
-		return AE_OK;
-
+		return -ENODEV;
 	mutex_lock(&pci_acpi_lock);
 	osc_data = acpi_get_osc_data(handle);
 	if (!osc_data) {
 		printk(KERN_ERR "acpi osc data array is full\n");
+		rc = -ENOMEM;
 		goto out;
 	}
 
 	__acpi_query_osc(flags, osc_data, &dummy);
-out:
+ out:
 	mutex_unlock(&pci_acpi_lock);
+	return rc;
+}
+
+static acpi_status acpi_query_osc(acpi_handle handle, u32 level,
+						void *context, void **retval)
+{
+	pci_acpi_osc_support(handle, (unsigned long)context);
 	return AE_OK;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 21f2ac6..44d00c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2037,8 +2037,6 @@ static int __devinit pci_init(void)
 		pci_fixup_device(pci_fixup_final, dev);
 	}
 
-	msi_init();
-
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9de87e9..b205ab8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -98,11 +98,9 @@ extern unsigned int pci_pm_d3_delay;
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
 extern void pci_msi_init_pci_dev(struct pci_dev *dev);
-extern void __devinit msi_init(void);
 #else
 static inline void pci_no_msi(void) { }
 static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
-static inline void msi_init(void) { }
 #endif
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 6dd7b13..ebce26c 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -38,7 +38,6 @@ int aer_osc_setup(struct pcie_device *pciedev)
 
 	handle = acpi_find_root_bridge_handle(pdev);
 	if (handle) {
-		pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
 		status = pci_osc_control_set(handle,
 					OSC_PCI_EXPRESS_AER_CONTROL |
 					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8f63f4c..2c87883 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -833,25 +833,3 @@ void pcie_no_aspm(void)
 	if (!aspm_force)
 		aspm_disabled = 1;
 }
-
-#ifdef CONFIG_ACPI
-#include <acpi/acpi_bus.h>
-#include <linux/pci-acpi.h>
-static void pcie_aspm_platform_init(void)
-{
-	pcie_osc_support_set(OSC_ACTIVE_STATE_PWR_SUPPORT|
-		OSC_CLOCK_PWR_CAPABILITY_SUPPORT);
-}
-#else
-static inline void pcie_aspm_platform_init(void) { }
-#endif
-
-static int __init pcie_aspm_init(void)
-{
-	if (aspm_disabled)
-		return 0;
-	pcie_aspm_platform_init();
-	return 0;
-}
-
-fs_initcall(pcie_aspm_init);
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index d1fcd7e..ec048d3 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -605,17 +605,17 @@ static int sym_eh_handler(int op, char *opname, struct scsi_cmnd *cmd)
  * interrupt.  This can happen for a number of reasons, including buggy
  * hardware and interrupt handler failures.
  */
-static enum scsi_eh_timer_return sym53c8xx_eh_timed_out(struct scsi_cmnd *cmd)
+static enum blk_eh_timer_return sym53c8xx_eh_timed_out(struct scsi_cmnd *cmd)
 {
 	static int printed_warning;
 	int result = sym53c8xx_intr(0, cmd->device->host);
 
 	if (result == IRQ_NONE)
-		return EH_NOT_HANDLED;
+		return BLK_EH_NOT_HANDLED;
 
 	/* When commands have been handled, host_data is set to NULL */
 	if (cmd->host_data)
-		return EH_NOT_HANDLED;
+		return BLK_EH_NOT_HANDLED;
 
 	if (!printed_warning) {
 		scmd_printk(KERN_ERR, cmd, "Command timed out and was "
@@ -624,7 +624,7 @@ static enum scsi_eh_timer_return sym53c8xx_eh_timed_out(struct scsi_cmnd *cmd)
 		printed_warning = 1;
 	}
 
-	return EH_HANDLED;
+	return BLK_EH_HANDLED;
 }
 
 static int sym53c8xx_eh_abort_handler(struct scsi_cmnd *cmd)
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8837928..424f06f 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -8,6 +8,8 @@
 #ifndef _PCI_ACPI_H_
 #define _PCI_ACPI_H_
 
+#include <linux/acpi.h>
+
 #define OSC_QUERY_TYPE			0
 #define OSC_SUPPORT_TYPE 		1
 #define OSC_CONTROL_TYPE		2
@@ -49,6 +51,7 @@
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
 extern acpi_status __pci_osc_support_set(u32 flags, const char *hid);
+int pci_acpi_osc_support(acpi_handle handle, u32 flags);
 static inline acpi_status pci_osc_support_set(u32 flags)
 {
 	return __pci_osc_support_set(flags, PCI_ROOT_HID_STRING);

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
