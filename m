From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC 1/2] Modular acpi_idle policy
Date: Wed, 11 Jan 2006 08:57:46 +0100
Message-ID: <20060111075746.GA599@isilmar.linta.de>
References: <1136866373.5750.28.camel@sli10-desk.sh.intel.com> <20060110230044.GA30356@isilmar.linta.de> <1136943726.5750.52.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1136943726.5750.52.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 09:42:01AM +0800, Shaohua Li wrote:
> > Have you reviewed my patches I sent to this list on 2005-12-31 yet? As they
> > touch a lot of this code _and_ (partly) make sense for _all_ C-state
> > policies, please consider merging them first before these patches.
> Len hopes policy changes can be smoothly made. The approach is we keep
> current policy as default and add new policies as module. If you change
> the policy a lot, you'd better make a module.
OK, that's fine with me :-)

> > > -	/*
> > > -	 * Check BM Activity
> > > -	 * -----------------
> > > -	 * Check for bus mastering activity (if required), record, and check
> > > -	 * for demotion.
> > > -	 */
> > 
> > Whatever the C-State policy is, we need to track the BM activity.
> It's policy specific, right? No reason generic code do the BM activity
> track.

Not exactly. _Every_ C-State policy must check whether there is BM activity
and not enter C3-type sleep. How it keeps track of "past" BM activity, is up
to the policy, that's correct. But I'd favour it if every policy just would
need to call one function (acpi_processor_check_bm_activity) which returns
one on current bus master activity and zero if there is no such activity.
This probing of the hardware is _not_ policy-specific.

> > This result may be _very_ wrong, at least with preemption enabled...
> IIRC, with Ingo's patch, idle thread can't be preempted at any places in
> current kernel. Yes, the result may be very wrong, but it's better than
> 0xFFFFFFFF.

Well, last time I looked that was the case. Might have changed in between,
though... one more reason to add a schedule() call at the place I suggested
;-)

Thanks,
	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
