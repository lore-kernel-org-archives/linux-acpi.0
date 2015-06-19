From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/32] ACPICA: Hardware: Cleanup the return values in acpi_set_waking_vector().
Date: Fri, 19 Jun 2015 11:38:59 +0800
Message-ID: <e94084d299f3376d1035d825416f6259b81bc991.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit a04dbfa308a48ab0b2d10519c54a6c533c5c8949

The return statement in acpi_set_waking_vector() is wrong and this patch
corrects it. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/a04dbfa3
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 9a438d2..5601fed 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -159,7 +159,7 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
 	/* If Hardware Reduced flag is set, there is no FACS */
 
 	if (acpi_gbl_reduced_hardware) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	if (acpi_gbl_facs32) {
-- 
1.7.10
