From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/10] ACPICA: Hardware: Cast GPE enable_mask before storing
Date: Thu,  5 Feb 2015 15:20:38 +0800
Message-ID: <925b682d92f0b8432b9b98ea4fb0ba1302b289e7.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 490ec7f7839bf7ee5e8710a34d1d1a78d54a49b6

In function acpi_hw_low_set_gpe(), cast enable_mask to u8 before
storing. The mask was read from a 32 bit register but is an 8 bit
value. Fixes Visual Studio compiler warning.

Link: https://github.com/acpica/acpica/commit/490ec7f7
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwgpe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index ed85fe7..b7fb00d 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -150,7 +150,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 
 	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
 	if (ACPI_SUCCESS(status) && (action & ACPI_GPE_SAVE_MASK)) {
-		gpe_register_info->enable_mask = enable_mask;
+		gpe_register_info->enable_mask = (u8)enable_mask;
 	}
 	return (status);
 }
-- 
1.7.10
