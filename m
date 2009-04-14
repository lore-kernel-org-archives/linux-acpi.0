From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH -test] ACPI video: fix an error when the brightness levels
	on AC and on Battery are same
Date: Tue, 14 Apr 2009 11:02:18 +0800
Message-ID: <1239678138.7661.255.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12046 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbZDNDB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 23:01:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>


when the brightness level on AC and brightness level on Battery
are same, the level_ac_battery is 1 in the current code,
which is wrong.
http://marc.info/?l=linux-acpi&m=123963513206858&w=2

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -768,10 +768,12 @@ acpi_video_init_brightness(struct acpi_v
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
-	for (i = 2; i < count; i++)
-		if (br->levels[i] == br->levels[0] ||
-		    br->levels[i] == br->levels[1])
+	for (i = 2; i < count; i++) {
+		if (br->levels[i] == br->levels[0])
 			level_ac_battery++;
+		if (br->levels[i] == br->levels[1])
+			level_ac_battery++;
+	}
 
 	if (level_ac_battery < 2) {
 		level_ac_battery = 2 - level_ac_battery;


