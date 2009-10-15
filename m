From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] fujitsu-laptop: address missed led-class ifdef fixup
Date: Thu, 15 Oct 2009 00:59:38 -0400
Message-ID: <2906206350b7e13e2047467cc29a0a2d78d71cb2.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:57624 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZJOFAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:32 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ008I1HVQNMWY@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:56 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Len Brown <len.brown@intel.com>

From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

A follow-up 2.6.32-rc1's

1e384cb0f9a940f2a431d1708f963987e61d71e3
"fujitsu-laptop: support led-class as module"

It's a trivial fix for one of the CONFIG_LEDS_CLASS ifdefs
which was somehow missed in the original patch.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index f35aee5..bcd4ba8 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -944,7 +944,7 @@ static int acpi_fujitsu_hotkey_remove(struct acpi_device *device, int type)
 	struct fujitsu_hotkey_t *fujitsu_hotkey = acpi_driver_data(device);
 	struct input_dev *input = fujitsu_hotkey->input;
 
-#ifdef CONFIG_LEDS_CLASS
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
 	if (fujitsu_hotkey->logolamp_registered)
 		led_classdev_unregister(&logolamp_led);
 
-- 
1.6.0.6

