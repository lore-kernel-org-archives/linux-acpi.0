From: Len Brown <lenb@kernel.org>
Subject: [PATCH 64/98] sony-laptop: notify the hardware of a state change in
 wwanpower
Date: Sat, 28 Mar 2009 00:31:39 -0400
Message-ID: <3ad1b7619959c0387a30e05c6f36537190b6da7b.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8461 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbZC1Edf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700HIN8NPYCNS@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:26 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sergey Yanovich <ynvich@gmail.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Sergey Yanovich <ynvich@gmail.com>

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5030f99..74df723 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2004,6 +2004,7 @@ static void sony_pic_set_wwanpower(u8 state)
 		return;
 	}
 	sony_pic_call2(0xB0, state);
+	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
 	mutex_unlock(&spic_dev.lock);
 }
-- 
1.6.0.6

