From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/29] sony-laptop: Duplicate SNC 127 Event Fix
Date: Thu, 23 Apr 2009 02:23:33 -0400
Message-ID: <f7e8374da66da246ac85c2936e30be0b22afc92d.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45066 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZDWGYB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:01 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00LI0J403VE1@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:01 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes a duplicate mapping in the SNC sony_127_events structure.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index d3c92d7..87080d0 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -905,7 +905,6 @@ static struct sony_nc_event sony_127_events[] = {
 	{ 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x86, SONYPI_EVENT_PKEY_P5 },
 	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
-	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
 	{ 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0, 0 },
-- 
1.6.0.6

