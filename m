From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 1/2] PNPACPI: fix IRQ flag decoding
Date: Wed, 28 May 2008 22:53:23 +0200
Message-ID: <483DC643.6090008@keyaccess.nl>
References: <20080527224915.412211349@ldl.fc.hp.com> <20080527224938.356177274@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060001010305030207080602"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38976 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbYE1Uub (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 May 2008 16:50:31 -0400
In-Reply-To: <20080527224938.356177274@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

This is a multi-part message in MIME format.
--------------060001010305030207080602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 28-05-08 00:49, Bjorn Helgaas wrote:

> When decoding IRQ trigger mode and polarity, it is not enough to mask
> by IORESOURCE_BITS because there are now additional bits defined.
> For example, if IORESOURCE_IRQ_SHAREABLE was set, we failed to set
> *triggering and *polarity at all.

Ack. This would also imply the attached is a comment fix...

Rene.


--------------060001010305030207080602
Content-Type: text/plain;
 name="pnp-non-isa-specific-ioresource_bits.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-non-isa-specific-ioresource_bits.diff"

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index d5d40a9..c6801bf 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
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
+/* PnP memory I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_MEM_WRITEABLE	(1<<0)	/* dup: IORESOURCE_READONLY */
 #define IORESOURCE_MEM_CACHEABLE	(1<<1)	/* dup: IORESOURCE_CACHEABLE */
 #define IORESOURCE_MEM_RANGELENGTH	(1<<2)	/* dup: IORESOURCE_RANGELENGTH */

--------------060001010305030207080602--
