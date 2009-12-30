From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/14] thinkpad-acpi: update volume subdriver documentation
Date: Wed, 30 Dec 2009 02:36:29 -0500
Message-ID: <169220f88f0f26f4450ac0bc8ff0f807b453ec58.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:46041 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZL3Hgo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:44 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG001HWFT6V1M0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:43 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   58 ++++++++++++++++++++++++++----
 1 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 169091f..75afa12 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1092,8 +1092,8 @@ WARNING:
     its level up and down at every change.
 
 
-Volume control
---------------
+Volume control (Console Audio control)
+--------------------------------------
 
 procfs: /proc/acpi/ibm/volume
 ALSA: "ThinkPad Console Audio Control", default ID: "ThinkPadEC"
@@ -1110,9 +1110,53 @@ the desktop environment to just provide on-screen-display feedback.
 Software volume control should be done only in the main AC97/HDA
 mixer.
 
-This feature allows volume control on ThinkPad models with a digital
-volume knob (when available, not all models have it), as well as
-mute/unmute control.  The available commands are:
+
+About the ThinkPad Console Audio control:
+
+ThinkPads have a built-in amplifier and muting circuit that drives the
+console headphone and speakers.  This circuit is after the main AC97
+or HDA mixer in the audio path, and under exclusive control of the
+firmware.
+
+ThinkPads have three special hotkeys to interact with the console
+audio control: volume up, volume down and mute.
+
+It is worth noting that the normal way the mute function works (on
+ThinkPads that do not have a "mute LED") is:
+
+1. Press mute to mute.  It will *always* mute, you can press it as
+   many times as you want, and the sound will remain mute.
+
+2. Press either volume key to unmute the ThinkPad (it will _not_
+   change the volume, it will just unmute).
+
+This is a very superior design when compared to the cheap software-only
+mute-toggle solution found on normal consumer laptops:  you can be
+absolutely sure the ThinkPad will not make noise if you press the mute
+button, no matter the previous state.
+
+The IBM ThinkPads, and the earlier Lenovo ThinkPads have variable-gain
+amplifiers driving the speakers and headphone output, and the firmware
+also handles volume control for the headphone and speakers on these
+ThinkPads without any help from the operating system (this volume
+control stage exists after the main AC97 or HDA mixer in the audio
+path).
+
+The newer Lenovo models only have firmware mute control, and depend on
+the main HDA mixer to do volume control (which is done by the operating
+system).  In this case, the volume keys are filtered out for unmute
+key press (there are some firmware bugs in this area) and delivered as
+normal key presses to the operating system (thinkpad-acpi is not
+involved).
+
+
+The ThinkPad-ACPI volume control:
+
+The preferred way to interact with the Console Audio control is the
+ALSA interface.
+
+The legacy procfs interface allows one to read the current state,
+and if volume control is enabled, accepts the following commands:
 
 	echo up   >/proc/acpi/ibm/volume
 	echo down >/proc/acpi/ibm/volume
@@ -1121,12 +1165,10 @@ mute/unmute control.  The available commands are:
 	echo 'level <level>' >/proc/acpi/ibm/volume
 
 The <level> number range is 0 to 14 although not all of them may be
-distinct. The unmute the volume after the mute command, use either the
+distinct. To unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume), or
 the unmute command.
 
-The current volume level and mute state is shown in the file.
-
 You can use the volume_capabilities parameter to tell the driver
 whether your thinkpad has volume control or mute-only control:
 volume_capabilities=1 for mixers with mute and volume control,
-- 
1.6.0.6

