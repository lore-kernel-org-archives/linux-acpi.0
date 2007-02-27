From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: improve backlight power handling
Date: Mon, 26 Feb 2007 22:01:26 -0300
Message-ID: <20070227010126.GA6828__8456.38234536654$1172538458$gmane$org@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52997 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030572AbXB0BHZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Feb 2007 20:07:25 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id 021A61E1092
	for <linux-acpi@vger.kernel.org>; Mon, 26 Feb 2007 20:07:24 -0500 (EST)
Received: from khazad-dum.debian.net (unknown [201.82.24.150])
	by mail.messagingengine.com (Postfix) with ESMTP id 55BE1EC49
	for <linux-acpi@vger.kernel.org>; Mon, 26 Feb 2007 20:07:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 052942809E
	for <linux-acpi@vger.kernel.org>; Mon, 26 Feb 2007 22:07:20 -0300 (BRT)
Received: from khazad-dum.debian.net ([127.0.0.1])
	by localhost (khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A484zFeVWUqs for <linux-acpi@vger.kernel.org>;
	Mon, 26 Feb 2007 22:07:19 -0300 (BRT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Improve the backlight code to emulate as much as possible the power
management events, as we are unable to really power on or power off the
backlight.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---

 Len, I have added this to the for-upstream/acpi-test branch
 of git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
 for when you pull it.

 drivers/acpi/ibm_acpi.c |    5 ++++-
 drivers/acpi/ibm_acpi.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index dd36be0..6573d01 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1664,7 +1664,10 @@ static void brightness_exit(void)
 
 static int brightness_update_status(struct backlight_device *bd)
 {
-	return brightness_set(bd->props.brightness);
+	return brightness_set(
+		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+				bd->props.brightness : 0);
 }
 
 static int brightness_get(struct backlight_device *bd)
diff --git a/drivers/acpi/ibm_acpi.h b/drivers/acpi/ibm_acpi.h
index 4d0387a..b63c014 100644
--- a/drivers/acpi/ibm_acpi.h
+++ b/drivers/acpi/ibm_acpi.h
@@ -32,6 +32,7 @@
 
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/fb.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
-- 
1.5.0.1

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
