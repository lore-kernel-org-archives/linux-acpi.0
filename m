From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] backlight: extend event support to also support poll()
Date: Sun, 20 Sep 2009 14:44:47 -0300
Message-ID: <1253468688-4933-2-git-send-email-hmh@hmh.eng.br>
References: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51338 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755004AbZITRox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:44:53 -0400
In-Reply-To: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg@redhat.com>

Extend the backlight event support to also allow the use of
poll()/select() on actual_brightness.

We already have the entire event hookup anyway, adding a single
function call in one line to get functionality like that is a really
good deal.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/video/backlight/backlight.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 01efb2d..4d15dfe 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -91,6 +91,7 @@ static void backlight_generate_event(struct backlight_device *bd,
 	}
 	envp[1] = NULL;
 	kobject_uevent_env(&bd->dev.kobj, KOBJ_CHANGE, envp);
+	sysfs_notify(&bd->dev.kobj, NULL, "actual_brightness");
 }
 
 static ssize_t backlight_show_power(struct device *dev,
-- 
1.6.3.3

