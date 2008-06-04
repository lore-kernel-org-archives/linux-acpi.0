From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 03/18] PNP: IORESOURCE_* flags are PNP-specific, not ISA PNP-specific
Date: Wed, 04 Jun 2008 16:09:36 -0600
Message-ID: <20080604221127.351243617@ldl.fc.hp.com>
References: <20080604220933.168145536@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:20736 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbYFDWLZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 18:11:25 -0400
Content-Disposition: inline; filename=pnp-ioresource-comment-fix
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

Change comments on the bus-specific IORESOURCE bit definitions
to indicate the PNP ones are not ISA-specific.  They are used
by PNPBIOS and PNPACPI in addition to ISAPNP.

Rene Herman <rene.herman@gmail.com> wrote this patch:
    http://marc.info/?l=linux-acpi&m=121200787202959&w=4.
I picked it up to resolve conflicts with other patches.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/include/linux/ioport.h
===================================================================
--- work10.orig/include/linux/ioport.h	2008-06-03 14:22:29.000000000 -0600
+++ work10/include/linux/ioport.h	2008-06-03 14:32:52.000000000 -0600
@@ -53,14 +53,14 @@ struct resource_list {
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
 
-/* ISA PnP IRQ specific bits (IORESOURCE_BITS) */
+/* PnP IRQ specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IRQ_HIGHEDGE		(1<<0)
 #define IORESOURCE_IRQ_LOWEDGE		(1<<1)
 #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
 #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
 #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
 
-/* ISA PnP DMA specific bits (IORESOURCE_BITS) */
+/* PnP DMA specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
 #define IORESOURCE_DMA_8BIT		(0<<0)
 #define IORESOURCE_DMA_8AND16BIT	(1<<0)
@@ -76,7 +76,7 @@ struct resource_list {
 #define IORESOURCE_DMA_TYPEB		(2<<6)
 #define IORESOURCE_DMA_TYPEF		(3<<6)
 
-/* ISA PnP memory I/O specific bits (IORESOURCE_BITS) */
+/* PnP memory specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_MEM_WRITEABLE	(1<<0)	/* dup: IORESOURCE_READONLY */
 #define IORESOURCE_MEM_CACHEABLE	(1<<1)	/* dup: IORESOURCE_CACHEABLE */
 #define IORESOURCE_MEM_RANGELENGTH	(1<<2)	/* dup: IORESOURCE_RANGELENGTH */

-- 
