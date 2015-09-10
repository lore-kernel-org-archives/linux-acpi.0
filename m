From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ACPICA: fix possible NULL dereference
Date: Thu, 10 Sep 2015 15:49:28 +0530
Message-ID: <1441880368-17718-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36570 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbbIJKTj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2015 06:19:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

acpi_ns_get_secondary_object() can return NULL, and if it returns NULL
then we were dereferencing it while calling acpi_ds_execute_arguments().

Lets have a NULL check and return AE_NOT_EXIST.	

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/acpi/acpica/dsargs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index e2ab59e..4bb8952 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -192,6 +192,9 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 	/* Get the AML pointer (method object) and buffer_field node */
 
 	extra_desc = acpi_ns_get_secondary_object(obj_desc);
+	if (!extra_desc)
+		return_ACPI_STATUS(AE_NOT_EXIST);
+
 	node = obj_desc->buffer_field.node;
 
 	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname(ACPI_TYPE_BUFFER_FIELD,
-- 
1.9.1

