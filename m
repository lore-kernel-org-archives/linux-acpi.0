From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: ACPI lockdep warning on boot, 2.6.25-rc5
Date: Fri, 18 Apr 2008 12:24:20 +0200
Message-ID: <1208514260.7115.73.camel@twins>
References: <E1JZOGd-00057d-BU@pomaz-ex.szeredi.hu>
	 <20080315131611.GA4828@ucw.cz>
	 <20080319200931.GA1525@linux-os.sc.intel.com>
	 <200803192151.59720.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757145AbYDRKZA@vger.kernel.org>
In-Reply-To: <200803192151.59720.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2008-03-19 at 21:51 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 19 of March 2008, Venki Pallipadi wrote:
> > On Sat, Mar 15, 2008 at 02:16:11PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > @@ -421,7 +423,9 @@
> > > >  		else
> > > >  			acpi_safe_halt();
> > > >  
> > > > -		local_irq_enable();
> > > > +		if (irqs_disabled())
> > > > +			local_irq_enable();
> > > > +
> > > >  		return;
> > > >  	}
> > > >  
> > > > @@ -530,7 +534,9 @@
> > > >  		 *       skew otherwise.
> > > >  		 */
> > > >  		sleep_ticks = 0xFFFFFFFF;
> > > > -		local_irq_enable();
> > > > +		if (irqs_disabled())
> > > > +			local_irq_enable();
> > > > +
> > > >  		break;
> > > >  
> > > >  	case ACPI_STATE_C2:
> > > 
> > > That's pretty ugly. Could the code be modified to have interrupt
> > > consistent at this point?
> > > 
> > 
> > Agreed that this is not very clean. The problem is that we cannot be sure
> > about the interrupt state at this point as the low level idle handlers at
> > this point can come from variety of different places like safe_halt, arch
> > dependent pm_idle code (which is different for (32 and 64 bit at this point)
> > and also pm_idle can be somewhere outside the kernel in some module as it is
> > a function pointer.
> 
> Well, I'd add a comment that this is to make lockdep happy.  Otherwise it looks
> bizarre.

I'd suggest to clean up the source of this mess instead; this is quite
horrible.
