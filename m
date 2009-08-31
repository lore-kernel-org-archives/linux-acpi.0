From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] fujitsu-laptop: address missed led-class ifdef fixup
Date: Mon, 31 Aug 2009 10:00:48 +0930 (CST)
Message-ID: <200908310030.n7V0UmlZ001727@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:42756 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929AbZHaAcH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Aug 2009 20:32:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi Len

The following patch follows on from "[PATCH] fujitsu-laptop: support
led-class as module" which has gone into -test.  It's a trivial fix for one
of the CONFIG_LEDS_CLASS ifdefs which was somehow missed in the original
patch.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

--- a/drivers/platform/x86/fujitsu-laptop.c	2009-08-31 09:52:14.242247260 +0930
+++ b/drivers/platform/x86/fujitsu-laptop.c	2009-08-31 09:53:18.812961106 +0930
@@ -944,7 +944,7 @@
 	struct fujitsu_hotkey_t *fujitsu_hotkey = acpi_driver_data(device);
 	struct input_dev *input = fujitsu_hotkey->input;
 
-#ifdef CONFIG_LEDS_CLASS
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 	if (fujitsu_hotkey->logolamp_registered)
 		led_classdev_unregister(&logolamp_led);
 
