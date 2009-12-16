From: Len Brown <lenb@kernel.org>
Subject: [PATCH 049/103] asus-laptop: schedule display_get and lcd_switch for
 removal
Date: Wed, 16 Dec 2009 03:36:00 -0500
Message-ID: <728900f6fa7142e07a67d10d862bcb774d7a3493.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761903AbZLPJGU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:20 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index bc693ff..d1c9e17 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -489,3 +489,23 @@ Why:	With the recent innovations in CPU hardware acceleration technologies
 Who:	Alok N Kataria <akataria@vmware.com>
 
 ----------------------------
+
+What:	Support for lcd_switch and display_get in asus-laptop driver
+When:	March 2010
+Why:	These two features use non-standard interfaces. There are the
+	only features that really need multiple path to guess what's
+	the right method name on a specific laptop.
+
+	Removing them will allow to remove a lot of code an significantly
+	clean the drivers.
+
+	This will affect the backlight code which won't be able to know
+	if the backlight is on or off. The platform display file will also be
+	write only (like the one in eeepc-laptop).
+
+	This should'nt affect a lot of user because they usually know
+	when their display is on or off.
+
+Who:	Corentin Chary <corentin.chary@gmail.com>
+
+----------------------------
-- 
1.6.0.6

