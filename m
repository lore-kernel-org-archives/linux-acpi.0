From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] ACPICA: Clear power button status before enabling event
Date: Mon, 15 Jun 2009 10:49:07 -0600
Message-ID: <20090615164907.10901.73210.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:18849 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZFOQtG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2009 12:49:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Clear power button status before enabling event.

It's unusual to enable an event, then immediately clear it, so this
looks like a possible bug.  If it was intentional, perhaps a comment
would be in order.

This patch may be used under either the GPL v2 or the BSD-style license
used for the Intel ACPICA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index db307a3..3558c53 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -613,12 +613,12 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	(void)
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].
-			      enable_register_id, ACPI_ENABLE_EVENT);
+			      status_register_id, ACPI_CLEAR_STATUS);
 
 	(void)
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].
-			      status_register_id, ACPI_CLEAR_STATUS);
+			      enable_register_id, ACPI_ENABLE_EVENT);
 
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);

