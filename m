From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 10/14] ACPI: thinkpad-acpi: use uppercase for "LED" on user documentation
Date: Sat, 26 Apr 2008 01:02:26 -0300
Message-ID: <1209182550-32725-11-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44062 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbYDZECg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:36 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Randy Dunlap <randy.dunlap@oracle.com>

Change all occourences of the "led" word to full uppercase in user
documentation.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 73b80a7..947b726 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -697,7 +697,7 @@ ThinkLight control
 ------------------
 
 procfs: /proc/acpi/ibm/light
-sysfs attributes: as per led class, for the "tpacpi::thinklight" led
+sysfs attributes: as per LED class, for the "tpacpi::thinklight" LED
 
 procfs notes:
 
@@ -710,11 +710,11 @@ status as "unknown". The available commands are:
 
 sysfs notes:
 
-The ThinkLight sysfs interface is documented by the led class
-documentation, in Documentation/leds-class.txt.  The ThinkLight led name
+The ThinkLight sysfs interface is documented by the LED class
+documentation, in Documentation/leds-class.txt.  The ThinkLight LED name
 is "tpacpi::thinklight".
 
-Due to limitations in the sysfs led class, if the status of the thinklight
+Due to limitations in the sysfs LED class, if the status of the thinklight
 cannot be read or if it is unknown, thinkpad-acpi will report it as "off".
 It is impossible to know if the status returned through sysfs is valid.
 
@@ -880,7 +880,7 @@ LED control
 -----------
 
 procfs: /proc/acpi/ibm/led
-sysfs attributes: as per led class, see below for names
+sysfs attributes: as per LED class, see below for names
 
 Some of the LED indicators can be controlled through this feature.  On
 some older ThinkPad models, it is possible to query the status of the
@@ -891,11 +891,11 @@ procfs notes:
 
 The available commands are:
 
-	echo '<led number> on' >/proc/acpi/ibm/led
-	echo '<led number> off' >/proc/acpi/ibm/led
-	echo '<led number> blink' >/proc/acpi/ibm/led
+	echo '<LED number> on' >/proc/acpi/ibm/led
+	echo '<LED number> off' >/proc/acpi/ibm/led
+	echo '<LED number> blink' >/proc/acpi/ibm/led
 
-The <led number> range is 0 to 7. The set of LEDs that can be
+The <LED number> range is 0 to 7. The set of LEDs that can be
 controlled varies from model to model. Here is the common ThinkPad
 mapping:
 
@@ -912,7 +912,7 @@ All of the above can be turned on and off and can be made to blink.
 
 sysfs notes:
 
-The ThinkPad LED sysfs interface is described in detail by the led class
+The ThinkPad LED sysfs interface is described in detail by the LED class
 documentation, in Documentation/leds-class.txt.
 
 The leds are named (in LED ID order, from 0 to 7):
@@ -920,7 +920,7 @@ The leds are named (in LED ID order, from 0 to 7):
 "tpacpi::dock_active", "tpacpi::bay_active", "tpacpi::dock_batt",
 "tpacpi::unknown_led", "tpacpi::standby".
 
-Due to limitations in the sysfs led class, if the status of the LED
+Due to limitations in the sysfs LED class, if the status of the LED
 indicators cannot be read due to an error, thinkpad-acpi will report it as
 a brightness of zero (same as LED off).
 
-- 
1.5.4.4

