From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/42] ACPI / PM: Modify the "low-level resume finished" message
Date: Wed, 23 Mar 2011 02:42:25 -0400
Message-ID: <7a63f08b2b904d25e966dd0e15c9af4a13c80b90.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36978 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1CWHHa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:30 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the low-level resume completion message to the point where
control goes back to acpi_suspend_enter() during resume and change
it so that it's more informative.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 3b54937..6bea2fe 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -263,6 +263,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
+		pr_info(PREFIX "Low-level resume complete\n");
 		break;
 	}
 
@@ -288,8 +289,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions_early();
 
-	printk(KERN_DEBUG "Back to C!\n");
-
 	suspend_nvs_restore();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
-- 
1.7.4.1.343.ga91df

