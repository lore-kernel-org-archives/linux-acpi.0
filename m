From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in acpi_read/write
Date: Fri, 18 Nov 2011 10:27:20 +0100
Message-ID: <201111181027.20707.rjw@sisk.pl>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <201111172127.40664.rjw@sisk.pl> <201111180038.38133.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45348 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab1KRJYg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Nov 2011 04:24:36 -0500
In-Reply-To: <201111180038.38133.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Huang Ying <ying.huang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Friday, November 18, 2011, Thomas Renninger wrote:
> On Thursday 17 November 2011 21:27:40 Rafael J. Wysocki wrote:
> > On Thursday, November 17, 2011, Huang Ying wrote:
> ... 
> > > page_is_ram() is used by x86 ioremap implementation to exclude RAM
> > > range.  So I think it can be used here.
> > 
> > Except that ACPI is not going to be x86-specific any more in the (near?)
> > future.  Have you taken that into consideration?
> This is about the NVS ram resource registering/requesting problem?
> I had an idea to make the resource management more fine grained.
> There already is a possibility to pass "flags" to request_mem_region macro:
> include/linux/ioport.h:
> #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
> #define request_muxed_region(start,n,name)    __request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
> ...
> 
> 
> The idea is to e.g. flag memory with:
>   MEM_NVS
>   MEM_RESERVED
>   (MEM_PCI?)
>   other archs may have other memory flags
>   ...
> once it got detected/initialized at early boot.
> 
> and then have something like:
> request_specific_mem_region(start, n, name, (MEM_NVS | MEM_RESERVED))
> for apei (or others allowed to access NVS mem) which is only successful
> if the requested memory region has been marked as NVS/RESERVED memory.
> 
> This is nothing I have time for right now, therefore don't get
> the mail wrong: I don't object to adding any other working solution
> discussed here.
> Just an idea how this could be solved in a cleaner way,
> also re-usable for others.
> 
> What do you think?

That sounds like a good idea in principle, it would save us from some ugly
hacks here and there I think. :-)

Thanks,
Rafael
