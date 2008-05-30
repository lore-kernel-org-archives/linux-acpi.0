From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 02/15] PNP: whitespace/coding style fixes
Date: Fri, 30 May 2008 16:48:55 -0600
Message-ID: <20080530224931.775639142@ldl.fc.hp.com>
References: <20080530224853.976744229@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:18537 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYE3Wt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2008 18:49:29 -0400
Content-Disposition: inline; filename=pnp-interface-style
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

No functional change; just make a couple declarations
consistent with the rest of the file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/interface.c
===================================================================
--- work10.orig/drivers/pnp/interface.c	2008-05-09 14:42:25.000000000 -0600
+++ work10/drivers/pnp/interface.c	2008-05-09 14:45:57.000000000 -0600
@@ -216,12 +216,12 @@ static ssize_t pnp_show_options(struct d
 				struct device_attribute *attr, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	pnp_info_buffer_t *buffer;
 	struct pnp_option *independent = dev->independent;
 	struct pnp_option *dependent = dev->dependent;
 	int ret, dep = 1;
 
-	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
-	    pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
 
@@ -248,17 +248,18 @@ static ssize_t pnp_show_current_resource
 					  char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	pnp_info_buffer_t *buffer;
 	struct pnp_resource *pnp_res;
 	struct resource *res;
 	int ret;
-	pnp_info_buffer_t *buffer;
 
 	if (!dev)
 		return -EINVAL;
 
-	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
+
 	buffer->len = PAGE_SIZE;
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
@@ -295,9 +296,9 @@ static ssize_t pnp_show_current_resource
 	return ret;
 }
 
-static ssize_t
-pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
-			  const char *ubuf, size_t count)
+static ssize_t pnp_set_current_resources(struct device *dmdev,
+					 struct device_attribute *attr,
+					 const char *ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	char *buf = (void *)ubuf;

-- 
