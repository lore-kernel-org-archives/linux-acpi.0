From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/27] ACPICA: Update handling of PCI ID lists.
Date: Wed, 30 Apr 2014 10:04:20 +0800
Message-ID: <d6a663f690cde8e3a40ca0262cdd43b344df48c7.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

More of a style cleanup. if hw_build_pci_list is to return a non-zero
status, it now deletes any partial ID list that has been constructed.
if it returns AE_OK, the caller is responsible for list deletion.
David Box.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwpci.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index e701d8c..6aade8e 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -140,11 +140,12 @@ acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		/* Walk the list, updating the PCI device/function/bus numbers */
 
 		status = acpi_hw_process_pci_list(pci_id, list_head);
-	}
 
-	/* Always delete the list */
+		/* Delete the list */
+
+		acpi_hw_delete_pci_list(list_head);
+	}
 
-	acpi_hw_delete_pci_list(list_head);
 	return_ACPI_STATUS(status);
 }
 
@@ -187,6 +188,10 @@ acpi_hw_build_pci_list(acpi_handle root_pci_device,
 	while (1) {
 		status = acpi_get_parent(current_device, &parent_device);
 		if (ACPI_FAILURE(status)) {
+
+			/* Must delete the list before exit */
+
+			acpi_hw_delete_pci_list(*return_list_head);
 			return (status);
 		}
 
@@ -199,6 +204,10 @@ acpi_hw_build_pci_list(acpi_handle root_pci_device,
 
 		list_element = ACPI_ALLOCATE(sizeof(struct acpi_pci_device));
 		if (!list_element) {
+
+			/* Must delete the list before exit */
+
+			acpi_hw_delete_pci_list(*return_list_head);
 			return (AE_NO_MEMORY);
 		}
 
-- 
1.7.10
