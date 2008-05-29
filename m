From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] Fujitsu-laptop: autoload based on PnP device
Date: Thu, 29 May 2008 10:30:20 +0930 (CST)
Message-ID: <200805290100.m4T10KZe019539@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:60946 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752669AbYE2BAo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 May 2008 21:00:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, lenb@kernel.org, nokos@gmx.net

This patch adds module autoloading based on PnP devices in Fujitsu
laptops following Matthew Garrett's suggestion.  It is against a 2.6.25 tree
which has already had my previous fujitsu laptop update patch applied.

This patch includes the patch submitted earlier by Dan Williams which adds
the FUJ02bf PnP device to the autoload list.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

--- linux-2.6.25-old/drivers/misc/fujitsu-laptop.c	2008-05-29 10:14:30.000000000 +0930
+++ linux-2.6.25/drivers/misc/fujitsu-laptop.c	2008-05-29 10:22:07.000000000 +0930
@@ -65,7 +65,7 @@
 #include <linux/video_output.h>
 #include <linux/platform_device.h>
 
-#define FUJITSU_DRIVER_VERSION "0.4.0"
+#define FUJITSU_DRIVER_VERSION "0.4.1"
 
 #define FUJITSU_LCD_N_LEVELS 8
 
@@ -1074,3 +1074,10 @@
     ("dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1D3:*:cvrS6410:*");
 MODULE_ALIAS
     ("dmi:*:svnFUJITSU:*:pvr:rvnFUJITSU:rnFJNB19C:*:cvrS7020:*");
+
+static struct pnp_device_id pnp_ids[] = {
+	{ .id = "FUJ02bf" },
+	{ .id = "FUJ02B1" },
+	{ .id = "FUJ02E3" },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_ids);
