From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Do not check reference counters in acpi_ev_enable_gpe()
Date: Tue, 16 Mar 2010 23:21:55 +0100
Message-ID: <201003162321.55881.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42246 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab0CPWTB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Mar 2010 18:19:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_ev_enable_gpe() should enable the GPE at the hardware level
regardless of the value of the GPE's runtime reference counter.

There are only two callers of acpi_ev_enable_gpe(), acpi_enable_gpe()
and acpi_set_gpe().  The first one checks the GPE's runtime
reference counter itself and only calls acpi_ev_enable_gpe() if it's
equal to one, and the other one is supposed to enable the GPE
unconditionally (if called with ACPI_GPE_ENABLE).

This change fixes the problem in acpi_enable_wakeup_device() where
the GPE will not be enabled for wakeup if it's runtime reference
counter is zero, which is a regression from 2.6.33.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Robert Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -117,19 +117,14 @@ acpi_status acpi_ev_enable_gpe(struct ac
 	if (ACPI_FAILURE(status))
 		return_ACPI_STATUS(status);
 
-	/* Mark wake-enabled or HW enable, or both */
-
-	if (gpe_event_info->runtime_count) {
-		/* Clear the GPE (of stale events), then enable it */
-		status = acpi_hw_clear_gpe(gpe_event_info);
-		if (ACPI_FAILURE(status))
-			return_ACPI_STATUS(status);
-
-		/* Enable the requested runtime GPE */
-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
-	}
+	/* Clear the GPE (of stale events), then enable it */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
 
-	return_ACPI_STATUS(AE_OK);
+	/* Enable the requested GPE */
+	status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
