From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 14/24] led: document sysfs interface
Date: Fri, 28 Aug 2009 14:56:45 +0200
Message-ID: <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.10]:6652 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZH1NDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:41 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2205.sfr.fr (SMTP Server) with ESMTP id 55A267000D3A
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:43 +0200 (CEST)
In-Reply-To: <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>, Richard Purdie <rpurdie@rpsys.net>

Also fix Documentation/led-class.txt, the acceptable
range of values for brightness is 0-max_brightness, not 0-255.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 Documentation/ABI/testing/sysfs-class-led |   28 ++++++++++++++++++++++++++++
 Documentation/leds-class.txt              |    9 +++++----
 2 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
new file mode 100644
index 0000000..9e4541d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -0,0 +1,28 @@
+What:		/sys/class/leds/<led>/brightness
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Set the brightness of the LED. Most LEDs don't
+		have hardware brightness support so will just be turned on for
+		non-zero brightness settings. The value is between 0 and
+		/sys/class/leds/<led>/max_brightness.
+
+What:		/sys/class/leds/<led>/max_brightness
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Maximum brightness level for this led, default is 255 (LED_FULL).
+
+What:		/sys/class/leds/<led>/trigger
+Date:		March 2006
+KernelVersion:	2.6.17
+Contact:	Richard Purdie <rpurdie@rpsys.net>
+Description:
+		Set the trigger for this LED. A trigger is a kernel based source
+		of led events.
+		You can change triggers in a similar manner to the way an IO
+		scheduler is chosen. Trigger specific parameters can appear in
+		/sys/class/leds/<led> once a given trigger is selected.
+
diff --git a/Documentation/leds-class.txt b/Documentation/leds-class.txt
index 6399557..8fd5ca2 100644
--- a/Documentation/leds-class.txt
+++ b/Documentation/leds-class.txt
@@ -1,3 +1,4 @@
+
 LED handling under Linux
 ========================
 
@@ -5,10 +6,10 @@ If you're reading this and thinking about keyboard leds, these are
 handled by the input subsystem and the led class is *not* needed.
 
 In its simplest form, the LED class just allows control of LEDs from
-userspace. LEDs appear in /sys/class/leds/. The brightness file will
-set the brightness of the LED (taking a value 0-255). Most LEDs don't
-have hardware brightness support so will just be turned on for non-zero
-brightness settings.
+userspace. LEDs appear in /sys/class/leds/. The maximum brightness of the
+LED is defined in max_brightness file. The brightness file will set the brightness
+of the LED (taking a value 0-max_brightness). Most LEDs don't have hardware
+brightness support so will just be turned on for non-zero brightness settings.
 
 The class also introduces the optional concept of an LED trigger. A trigger
 is a kernel based source of led events. Triggers can either be simple or
-- 
1.6.4


