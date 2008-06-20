From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/70] ISAPNP: handle independent options following dependent
 ones
Date: Fri, 20 Jun 2008 03:44:05 -0400
Message-ID: <0ab0c989b649ae4a46c243bd25ab8898f9999f40.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53835 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbYFTHqg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:46:36 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007Z73YFC1B3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:39:52 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The ISAPNP spec recommends that independent options precede
dependent ones, but this is not actually required.  The current
ISAPNP code incorrectly puts such trailing independent options
at the end of the last dependent option list.

This patch fixes that bug by resetting the current option list
to the independent list when we see an "End Dependent Functions"
tag.  PNPBIOS and PNPACPI handle this the same way.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/isapnp/core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 90718be..53cc4d6 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -584,14 +584,14 @@ static int __init isapnp_create_device(struct pnp_card *card,
 {
 	int number = 0, skip = 0, priority, compat = 0;
 	unsigned char type, tmp[17];
-	struct pnp_option *option;
+	struct pnp_option *option, *option_independent;
 	struct pnp_dev *dev;
 	u32 eisa_id;
 	char id[8];
 
 	if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 		return 1;
-	option = pnp_register_independent_option(dev);
+	option_independent = option = pnp_register_independent_option(dev);
 	if (!option) {
 		kfree(dev);
 		return 1;
@@ -613,6 +613,7 @@ static int __init isapnp_create_device(struct pnp_card *card,
 				size = 0;
 				skip = 0;
 				option = pnp_register_independent_option(dev);
+				option_independent = option;
 				if (!option) {
 					kfree(dev);
 					return 1;
@@ -662,6 +663,10 @@ static int __init isapnp_create_device(struct pnp_card *card,
 		case _STAG_ENDDEP:
 			if (size != 0)
 				goto __skip;
+			if (option_independent == option)
+				dev_warn(&dev->dev, "missing "
+					 "_STAG_STARTDEP tag\n");
+			option = option_independent;
 			dev_dbg(&dev->dev, "end dependent options\n");
 			break;
 		case _STAG_IOPORT:
-- 
1.5.6

