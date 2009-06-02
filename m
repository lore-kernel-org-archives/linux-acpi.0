From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 03/10] ACPI: export acpi_pci_find_root()
Date: Tue, 02 Jun 2009 09:24:51 -0600
Message-ID: <20090602152451.7346.99317.stgit@bob.kio>
References: <20090602152351.7346.48697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090602152351.7346.48697.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This function is useful for pci_bind.c as well.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/pci_root.c |   33 ++++++++++-----------------------
 include/acpi/acpi_bus.h |   13 +++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 853a6e4..bcab69a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -61,19 +61,6 @@ static struct acpi_driver acpi_pci_root_driver = {
 		},
 };
 
-struct acpi_pci_root {
-	struct list_head node;
-	struct acpi_device * device;
-	struct acpi_pci_id id;
-	struct pci_bus *bus;
-
-	u32 osc_support_set;	/* _OSC state of support bits */
-	u32 osc_control_set;	/* _OSC state of control bits */
-	u32 osc_control_qry;	/* the latest _OSC query result */
-
-	u32 osc_queried:1;	/* has _OSC control been queried? */
-};
-
 static LIST_HEAD(acpi_pci_roots);
 
 static struct acpi_pci_driver *sub_driver;
@@ -183,6 +170,16 @@ out:
 }
 EXPORT_SYMBOL_GPL(acpi_is_root_bridge);
 
+struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
+{
+	struct acpi_pci_root *root;
+	list_for_each_entry(root, &acpi_pci_roots, node) {
+		if (root->device->handle == handle)
+			return root;
+	}
+	return NULL;
+}
+
 static acpi_status
 get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
@@ -336,16 +333,6 @@ static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
 	return status;
 }
 
-static struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
-{
-	struct acpi_pci_root *root;
-	list_for_each_entry(root, &acpi_pci_roots, node) {
-		if (root->device->handle == handle)
-			return root;
-	}
-	return NULL;
-}
-
 /**
  * acpi_pci_osc_control_set - commit requested control to Firmware
  * @handle: acpi_handle for the target ACPI object
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 494088b..38f2bff 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -371,9 +371,22 @@ struct device *acpi_get_physical_device(acpi_handle);
 struct device *acpi_get_physical_pci_device(acpi_handle);
 
 /* helper */
+struct acpi_pci_root {
+	struct list_head node;
+	struct acpi_device *device;
+	struct acpi_pci_id id;
+	struct pci_bus *bus;
+
+	u32 osc_support_set;	/* _OSC state of support bits */
+	u32 osc_control_set;	/* _OSC state of control bits */
+	u32 osc_control_qry;	/* the latest _OSC query result */
+
+	u32 osc_queried:1;	/* has _OSC control been queried? */
+};
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 int acpi_is_root_bridge(acpi_handle);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
+struct acpi_pci_root *acpi_pci_find_root(acpi_handle);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
 #ifdef CONFIG_PM_SLEEP
