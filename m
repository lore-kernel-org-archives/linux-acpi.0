From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Fri, 11 May 2007 13:28:46 -0700
Message-ID: <20070511132846.5ebf4437.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<200705102212.08046.rjw@sisk.pl>
	<20070511094750.e91ea55b.akpm@linux-foundation.org>
	<200705112210.25397.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:57165 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757232AbXEKU3R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2007 16:29:17 -0400
In-Reply-To: <200705112210.25397.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Fri, 11 May 2007 22:10:24 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > Index: linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > > ===================================================================
> > > --- linux-2.6.21.orig/drivers/acpi/hardware/hwsleep.c
> > > +++ linux-2.6.21/drivers/acpi/hardware/hwsleep.c
> > > @@ -200,10 +200,10 @@ acpi_status acpi_enter_sleep_state_prep(
> > >  		return_ACPI_STATUS(status);
> > >  	}
> > >  
> > > -	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> > > +	/*status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
> > >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > >  		return_ACPI_STATUS(status);
> > > -	}
> > > +	}*/
> > >  
> > >  	/* Setup the argument to _SST */
> > >  
> > 
> > I tested this against Thomas's original patch (below).  Still hangs, in the
> > same way.
> 
> Well, I'm out of ideas. :-(
> 
> Could you please send me the Vaio's DSDT?

Maybe I should send you the Vaio ;)

I have this 1999-era pre-ACPI, pre-everything-else Dual-PIII-based
Supermicro machine and it just *always* works.  Sigh.


hm, Fedora don't seem to want to give me an RPM which contains acpidump and
all the yum servers are featuring scrogged checksums.  I could build it, I
guess, but there's a principle involved ;)

http://userweb.kernel.org/~akpm/dsdt is /proc/acpi/dsdt.  Is that OK?
