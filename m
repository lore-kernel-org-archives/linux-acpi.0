From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 04/15] eeepc-laptop: enable camera by default
Date: Tue, 16 Jun 2009 21:28:45 +0200
Message-ID: <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60972 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbZFPTbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:24 -0400
In-Reply-To: <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>

From: Pekka Enberg <penberg@cs.helsinki.fi>

If we leave the camera disabled by default, userspace programs (e.g.
Skype, Cheese) leave the user out in the cold saying that the machine
"has no camera." Therefore, it's better to enable camera by default and
let people who really don't want it just disable the thing.

To reduce power usage you should enable USB autosuspend:
echo -n auto > /sys/bus/usb/drivers/uvcvideo/*:*/../power/level

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 51b07c6..2a03425 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -341,6 +341,15 @@ static int eeepc_bluetooth_rfkill_state(void *data, enum rfkill_state *state)
 	return 0;
 }
 
+static void __init eeepc_enable_camera(void)
+{
+	/*
+	 * If the following call to set_acpi() fails, it's because there's no
+	 * camera so we can ignore the error.
+	 */
+	set_acpi(CM_ASL_CAMERA, 1);
+}
+
 /*
  * Sys helpers
  */
@@ -1072,6 +1081,9 @@ static int __init eeepc_laptop_init(void)
 	result = eeepc_hwmon_init(dev);
 	if (result)
 		goto fail_hwmon;
+
+	eeepc_enable_camera();
+
 	/* Register platform stuff */
 	result = platform_driver_register(&platform_driver);
 	if (result)
-- 
1.6.3.1

