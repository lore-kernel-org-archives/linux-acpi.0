From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 6/7] eeepc-laptop: get the right value for CMSG
Date: Thu, 25 Jun 2009 13:25:41 +0200
Message-ID: <1245929142-3354-6-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906240136300.32742@localhost.localdomain>
 <1245929142-3354-1-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-2-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-3-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-4-git-send-email-corentincj@iksaif.net>
 <1245929142-3354-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:54906 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbZFYLXD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2009 07:23:03 -0400
In-Reply-To: <1245929142-3354-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

CMSG is an ACPI method used to find features available on
an Eee PC. But some features are never repported, even if present.

If the getter of a feature is present, this patch will set
the corresponding bit in cmsg.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.3.3

