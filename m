From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/34] ACPI: delete unused acpi_evaluate_string()
Date: Sun, 14 Mar 2010 21:40:48 -0400
Message-ID: <0e026445fb36852d3102cb8bb24868765fe5816a.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:57930 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0COBuw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:50:52 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00CQ3VS33361@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:50:33 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Roel found a logic issue in the #if 0 acpi_evaluate_string():

-           || (element->type != ACPI_TYPE_BUFFER)
+           && (element->type != ACPI_TYPE_BUFFER)

delete the dead code.

pointed-out-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utils.c |   45 ---------------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 811fec1..592dffb 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -289,51 +289,6 @@ acpi_evaluate_integer(acpi_handle handle,
 
 EXPORT_SYMBOL(acpi_evaluate_integer);
 
-#if 0
-acpi_status
-acpi_evaluate_string(acpi_handle handle,
-		     acpi_string pathname,
-		     acpi_object_list * arguments, acpi_string * data)
-{
-	acpi_status status = AE_OK;
-	acpi_object *element = NULL;
-	acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-
-	if (!data)
-		return AE_BAD_PARAMETER;
-
-	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_util_eval_error(handle, pathname, status);
-		return status;
-	}
-
-	element = (acpi_object *) buffer.pointer;
-
-	if ((element->type != ACPI_TYPE_STRING)
-	    || (element->type != ACPI_TYPE_BUFFER)
-	    || !element->string.length) {
-		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
-		return AE_BAD_DATA;
-	}
-
-	*data = kzalloc(element->string.length + 1, GFP_KERNEL);
-	if (!data) {
-		printk(KERN_ERR PREFIX "Memory allocation\n");
-		return -ENOMEM;
-	}
-
-	memcpy(*data, element->string.pointer, element->string.length);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%s]\n", *data));
-
-	kfree(buffer.pointer);
-
-	return AE_OK;
-}
-#endif
-
 acpi_status
 acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
-- 
1.7.0.2.201.g80978

