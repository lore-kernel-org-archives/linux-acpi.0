From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/15] ACPICA: Disassembler: Enhance resource descriptor detection
Date: Wed, 26 Apr 2017 16:17:43 +0800
Message-ID: <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43652 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949888AbdDZIRr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:17:47 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ba5020b2dbe1538e4ccd7ac2dfd8843a690c007f

This change enhances the detection of resource descriptors
within a buffer object. For the end_tag opcode, the second byte
is defined to be either a checksum or zero. All known ASL compilers
insert a zero for this byte. The disassembler now ensures this
byte is zero before deciding that a buffer should be disassembled
to a resource descriptor. This helps eliminate incorrect decisions
when attempting to disassemble a buffer to a resource descriptor.

Link: https://github.com/acpica/acpica/commit/ba5020b2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index ff096d9..e0587c8 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -474,6 +474,15 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
 			}
 
+			/*
+			 * The end_tag opcode must be followed by a zero byte.
+			 * Although this byte is technically defined to be a checksum,
+			 * in practice, all ASL compilers set this byte to zero.
+			 */
+			if (*(aml + 1) != 0) {
+				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
+			}
+
 			/* Return the pointer to the end_tag if requested */
 
 			if (!user_function) {
-- 
2.7.4

