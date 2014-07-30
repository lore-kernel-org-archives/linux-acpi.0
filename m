From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/17] ACPICA: Update for comments/formatting. No functional changes.
Date: Wed, 30 Jul 2014 12:20:46 +0800
Message-ID: <a02056e8a02becac47c1c0c956b253c4ad514ab0.1406689494.git.lv.zheng@intel.com>
References: <cover.1406689493.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406689493.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Fix some issues detected by acpisrc utility.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exfield.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1ff42c0..6907ce0 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -186,12 +186,11 @@ acpi_ex_read_data_from_field(struct acpi_walk_state * walk_state,
 								  access_length);
 
 			/*
-			 * Add additional 2 bytes for modeled generic_serial_bus data buffer:
-			 * typedef struct {
-			 *     BYTEStatus; // Byte 0 of the data buffer
-			 *     BYTELength; // Byte 1 of the data buffer
-			 *     BYTE[x-1]Data; // Bytes 2-x of the arbitrary length data buffer,
-			 * }
+			 * Add additional 2 bytes for the generic_serial_bus data buffer:
+			 *
+			 *     Status;      (Byte 0 of the data buffer)
+			 *     Length;      (Byte 1 of the data buffer)
+			 *     Data[x-1];   (Bytes 2-x of the arbitrary length data buffer)
 			 */
 			length += 2;
 			function = ACPI_READ | (accessor_type << 16);
@@ -368,12 +367,11 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 								  access_length);
 
 			/*
-			 * Add additional 2 bytes for modeled generic_serial_bus data buffer:
-			 * typedef struct {
-			 *     BYTEStatus; // Byte 0 of the data buffer
-			 *     BYTELength; // Byte 1 of the data buffer
-			 *     BYTE[x-1]Data; // Bytes 2-x of the arbitrary length data buffer,
-			 * }
+			 * Add additional 2 bytes for the generic_serial_bus data buffer:
+			 *
+			 *     Status;      (Byte 0 of the data buffer)
+			 *     Length;      (Byte 1 of the data buffer)
+			 *     Data[x-1];   (Bytes 2-x of the arbitrary length data buffer)
 			 */
 			length += 2;
 			function = ACPI_WRITE | (accessor_type << 16);
-- 
1.7.10
