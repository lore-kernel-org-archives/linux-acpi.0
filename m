From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Fri, 30 Jun 2006 09:30:06 +0800
Message-ID: <1151631006.21189.111.camel@sli10-desk.sh.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <200606281055.26887.bjorn.helgaas@hp.com>
	 <1151543616.21189.99.camel@sli10-desk.sh.intel.com>
	 <200606291238.38984.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30068 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751191AbWF3Bcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jun 2006 21:32:48 -0400
In-Reply-To: <200606291238.38984.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: castet.matthieu@free.fr, Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, uwe.bugla@gmx.de

On Thu, 2006-06-29 at 12:38 -0600, Bjorn Helgaas wrote:
> On Wednesday 28 June 2006 19:13, Shaohua Li wrote:
> > On Wed, 2006-06-28 at 10:55 -0600, Bjorn Helgaas wrote:
> > > On Tuesday 27 June 2006 19:02, Shaohua Li wrote:
> > > > Or could we take this way, merge both patches (both patches are good to
> > > > me), which should be safer. Anyway, it doesn't make sense to export root
> > > > bridge to pnp layer to me.
> > > 
> > > One reason I don't like the blacklist is because it just papers over
> > > the problem without leaving a clue about how to really solve it.
> > > For example, if PNP is enhanced later to comprehend resource producers,
> > > we won't know to go back and remove things from the blacklist.
> > So lets have a note there. It (no blacklist) is meaningful to have all
> > ACPI devices handled by PNP layer, but currently not. We don't expect a
> > PNP driver for root bridge. And we will take risk of buggy BIOS.
> 
> Assuming we apply the first patch, a blacklist entry is neither
> necessary (because the PNPACPI producer check covers it) nor
> sufficient (because non-PNP0A03 devices may also have producer
> resources).
> 
> It's true that blacklisting PNP0A03 will prevent problems if a BIOS
> has buggy _CRS data for such a device.  But it will also hide Linux
> problems like the one I fixed here:
>     http://marc.theaimsgroup.com/?l=linux-acpi&m=113890268621542&w=2
> 
> So I think we should not blacklist PNP0A03 until we discover a specific
> problem that requires that.
Looks you just want it to find bug :). If you insist, I'm fine with your
proposal.

Thanks,
SHaohua
