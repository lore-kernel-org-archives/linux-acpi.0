From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/19] ACPICA: Hardware: Fix a resource leak issue in acpi_hw_build_pci_list().
Date: Thu, 21 May 2015 10:31:12 +0800
Message-ID: <6ccad2f9b014a0b65f1a770122cf7a018eee856f.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30673 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbbEUCbb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 May 2015 22:31:31 -0400
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit e4f0b73c107680841d7dd01cc04ec108df6580bd

There is code in acpi_hw_build_pci_list() destructing returned object
(return_list_head) before touching it while the allocated new object
(list_head) is not tracked correctly to be destructed on the error case,
which is detected as unsecure code by the "Coverity" tool.

This patch fixes this issue by always intializing the returned object in
acpi_hw_build_pci_list() so that the caller of acpi_hw_build_pci_list() needn't
initialize it and always using the returned object to track the new
allocated objects. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e4f0b73c
Reference: https://jira01.devtools.intel.com/browse/LCK-2143
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwpci.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index c5214de..f785ea7 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -123,7 +123,7 @@ acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region)
 {
 	acpi_status status;
-	struct acpi_pci_device *list_head = NULL;
+	struct acpi_pci_device *list_head;
 
 	ACPI_FUNCTION_TRACE(hw_derive_pci_id);
 
@@ -177,13 +177,13 @@ acpi_hw_build_pci_list(acpi_handle root_pci_device,
 	acpi_handle parent_device;
 	acpi_status status;
 	struct acpi_pci_device *list_element;
-	struct acpi_pci_device *list_head = NULL;
 
 	/*
 	 * Ascend namespace branch until the root_pci_device is reached, building
 	 * a list of device nodes. Loop will exit when either the PCI device is
 	 * found, or the root of the namespace is reached.
 	 */
+	*return_list_head = NULL;
 	current_device = pci_region;
 	while (1) {
 		status = acpi_get_parent(current_device, &parent_device);
@@ -198,7 +198,6 @@ acpi_hw_build_pci_list(acpi_handle root_pci_device,
 		/* Finished when we reach the PCI root device (PNP0A03 or PNP0A08) */
 
 		if (parent_device == root_pci_device) {
-			*return_list_head = list_head;
 			return (AE_OK);
 		}
 
@@ -213,9 +212,9 @@ acpi_hw_build_pci_list(acpi_handle root_pci_device,
 
 		/* Put new element at the head of the list */
 
-		list_element->next = list_head;
+		list_element->next = *return_list_head;
 		list_element->device = parent_device;
-		list_head = list_element;
+		*return_list_head = list_element;
 
 		current_device = parent_device;
 	}
-- 
1.7.10

