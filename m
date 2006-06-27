From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Tue, 27 Jun 2006 10:03:12 -0600
Message-ID: <200606271003.12579.bjorn.helgaas@hp.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com> <1151393390.21189.59.camel@sli10-desk.sh.intel.com> <1151409746.44a11e52e7002@imp8-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:63200 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932493AbWF0QE0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 12:04:26 -0400
In-Reply-To: <1151409746.44a11e52e7002@imp8-g19.free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: castet.matthieu@free.fr
Cc: Shaohua Li <shaohua.li@intel.com>, Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, uwe.bugla@gmx.de

On Tuesday 27 June 2006 06:02, castet.matthieu@free.fr wrote:
> Selon Shaohua Li <shaohua.li@intel.com>:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c4bb6f5ad968540d7f9619565bacd18d7419b85f
> > Thanks and sorry I didn't find the issue before. We'd better blacklist
> > root bridge. I saw at lest one BIOS (IA64 box) didn't assign correct
> > producer/consumer flag to root bridge resources. Blacklist it is much
> > safer.

If there's a specific broken BIOS, I'd prefer a quirk-type
mechanism to work around it.

> Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
> If not we will have the same problem with others devices...
> 
> I don't think blacklist is the solution : pnpacpi should be able to handle all
> ressources types : we should complete the implementation instead of blacklist
> devices our implementation doesn't support.

I agree.  I don't think blacklisting PNP0A03 is the correct solution.
Any ACPI device can have a producer resource.  The next time we
find a non-PNP0A03 bridge device with a producer resource, we'll
just trip over the same problem again.

Adam, Len, or Shaohua, can you explain the reason for preferring
a blacklist entry?
