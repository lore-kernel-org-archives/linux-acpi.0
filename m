From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Wed, 24 Mar 2010 15:40:01 +0100
Message-ID: <201003241540.01187.trenn@suse.de>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <201003121418.14204.trenn@suse.de> <4BA123DB.5050807@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54898 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab0CXOkG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Mar 2010 10:40:06 -0400
In-Reply-To: <4BA123DB.5050807@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: chen gong <gong.chen@linux.intel.com>, ykzhao <yakui.zhao@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@novell.com

On Wednesday 17 March 2010 19:47:55 Prarit Bhargava wrote:
> 
> Thomas Renninger wrote:
> > On Thursday 11 March 2010 09:32:09 chen gong wrote:
> >   
> >> On 2010-3-11 16:07, ykzhao wrote:
> >>     
> > ... 
> >   
> >> BTW, how about using UDEV rules to do this operation. It looks more smooth. I know some
> >> Novell guy is working on it.
> >>     
> > I also know this guy :)
> >
> > These would be the udev rules to automatically add memory/cpus:
> > SUBSYSTEM=="cpu", ACTION=="add", TEST=="online", ATTR{online}=="0", ATTR{online}="1", RUN+="/bin/logger onlining cpu: $env{DEVPATH}"
> > SUBSYSTEM=="memory", ACTION=="add", TEST=="state", ATTR{state}=="offline", ATTR{state}="online", RUN+="/bin/logger onlining memory: $env{DEVPATH}"
> >
> > But this should be the same as you suggest (at least the memory rule)
> > to do in the kernel:
> > automatically online the memory, once hotadded.
> >
> > I would not add any udev rules before this does not work
> > reliably and currently it is totally broken, mainly because:
> >   - not being able to alloc memory on foreign nodes (at least with slab)
> >   - C-state, throttling and cpufreq set up is done without valid
> >     cpu_data(new_cpu) resulting in wrong C-state (and other) info
> >
> >   
> 
> Thomas, forgive my ignorance of udev rules ... but can one udev rule 
> block another?  ... That's not the best way to explain it ... here's an 
> example:
> 
> CPU hot add on Nehalem-EX.  Memory is brought online.  Memory udev 
> events are generated.  CPU udev events are generated.
> 
> Can the memory udev events block the cpu udev events?  ie) can I be 
> assured that memory will come online before the cpus?
I give up, there are too many open issues.
Onlining cpus and memory in parallel currently is not a good idea.

If the cpu event comes first, you run into other issues. I accidently had
the acpi_memhotplug driver not loaded, in this case a new node was not
created at all and the cpus ended up on the wrong node.

Some comments on your patch:
Your patch misses EXPORT_SYMBOL(_GPL?)(set_memory_state); (I wonder why
drivers/base/memory.c does not export symbols under gpl...) and
EXPORT_SYMBOL_GPL(online_pages);

You also need to set each memory block MEM_ONLINE somehow,
while all memory was active, only one memory block showed "online" here:
/sys/devices/system/node/node3/memory*/state
which has side-effects.

Would be great if you add me to CC if you repost or on related topics.

Thanks,

     Thomas
