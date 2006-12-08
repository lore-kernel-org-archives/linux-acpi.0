From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Fri, 8 Dec 2006 09:50:52 -0700
Message-ID: <200612080950.52390.bjorn.helgaas@hp.com>
References: <1165496170.11485.74.camel@localhost.localdomain> <200612070928.30460.bjorn.helgaas@hp.com> <200612080529.56183.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:58104 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425628AbWLHQvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Dec 2006 11:51:01 -0500
In-Reply-To: <200612080529.56183.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

[Sorry for the duplicate; I fat-fingered my reply and inadvertently
introduced an HTML sub-part, causing linux-acpi to reject it as spam.]

On Friday 08 December 2006 03:29, Len Brown wrote:
> On Thursday 07 December 2006 11:28, Bjorn Helgaas wrote:
> > Is it possible to extend the PNP model to include ACPI, rather
> > than introducing a new ACPI model alongside the PNP model?
> 
> Hmmm, well, I thought we were doing well to get ride of ACPI specific
> devices names...
> 
> The PNPBIOS + ACPI  box will never run both PNPBIOS and ACPI at
> the same time.

Right.  But should the fact that we use ACPI instead of PNPBIOS make
a difference to userland?  My intuition says "no."  Obviously there
might be new devices and new functionality with ACPI, so there might
be new files and knobs in sysfs, but if you don't care about those,
it'd be nice if all the old PNP stuff just worked.

> My question is where the "cut point is".  At what point do we start
> pushing this work upstream, and what parts of it?

I don't want to delay pushing Zhang's patches upstream.  I think
they are definitely a step in the right direction.

Bjorn
