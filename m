From: oliver@neukum.org
Subject: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Fri, 10 Jan 2014 10:51:53 +0100
Message-ID: <1389347514-8112-1-git-send-email-oliver@neukum.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:51366 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaAJJv5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 04:51:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, trenn@suse.de
Cc: Oliver Neukum <oneukum@suse.de>

From: Oliver Neukum <oneukum@suse.de>

Some BIOSes change hardware based on the state of
a laptop's lid. If the lid is closed, the touchpad is
disabled and the checksum changes. Windows 8 no longer
aborts resume if the checksum has changed.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/acpi/sleep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9c1a435..14744e5 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -664,11 +664,9 @@ static void acpi_hibernation_leave(void)
 	/* Reprogram control registers */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 	/* Check the hardware signature */
-	if (facs && s4_hardware_signature != facs->hardware_signature) {
-		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
-			"cannot resume!\n");
-		panic("ACPI S4 hardware signature mismatch");
-	}
+	if (facs && s4_hardware_signature != facs->hardware_signature)
+		printk(KERN_CRIT "ACPI: Hardware changed while hibernated, "
+			"success doubtful!\n");
 	/* Restore the NVS memory area */
 	suspend_nvs_restore();
 	/* Allow EC transactions to happen. */
-- 
1.8.4

