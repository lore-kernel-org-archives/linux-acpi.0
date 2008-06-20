From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/70] PNP: remove extra 0x100 bit from option priority
Date: Fri, 20 Jun 2008 03:44:04 -0400
Message-ID: <b019f4f739b5346e31f88af88bf9bb33928a892e.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40710 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYFTHqM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:46:12 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00EIJ48Z0VK2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:46:12 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When building resource options, ISAPNP and PNPBIOS set the priority
to something like "0x100 | PNP_RES_PRIORITY_ACCEPTABLE", but we
immediately mask off the 0x100 again in pnp_build_option(), so that
bit looks superfluous.

Thanks to Rene Herman <rene.herman@gmail.com> for pointing this out.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/isapnp/core.c      |    8 +++-----
 drivers/pnp/pnpacpi/rsparser.c |    2 +-
 drivers/pnp/pnpbios/rsparser.c |    6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 3f75fdb..90718be 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -582,7 +582,7 @@ isapnp_parse_name(char *name, unsigned int name_max, unsigned short *size)
 static int __init isapnp_create_device(struct pnp_card *card,
 				       unsigned short size)
 {
-	int number = 0, skip = 0, priority = 0, compat = 0;
+	int number = 0, skip = 0, priority, compat = 0;
 	unsigned char type, tmp[17];
 	struct pnp_option *option;
 	struct pnp_dev *dev;
@@ -621,7 +621,6 @@ static int __init isapnp_create_device(struct pnp_card *card,
 			} else {
 				skip = 1;
 			}
-			priority = 0;
 			compat = 0;
 			break;
 		case _STAG_COMPATDEVID:
@@ -650,10 +649,10 @@ static int __init isapnp_create_device(struct pnp_card *card,
 		case _STAG_STARTDEP:
 			if (size > 1)
 				goto __skip;
-			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			priority = PNP_RES_PRIORITY_ACCEPTABLE;
 			if (size > 0) {
 				isapnp_peek(tmp, size);
-				priority = 0x100 | tmp[0];
+				priority = tmp[0];
 				size = 0;
 			}
 			option = pnp_register_dependent_option(dev, priority);
@@ -663,7 +662,6 @@ static int __init isapnp_create_device(struct pnp_card *card,
 		case _STAG_ENDDEP:
 			if (size != 0)
 				goto __skip;
-			priority = 0;
 			dev_dbg(&dev->dev, "end dependent options\n");
 			break;
 		case _STAG_IOPORT:
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 3808a8f..e6bd14d 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -579,7 +579,7 @@ struct acpipnp_parse_option_s {
 static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 						  void *data)
 {
-	int priority = 0;
+	int priority;
 	struct acpipnp_parse_option_s *parse_data = data;
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 26fb04c..db23ba7 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -315,7 +315,7 @@ pnpbios_parse_resource_option_data(unsigned char *p, unsigned char *end,
 					struct pnp_dev *dev)
 {
 	unsigned int len, tag;
-	int priority = 0;
+	int priority;
 	struct pnp_option *option, *option_independent;
 
 	if (!p)
@@ -389,9 +389,9 @@ pnpbios_parse_resource_option_data(unsigned char *p, unsigned char *end,
 		case SMALL_TAG_STARTDEP:
 			if (len > 1)
 				goto len_err;
-			priority = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
+			priority = PNP_RES_PRIORITY_ACCEPTABLE;
 			if (len > 0)
-				priority = 0x100 | p[1];
+				priority = p[1];
 			option = pnp_register_dependent_option(dev, priority);
 			if (!option)
 				return NULL;
-- 
1.5.6

