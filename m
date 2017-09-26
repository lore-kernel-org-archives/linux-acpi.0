From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI / EC: Fix a regression related to the triggering source of the EC event handling
Date: Tue, 26 Sep 2017 16:54:03 +0800
Message-ID: <5f4131254125471f109739790d1deb619102ae43.1506414565.git.lv.zheng@intel.com>
References: <cover.1506414565.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506414565.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "4 . 11+ # 4 . 11+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Originally the Samsung quirks removed by commit 4c237371 can be covered by
commit e923e8e7 and ec_freeze_events=Y mode. But commit 9c40f956 changed
ec_freeze_events=Y back to N, making this problem re-surfaced.
Actually, if commit e923e8e7 is robust enough, we can freely change
ec_freeze_events mode, so this patch fixes the issue by improving
commit e923e8e7.

Related commits listed in the merged order:
 Commit: e923e8e79e18fd6be9162f1be6b99a002e9df2cb
 Subject: ACPI / EC: Fix an issue that SCI_EVT cannot be detected after
          event is enabled
 Commit: 4c237371f290d1ed3b2071dd43554362137b1cce
 Subject: ACPI / EC: Remove old CLEAR_ON_RESUME quirk
 Commit: 9c40f956ce9b331493347d1b3cb7e384f7dc0581
 Subject: Revert "ACPI / EC: Enable event freeze mode..." to fix a
          regression

This patch not only fixes the reported post-resume EC event triggering
source issue, but also fixes an unreported similar issue related to the
driver bind by adding EC event triggering source in ec_install_handlers().

Fixes: e923e8e79e18 (ACPI / EC: Fix an issue that SCI_EVT cannot be detected after event is enabled)
Fixes: 4c237371f290 (ACPI / EC: Remove old CLEAR_ON_RESUME quirk)
Fixes: 9c40f956ce9b (Revert "ACPI / EC: Enable event freeze mode..." to fix a regression)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196833
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-by: Alistair Hamilton <ahpatent@gmail.com>
Tested-by: Alistair Hamilton <ahpatent@gmail.com>
Cc: 4.11+ <stable@vger.kernel.org> # 4.11+
---
 drivers/acpi/ec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 236b143..82b3ce5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -486,8 +486,11 @@ static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
 		ec_log_drv("event unblocked");
-	if (!test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-		advance_transaction(ec);
+	/*
+	 * Unconditionally invoke this once after enabling the event
+	 * handling mechanism to detect the pending events.
+	 */
+	advance_transaction(ec);
 }
 
 static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
@@ -1456,11 +1459,10 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 			    ec->reference_count >= 1)
 				acpi_ec_enable_gpe(ec, true);
-
-			/* EC is fully operational, allow queries */
-			acpi_ec_enable_event(ec);
 		}
 	}
+	/* EC is fully operational, allow queries */
+	acpi_ec_enable_event(ec);
 
 	return 0;
 }
-- 
2.7.4
