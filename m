From: Len Brown <lenb@kernel.org>
Subject: [PATCH 65/98] sony-laptop: Add FW specific hotkey events
Date: Sat, 28 Mar 2009 00:31:40 -0400
Message-ID: <f5acf5e898618295895b61d81681ae3115d94b96.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64907 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZC1Ed3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:29 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7005108NQEX00@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:27 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Anton Veretenenko <anton@veretenenko.ru>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Anton Veretenenko <anton@veretenenko.ru>

Signed-off-by: Anton Veretenenko <anton@veretenenko.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 74df723..3575a2d 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -870,6 +870,12 @@ static struct sony_nc_event sony_100_events[] = {
 	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x82, SONYPI_EVENT_FNKEY_F2 },
+	{ 0x02, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x83, SONYPI_EVENT_FNKEY_F3 },
+	{ 0x03, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x84, SONYPI_EVENT_FNKEY_F4 },
+	{ 0x04, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
 	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x86, SONYPI_EVENT_FNKEY_F6 },
-- 
1.6.0.6

