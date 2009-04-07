From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 86/98] ACPI: cap off P-state transition latency from buggy
 BIOSes
Date: Tue, 07 Apr 2009 01:48:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070142190.5698@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <200904021450.26935.trenn@suse.de>
 <alpine.LFD.2.00.0904031226350.4655@localhost.localdomain>
 <200904060017.25093.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:18828 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZDGFsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 01:48:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP006RMUSAWMV2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 00:48:11 -0500 (CDT)
In-reply-to: <200904060017.25093.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>



thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 6 Apr 2009, Thomas Renninger wrote:

> On Friday 03 April 2009 06:35:20 pm Len Brown wrote:
> > > Whatabout:
> > >
> > > CC: stable@kernel.org
> >
> > I've added this to my .stable list, thanks for pointing it out.
> > Note that I don't send patches to stable until after they are upstream.
> Thanks.
> There are generally two kind of patches that should go to stable:
> 1) The simple NULL pointer fixes (and similar safe ones) which can/
>      should go directly to stable, at least if they hit the mainline kernel
> 2) Bug fixes which potentially could harm others (as you mentioned
>      in the other one).
> For the latter these should go to stable if they survived a full mainline kernel
> round (and eventually together with add-on patches) or at least some RCs.
> Looks like every maintainer has his own way (and overhead) to queue and
> take care of them?
> I wonder how things could get automated and patches could get tagged,
> not only with CC: <stable@kernel.org>, but to consider both cases.
> Or you always add CC: <stable@kernel.org>, the stable team will ask again
> before adding them and you can tell them to still hold them off for a while,
> so that they get more testing.

I send patches to stable manually,
and I manually make sure it applies to the targeted .y release first.

As you know, I'm not super aggressive in what I send back,
but I do keep a list for this in my notes.

> > > This is a bug fix also existing in older kernels.
> > > I remember even much newer HW (Intel and AMD) based have higher values
> > > exported through ACPI _PSS tables as latency.
> > >
> > > I remember values around (50-70us Core 2 Duo?) and 37us on K10.
> > > I doubt this patch will cause much pain, but being close to values
> > > exported via ACPI tables on similar HW sounds like a good idea.
> > >
> > > In 2.6.30 (as soon as cpufreq branch is merged) you get that easily from
> > > here:
> > > cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency
> > > 109000
> > >
> > > I expect my machine's (K8 Dual core) ACPI exported value will be cut down
> > > to:
> > > 20000
> > > now?
> >
> > Does your AMD box run acpi-cpufreq and use native MSR access to change
> > P-states?

> Argh, now I see it. It's done in acpi-cpufreq, it looked like generic code in
> drivers/acpi/processor_*
> 
> But it still looks rather low. I've seen higher values exported
> via ACPI tables even for newer Intel based laptops. But Venki should
> know better than myself. Just a heads up.

We (Intel Linux team) are acutely aware of Intel's actual P-state 
latencies and how BIOS writers are more often wrong than right.

note that this cap applies only to the systems that support
MSR transitions -- which is the newer stuff.

> Capping off the sampling rate generally (this is the value calculated from the latency
> which causes the performance regression) in ondemand governor to e.g. 100ms sampling rate
> is probably also a good idea. I'll suggest that on the cpufreq list...

yeah, that does sound like a good idea.
all it needs is a real example of the failure to justify the patch.

cheers,
Len Brown, Intel Open Source Technology Center
