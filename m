From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Sun, 10 Jun 2007 15:44:35 -0600
Message-ID: <200706101544.35463.bjorn.helgaas@hp.com>
References: <200705261239.27485.lists-receive@programmierforen.de> <20070531095603.GA24654@infradead.org> <20070610105712.GA4695@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:57159 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435AbXFJVos (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jun 2007 17:44:48 -0400
In-Reply-To: <20070610105712.GA4695@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>, Andi Drebes <lists-receive@programmierforen.de>, kernel-janitors@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 10 June 2007 04:57:12 am Pavel Machek wrote:
> > > > > Any reason to not just replace ACPI_RSD_TABLE_SIZE with ARRAY_SIZE?
> > > 
> > > Probably because ARRAY_SIZE doesn't exist in ACPICA, which is
> > > where this code comes from...
> > > 
> > > When we change syntax in ACPICA files in Linux to make it more "beautiful",
> > > then it creates more work for me -- as forever on, that syntax difference
> > > must be manually compared to upstream ACPICA and Linux -- and that syntax
> > > difference causes upstream patches to no longer apply and require
> > > hand merging.
> > 
> > Or we could stop that ACPCICA crap ASAP.  The acpi code not only looks
> > like crap because of that but it's buggy as hell now.
> 
> +1.
> 
> Len, acpi subsystem is old enough to live by kernel standards, and
> important enough that it should look&feel like a kernel code. It also
> does not seem to change quickly, so merging patches should not be a
> big deal.

I agree the ACPI CA is a nuisance.  But in this case, we're making
a mountain out of a molehill.  I suspect that if somebody spent the
15 minutes to make the ARRAY_SIZE patch work in both the Linux ACPI CA
and the generic Intel one and license it appropriately, Len would
happily apply the patch.
