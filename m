From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Fri, 11 May 2007 23:09:15 +0200
Message-ID: <200705112309.15996.rjw@sisk.pl>
References: <20070430102837.748238000@linutronix.de> <20070511132846.5ebf4437.akpm@linux-foundation.org> <200705112302.47726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60767 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761033AbXEKVEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2007 17:04:16 -0400
In-Reply-To: <200705112302.47726.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Friday, 11 May 2007 23:02, Rafael J. Wysocki wrote:
> On Friday, 11 May 2007 22:28, Andrew Morton wrote:
> > On Fri, 11 May 2007 22:10:24 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > > > Index: linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > > > > ===================================================================
> > > > > --- linux-2.6.21.orig/drivers/acpi/hardware/hwsleep.c
> > > > > +++ linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > > > > @@ -200,10 +200,10 @@ acpi_status acpi_enter_sleep_state_prep(
> > > > >  		return_ACPI_STATUS(status);
> > > > >  	}
> > > > >  
> > > > > -	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> > > > > +	/*status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> > > > >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > > > >  		return_ACPI_STATUS(status);
> > > > > -	}
> > > > > +	}*/
> > > > >  
> > > > >  	/* Setup the argument to _SST */
> > > > >  
> > > > 
> > > > I tested this against Thomas's original patch (below).  Still hangs, in the
> > > > same way.
> > > 
> > > Well, I'm out of ideas. :-(
> > > 
> > > Could you please send me the Vaio's DSDT?
> > 
> > Maybe I should send you the Vaio ;)
> 
> Well, machines with so much potential of exposing problems are priceless. ;-)
> 
> > I have this 1999-era pre-ACPI, pre-everything-else Dual-PIII-based
> > Supermicro machine and it just *always* works.  Sigh.
> > 
> > 
> > hm, Fedora don't seem to want to give me an RPM which contains acpidump and
> > all the yum servers are featuring scrogged checksums.  I could build it, I
> > guess, but there's a principle involved ;)
> > 
> > http://userweb.kernel.org/~akpm/dsdt is /proc/acpi/dsdt.  Is that OK?
> 
> Yes, thanks.

Hmm, have you tried to do 'echo shutdown > /sys/power/disk' before the
hibernation?
