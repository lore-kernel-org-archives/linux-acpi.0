From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/30] ACPICA: Hardware: Enhance acpi_hw_validate_register() with access_width/bit_offset awareness
Date: Thu, 24 Mar 2016 09:41:09 +0800
Message-ID: <2fb98494a7434b63703b68cc44283a6d4e87a332.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 997a90f810a4cb78604ef2e187611a181b498286

This patch enhances acpi_hw_validate_register() to sanitize register
accesses with awareness of access_width and bit_offset. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/997a90f8
Link: https://bugs.acpica.org/show_bug.cgi?id=1240
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 93f8831..bc3f60a 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -83,6 +83,8 @@ acpi_status
 acpi_hw_validate_register(struct acpi_generic_address *reg,
 			  u8 max_bit_width, u64 *address)
 {
+	u8 bit_width;
+	u8 access_width;
 
 	/* Must have a valid pointer to a GAS structure */
 
@@ -109,23 +111,26 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
 		return (AE_SUPPORT);
 	}
 
-	/* Validate the bit_width */
+	/* Validate the access_width */
 
-	if ((reg->bit_width != 8) &&
-	    (reg->bit_width != 16) &&
-	    (reg->bit_width != 32) && (reg->bit_width != max_bit_width)) {
+	if (reg->access_width > 4) {
 		ACPI_ERROR((AE_INFO,
-			    "Unsupported register bit width: 0x%X",
-			    reg->bit_width));
+			    "Unsupported register access width: 0x%X",
+			    reg->access_width));
 		return (AE_SUPPORT);
 	}
 
-	/* Validate the bit_offset. Just a warning for now. */
+	/* Validate the bit_width, convert access_width into number of bits */
 
-	if (reg->bit_offset != 0) {
+	access_width = reg->access_width ? reg->access_width : 1;
+	access_width = 1 << (access_width + 2);
+	bit_width =
+	    ACPI_ROUND_UP(reg->bit_offset + reg->bit_width, access_width);
+	if (max_bit_width < bit_width) {
 		ACPI_WARNING((AE_INFO,
-			      "Unsupported register bit offset: 0x%X",
-			      reg->bit_offset));
+			      "Requested bit width 0x%X is smaller than register bit width 0x%X",
+			      max_bit_width, bit_width));
+		return (AE_SUPPORT);
 	}
 
 	return (AE_OK);
-- 
1.7.10
