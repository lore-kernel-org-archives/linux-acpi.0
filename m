From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: ACPI lockdep warning on boot, 2.6.25-rc5
Date: Wed, 19 Mar 2008 13:09:31 -0700
Message-ID: <20080319200931.GA1525@linux-os.sc.intel.com>
References: <E1JZOGd-00057d-BU@pomaz-ex.szeredi.hu> <200803122301.17356.rjw@sisk.pl> <200803131614.33386.lenb@kernel.org> <20080314001819.GA32584@linux-os.sc.intel.com> <20080315131611.GA4828@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1833 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757339AbYCSUQX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 16:16:23 -0400
Content-Disposition: inline
In-Reply-To: <20080315131611.GA4828@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Miklos Szeredi <miklos@szeredi.hu>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 15, 2008 at 02:16:11PM +0100, Pavel Machek wrote:
> Hi!
> 
> > @@ -421,7 +423,9 @@
> >  		else
> >  			acpi_safe_halt();
> >  
> > -		local_irq_enable();
> > +		if (irqs_disabled())
> > +			local_irq_enable();
> > +
> >  		return;
> >  	}
> >  
> > @@ -530,7 +534,9 @@
> >  		 *       skew otherwise.
> >  		 */
> >  		sleep_ticks = 0xFFFFFFFF;
> > -		local_irq_enable();
> > +		if (irqs_disabled())
> > +			local_irq_enable();
> > +
> >  		break;
> >  
> >  	case ACPI_STATE_C2:
> 
> That's pretty ugly. Could the code be modified to have interrupt
> consistent at this point?
> 

Agreed that this is not very clean. The problem is that we cannot be sure
about the interrupt state at this point as the low level idle handlers at
this point can come from variety of different places like safe_halt, arch
dependent pm_idle code (which is different for (32 and 64 bit at this point)
and also pm_idle can be somewhere outside the kernel in some module as it is
a function pointer.

Thanks,
Venki

 
