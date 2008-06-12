From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/17] ACPICA: Several lint changes, no functional changes
Date: Thu, 12 Jun 2008 00:35:06 -0400
Message-ID: <5e7a03b3c80f3bbf4fc245f3665fb2e4c52fae2b.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:39657 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYFLEfi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:38 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2C00KAS22WEYF6@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:35:21 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Remove pointer cast warnings and fix for a debug printf.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exprep.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exprep.c b/drivers/acpi/executer/exprep.c
index 3a2f8cd..5d438c3 100644
--- a/drivers/acpi/executer/exprep.c
+++ b/drivers/acpi/executer/exprep.c
@@ -503,11 +503,11 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		 */
 		second_desc = obj_desc->common.next_object;
 		second_desc->extra.aml_start =
-		    ((union acpi_parse_object *)(info->data_register_node))->
-		    named.data;
+		    ACPI_CAST_PTR(union acpi_parse_object,
+				  info->data_register_node)->named.data;
 		second_desc->extra.aml_length =
-		    ((union acpi_parse_object *)(info->data_register_node))->
-		    named.length;
+		    ACPI_CAST_PTR(union acpi_parse_object,
+				  info->data_register_node)->named.length;
 
 		break;
 
-- 
1.5.6.rc2.26.g8c37

