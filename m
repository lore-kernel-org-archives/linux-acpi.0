From: Andi Kleen <ak@muc.de>
Subject: Re: CONFIG_ACPI_HOTPLUG_MEMORY=m with x86_64 devel tree
Date: 23 Mar 2006 16:37:35 +0100
Message-ID: <20060323153735.GB49452@muc.de>
References: <20060321222332.1a037c8e.akpm@osdl.org> <20060322192804.E490.Y-GOTO@jp.fujitsu.com> <20060322030208.30e3581e.akpm@osdl.org> <20060322203220.6433e697.kamezawa.hiroyu@jp.fujitsu.com> <20060322192134.GA44212@muc.de> <20060323082732.9828ca2f.kamezawa.hiroyu@jp.fujitsu.com> <20060323000759.GB71469@muc.de> <20060323093609.8eb03249.kamezawa.hiroyu@jp.fujitsu.com> <20060323024306.GA90581@muc.de> <20060323122250.c22003d0.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:13833 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030247AbWCWPhl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 10:37:41 -0500
Date: Thu, 23 Mar 2006 16:37:35 +0100
Content-Disposition: inline
In-Reply-To: <20060323122250.c22003d0.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, tony.luck@intel.com, yo-goto@ml.soft.fujitsu.com, kmannth@gmail.com

On Thu, Mar 23, 2006 at 12:22:50PM +0900, KAMEZAWA Hiroyuki wrote:
> On 23 Mar 2006 03:43:06 +0100
> Andi Kleen <ak@muc.de> wrote:
> 
> >
> > Don't do that.
> > The x86-64 kernel will preallocate memmaps when everything is enabled soon.
> > Ok that won't concern your IA64 machine immediately.
> > 
> > 
> 
> I read hotadd-reserve patches again.. Okay, please preallocate if you want.
> 
> Problem I found is:
> 1) Goto's rebuild_zonelist patch will not work if CONFIG_MEMORY_HOTPLUG=n.
>    rebuild zonelist is necessary when the system has just memory < 4G at boot,   
>    and hot add memory > 4G. because x86_64 has DMA32, ZONE_NORAML is not included into
>    zonelist at boot time if system doesn't have memory >4G at boot.
> 
> 2) zone and node's spanned_pages and present_pages are not incremented. you should do.

Thanks for the review. All good points. Will fix. 

I think I just can force the higher zones to be built at boot when there 
are any SRATs > 4GB.

I will also add some throttling to prevent the kernel not booting
in the "1TB of hotplug ram" scenario you outlined. Probably just limit
the memory map preallocated to not more than some percentage of the 
free RAM.

Just need to figure out a good limit.

Currently mem_map costs about 1.5% of RAM, so not allocating more
than e.g. 5% of RAM to hotplug memmaps would limit the hotplug memory
on a 1GB machine to 3GB. Hmm, maybe 10% but users could be annoyed
if they lose that much memory due to hotplug.

Another problem is that mem_map needs to be contiguous by node,
but that can be handled with existing functions by checking the e820 map.

-Andi
