From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [2/2] ACPI / PM: Call suspend_nvs_free() earlier during resume
Date: Wed, 19 Jan 2011 22:27:55 +0100
Message-ID: <201101192227.55298.rjw@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com> <AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com> <201101192219.07569.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57119 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab1ASV3S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jan 2011 16:29:18 -0500
In-Reply-To: <201101192219.07569.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that some device drivers map pages from the ACPI NVS
region during resume using ioremap(), which conflicts with
ioremap_cache() used for mapping those pages by the NVS save/restore
code in nvs.c.

Make the NVS pages mapped by the code in nvs.c be unmapped before
device drivers' resume routines run.

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

