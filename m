From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/3] ACPICA: Clear GPEs and power button events during wakeup
Date: Fri, 19 Jun 2009 14:57:57 -0600
Message-ID: <20090619205757.30130.90049.stgit@bob.kio>
References: <20090619205713.30130.79530.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:7588 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbZFSU5z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 16:57:55 -0400
In-Reply-To: <20090619205713.30130.79530.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

Per spec section 4.7.2.2.1.1, OSPM should clear power button status when
waking the system.  This must be done before enabling interrupts to prevent
spurious power button events.

Linux currently clears these events in acpi_suspend_enter() just after
calling acpi_leave_sleep_state_prep().  Other OSes should be doing
something similar.  But it seems more robust to do this in the CA.

The clear in acpi_leave_sleep_state() should be unnecessary.

Thanks to Zhao Yakui for patiently educating me about this.

This patch may be used under either the GPL v2 or the BSD-style license
used for the Intel ACPICA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index ea51ee6..283e872 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -534,6 +534,12 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 			ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
 		}
 	}
+
+	/* Clear any pending events before enabling interrupts */
+
+	acpi_hw_disable_all_gpes();
+	acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+
 	return_ACPI_STATUS(status);
 }
 
@@ -578,15 +584,7 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	/*
 	 * GPEs must be enabled before _WAK is called as GPEs
 	 * might get fired there
-	 *
-	 * Restore the GPEs:
-	 * 1) Disable/Clear all GPEs
-	 * 2) Enable all runtime GPEs
 	 */
-	status = acpi_hw_disable_all_gpes();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 	status = acpi_hw_enable_all_runtime_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -611,7 +609,6 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	/* Enable power button */
 
 	acpi_enable_event(ACPI_EVENT_POWER_BUTTON, 0);
-	acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);

