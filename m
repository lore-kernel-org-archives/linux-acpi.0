From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] ACPICA: Use fixed event wrappers to enable/disable/clear
Date: Mon, 15 Jun 2009 10:49:12 -0600
Message-ID: <20090615164912.10901.77224.stgit@bob.kio>
References: <20090615164907.10901.73210.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:7995 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbZFOQtO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2009 12:49:14 -0400
In-Reply-To: <20090615164907.10901.73210.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Use acpi_enable_event(), acpi_disable_event(), and acpi_clear_event()
instead of writing the register directly.

This patch may be used under either the GPL v2 or the BSD-style license
used for the Intel ACPICA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evevent.c |   13 +++----------
 drivers/acpi/acpica/hwsleep.c |   12 ++----------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index cd55c77..5df6af7 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -203,10 +203,7 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 		/* Disable the fixed event */
 
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
-			status =
-			    acpi_write_bit_register(acpi_gbl_fixed_event_info
-						    [i].enable_register_id,
-						    ACPI_DISABLE_EVENT);
+			status = acpi_disable_event(i, 0);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -288,18 +285,14 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	ACPI_FUNCTION_ENTRY();
 
 	/* Clear the status bit */
-
-	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-				      status_register_id, ACPI_CLEAR_STATUS);
+	acpi_clear_event(event);
 
 	/*
 	 * Make sure we've got a handler. If not, report an error. The event is
 	 * disabled to prevent further interrupts.
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
-		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
+		acpi_disable_event(event, 0);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event [%08X]",
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 3558c53..44ae73e 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -609,16 +609,8 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */
-
-	(void)
-	    acpi_write_bit_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].
-			      status_register_id, ACPI_CLEAR_STATUS);
-
-	(void)
-	    acpi_write_bit_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].
-			      enable_register_id, ACPI_ENABLE_EVENT);
+	acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+	acpi_enable_event(ACPI_EVENT_POWER_BUTTON, 0);
 
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);

