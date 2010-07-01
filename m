From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/5] ACPI / Sleep: Drop acpi_suspend_finish()
Date: Fri, 2 Jul 2010 00:14:57 +0200
Message-ID: <201007020014.57877.rjw@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42774 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932556Ab0GAWQ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:16:58 -0400
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_suspend_finish() is not necessary any more, because
acpi_pm_finish() can be used instead of it just fine.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -285,11 +285,6 @@ static int acpi_suspend_enter(suspend_st
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
-static void acpi_suspend_finish(void)
-{
-	acpi_pm_finish();
-}
-
 static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -311,7 +306,7 @@ static struct platform_suspend_ops acpi_
 	.begin = acpi_suspend_begin,
 	.prepare_late = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 };
 
@@ -339,7 +334,7 @@ static struct platform_suspend_ops acpi_
 	.begin = acpi_suspend_begin_old,
 	.prepare_late = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };

