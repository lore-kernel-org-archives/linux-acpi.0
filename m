From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/11] ACPI / PM: Call suspend_nvs_free() earlier during resume
Date: Thu, 20 Jan 2011 12:28:57 +0100
Message-ID: <201101201228.57812.rjw@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60034 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab1ATLij (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jan 2011 06:38:39 -0500
In-Reply-To: <201101201226.41021.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that some device drivers map pages from the ACPI NVS
region during resume using ioremap(), which conflicts with the
ioremap_cache() used for mapping those pages by the NVS save/restore
code in nvs.c.

Make the NVS pages mapped by the code in nvs.c be unmapped before
device drivers' resume routines run.

Tested-by: Jeff Chua <jeff.chua.linux@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -166,6 +166,7 @@ static void acpi_pm_finish(void)
 	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_ec_unblock_transactions();
+	suspend_nvs_free();
 
 	if (acpi_state == ACPI_STATE_S0)
 		return;
@@ -186,7 +187,6 @@ static void acpi_pm_finish(void)
  */
 static void acpi_pm_end(void)
 {
-	suspend_nvs_free();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
 	 * failing transition to a sleep state.

