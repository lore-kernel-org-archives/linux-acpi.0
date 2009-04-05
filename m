From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 86/98] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Mon, 6 Apr 2009 00:17:24 +0200
Message-ID: <200904060017.25093.trenn@suse.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200904021450.26935.trenn@suse.de> <alpine.LFD.2.00.0904031226350.4655@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.qsc.de ([213.148.130.14]:53060 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZDEWjm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Apr 2009 18:39:42 -0400
In-Reply-To: <alpine.LFD.2.00.0904031226350.4655@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

On Friday 03 April 2009 06:35:20 pm Len Brown wrote:
> > Whatabout:
> >
> > CC: stable@kernel.org
>
> I've added this to my .stable list, thanks for pointing it out.
> Note that I don't send patches to stable until after they are upstream.
Thanks.
There are generally two kind of patches that should go to stable:
1) The simple NULL pointer fixes (and similar safe ones) which can/
     should go directly to stable, at least if they hit the mainline kernel
2) Bug fixes which potentially could harm others (as you mentioned
     in the other one).
For the latter these should go to stable if they survived a full mainline kernel
round (and eventually together with add-on patches) or at least some RCs.
Looks like every maintainer has his own way (and overhead) to queue and
take care of them?
I wonder how things could get automated and patches could get tagged,
not only with CC: <stable@kernel.org>, but to consider both cases.
Or you always add CC: <stable@kernel.org>, the stable team will ask again
before adding them and you can tell them to still hold them off for a while,
so that they get more testing.

> thanks,
> -Len
>
> > This is a bug fix also existing in older kernels.
> > I remember even much newer HW (Intel and AMD) based have higher values
> > exported through ACPI _PSS tables as latency.
> >
> > I remember values around (50-70us Core 2 Duo?) and 37us on K10.
> > I doubt this patch will cause much pain, but being close to values
> > exported via ACPI tables on similar HW sounds like a good idea.
> >
> > In 2.6.30 (as soon as cpufreq branch is merged) you get that easily from
> > here:
> > cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency
> > 109000
> >
> > I expect my machine's (K8 Dual core) ACPI exported value will be cut down
> > to:
> > 20000
> > now?
>
> Does your AMD box run acpi-cpufreq and use native MSR access to change
> P-states?
Argh, now I see it. It's done in acpi-cpufreq, it looked like generic code in
drivers/acpi/processor_*

But it still looks rather low. I've seen higher values exported
via ACPI tables even for newer Intel based laptops. But Venki should
know better than myself. Just a heads up.

Capping off the sampling rate generally (this is the value calculated from the latency
which causes the performance regression) in ondemand governor to e.g. 100ms sampling rate
is probably also a good idea. I'll suggest that on the cpufreq list...

Thanks,

      Thomas
