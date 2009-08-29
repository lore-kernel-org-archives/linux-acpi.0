From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] ACPICA: Windows compatibility fix: same buffer/string store
Date: Fri, 28 Aug 2009 20:18:01 -0400
Message-ID: <b0de22bdffa2e9a8e280d769c59f866605268484.1251505014.git.len.brown@intel.com>
References: <1251505083-24354-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:52077 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZH2ASP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 20:18:15 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP4002233I9X3K9@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 28 Aug 2009 19:18:10 -0500 (CDT)
In-reply-to: <1251505083-24354-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fix a compatibility issue when the same buffer or string is
stored to itself. This has been seen in the field. Previously,
ACPICA would zero out the buffer/string. Now, the operation is
treated as a NOP.

http://bugzilla.acpica.org/show_bug.cgi?id=803

Reported-by: Rezwanul Kabir <Rezwanul_Kabir@Dell.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exstorob.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 67340cc..257706e 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -70,6 +70,12 @@ acpi_ex_store_buffer_to_buffer(union acpi_operand_object *source_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_store_buffer_to_buffer, source_desc);
 
+	/* If Source and Target are the same, just return */
+
+	if (source_desc == target_desc) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* We know that source_desc is a buffer by now */
 
 	buffer = ACPI_CAST_PTR(u8, source_desc->buffer.pointer);
@@ -161,6 +167,12 @@ acpi_ex_store_string_to_string(union acpi_operand_object *source_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_store_string_to_string, source_desc);
 
+	/* If Source and Target are the same, just return */
+
+	if (source_desc == target_desc) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* We know that source_desc is a string by now */
 
 	buffer = ACPI_CAST_PTR(u8, source_desc->string.pointer);
-- 
1.6.0.6

