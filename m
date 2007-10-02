From: akpm@linux-foundation.org
Subject: [patch 5/8] ACPI: clean up acpi_enter_sleep_state_prep
Date: Tue, 02 Oct 2007 13:24:09 -0700
Message-ID: <200710022024.l92KO9KP020465@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54755 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753271AbXJBUZH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 16:25:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rjw@sisk.pl, pavel@ucw.cz

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove some redundant code from acpi_enter_sleep_state_prep() and clean up
a comment in there.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/hardware/hwsleep.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/hardware/hwsleep.c~acpi-clean-up-acpi_enter_sleep_state_prep drivers/acpi/hardware/hwsleep.c
--- a/drivers/acpi/hardware/hwsleep.c~acpi-clean-up-acpi_enter_sleep_state_prep
+++ a/drivers/acpi/hardware/hwsleep.c
@@ -234,15 +234,11 @@ acpi_status acpi_enter_sleep_state_prep(
 				"While executing method _SST"));
 	}
 
-	/*
-	 * 1) Disable/Clear all GPEs
-	 */
+	/* Disable/Clear all GPEs */
+
 	status = acpi_hw_disable_all_gpes();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
-	return_ACPI_STATUS(AE_OK);
+	return_ACPI_STATUS(status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
_
