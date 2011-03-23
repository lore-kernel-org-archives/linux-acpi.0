From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/42] ACPI / PM: Call acpi_save_state_mem() right before
 low-level suspend
Date: Wed, 23 Mar 2011 02:42:26 -0400
Message-ID: <979f11b060c0b35b03b86ae854d6f21a710305d0.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36983 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1CWHHb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:31 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:31 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since acpi_save_state_mem() is only called by acpi_suspend_enter()
if the target sleep state is S3, it's better to call it under the
switch (acpi_state), right before do_suspend_lowlevel().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 6bea2fe..2307604 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -244,17 +244,10 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
 	u32 acpi_state = acpi_target_sleep_state;
+	int error;
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	/* Do arch specific saving of state. */
-	if (acpi_state == ACPI_STATE_S3) {
-		int error = acpi_save_state_mem();
-
-		if (error)
-			return error;
-	}
-
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -262,6 +255,9 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 
 	case ACPI_STATE_S3:
+		error = acpi_save_state_mem();
+		if (error)
+			return error;
 		do_suspend_lowlevel();
 		pr_info(PREFIX "Low-level resume complete\n");
 		break;
-- 
1.7.4.1.343.ga91df

