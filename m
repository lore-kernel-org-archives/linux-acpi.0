From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 2/8] ACPI, PCI: call _OSC support during root bridge discovery
Date: Tue, 28 Oct 2008 23:48:26 -0600
Message-ID: <20081029054826.2263.48713.stgit@bob.kio>
References: <20081029054815.2263.40833.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081029054815.2263.40833.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

ACPI, PCI: call _OSC support during root bridge discovery

Added pci_acpi_isc_support() which is called when a PCI bridge is
added, so individual PCI root bridge drivers do not have to call _OSC
support for every root bridge in their probe functions.
---

 drivers/acpi/pci_root.c  |    6 ++++++
 drivers/pci/pci-acpi.c   |   24 +++++++++++++++++++-----
 include/linux/pci-acpi.h |    1 +
 3 files changed, 26 insertions(+), 5 deletions(-)


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 1b8f67d..47df4a8 100644
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
@@ -210,6 +211,11 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	device->ops.bind = acpi_pci_bind;
 
+	pci_acpi_osc_support(device->handle,
+			     OSC_EXT_PCI_CONFIG_SUPPORT |
+			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
+			     0);
+
 	/* 
 	 * Segment
 	 * -------
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dfe7c8e..f457387 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -139,28 +139,42 @@ static acpi_status __acpi_query_osc(u32 flags, struct acpi_osc_data *osc_data,
 	return status;
 }
 
-static acpi_status acpi_query_osc(acpi_handle handle,
-				  u32 level, void *context, void **retval)
+/*
+ * pci_acpi_osc_support: Invoke _OSC indicating support for the given feature
+ * @flags: Bitmask of flags to support
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
+		return -ENOTTY;
 
 	mutex_lock(&pci_acpi_lock);
 	osc_data = acpi_get_osc_data(handle);
 	if (!osc_data) {
 		printk(KERN_ERR "acpi osc data array is full\n");
+		rc = -ENOMEM;
 		goto out;
 	}
 
 	__acpi_query_osc(flags, osc_data, &dummy);
 out:
 	mutex_unlock(&pci_acpi_lock);
+	return rc;
+}
+
+static acpi_status acpi_query_osc(acpi_handle handle, u32 level,
+				  void *context, void **retval)
+{
+	pci_acpi_osc_support(handle, (unsigned long)context);
 	return AE_OK;
 }
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index a9e4c34..424f06f 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -51,6 +51,7 @@
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
 extern acpi_status __pci_osc_support_set(u32 flags, const char *hid);
+int pci_acpi_osc_support(acpi_handle handle, u32 flags);
 static inline acpi_status pci_osc_support_set(u32 flags)
 {
 	return __pci_osc_support_set(flags, PCI_ROOT_HID_STRING);
