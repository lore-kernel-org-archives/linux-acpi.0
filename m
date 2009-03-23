From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 21:27:40 +0100
Message-ID: <200903232127.40683.rjw@sisk.pl>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl> <49C7DDDC.2050103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32998 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbZCWU1Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2009 16:27:25 -0400
In-Reply-To: <49C7DDDC.2050103@goop.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

On Monday 23 March 2009, Jeremy Fitzhardinge wrote:
> Rafael J. Wysocki wrote:
> > On Monday 23 March 2009, Tian, Kevin wrote:
> >   
> >> And then Xen jumps in to finish remaining steps. From this angle,
> >> Xen is not a completely new platform and, well, S3 is more like a
> >> 'S1' type from dom0's p.o.v with a different trigger method. Then is
> >> it overkilled to introduce a new set of ops with 99% content 
> >> duplicated?
> >>     
> >
> > IMO, no, it isn't.
> 
> Hm.  Well, lets take acpi_suspend_enter() as a specific example.  The 
> Xen change here is:
> 
> @@ -240,11 +240,20 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>  		barrier();
>  		status = acpi_enter_sleep_state(acpi_state);
>  		break;
>  
>  	case ACPI_STATE_S3:
> -		do_suspend_lowlevel();
> +		if (!xen_pv_domain())
> +			do_suspend_lowlevel();
> +		else {
> +			/*
> +			 * Xen will save and restore CPU context, so
> +			 * we can skip that and just go straight to
> +			 * the suspend.
> +			 */
> +			acpi_enter_sleep_state(acpi_state);
> +		}
>  		break;
>  	}

Hmm, in that case it may be more appropriate to modify
do_suspend_lowlevel().  Have you considered doing that?

>  	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
>  	if (set_sci_en_on_resume)
> 
> 
> Which is, functionally, adding one if() and a new line of code, in the 
> middle of a ~70 line function.
> 
> Are you suggesting that it would be best to copy this whole function so 
> that I can put one line of Xen-specific code in the middle, rather than 
> just making this change?

No.

> Some other functions, the Xen vs. non-Xen changes are larger; 
> acpi_sleep_prepare() could reasonably have a Xen-specific variant 
> because a big chunk of it is setting up the wakeup vector (which is 
> unnecessary under Xen), and the rest can be easily pulled into common 
> code.  But unfortunately acpi_sleep_prepare isn't itself an operation, 
> and is only called at the bottom of 2-3 level deep callchains.
> 
> I think that rather than having a separate xen-acpi 
> platform_suspend_ops, it would make more sense to have a acpi_ops within 
> acpi/sleep.c and handle the differences that way.  I'll see how it turns 
> out.

Yes, that may be better.

Thanks,
Rafael
