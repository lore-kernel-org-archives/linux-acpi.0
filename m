From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 09:04:02 +0100
Message-ID: <20060111080402.GB599@isilmar.linta.de>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com> <20060110231711.GB30356@isilmar.linta.de> <1136944855.5750.61.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1136944855.5750.61.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 10:00:54AM +0800, Shaohua Li wrote:
> > As the behaviour is so totally different whether CONFIG_PREEMPTION is set or
> > not, I'd suggest the following (untested): add a "schedule()" right after
> > "local_irq_enable()". This will force the same behaviour as
> > CONFIG_PREEMPTION does currently also for the !CONFIG_PREEMTPION case.
> I only do bm check with irq disabled. promotion/demotion calculation is
> done with irq enabled. As I said, idle currently can't be preempted at
> any places.

*panic* -- you're disabling IRQs, checking for bm activity (1), then re-enabling
IRQs (2), then doing some calculations (3), then disabling IRQs (4)again? This calls
for "false negatives", i.e. bus mastering activity being initiated between
(2) and (4), causing faulty transitions afterwards....

> > > It's still not very good. Comments/suggestions are highly appreciated.
> > Take a look at my four patches, please, and all the tricks and tweaks they
> > do ;-)
> Sure, I did look at your patches. They did have many good staffs. As I
> said, Len hopes smooth move, so adding a new module might be better. 

Sure, for the policy changes yes. However, for the staticistics patch (which
was 3/4) the core is the place to go, IMHO...

> > Also, the actual checking for bm_activity should be common code, e.g.
> It's policy specific. Each policy could have its own method to calculate
> bm_activity.

What to do once bm_activity is or was detected, yes. How to determine
whether there is current bus mastering activity, no -- that's core stuff,
not policy stuff.

Thanks,
	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
