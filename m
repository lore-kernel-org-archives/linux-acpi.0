From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/12] ACPI / ACPICA: Do not check reference counters in
 acpi_ev_enable_gpe()
Date: Tue, 06 Apr 2010 03:06:16 -0400
Message-ID: <bf02bd2590eb78d79ba1033d6df80c778b2f5ddf.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:43525 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343Ab0DFHGl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:41 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00AFA12S7XH5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:41 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 837de66..78c5550 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -117,19 +117,14 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
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
-- 
1.6.0.6

