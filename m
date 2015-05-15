From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/6] ACPI / EC: Update acpi_ec_is_gpe_raised() with new GPE status flag.
Date: Fri, 15 May 2015 14:16:17 +0800
Message-ID: <86fcff060a37d170bcfb64fcfbc0f0f43a301ab4.1431670199.git.lv.zheng@intel.com>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com> <cover.1431670199.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431670199.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch updates acpi_ec_is_gpe_raised() according to the following
commit:
  Commit: 09af8e8290deaff821ced01ea83594ee4c21e8df
  Subject: ACPICA: Events: Add support to return both enable/status register values for GPE and fixed event.
This is actually a no-op change as both the flags are defined to a same
value.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5e8fed4..99084e8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -267,7 +267,7 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
 	acpi_event_status gpe_status = 0;
 
 	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
-	return (gpe_status & ACPI_EVENT_FLAG_SET) ? true : false;
+	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
 }
 
 static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
-- 
1.7.10
