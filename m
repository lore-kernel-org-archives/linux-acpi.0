From: Len Brown <lenb@kernel.org>
Subject: [PATCH 061/122] asus-laptop: Add support for P30/P35
Date: Thu, 23 Oct 2008 02:38:35 -0400
Message-ID: <4d0b856ef7eea5c03f4c1fa57793286ac068f4cd.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006Y0IIT3BU1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:06 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Torsten Krah <tkrah@fachschaft.imn.htwk-leipzig.de>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Torsten Krah <tkrah@fachschaft.imn.htwk-leipzig.de>

Add support for P30/P35.

http://bugzilla.kernel.org/show_bug.cgi?id=10848

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index de82f2f..df82cda 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -139,6 +139,7 @@ ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10",	/* All new models */
 	    "\\_SB.PCI0.PX40.ECD0._Q10",	/* L3C */
 	    "\\_SB.PCI0.PX40.EC0.Q10",	/* M1A */
 	    "\\_SB.PCI0.LPCB.EC0._Q10",	/* P30 */
+	    "\\_SB.PCI0.LPCB.EC0._Q0E", /* P30/P35 */
 	    "\\_SB.PCI0.PX40.Q10",	/* S1x */
 	    "\\Q10");		/* A2x, L2D, L3D, M2E */
 
-- 
1.5.5.1

