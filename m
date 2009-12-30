From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/14] thinkpad-acpi: don't take the first ALSA slot by default
Date: Wed, 30 Dec 2009 02:36:26 -0500
Message-ID: <ead510cebcdf41c92fce2a909f342255b028a33d.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50309 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZL3Hgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:55 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG004AUFT4VD95@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:41 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We don't want to be the first soundcard.  We don't want to shift other
soundcards out of the way either, even if they load much later.

Ask ALSA to (by default) load us in one of the last three slots.  This
can be overriden at will using the "index" parameter.

Reported-by: Whoopie <whoopie79@gmx.net>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 448c8ae..3311b00 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6388,7 +6388,7 @@ static struct ibm_struct brightness_driver_data = {
 #define TPACPI_ALSA_SHRTNAME "ThinkPad Console Audio Control"
 #define TPACPI_ALSA_MIXERNAME TPACPI_ALSA_SHRTNAME
 
-static int alsa_index = SNDRV_DEFAULT_IDX1;
+static int alsa_index = ~((1 << (SNDRV_CARDS - 3)) - 1); /* last three slots */
 static char *alsa_id = "ThinkPadEC";
 static int alsa_enable = SNDRV_DEFAULT_ENABLE1;
 
-- 
1.6.0.6

