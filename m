From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/18] ACPICA: Add error msg for Index/Bank field registers
 out-of-range
Date: Sun, 11 Dec 2011 12:45:35 -0500
Message-ID: <7072c90857d690ce071d8846c3606d1fab3de86d.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63198 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1LKRqS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 12:46:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW100K28W0LMVG0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 11:46:03 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Supplement the exception code with an actual message.

Found during ACPICA debugging.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exfldio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index f915a7f..19df8ce 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -316,6 +316,7 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 static u8
 acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
 {
+	ACPI_FUNCTION_NAME(ex_register_overflow);
 
 	if (obj_desc->common_field.bit_length >= ACPI_INTEGER_BIT_SIZE) {
 		/*
@@ -330,6 +331,11 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
 		 * The Value is larger than the maximum value that can fit into
 		 * the register.
 		 */
+		ACPI_ERROR((AE_INFO,
+			    "Index value 0x%8.8X%8.8X overflows field width 0x%X",
+			    ACPI_FORMAT_UINT64(value),
+			    obj_desc->common_field.bit_length));
+
 		return (TRUE);
 	}
 
-- 
1.7.7.rc0.72.g4b5ea

