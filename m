From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/6] thinkpad-acpi: drop HKEY event 0x5010
Date: Sun, 20 Sep 2009 14:09:24 -0300
Message-ID: <1253466567-4285-4-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50239 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682AbZITRJ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:09:57 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

HKEY event 0x5010 is useless to us: old ThinkPads don't issue it.  Newer
ThinkPads won't issue it anymore.  And all ThinkPads issue 0x1010 and
0x1011 events.

Just silently drop it instead of sending it to userspace.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 drivers/platform/x86/thinkpad_acpi.c    |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 6d03487..f635fb0 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -525,6 +525,7 @@ compatibility purposes when hotkey_report_mode is set to 1.
 0x2305		System is waking up from suspend to eject bay
 0x2404		System is waking up from hibernation to undock
 0x2405		System is waking up from hibernation to eject bay
+0x5010		Brightness level changed/control event
 
 The above events are never propagated by the driver.
 
@@ -532,7 +533,6 @@ The above events are never propagated by the driver.
 0x4003		Undocked (see 0x2x04), can sleep again
 0x500B		Tablet pen inserted into its storage bay
 0x500C		Tablet pen removed from its storage bay
-0x5010		Brightness level changed (newer Lenovo BIOSes)
 
 The above events are propagated by the driver.
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 1b4d6f6..66ba5f5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3305,7 +3305,6 @@ static bool hotkey_notify_usrevent(const u32 hkey,
 	*ignore_acpi_ev = false;
 
 	switch (hkey) {
-	case 0x5010: /* Lenovo new BIOS: brightness changed */
 	case 0x500b: /* X61t: tablet pen inserted into bay */
 	case 0x500c: /* X61t: tablet pen removed from bay */
 		return true;
@@ -3317,9 +3316,10 @@ static bool hotkey_notify_usrevent(const u32 hkey,
 		*send_acpi_ev = false;
 		return true;
 
-	case 0x5001:
-	case 0x5002:
-		/* LID switch events.  Do not propagate */
+	case 0x5001: /* Lid close */
+	case 0x5002: /* Lid open */
+	case 0x5010: /* brightness control */
+		/* do not propagate these events */
 		*ignore_acpi_ev = true;
 		return true;
 
-- 
1.6.3.3

