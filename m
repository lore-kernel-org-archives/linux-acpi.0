From: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/25] ACPI: enable GPEs before calling _WAK on resume
Date: Fri, 24 Aug 2007 03:21:04 -0400
Message-ID: <11879400933976-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7250 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbXHXHVf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:35 -0400
In-Reply-To: <11879400921598-git-send-email-len.brown@intel.com>
Message-Id: <79d2dfaa4e787f94b7f65f4611bc7d1c8d85fabc.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

It seems it's required to enable GPEs before _WAK.  E.g.  X60 triggers a
LID related GPE instead of doing a Notify in WAK.  Now the GPE reaches the
kernel and the Notify for LID status change gets thrown from there.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 76c525d..cf69c00 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -576,13 +576,10 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
 	}
 
-	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
-	}
-	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
-
 	/*
+	 * GPEs must be enabled before _WAK is called as GPEs
+	 * might get fired there
+	 *
 	 * Restore the GPEs:
 	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all runtime GPEs
@@ -591,13 +588,19 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-	acpi_gbl_system_awake_and_running = TRUE;
-
 	status = acpi_hw_enable_all_runtime_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
+	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
+	}
+	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
+
+	acpi_gbl_system_awake_and_running = TRUE;
+
 	/* Enable power button */
 
 	(void)
-- 
1.5.3.rc6.17.g1911
