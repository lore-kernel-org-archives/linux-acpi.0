From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPI / sleep: Make acpi_sleep_syscore_init static
Date: Mon, 31 Jul 2017 11:40:13 +0200
Message-ID: <20170731114013.75bc1b0a@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750739AbdGaJkQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 05:40:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Function acpi_sleep_syscore_init has no external user so it should be
static.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/sleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.13-rc3.orig/drivers/acpi/sleep.c	2017-07-31 10:51:43.665159497 +0200
+++ linux-4.13-rc3/drivers/acpi/sleep.c	2017-07-31 11:34:07.180873669 +0200
@@ -870,7 +870,7 @@ static struct syscore_ops acpi_sleep_sys
 	.resume = acpi_restore_bm_rld,
 };
 
-void acpi_sleep_syscore_init(void)
+static void acpi_sleep_syscore_init(void)
 {
 	register_syscore_ops(&acpi_sleep_syscore_ops);
 }


-- 
Jean Delvare
SUSE L3 Support
