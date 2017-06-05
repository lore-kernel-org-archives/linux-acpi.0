From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 30/53] ACPICA: Update error message for field beyond buffer case
Date: Mon,  5 Jun 2017 16:40:08 +0800
Message-ID: <f56ea5b5fbbeca8b7e51f0ac208a6e95121e2c5d.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdFEIkN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:13 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7a6b9c0b31cfb1606a6348404fee670b2d18743c

Improve/clarify the problem of a field definition beyond the limit
of the target buffer.

Link: https://github.com/acpica/acpica/commit/7a6b9c0b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsopcode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 9a8f8a9..dfc3c25 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -227,13 +227,12 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 
 	/* Entire field must fit within the current length of the buffer */
 
-	if ((bit_offset + bit_count) > (8 * (u32) buffer_desc->buffer.length)) {
+	if ((bit_offset + bit_count) > (8 * (u32)buffer_desc->buffer.length)) {
 		ACPI_ERROR((AE_INFO,
-			    "Field [%4.4s] at %u exceeds Buffer [%4.4s] size %u (bits)",
-			    acpi_ut_get_node_name(result_desc),
-			    bit_offset + bit_count,
-			    acpi_ut_get_node_name(buffer_desc->buffer.node),
-			    8 * (u32) buffer_desc->buffer.length));
+			    "Field [%4.4s] at bit offset/length %u/%u "
+			    "exceeds size of target Buffer (%u bits)",
+			    acpi_ut_get_node_name(result_desc), bit_offset,
+			    bit_count, 8 * (u32)buffer_desc->buffer.length));
 		status = AE_AML_BUFFER_LIMIT;
 		goto cleanup;
 	}
-- 
2.7.4

