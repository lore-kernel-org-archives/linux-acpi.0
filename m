From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/3] ACPI: remove clearing of events on resume,
	now that ACPI CA does it
Date: Fri, 19 Jun 2009 14:58:02 -0600
Message-ID: <20090619205802.30130.60093.stgit@bob.kio>
References: <20090619205713.30130.79530.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:17903 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZFSU6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 16:58:00 -0400
In-Reply-To: <20090619205713.30130.79530.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

The ACPI CA now clears GPEs and power button events in
acpi_leave_sleep_state_prep(), so there's no need for us to do it again.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/sleep.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 01574a0..bf2e2e1 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -257,20 +257,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(acpi_state);
 
-	/* ACPI 3.0 specs (P62) says that it's the responsibility
-	 * of the OSPM to clear the status bit [ implying that the
-	 * POWER_BUTTON event should not reach userspace ]
-	 */
-	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
-		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
-
-	/*
-	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
-	 * acpi_leave_sleep_state will reenable specific GPEs later
-	 */
-	acpi_disable_all_gpes();
-
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 

