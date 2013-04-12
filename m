From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/11] ACPICA: _OSI Support: handle any errors from AcpiOsAcquireMutex
Date: Fri, 12 Apr 2013 08:24:34 +0800
Message-ID: <78a2c4f085c8019e9825183e7f75001a19a689ff.1365473141.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28645 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3DLAYn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:24:43 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Lv Zheng <lv.zheng@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

Check for any errors. Handles possible timeout case if
ACPI_WAIT_FOREVER is changed to be less than "forever".
Jung-uk Kim.

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h |    2 +-
 drivers/acpi/acpica/utosi.c   |   26 ++++++++++++++++++++------
 drivers/acpi/acpica/utxface.c |   17 +++++++++++++----
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 8c25bb0..bbeb961 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -421,7 +421,7 @@ acpi_ut_get_object_size(union acpi_operand_object *obj, acpi_size * obj_length);
  */
 acpi_status acpi_ut_initialize_interfaces(void);
 
-void acpi_ut_interface_terminate(void);
+acpi_status acpi_ut_interface_terminate(void);
 
 acpi_status acpi_ut_install_interface(acpi_string interface_name);
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 36a7d36..b15aceb 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -108,9 +108,14 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 
 acpi_status acpi_ut_initialize_interfaces(void)
 {
+	acpi_status status;
 	u32 i;
 
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
 	acpi_gbl_supported_interfaces = acpi_default_supported_interfaces;
 
 	/* Link the static list of supported interfaces */
@@ -132,20 +137,24 @@ acpi_status acpi_ut_initialize_interfaces(void)
  *
  * PARAMETERS:  None
  *
- * RETURN:      None
+ * RETURN:      Status
  *
  * DESCRIPTION: Delete all interfaces in the global list. Sets
  *              acpi_gbl_supported_interfaces to NULL.
  *
  ******************************************************************************/
 
-void acpi_ut_interface_terminate(void)
+acpi_status acpi_ut_interface_terminate(void)
 {
+	acpi_status status;
 	struct acpi_interface_info *next_interface;
 
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
-	next_interface = acpi_gbl_supported_interfaces;
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
+	next_interface = acpi_gbl_supported_interfaces;
 	while (next_interface) {
 		acpi_gbl_supported_interfaces = next_interface->next;
 
@@ -160,6 +169,7 @@ void acpi_ut_interface_terminate(void)
 	}
 
 	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (AE_OK);
 }
 
 /*******************************************************************************
@@ -315,6 +325,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state * walk_state)
 	union acpi_operand_object *return_desc;
 	struct acpi_interface_info *interface_info;
 	acpi_interface_handler interface_handler;
+	acpi_status status;
 	u32 return_value;
 
 	ACPI_FUNCTION_TRACE(ut_osi_implementation);
@@ -336,7 +347,10 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state * walk_state)
 	/* Default return value is 0, NOT SUPPORTED */
 
 	return_value = 0;
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
 	/* Lookup the interface in the global _OSI list */
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 48efb44..6505774 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -287,7 +287,10 @@ acpi_status acpi_install_interface(acpi_string interface_name)
 		return (AE_BAD_PARAMETER);
 	}
 
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
 	/* Check if the interface name is already in the global list */
 
@@ -336,7 +339,10 @@ acpi_status acpi_remove_interface(acpi_string interface_name)
 		return (AE_BAD_PARAMETER);
 	}
 
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
 	status = acpi_ut_remove_interface(interface_name);
 
@@ -362,9 +368,12 @@ ACPI_EXPORT_SYMBOL(acpi_remove_interface)
  ****************************************************************************/
 acpi_status acpi_install_interface_handler(acpi_interface_handler handler)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 
-	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
 
 	if (handler && acpi_gbl_interface_handler) {
 		status = AE_ALREADY_EXISTS;
-- 
1.7.10

