From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/84] ACPICA: Several lint changes, no functional changes
Date: Sat, 28 Jun 2008 01:43:41 -0400
Message-ID: <135f0f863cbeb83f26beefcd641675acca9b18a3.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61921 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYF1FpK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:10 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500HDTRZ8JGJA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:09 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
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
1.5.6.1.89.gd544

