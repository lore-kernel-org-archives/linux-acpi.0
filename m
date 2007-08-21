From: Adam Belay <abelay@novell.com>
Subject: [PATCH 1/6] CPUIDLE: fix 'current_governor' sysfs entry
Date: Tue, 21 Aug 2007 18:24:40 -0400
Message-ID: <1187735080.7199.48.camel@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from peabody.ximian.com ([130.57.169.10]:43638 "EHLO
	peabody.ximian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbXHUWb1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 18:31:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brown@vger.kernel.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>

This patch allows the "current_governor" sysfs entry to properly handle
input terminated with '\n'.

Please Apply,
Adam

Change Summary:
 sysfs.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
---

diff -urN a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
--- a/drivers/cpuidle/sysfs.c	2007-08-13 00:02:10.000000000 -0400
+++ b/drivers/cpuidle/sysfs.c	2007-08-03 20:59:47.000000000 -0400
@@ -80,16 +80,13 @@
 
 	memcpy(gov_name, buf, len);
 	gov_name[len] = '\0';
-
-	len = strlen(gov_name);
-
-	if (len && gov_name[len - 1] == '\n')
-		gov_name[len - 1] = '\0';
+	if (gov_name[len - 1] == '\n')
+		gov_name[--len] = '\0';
 
 	mutex_lock(&cpuidle_lock);
 
 	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
-		if (strlen(gov->name) == len && !strcmp(gov->name, buf)) {
+		if (strlen(gov->name) == len && !strcmp(gov->name, gov_name)) {
 			ret = cpuidle_switch_governor(gov);
 			break;
 		}


