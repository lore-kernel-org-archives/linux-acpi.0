From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/94] ACPI: panasonic-laptop.c: remove ACPI_FUNCTION_TRACE
Date: Fri, 09 Jan 2009 04:27:13 -0500
Message-ID: <46422814f988b32d595dd2ce6d43f4c6d3623d41.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZAIJ2d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700BCK6BDP297@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:27 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

ACPI_FUNCTION_TRACE is an internal acpica function.
remove ACPI_FUNCTION_TRACE from driver file

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/panasonic-laptop.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/panasonic-laptop.c b/drivers/misc/panasonic-laptop.c
index 4a1bc64..f30db36 100644
--- a/drivers/misc/panasonic-laptop.c
+++ b/drivers/misc/panasonic-laptop.c
@@ -241,8 +241,6 @@ static int acpi_pcc_write_sset(struct pcc_acpi *pcc, int func, int val)
 	};
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_write_sset");
-
 	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SSET,
 				      &params, NULL);
 
@@ -254,8 +252,6 @@ static inline int acpi_pcc_get_sqty(struct acpi_device *device)
 	unsigned long long s;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_get_sqty");
-
 	status = acpi_evaluate_integer(device->handle, METHOD_HKEY_SQTY,
 				       NULL, &s);
 	if (ACPI_SUCCESS(status))
@@ -274,8 +270,6 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc, u32 *sinf)
 	union acpi_object *hkey = NULL;
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_retrieve_biosdata");
-
 	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, 0,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -501,8 +495,6 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	int key_code, hkey_num;
 	unsigned long long result;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_generate_keyinput");
-
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
 	if (!ACPI_SUCCESS(rc)) {
@@ -538,8 +530,6 @@ static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct pcc_acpi *pcc = (struct pcc_acpi *) data;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_notify");
-
 	switch (event) {
 	case HKEY_NOTIFY:
 		acpi_pcc_generate_keyinput(pcc);
@@ -554,8 +544,6 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 {
 	int i, rc;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_init_input");
-
 	pcc->input_dev = input_allocate_device();
 	if (!pcc->input_dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
@@ -597,8 +585,6 @@ static int acpi_pcc_hotkey_resume(struct acpi_device *device)
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_resume");
-
 	if (device == NULL || pcc == NULL)
 		return -EINVAL;
 
@@ -616,8 +602,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_add");
-
 	if (!device)
 		return -EINVAL;
 
@@ -714,8 +698,6 @@ static int __init acpi_pcc_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_init");
-
 	if (acpi_disabled)
 		return -ENODEV;
 
@@ -733,8 +715,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_remove");
-
 	if (!device || !pcc)
 		return -EINVAL;
 
@@ -757,8 +737,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 
 static void __exit acpi_pcc_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_pcc_exit");
-
 	acpi_bus_unregister_driver(&acpi_pcc_driver);
 }
 
-- 
1.5.6.6

