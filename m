From: Len Brown <len.brown@intel.com>
Subject: [PATCH 48/77] ACPI: thinkpad-acpi: update CMOS commands documentation
Date: Sun, 22 Jul 2007 05:14:33 -0400
Message-ID: <11850957522609-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763324AbXGVJPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:55 -0400
In-Reply-To: <1185095751279-git-send-email-len.brown@intel.com>
Message-Id: <d54b7d7f8026300c612dd733d501fcbc22fd0370.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The CMOS set of commands is often just used to keep the CMOS NVRAM in sync
with whatever the ACPI BIOS has been doing in modern ThinkPads.  In older
ThinkPads, it actually carried out real actions.  Document this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 7a06a27..bd00d14 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -464,27 +464,34 @@ CMOS control
 procfs: /proc/acpi/ibm/cmos
 sysfs device attribute: cmos_command
 
-This feature is used internally by the ACPI firmware to control the
-ThinkLight on most newer ThinkPad models. It may also control LCD
-brightness, sounds volume and more, but only on some models.
+This feature is mostly used internally by the ACPI firmware to keep the legacy
+CMOS NVRAM bits in sync with the current machine state, and to record this
+state so that the ThinkPad will retain such settings across reboots.
+
+Some of these commands actually perform actions in some ThinkPad models, but
+this is expected to disappear more and more in newer models.  As an example, in
+a T43 and in a X40, commands 12 and 13 still control the ThinkLight state for
+real, but commands 0 to 2 don't control the mixer anymore (they have been
+phased out) and just update the NVRAM.
 
 The range of valid cmos command numbers is 0 to 21, but not all have an
 effect and the behavior varies from model to model.  Here is the behavior
 on the X40 (tpb is the ThinkPad Buttons utility):
 
-	0 - no effect but tpb reports "Volume down"
-	1 - no effect but tpb reports "Volume up"
-	2 - no effect but tpb reports "Mute on"
-	3 - simulate pressing the "Access IBM" button
-	4 - LCD brightness up
-	5 - LCD brightness down
-	11 - toggle screen expansion
-	12 - ThinkLight on
-	13 - ThinkLight off
-	14 - no effect but tpb reports ThinkLight status change
+	0 - Related to "Volume down" key press
+	1 - Related to "Volume up" key press
+	2 - Related to "Mute on" key press
+	3 - Related to "Access IBM" key press
+	4 - Related to "LCD brightness up" key pess
+	5 - Related to "LCD brightness down" key press
+	11 - Related to "toggle screen expansion" key press/function
+	12 - Related to "ThinkLight on"
+	13 - Related to "ThinkLight off"
+	14 - Related to "ThinkLight" key press (toggle thinklight)
 
 The cmos command interface is prone to firmware split-brain problems, as
-in newer ThinkPads it is just a compatibility layer.
+in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
+exported just as a debug tool.
 
 LED control -- /proc/acpi/ibm/led
 ---------------------------------
-- 
1.5.3.rc2.22.g69a9b
