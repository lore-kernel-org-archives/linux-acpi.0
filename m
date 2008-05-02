From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25 pci=noacpi
Date: Fri, 2 May 2008 05:47:29 -0700
Message-ID: <20080502054729.a91e601c.akpm@linux-foundation.org>
References: <20080425183807.366134771@ldl.fc.hp.com>
	<200805010110.40709.lenb@kernel.org>
	<48196CC5.6070704@gmail.com>
	<200805011159.38059.lenb@kernel.org>
	<481AF995.3000305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59265 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760111AbYEBMsf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2008 08:48:35 -0400
In-Reply-To: <481AF995.3000305@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

On Fri, 02 May 2008 12:23:01 +0100 Richard <tuxbox.guru@gmail.com> wrote:

> Len Brown wrote:
> > On Thursday 01 May 2008, Richard wrote:
> >   
> >> Len Brown wrote:
> >>     
> >>> On Tuesday 29 April 2008, Richard wrote:
> >>>   
> >>>       
> >>>> Hi there,
> >>>>
> >>>> Now I am at a loss.. I cant get any logs from netconsole. With ACPI
> >>>> enabled it drops dead just after the kernel hands control to Init. When
> >>>> I reboot with acpi disabled there is no trace of the previous boot in
> >>>> /var/log/message or kernel logs.
> >>>>
> >>>> The network card I have is a Tigon3 and its not initialised before the
> >>>> system dies... or so it looks (altho I cant seem to get any netconsole
> >>>> working - I suspect pebkac)
> >>>>
> >>>> I have tried to find an option where the kernel boot is logged
> >>>> explicitly to disk, but I cant seem to find the option. There is so much
> >>>> chaff I cant seem to get my brain to find the REAL options list thats up
> >>>> to date.
> >>>>
> >>>> Any pointers are appreciated
> >>>>     
> >>>>         
> >>> go fishing with this bait:
> >>>
> >>> idle=poll
> >>> acpi=noirq
> >>>
> >>> -Len
> >>>
> >>>   
> >>>       
> >> Thanks :-) With help from Thomas (and his team) , noapictimer seems to
> >> have fixed the symptom.. now its to hunt for the cure :-)
> >>     
> >
> > if the problem is the apic timer stopping during C-states,
> > then you should find that idle=poll will also work around the problem.
> > If idle=poll does not work around it but noapictimer does, then
> > the problem is the apic timer when the system is non-idle.
> >
> > -Len
> >
> >   
> Hi Len,
> 
> thanks - the idle=poll works to fix the problem.

Well, that's hardly a "fix".  The power consumption will be very high.
