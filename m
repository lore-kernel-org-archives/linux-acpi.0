From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/94] ACPI: ec.c: call acpi_get_name to get node name
Date: Fri, 09 Jan 2009 04:27:05 -0500
Message-ID: <0175d562a29ad052c510782c7e76bc63d5155b9b.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZAIJ2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700E6H6BAPGT2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:23 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

acpi_namespace_node is internal struct, it should not be used outside of ACPICA
call acpi_get_name to get node ascii name

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 30f3ef2..2cbc2c9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -756,10 +756,15 @@ static acpi_status
 acpi_ec_register_query_methods(acpi_handle handle, u32 level,
 			       void *context, void **return_value)
 {
-	struct acpi_namespace_node *node = handle;
+	char node_name[5];
+	struct acpi_buffer buffer = { sizeof(node_name), node_name };
 	struct acpi_ec *ec = context;
 	int value = 0;
-	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
+	acpi_status status;
+
+	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+
+	if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) == 1) {
 		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
 	}
 	return AE_OK;
-- 
1.5.6.6

