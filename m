From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Fix mismerge in acpi_hibernation_finish
Date: Thu, 1 Nov 2007 23:50:19 +0100
Message-ID: <200711012350.20574.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50747 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbXKAWdd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Nov 2007 18:33:33 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

[Len, please send Linuswards.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

Some code in acpi_hibernation_finish() was moved to acpi_hibernation_leave(),
but the old copy had been left (it's harmless, but also useless).  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -267,11 +267,6 @@ static void acpi_hibernation_leave(void)
 
 static void acpi_hibernation_finish(void)
 {
-	/*
-	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
-	 * enable it here.
-	 */
-	acpi_enable();
 	acpi_disable_wakeup_device(ACPI_STATE_S4);
 	acpi_leave_sleep_state(ACPI_STATE_S4);
 
