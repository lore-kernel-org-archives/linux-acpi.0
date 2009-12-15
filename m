From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] cpufreq: Processor Clocking Control interface driver
Date: Tue, 15 Dec 2009 19:33:31 +0100
Message-ID: <20091215183331.GA5560@comet.dominikbrodowski.net>
References: <20091128034424.6796.75673.sendpatchset@localhost.localdomain>
 <20091211231233.GA4291@isilmar.linta.de>
 <66D9D2F0CDB5C9428E6166B01EC85EE161DEEE3CB7@GVW0676EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933333AbZLOSds@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <66D9D2F0CDB5C9428E6166B01EC85EE161DEEE3CB7@GVW0676EXC.americas.hpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chumbalkar, Nagananda" <Nagananda.Chumbalkar@hp.com>
Cc: "davej@redhat.com" <davej@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mjg@redhat.com" <mjg@redhat.com>, "trenn@suse.de" <trenn@suse.de>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hey,

On Tue, Dec 15, 2009 at 06:08:08PM +0000, Chumbalkar, Nagananda wrote:
> Hi, I have addressed your concerns below: 

Thanks!

> >If this is _really_ necessary... Doesn't the driver version 
> >relate to some
> >Linux kernel version anyway?
> >
> 
> If distros backport this driver to different kernel versions, it will be
> easy to keep track of which driver version is in the distro.

Well, IMVHO it's ugly, but if Linux ACPI and cpufreq folks are fine with
it, so be it.

> Yes, it works fine. Both "ondemand" and "conservative" sanitize the
> latency value, and set it to a default value which is good.

OK. Any way to fix the spec for the next revision, though?

> >> +	if (target_freq <= 
> >(ioread32(&pcch_hdr->minimum_frequency) * 1000)) {
> >> +		target_freq = 
> >ioread32(&pcch_hdr->minimum_frequency) * 1000;
> >> +		dprintk("target: target_freq for cpu %d was 
> >below limit, "
> >> +			"converted it to %d\n", cpu, target_freq);
> >> +	}
> >
> >why not do this in the _verify() step? Does pcch_hdr->minimum_frequency
> >even change "on the fly"?
> 
> pcch_hdr->minimum_frequency does not change "on the fly". Also, there is no
> need for those IO accesses:

target_freq cannot be below policy->min or above policy->max. If it were,
the whole cpufreq subsystem is broken. So there's no need for these checks,
AFAICS.

Best,
	Dominik
