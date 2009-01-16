From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/23] eeepc-laptop: enable Bluetooth ACPI details
Date: Fri, 16 Jan 2009 15:25:09 -0500
Message-ID: <3af9bfcb433c110839e4c815a9928377f66bbd0e.1232137453.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:60431 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbZAPUZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK0038SZ6EBNE1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:20:38 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan McDowell <noodles@earth.li>, Len Brown <len.brown@intel.com>

From: Jonathan McDowell <noodles@earth.li>

Although rfkill support for the EEE bluetooth device has been added to
2.6.28-rc the appropriate ACPI accessor definitions were not added, so
the support was non functional. The patch below adds the get and set
accessors and has been verified to work on an EEE 901.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Acked-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 02fe2b8..9d93cb9 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -90,7 +90,7 @@ enum {
 };
 
 static const char *cm_getv[] = {
-	"WLDG", NULL, NULL, NULL,
+	"WLDG", "BTHG", NULL, NULL,
 	"CAMG", NULL, NULL, NULL,
 	NULL, "PBLG", NULL, NULL,
 	"CFVG", NULL, NULL, NULL,
@@ -99,7 +99,7 @@ static const char *cm_getv[] = {
 };
 
 static const char *cm_setv[] = {
-	"WLDS", NULL, NULL, NULL,
+	"WLDS", "BTHS", NULL, NULL,
 	"CAMS", NULL, NULL, NULL,
 	"SDSP", "PBLS", "HDPS", NULL,
 	"CFVS", NULL, NULL, NULL,
-- 
1.5.6.6

