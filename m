From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] drivers/acpi/sbs.c: remove dead code
Date: Fri, 15 Jun 2007 23:45:25 +0200
Message-ID: <20070615214525.GN3588@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36341 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757410AbXFOVpL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 17:45:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch removes dead code spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/sbs.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.22-rc4-mm2/drivers/acpi/sbs.c.old	2007-06-15 22:44:17.000000000 +0200
+++ linux-2.6.22-rc4-mm2/drivers/acpi/sbs.c	2007-06-15 22:46:26.000000000 +0200
@@ -1411,7 +1411,7 @@ static int acpi_sbs_update_run(struct ac
 	char dir_name[32];
 	int do_battery_init = 0, do_ac_init = 0;
 	int old_remaining_capacity = 0;
-	int update_ac = 1, update_battery = 1;
+	int update_battery = 1;
 	int up_tm = update_time;
 
 	if (sbs_zombie(sbs)) {
@@ -1431,10 +1431,6 @@ static int acpi_sbs_update_run(struct ac
 
 	sbs->run_cnt++;
 
-	if (!update_ac && !update_battery) {
-		goto end;
-	}
-
 	old_ac_present = sbs->ac.ac_present;
 
 	result = acpi_ac_get_present(sbs);

