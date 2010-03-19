From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Fri, 19 Mar 2010 17:55:35 +0100
Message-ID: <201003191755.35421.trenn@suse.de>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <201003121418.14204.trenn@suse.de> <4BA123DB.5050807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48484 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab0CSQzi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Mar 2010 12:55:38 -0400
In-Reply-To: <4BA123DB.5050807@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ykzhao <yakui.zhao@intel.com>, chen gong <gong.chen@linux.intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 17 March 2010 07:47:55 pm Prarit Bhargava wrote:
> Thomas Renninger wrote:
> > On Thursday 11 March 2010 09:32:09 chen gong wrote:
> >> On 2010-3-11 16:07, ykzhao wrote:
> >
> > ...
> >
> >> BTW, how about using UDEV rules to do this operation. It looks more
> >> smooth. I know some Novell guy is working on it.
> >
> > I also know this guy :)
> >
> > These would be the udev rules to automatically add memory/cpus:
> > SUBSYSTEM=="cpu", ACTION=="add", TEST=="online", ATTR{online}=="0",
> > ATTR{online}="1", RUN+="/bin/logger onlining cpu: $env{DEVPATH}"
> > SUBSYSTEM=="memory", ACTION=="add", TEST=="state",
> > ATTR{state}=="offline", ATTR{state}="online", RUN+="/bin/logger onlining
> > memory: $env{DEVPATH}"
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

Blocking does not work.
But I have an idea, whatabout:
  - CPU add rule which only adds a CPU if the corresponding Numa node already
    has onlined memory
  - Memory add rule which adds the memory and also onlines CPUs if the Numa
    node still has offlined CPUs

This has the side effect that you online a CPU which may have been offlined on
purpose if you hotadd memory on the same node..., a rather uncommon case.

A quick try showed that it would be convenient to add the Numa node to the 
uevent which is a bit tricky...
Ok, I got this working, but messed up the cpu hotplugging with my patches:
...
Unable to map lapic 32 to logical cpu number
...
This already worked...

I wanted to post something today, but I couldn't made it.
Still I more or less could prove that above works and I hopefully can show
some results on Monday.

Comments?

   Thomas

BTW: I was wrong with slub. It also has bad side effects. What is strange is 
that with deep C-states one CPU (not the onlined) gets stuck (softlock up), 
but with processor.max_cstate=1 it does not. It reproducable hangs (loops?) 
in mm code, looks like it tries to alloc foreign memory. What I do not 
understand is why this happens with C3, but not with C1, it shouldn't have 
anything to do with memory setup. Anyway, I go back to slab again, lets 
ensure somehow that memory hot add comes first.
