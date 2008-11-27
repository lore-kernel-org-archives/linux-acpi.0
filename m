From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/11] ACPI: scheduling in atomic via acpi_evaluate_integer ()
Date: Thu, 27 Nov 2008 02:25:08 -0500
Message-ID: <40599072dca3ec7d4c9ff8271978be169f974638.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:56663 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYK0HZW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAZ00I73DY9B389@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:22 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>

From: Pavel Machek <pavel@suse.cz>

Now I know why I had strange "scheduling in atomic" problems:
acpi_evaluate_integer() does malloc(..., irqs_disabled() ? GFP_ATOMIC
: GFP_KERNEL)... which is (of course) broken.

There's no way to reliably tell if we need GFP_ATOMIC or not from
code, this one for example fails to detect spinlocks held.

Fortunately, allocation seems small enough to be done on stack.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Acked-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utils.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index e827be3..f844941 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -259,34 +259,26 @@ acpi_evaluate_integer(acpi_handle handle,
 		      struct acpi_object_list *arguments, unsigned long long *data)
 {
 	acpi_status status = AE_OK;
-	union acpi_object *element;
+	union acpi_object element;
 	struct acpi_buffer buffer = { 0, NULL };
 
-
 	if (!data)
 		return AE_BAD_PARAMETER;
 
-	element = kzalloc(sizeof(union acpi_object), irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
-	if (!element)
-		return AE_NO_MEMORY;
-
 	buffer.length = sizeof(union acpi_object);
-	buffer.pointer = element;
+	buffer.pointer = &element;
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
-		kfree(element);
 		return status;
 	}
 
-	if (element->type != ACPI_TYPE_INTEGER) {
+	if (element.type != ACPI_TYPE_INTEGER) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
-		kfree(element);
 		return AE_BAD_DATA;
 	}
 
-	*data = element->integer.value;
-	kfree(element);
+	*data = element.integer.value;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%llu]\n", *data));
 
-- 
1.5.6.5

