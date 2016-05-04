From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/15] ACPICA: Hardware: Add optimized access bit width support
Date: Wed,  4 May 2016 13:49:11 +0800
Message-ID: <cc4ab42cfaa00fbbd2f6c2d5f124a8c90a2ae650.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit c49a751b4dae7baec1790748a2b4b6e8ab599f51

For Access Size = 0, it actually can use user expected access bit width.
This patch implements this.

Besides of the ACPICA upstream commit, this patch also includes a fix fixing
the issue reported by the FreeBSD community.
The old register descriptors are translated in acpi_tb_init_generic_address()
with access_width being filled with 0. This breaks code in
acpi_hw_get_access_bit_width() when the registers are 16-bit IO ports and their
bit_width fields are filled with 16. The rapid fix is meant to make code
written for acpi_hw_get_access_bit_width() regression safer before the issue is
correctly fixed from acpi_tb_init_generic_address(). Reported by
John Baldwin <jhb@freebsd.org>, fixed by Lv Zheng <lv.zheng@intel.com>, tested
by Jung-uk Kim <jkim@freebsd.org>.

Link: https://github.com/acpica/acpica/commit/c49a751b
Reported-by: John Baldwin <jhb@freebsd.org>
Tested-by Jung-uk Kim <jkim@freebsd.org>.
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 035fb52..892e677 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -51,6 +51,10 @@ ACPI_MODULE_NAME("hwregs")
 
 #if (!ACPI_REDUCED_HARDWARE)
 /* Local Prototypes */
+static u8
+acpi_hw_get_access_bit_width(struct acpi_generic_address *reg,
+			     u8 max_bit_width);
+
 static acpi_status
 acpi_hw_read_multiple(u32 *value,
 		      struct acpi_generic_address *register_a,
@@ -65,6 +69,48 @@ acpi_hw_write_multiple(u32 value,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_get_access_bit_width
+ *
+ * PARAMETERS:  reg                 - GAS register structure
+ *              max_bit_width       - Max bit_width supported (32 or 64)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Obtain optimal access bit width
+ *
+ ******************************************************************************/
+
+static u8
+acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
+{
+	u64 address;
+
+	if (!reg->access_width) {
+		/*
+		 * Detect old register descriptors where only the bit_width field
+		 * makes senses. The target address is copied to handle possible
+		 * alignment issues.
+		 */
+		ACPI_MOVE_64_TO_64(&address, &reg->address);
+		if (!reg->bit_offset && reg->bit_width &&
+		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
+		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
+		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
+			return (reg->bit_width);
+		} else {
+			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+				return (32);
+			} else {
+				return (max_bit_width);
+			}
+		}
+	} else {
+		return (1 << (reg->access_width + 2));
+	}
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_validate_register
  *
  * PARAMETERS:  reg                 - GAS register structure
@@ -122,8 +168,7 @@ acpi_hw_validate_register(struct acpi_generic_address *reg,
 
 	/* Validate the bit_width, convert access_width into number of bits */
 
-	access_width = reg->access_width ? reg->access_width : 1;
-	access_width = 1 << (access_width + 2);
+	access_width = acpi_hw_get_access_bit_width(reg, max_bit_width);
 	bit_width =
 	    ACPI_ROUND_UP(reg->bit_offset + reg->bit_width, access_width);
 	if (max_bit_width < bit_width) {
-- 
1.7.10
