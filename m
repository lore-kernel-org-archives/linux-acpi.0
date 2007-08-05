From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ACPI: thinkpad-acpi: fix sysfs paths in documentation
Date: Sun,  5 Aug 2007 12:18:20 -0300
Message-ID: <11863271001038-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44014 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752150AbXHEPcP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Aug 2007 11:32:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Hugh Dickins <hugh@veritas.com>

The documentation used "thinkpad-acpi" to refer to the directories in
sysfs, while it should have been using "thinkpad_acpi".  Thanks to Hugh
Dickins for the error report.

I wish I could just call the module and everything else by the proper
name with the "-", instead of using these ugly translations to "_".

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Hugh Dickins <hugh@veritas.com>
---
 Documentation/thinkpad-acpi.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 6711fbc..eb2f598 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -105,10 +105,10 @@ The version of thinkpad-acpi's sysfs interface is exported by the driver
 as a driver attribute (see below).
 
 Sysfs driver attributes are on the driver's sysfs attribute space,
-for 2.6.20 this is /sys/bus/platform/drivers/thinkpad-acpi/.
+for 2.6.20 this is /sys/bus/platform/drivers/thinkpad_acpi/.
 
 Sysfs device attributes are on the driver's sysfs attribute space,
-for 2.6.20 this is /sys/devices/platform/thinkpad-acpi/.
+for 2.6.20 this is /sys/devices/platform/thinkpad_acpi/.
 
 Driver version
 --------------
-- 
1.5.2.1

