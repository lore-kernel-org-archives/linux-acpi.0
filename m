From: akpm@linux-foundation.org
Subject: [patch 6/6] ACPI EC: remove potential deadlock from EC
Date: Fri, 10 Aug 2007 13:45:18 -0700
Message-ID: <200708102045.l7AKjJ0m007836@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41737 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933649AbXHJUqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 16:46:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, astarikivskiy@suse.de, astarikovskiy@suse.de

From: Alexey Starikovskiy <astarikivskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/ec.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/acpi/ec.c~acpi-ec-remove-potential-deadlock-from-ec drivers/acpi/ec.c
--- a/drivers/acpi/ec.c~acpi-ec-remove-potential-deadlock-from-ec
+++ a/drivers/acpi/ec.c
@@ -710,9 +710,7 @@ static int acpi_ec_add(struct acpi_devic
 	/* Check if we found the boot EC */
 	if (boot_ec) {
 		if (boot_ec->gpe == ec->gpe) {
-			mutex_lock(&boot_ec->lock);
 			ec_remove_handlers(boot_ec);
-			mutex_unlock(&boot_ec->lock);
 			mutex_destroy(&boot_ec->lock);
 			kfree(boot_ec);
 			first_ec = boot_ec = NULL;
_
