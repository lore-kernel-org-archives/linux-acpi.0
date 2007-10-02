From: akpm@linux-foundation.org
Subject: [patch 6/8] ACPI: SBS: fix sbs add alarm patch
Date: Tue, 02 Oct 2007 13:24:09 -0700
Message-ID: <200710022024.l92KO98H020468@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46164 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbXJBUY7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 16:24:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, astarikovskiy@suse.de

From: Alexey Starikovskiy <astarikovskiy@suse.de>

drivers/acpi/sbs.c: In function \u2018acpi_battery_alarm_show\u2019:
drivers/acpi/sbs.c:457: error: implicit declaration of function \u2018acpi_battery_get_alarm\u2019
drivers/acpi/sbs.c: In function \u2018acpi_battery_alarm_store\u2019:
drivers/acpi/sbs.c:472: error: implicit declaration of function \u2018acpi_battery_set_alarm\u2019
drivers/acpi/sbs.c: In function \u2018acpi_battery_add\u2019:

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sbs.c |    4 ----
 1 file changed, 4 deletions(-)

diff -puN drivers/acpi/sbs.c~acpi-sbs-fix-sbs-add-alarm-patch drivers/acpi/sbs.c
--- a/drivers/acpi/sbs.c~acpi-sbs-fix-sbs-add-alarm-patch
+++ a/drivers/acpi/sbs.c
@@ -395,8 +395,6 @@ static int acpi_battery_get_state(struct
 	return result;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -433,8 +431,6 @@ static int acpi_battery_set_alarm(struct
 	return ret;
 }
 
-#endif
-
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
 	int result;
_
