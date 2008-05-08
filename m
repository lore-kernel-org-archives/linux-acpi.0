From: Thomas Renninger <trenn@suse.de>
Subject: Re: 2.6.25 pci=noacpi
Date: Thu, 08 May 2008 14:37:47 +0200
Message-ID: <1210250267.26999.57.camel@queen.suse.de>
References: <20080425183807.366134771@ldl.fc.hp.com>
	 <200805010110.40709.lenb@kernel.org>	<48196CC5.6070704@gmail.com>
	 <200805011159.38059.lenb@kernel.org>	<481AF995.3000305@gmail.com>
	 <20080502054729.a91e601c.akpm@linux-foundation.org>
	 <481B12FE.1050805@gmail.com> <1210155584.13141.22.camel@queen.suse.de>
	 <4822AA74.3080300@gmail.com> <1210244763.26999.49.camel@queen.suse.de>
	 <4822E626.3070401@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:37465 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbYEHMhu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2008 08:37:50 -0400
In-Reply-To: <4822E626.3070401@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Jaroslav Kysela <perex@perex.cz>, andreas.herrmann3@amd.com

On Thu, 2008-05-08 at 12:38 +0100, Richard wrote:
> Thomas Renninger wrote:
> > On Thu, 2008-05-08 at 08:23 +0100, Richard wrote:
> >   
> >> Thomas Renninger wrote:
> >>     
> > ...
> >
> >   
> >>>>>> thanks - the idle=poll works to fix the problem.
> >>>>>>         
> >>>>>>             
> >>>>> Well, that's hardly a "fix".  The power consumption will be very high.
> >>>>>
> >>>>>           
> >>>> Hehehe, its a start. A booting kernel is definitely a good start (even 
> >>>> one what drinks battery). I have some avenues in the source to 
> >>>> investigate, but being a ACPI n00bie its trying to get my head around 
> >>>> the mass of code thats a daunting task.
> >>>>     
> >>>>         
> >>> Richard, could you try processor.max_cstate=2 (or even 1), pls (without
> >>> noapictimer).
> >>> Or you can double check whether you have cstates at all first(when
> >>> booting with noapictimer):
> >>> cat /proc/acpi/processor/*/power
> >>>
> >>> Vendors often invalidate deeper sleep states with an invalid latency.
> >>> Maybe this has been forgotten here, Windows does not use deeper C-state
> >>> or it works there for some reason.
> >>> If this works for you, please send dmidecode output.
> >>> IMO we should then blacklist this machine in
> >>> drivers/acpi/processor_idle.c to not use the offending sleep state.
> >>> There already is a blacklist.
> >>>
> >>> Thanks,
> >>>
> >>>    Thomas
> >>>
> >>>
> >>>   
> >>>       
> >> Hi Thomas (and all)
> >>
> >> I tried the processor.max_cstate=2 to no avail.   on a 23, 24 and a .25 
> >> kernel :-P   The machine shuts  down just after INIT  starts.
> >>     
> > Could you also try processor.max_cstate=1 (one kernel is enough, just a
> > quick test... )
> > The culprit is in the idle routine and there just the C-states are
> > triggered..., it should be related to C-states.
> >
> >   
> >> ------------- This is reported when booted with noapictimer ----------------
> >> cat /proc/acpi/processor/*/power
> >> active state:            C0
> >> max_cstate:              C8
> >> bus master activity:     00000000
> >> maximum allowed latency: 6666 usec
> >> states:
> >>     C1:                  type[C1] promotion[--] demotion[--] 
> >> latency[000] usage[00082490] duration[00000000000000000000]
> >>     C2:                  type[C2] promotion[--] demotion[--] 
> >> latency[018] usage[00000000] duration[00000000000000000000]
> >>     
> > I wonder why even C2 is not entered with noapictimer...
> >   
> >>     C3:                  type[C3] promotion[--] demotion[--] 
> >> latency[083] usage[00000000] duration[00000000000000000000]
> >> ----------------------------------------------------------------------------------
> >>     
> >
> >
> >   Thomas
> >
> >
> >   
> Hi there Thomas,
> 
> processor.max_cstate=1 didnt make any difference.   I can video the 
> bootup sequence so you can see exactly what I am looking at?

You mean when exactly it hangs, yes that would be useful.
Really strange is that idle=poll works and processor.max_cstate=1 does
not.
Maybe you can double check that you or I didn't do a mistake with the
boot parameter. Everything would perfectly fit: You have C3, those
machines are known that apictimer does not work in deeper sleep
states...

Interesting could be at what time it hangs and whether the processor
module could have been and was loaded already at that time.
This one provides its own idle routine which will get used when it's
loaded.

Maybe moving away the processor module (eventually it also must be
reverted from initrd) helps?

   Thomas

