From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] eeepc-laptop: get the right value for CMSG
Date: Fri, 26 Jun 2009 00:20:18 -0400
Message-ID: <d1a7d4c2babf269b2856006bb0d4d73c9772ecb2.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51659 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZFZEUd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:20:33 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT004VMW2AL4FC@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:36 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

CMSG is an ACPI method used to find features available on
an Eee PC. But some features are never repported, even if present.

If the getter of a feature is present, this patch will set
the corresponding bit in cmsg.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 19cc9ae..f5d8473 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -553,6 +553,28 @@ static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
 	return -EINVAL;
 }
 
+static void cmsg_quirk(int cm, const char *name)
+{
+	int dummy;
+
+	/* Some BIOSes do not report cm although it is avaliable.
+	   Check if cm_getv[cm] works and, if yes, assume cm should be set. */
+	if (!(ehotk->cm_supported & (1 << cm))
+	    && !read_acpi_int(ehotk->handle, cm_getv[cm], &dummy)) {
+		pr_info("%s (%x) not reported by BIOS,"
+			" enabling anyway\n", name, 1 << cm);
+		ehotk->cm_supported |= 1 << cm;
+	}
+}
+
+static void cmsg_quirks(void)
+{
+	cmsg_quirk(CM_ASL_LID, "LID");
+	cmsg_quirk(CM_ASL_TYPE, "TYPE");
+	cmsg_quirk(CM_ASL_PANELPOWER, "PANELPOWER");
+	cmsg_quirk(CM_ASL_TPD, "TPD");
+}
+
 static int eeepc_hotk_check(void)
 {
 	const struct key_entry *key;
@@ -576,6 +598,7 @@ static int eeepc_hotk_check(void)
 			pr_err("Get control methods supported failed\n");
 			return -ENODEV;
 		} else {
+			cmsg_quirks();
 			pr_info("Get control methods supported: 0x%x\n",
 				ehotk->cm_supported);
 		}
-- 
1.6.0.6

