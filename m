From: akpm@linux-foundation.org
Subject: [patch 5/7] drivers/acpi/sbs.c: remove dead code
Date: Mon, 09 Jul 2007 11:33:15 -0700
Message-ID: <200707091833.l69IXFCL000347@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55683 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754505AbXGISdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 14:33:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bunk@stusta.de, len.brown@intel.com, vladimir.p.lebedev@intel.com

From: Adrian Bunk <bunk@stusta.de>

Remove dead code spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sbs.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN drivers/acpi/sbs.c~drivers-acpi-sbsc-remove-dead-code drivers/acpi/sbs.c
--- a/drivers/acpi/sbs.c~drivers-acpi-sbsc-remove-dead-code
+++ a/drivers/acpi/sbs.c
@@ -1409,7 +1409,7 @@ static int acpi_sbs_update_run(struct ac
 	char dir_name[32];
 	int do_battery_init = 0, do_ac_init = 0;
 	int old_remaining_capacity = 0;
-	int update_ac = 1, update_battery = 1;
+	int update_battery = 1;
 	int up_tm = update_time;
 
 	if (sbs_zombie(sbs)) {
@@ -1429,10 +1429,6 @@ static int acpi_sbs_update_run(struct ac
 
 	sbs->run_cnt++;
 
-	if (!update_ac && !update_battery) {
-		goto end;
-	}
-
 	old_ac_present = sbs->ac.ac_present;
 
 	result = acpi_ac_get_present(sbs);
_
