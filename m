From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH V2 2/3] PNP: Allow resources to be set as disabled
Date: Wed, 11 Apr 2012 22:49:53 +0200
Message-ID: <4F85EE71.4060500@gmx.net>
References: <4F85ED86.8010002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:45684 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756977Ab2DKUuB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2012 16:50:01 -0400
In-Reply-To: <4F85ED86.8010002@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bhelgaas@google.com, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch allows to set PNP resources as "disabled".  As such, the patch is
a follow-up to commit 18fd470a48396c8795ba7256c5973e92ffa25cb3 where parsing
of ACPI PNP resources that can be disabled was made possible.  

The patch achieves this by allowing the strings "disabled" and "<none>" to be 
used as a valid PNP resource value.  The value "disabled" is used because it
also appears when reporting PNP resources, whereas the string "<none>" is
used when reporting PNP options.

The patch is required in order to support the setting of "disabled" IRQs like 
described in the commit 29df8d8f8702f0f53c1375015f09f04bc8d023c1, i.e., with
this patch applied, some vintage IBM ThinkPads like the 600E can allocate the
resources such that all devices can be used simultaneously.  

The patch is applied against Linux 3.3.x.


Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>


Index: linux/drivers/pnp/interface.c
===================================================================
--- linux.orig/drivers/pnp/interface.c
+++ linux/drivers/pnp/interface.c
@@ -311,10 +311,14 @@ static char *pnp_get_resource_value(char
 	if (flags)
 		*flags = 0;
 
-	/* TBD: allow for disabled resources */
-
 	buf = skip_spaces(buf);
-	if (start) {
+	if (flags && !strnicmp(buf, "disabled", 8)) {
+		buf += 8;
+		*flags |= IORESOURCE_DISABLED;
+	} else if (flags && !strnicmp(buf, "<none>", 6)) {
+		buf += 6;
+		*flags |= IORESOURCE_DISABLED;
+	} else if (start) {
 		*start = simple_strtoull(buf, &buf, 0);
 		if (end) {
 			buf = skip_spaces(buf);
