From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Fri, 11 May 2007 22:10:24 +0200
Message-ID: <200705112210.25397.rjw@sisk.pl>
References: <20070430102837.748238000@linutronix.de> <200705102212.08046.rjw@sisk.pl> <20070511094750.e91ea55b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966775AbXEKUFh@vger.kernel.org>
In-Reply-To: <20070511094750.e91ea55b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, 11 May 2007 18:47, Andrew Morton wrote:
> On Thu, 10 May 2007 22:12:07 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Thursday, 10 May 2007 11:27, Thomas Gleixner wrote:
> > > On Thu, 2007-05-10 at 02:18 -0700, Andrew Morton wrote:
> > > > > > > If that patch makes the problem go away, then we should have a quite
> > > > > > > good hint what we need to look at.
> > > > > > 
> > > > > > No joy, sorry.  It still hangs at the last statement in acpi_evaluate_object().
> > > > > 
> > > > > Can you add "nolapic_timer" to the command line please ?
> > > > > 
> > > > 
> > > > That works.
> > > 
> > > Ok, that boils it down to the change, which affects the lapic timer
> > > resume. It does nothing else, than fiddling in some APIC registers, but
> > > I don't see how this affects the ACPI stuff. This smells extremly fishy.
> > 
> > Hmm, I wonder if it might be related to the execution of the _GTS ACPI control
> > method in acpi_enter_sleep_state_prep() in violation of the spec.
> > 
> > Andrew, could you please try to apply the following change on top of the
> > previous ones and see if the machine still hangs in the same place without
> > "nolapic_timer"?
> > 
> > ---
> >  drivers/acpi/hardware/hwsleep.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > ===================================================================
> > --- linux-2.6.21.orig/drivers/acpi/hardware/hwsleep.c
> > +++ linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > @@ -200,10 +200,10 @@ acpi_status acpi_enter_sleep_state_prep(
> >  		return_ACPI_STATUS(status);
> >  	}
> >  
> > -	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> > +	/*status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> >  		return_ACPI_STATUS(status);
> > -	}
> > +	}*/
> >  
> >  	/* Setup the argument to _SST */
> >  
> 
> I tested this against Thomas's original patch (below).  Still hangs, in the
> same way.

Well, I'm out of ideas. :-(

Could you please send me the Vaio's DSDT?
