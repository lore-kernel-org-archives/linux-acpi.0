From: Alok Kataria <akataria@vmware.com>
Subject: Re: acpi based pci gap calculation  - v3
Date: Tue, 15 Jul 2008 13:54:16 -0700
Message-ID: <1216155256.6135.25.camel@alok-dev1>
References: <1216148382.6135.21.camel@alok-dev1>
	 <200807151328.00739.jbarnes@virtuousgeek.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:37684 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155AbYGOUyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 16:54:43 -0400
In-Reply-To: <200807151328.00739.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>

On Tue, 2008-07-15 at 13:28 -0700, Jesse Barnes wrote:
> On Tuesday, July 15, 2008 11:59 am Alok Kataria wrote:
> > Hi Andi,
> >
> > I don't see this patch being applied in any of the tree yet.
> > Resending this incase you guys might have missed it.
> > I assume this will go through the ACPI tree.
> >
> > The need for this patch was explained in
> > http://marc.info/?l=linux-kernel&m=121441818818598&w=2
> >
> > The v2 patch was discussed in
> > http://marc.info/?l=linux-acpi&m=121433339619175&w=2
> >
> > I then sent a incremental patch on top of v2 to fix some conditions and
> > handle the change in the e820_search_gap interface.
> >
> > In this v3 patch, i have folded the incremental fix into the v2 patch.
> > Please apply this.
> 
> This should probably go to linux-pci too.
> 
> I wonder if this is stable enough to go into 2.6.27?  

I have tested it with couple of different BIOS settings and it seems to
work as it should.

> Most of the PCI bugs we
> have at the moment are related to PCI resource allocation failures.  My hope
> is that finding more space will fix most of them.  Assuming this patch
> doesn't have any dependencies, I can put it in my linux-next branch.

No dependencies, I had added a function e820_search_gap which is used by
this patch. This function is already in the mainline tree. 
Thanks for applying.

--
Alok

