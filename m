From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
Date: Fri, 11 Aug 2017 13:57:32 +0800
Message-ID: <51eda0b8aad7a7578802b966fd406498a25fe004.1502430636.git.lv.zheng@intel.com>
References: <cover.1502430636.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502430636.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

Unconditionally clearing ACPI IRQs during suspend/resume can lead to
unexpected IRQ losts. This patch fixes this issue by removing such IRQ
clearing code.

If this patch triggers regression, the regression should be in the GPE
handlers that cannot correctly determine some spurious triggered events as
no-ops. Please report any regression related to this commit to the ACPI
component on kernel bugzilla. Reported by Eric Bakula-Davis, fixed by Lv
Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196249
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-and-tested-by: Eric Bakula-Davis <ericbakuladavis@gmail.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpica/evgpe.c     |  7 -------
 drivers/acpi/acpica/hwgpe.c     |  1 -
 drivers/acpi/acpica/hwsleep.c   | 11 ++---------
 drivers/acpi/acpica/hwxfsleep.c |  2 +-
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 2293820..390a5ce 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -115,13 +115,6 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Clear the GPE (of stale events) */
-
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Enable the requested GPE */
 
 	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 5eb11b3..e004d5f 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -497,7 +497,6 @@ acpi_status acpi_hw_disable_all_gpes(void)
 	ACPI_FUNCTION_TRACE(hw_disable_all_gpes);
 
 	status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
-	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 1fe7387..8f54af6 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -85,15 +85,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Clear all fixed and general purpose status bits */
-
-	status = acpi_hw_clear_acpi_status();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/*
-	 * 1) Disable/Clear all GPEs
+	 * 1) Disable all GPEs
 	 * 2) Enable all wakeup GPEs
 	 */
 	status = acpi_hw_disable_all_gpes();
@@ -299,7 +292,7 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 	 * might get fired there
 	 *
 	 * Restore the GPEs:
-	 * 1) Disable/Clear all GPEs
+	 * 1) Disable all GPEs
 	 * 2) Enable all runtime GPEs
 	 */
 	status = acpi_hw_disable_all_gpes();
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 7ef1393..1888107 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -206,7 +206,7 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 	}
 
 	/*
-	 * 1) Disable/Clear all GPEs
+	 * 1) Disable all GPEs
 	 * 2) Enable all wakeup GPEs
 	 */
 	status = acpi_hw_disable_all_gpes();
-- 
2.7.4
