From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: suspend: clear leftovers from S4BIOS.
Date: Thu, 21 Feb 2008 18:09:35 +0300
Message-ID: <20080221150935.20302.30835.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39405 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751539AbYBUPJr (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 10:09:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.orgLinux-acpi@vger.kernel.org

S4BIOS is not supported, so there is no reason to expect 
it as input and try to do something wrong.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sleep/main.c |    2 --
 drivers/acpi/sleep/proc.c |    5 -----
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 293a1cb..3e85a68 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -403,8 +403,6 @@ int acpi_suspend(u32 acpi_state)
 
 	if (acpi_state < 6 && states[acpi_state])
 		return pm_suspend(states[acpi_state]);
-	if (acpi_state == 4)
-		return hibernate();
 	return -EINVAL;
 }
 
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index f8df521..f530757 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -60,11 +60,6 @@ acpi_system_write_sleep(struct file *file,
 	if (copy_from_user(str, buffer, count))
 		return -EFAULT;
 
-	/* Check for S4 bios request */
-	if (!strcmp(str, "4b")) {
-		error = acpi_suspend(4);
-		goto Done;
-	}
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_HIBERNATION
 	if (state == 4) {

