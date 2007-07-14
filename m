From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ACPI: thinkpad-acpi: update CMOS commands documentation
Date: Sat, 14 Jul 2007 11:11:57 -0300
Message-ID: <1184422333373-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46910 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758342AbXGNOMW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Jul 2007 10:12:22 -0400
In-Reply-To: <11844223322928-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The CMOS set of commands is often just used to keep the CMOS NVRAM in sync
with whatever the ACPI BIOS has been doing in modern ThinkPads.  In older
ThinkPads, it actually carried out real actions.  Document this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.5.2.1

