From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 09 May 2007 10:18:17 +0200
Message-ID: <1178698697.3042.461.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070430102852.042964000@linutronix.de>
	 <20070505003421.00ec45ba.akpm@linux-foundation.org>
	 <20070505115127.GA17815@elte.hu>
	 <1178463784.31213.46.camel@localhost.localdomain>
	 <20070508225920.258d8d34.akpm@linux-foundation.org>
	 <20070509001032.dbb982ca.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:33163 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753107AbXEIIP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 04:15:26 -0400
In-Reply-To: <20070509001032.dbb982ca.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wed, 2007-05-09 at 00:10 -0700, Andrew Morton wrote:
> > > find an updated patch below. It fixes the problem on Ingo's
> > > VAIO-of-fun-emulator and I got confirmation from several other affected
> > > users, that the patch series is still solving their problems.
> > > 
> > 
> > The machine is still hanging with this patch applied.

What did change since yesterday ?

> yup, that now survives suspend-to-disk and resume, thanks.

> > suspend-to-disk gets up to "swsusp: critical section: done (NNN pages copied)"
> > 
> > No netconsole, no printk-timestamping.
> > 
> > ho hum, I guess I get to debug this.
> 
> It got ugly.
> 
> We finish swsusp_save() and a few other functions then we go
> 
> 	hibernate
> 	->platform_finish
> 	  ->acpi_hibernation_finish
> 	    ->acpi_leave_sleep_state
> 	      ->acpi_evaluate_object
> 
> and there it dies, in this call:
> 
> 	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
> 
> I wonder how your patch caused that?

hmm, that's more than strange

> <debugs further>
> 
> OK, it gets to the last statement in acpi_evaluate_object():
> 
> 	return_ACPI_STATUS(status);
> 
> but doesn't hit the printk on return to the caller,
> acpi_leave_sleep_state().
> 
> A working theory would be that something we did trashed the stack in
> acpi_evaluate_object().
> 
> <switches from 8k stacks to 4k. No change>
> 
> foo.  I'm not sure what to do now.

Hmm. Do we enable interrupts somewhere where we should not ?
/me goes looking for such places.

	tglx


	


