From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/20] ACPI / Sleep: Free NVS copy if suspending of devices
 fails
Date: Sun, 15 Aug 2010 01:23:05 -0400
Message-ID: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:50565 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0HOFX3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:29 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600EAGHN3ZO51@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:29 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If suspending of devices fails or system suspend is tested in the
"devices" mode, the memory allocated for storing a copy of the ACPI
NVS area will not be freed, because acpi_pm_finish() is not called
in that case.  Fix this by moving the suspend_nvs_free() call to
acpi_pm_end().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5b7c52e..da68ed2 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -145,7 +145,6 @@ static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
-	suspend_nvs_free();
 	acpi_ec_unblock_transactions();
 
 	if (acpi_state == ACPI_STATE_S0)
@@ -167,6 +166,7 @@ static void acpi_pm_finish(void)
  */
 static void acpi_pm_end(void)
 {
+	suspend_nvs_free();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
 	 * failing transition to a sleep state.
-- 
1.7.2.1.95.g3d045

