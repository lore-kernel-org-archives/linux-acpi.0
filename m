From: Len Brown <lenb@kernel.org>
Subject: [stable PATCH for 2.6.24.5 and 2.6.25] pnpacpi: fix potential corruption on "pnpacpi: exceeded the max number of IRQ resources 2"
Date: Wed, 23 Apr 2008 00:09:13 -0400
Message-ID: <200804230009.15258.lenb@kernel.org>
References: <20080417010122.148289106@sous-sol.org> <20080417010359.629397865@sous-sol.org> <200804181548.33872.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56279 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbYDWEMI (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 00:12:08 -0400
In-Reply-To: <200804181548.33872.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, stable@kernel.org, Linux-acpi@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Len Brown <len.brown@intel.com>

PNP_MAX_IRQ is 2
If a device invokes pnpacpi_parse_allocated_irqresource() 0, 1, or 2 times, we are happy.
The 3rd time, we will fail and print "pnpacpi: exceeded the max number of IRQ resources: 2"
The 4th and subsequent calls (if this ever happened) would silently scribble on
irq_resource[2], which doesn't actualy exist.

Found-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 2dcd196..98cbc9f 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -84,10 +84,12 @@ static void pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res,
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
 	       i < PNP_MAX_IRQ)
 		i++;
-	if (i >= PNP_MAX_IRQ && !warned) {
-		printk(KERN_WARNING "pnpacpi: exceeded the max number of IRQ "
-				"resources: %d \n", PNP_MAX_IRQ);
-		warned = 1;
+	if (i >= PNP_MAX_IRQ) {
+		if (!warned) {
+			printk(KERN_WARNING "pnpacpi: exceeded the max number"
+				" of IRQ resources: %d\n", PNP_MAX_IRQ);
+			warned = 1;
+		}
 		return;
 	}
 	/*
