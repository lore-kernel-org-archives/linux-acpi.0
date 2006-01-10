From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC 1/2] Modular acpi_idle policy
Date: Wed, 11 Jan 2006 00:00:44 +0100
Message-ID: <20060110230044.GA30356@isilmar.linta.de>
References: <1136866373.5750.28.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1136866373.5750.28.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Jan 10, 2006 at 12:12:53PM +0800, Shaohua Li wrote:
> Modular C-state policy. And convert current algorithm to the framework.
> This is the updated patch I sent out to the list several months ago.
> Next patch will use the framework.

Have you reviewed my patches I sent to this list on 2005-12-31 yet? As they
touch a lot of this code _and_ (partly) make sense for _all_ C-state
policies, please consider merging them first before these patches.

> -	/*
> -	 * Check BM Activity
> -	 * -----------------
> -	 * Check for bus mastering activity (if required), record, and check
> -	 * for demotion.
> -	 */

Whatever the C-State policy is, we need to track the BM activity.

> +	cx = current_policy->pre_cx(pr);
> +	if (cx != pr->power.state)
> +		acpi_processor_power_activate(pr, cx);


> @@ -320,18 +256,19 @@ static void acpi_processor_idle(void)
>  		 *      go to an ISR rather than here.  Need to instrument
>  		 *      base interrupt handler.
>  		 */
> -		sleep_ticks = 0xFFFFFFFF;
> +		t2 = read_acpi_pmtimer();
> +		sleep_ticks = ticks_elapsed(t1, t2);

This result may be _very_ wrong, at least with preemption enabled...

> +	/* FIXME: we have trouble in MP case here */
Please solve it first before merging, there are MP systems using ACPI
C-States AFAICS...

> +static struct acpi_processor_cx* dfl_cstate_pre_cx(struct acpi_processor *pr)

This one misses important policy updates (see my mails to this mailing list
2005-12-31).

> +	/* FIXME: we currently only support one extra policy */

And please provide for multiple extra policies, as unless Thomas, you and I
can agree on two policies, there'll be three ;-)


Thanks,
	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
