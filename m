From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Wed, 10 Mar 2010 09:57:05 +0800
Message-ID: <1268186225.3606.25.camel@localhost.localdomain>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>
	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59906 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab0CJB6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Mar 2010 20:58:53 -0500
In-Reply-To: <4B969305.9070103@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-03-10 at 02:27 +0800, Prarit Bhargava wrote:
> 
> Matthew Garrett wrote:
> > On Tue, Mar 09, 2010 at 09:12:03AM -0500, Prarit Bhargava wrote:
> >   
> >> New sockets have on-die memory controllers.  This means that in certain
> >> HW configurations the memory behind the socket comes and goes as the socket
> >> is physically enabled and disabled.
> >>
> >> Since the cpu bringup code does on node memory allocations, the memory on the
> >> added socket must be onlined first.
> >>
> >> Add a .config option to automatically online hot added memory, and enable it
> >> in the acpi memory add path.
> >>     
> >
> > This seems like the right thing to do.
> >
> >   
> >> +config ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
> >> +	bool "Automatically online hotplugged memory"
> >> +	depends on ACPI_HOTPLUG_MEMORY
> >> +	default n
> >>     
> >
> > default !S390? default x86?
> >   
> 
> I've been inquiring about this.  It seems that some vendors want the 
> capability to manually bring memory online.  I'm trying to get more 
> details as this doesn't seem intuitive.  It seems to me that if you add 
> memory you want to online it right now.
> 
> >   
> >> +		result = online_pages(info->start_addr >> PAGE_SHIFT,
> >> +				      info->length >> PAGE_SHIFT);
> >> +		if (!result)
> >> +			set_memory_state(info->start_addr, MEM_ONLINE);
> >> +		else
> >> +			printk("Memory online failed.\n");
> >>     
> >
> > That probably wants to be more descriptive and have a loglevel. 
> 
> Oops.  I'm very bad about setting the loglevel's on my printk's ;) ... 
> I'll fix that in the next patch.

One note is that the hot-added memory will be automatically onlined. And
we had better add an interface so that the user-space can quiry whether
the hot-added memory is automatically onlined. Otherwise the user-space
will receive the corresponding event and online hot-added memory again.
In such case it will get some error messages.

> 
> > What 
> > happens if this fails? The CPU presumably can't be brought up?
> >   
> 
> That's a good question...  After thinking about it I think that 
> acpi_processor_add() must check the node to see if it has memory before 
> bringing the cpu online.

Why do we need to see whether the memory is onlined before bringing cpu
to online state? It seems that there is no dependency between cpu online
and memory online.

Thanks.
> 
> I'll code that up, test, and repost.
> 
> P.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

