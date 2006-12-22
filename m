From: Len Brown <lenb@kernel.org>
Subject: Re: sysfs regression on Supermicro X7DB8+
Date: Thu, 21 Dec 2006 23:51:27 -0500
Message-ID: <200612212351.27906.lenb@kernel.org>
References: <200612210341.08394.lenb@kernel.org> <1166757145.12505.78.camel@localhost.localdomain> <200612212110.09190.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48305 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945932AbWLVEwF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 23:52:05 -0500
In-Reply-To: <200612212110.09190.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 21 December 2006 23:10, Bjorn Helgaas wrote:
> On Thursday 21 December 2006 20:12, Zhang Rui wrote:
> > Then I have an idea about the other ones. We can also convert the PNPids
> > reserved in the spec to such kind of strings.
> > E.g.	"PNP0C0D,PNP0C0C,PNP0C0E"	"button"
> > 	"ACPI0003"			"ac_adapter"
> > 	"PNP0C0A"			"battery"
> 
> I hesitate to hide the PNP IDs altogether.  They seem analogous
> to PCI vendor/device IDs.  We expose the PCI IDs directly and
> let user-space map them into human-readable strings.  In fact,
> the mostly-forgotten lspnp package already has a pnp.ids file
> with these mappings.  So I vote for keeping the mapping there.

I agree with Bjorn that it is a slippery slope for the kernel to try to be human friendly,
and that the kernel should just give the raw names and let an application translate them.

I think my original point was somewhat mis-interpreted.
My point is that when the kernel has _no_ PNPid to use to describe the device node
and we have to manufacture a string anyway, that we might as well manufacture
a string that a human can read.

thanks,
-Len
