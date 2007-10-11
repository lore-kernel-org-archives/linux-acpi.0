From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 6/6] PNP: add debug message for adding new device
Date: Thu, 11 Oct 2007 14:42:04 -0600
Message-ID: <200710111442.05167.bjorn.helgaas@hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com> <20070928164350.680575900@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:40173 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395AbXJKVD2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2007 17:03:28 -0400
In-Reply-To: <20070928164350.680575900@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Sigh, this isn't my finest hour.  My patch adds an unused variable
warning when !CONFIG_PNP_DEBUG.  Can you please add this additional
patch?


PNP: add debug message for adding new device (fix unused var)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/core.c
===================================================================
--- w.orig/drivers/pnp/core.c	2007-10-11 14:33:31.000000000 -0600
+++ w/drivers/pnp/core.c	2007-10-11 14:33:40.000000000 -0600
@@ -141,7 +141,9 @@
 int pnp_add_device(struct pnp_dev *dev)
 {
 	int ret;
+#ifdef CONFIG_PNP_DEBUG
 	struct pnp_id *id;
+#endif
 
 	if (dev->card)
 		return -EINVAL;
