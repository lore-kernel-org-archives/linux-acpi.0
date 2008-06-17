From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 24/28] PNP: remove extra 0x100 bit from option priority
Date: Tue, 17 Jun 2008 16:58:47 -0600
Message-ID: <20080617225912.640466826@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:17712 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759459AbYFQXAK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 19:00:10 -0400
Content-Disposition: inline; filename=pnp-remove-extra-priority-bits
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

When building resource options, ISAPNP and PNPBIOS set the priority
to something like "0x100 | PNP_RES_PRIORITY_ACCEPTABLE", but we 
immediately mask off the 0x100 again in pnp_build_option(), so that
bit looks superfluous.

Thanks to Rene Herman <rene.herman@gmail.com> for pointing this out.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work14/drivers/pnp/isapnp/core.c
===================================================================
--- work14.orig/drivers/pnp/isapnp/core.c	2008-06-17 15:52:27.000000000 -0600
+++ work14/drivers/pnp/isapnp/core.c	2008-06-17 15:52:33.000000000 -0600
@@ -582,7 +582,7 @@ isapnp_parse_name(char *name, unsigned i
 static int __init isapnp_create_device(struct pnp_card *card,
 				       unsigned short size)
 {
-	int number = 0, skip = 0, priority = 0, compat = 0;
+	int number = 0, skip = 0, priority, compat = 0;
 	unsigned char type, tmp[17];
 	struct pnp_option *option;
 	struct pnp_dev *dev;
@@ -621,7 +621,6 @@ static int __init isapnp_create_device(s
 			} else {
 				skip = 1;
 			}
-			priority = 0;
 			compat = 0;
 			break;
 		case _STAG_COMPATDEVID:
@@ -650,10 +649,10 @@ static int __init isapnp_create_device(s
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
@@ -663,7 +662,6 @@ static int __init isapnp_create_device(s
 		case _STAG_ENDDEP:
 			if (size != 0)
 				goto __skip;
-			priority = 0;
 			dev_dbg(&dev->dev, "end dependent options\n");
 			break;
 		case _STAG_IOPORT:
Index: work14/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work14.orig/drivers/pnp/pnpbios/rsparser.c	2008-06-17 15:52:27.000000000 -0600
+++ work14/drivers/pnp/pnpbios/rsparser.c	2008-06-17 15:52:33.000000000 -0600
@@ -315,7 +315,7 @@ pnpbios_parse_resource_option_data(unsig
 					struct pnp_dev *dev)
 {
 	unsigned int len, tag;
-	int priority = 0;
+	int priority;
 	struct pnp_option *option, *option_independent;
 
 	if (!p)
@@ -389,9 +389,9 @@ pnpbios_parse_resource_option_data(unsig
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
Index: work14/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work14.orig/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 15:52:29.000000000 -0600
+++ work14/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 15:52:33.000000000 -0600
@@ -579,7 +579,7 @@ struct acpipnp_parse_option_s {
 static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 						  void *data)
 {
-	int priority = 0;
+	int priority;
 	struct acpipnp_parse_option_s *parse_data = data;
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;

-- 
