From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA / hardware: Fix address check in acpi_hw_get_access_bit_width()
Date: Fri, 27 May 2016 11:40:50 +0800
Message-ID: <1464320450-5175-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The address check in acpi_hw_get_access_bit_width() should be byte size
based, not bit width based. This patch fixes this mistake.

Reported-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwregs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 0f18dbc..74a591b 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -95,7 +95,7 @@ acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
 		if (!reg->bit_offset && reg->bit_width &&
 		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
 		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
-		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
+		    ACPI_IS_ALIGNED(address, reg->bit_width >> 3)) {
 			return (reg->bit_width);
 		} else {
 			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-- 
1.7.10
