From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: the errors about two EC patches
Date: Wed, 10 Sep 2008 16:26:35 +0200
Message-ID: <200809101626.36769.rjw@sisk.pl>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com> <48C7BF94.6010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57620 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbYIJOWN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 10:22:13 -0400
In-Reply-To: <48C7BF94.6010204@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com, Andrew Morton <akpm@linux-foundation.org>

Hi Alex,

On Wednesday, 10 of September 2008, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> >
> >     >ACPI: EC: do transaction from interrupt context
> >
> >    In the above patch there exist the following problems:
> >    a. In the following code the GPE_STORM bit will always be set regardless 
> > of whether there exists the EC GPE storm.
> >     >if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> >     >            /* check if we received SCI during transaction */
> >     >           ec_check_sci(ec, acpi_ec_read_status(ec));
> >     >           /* it is safe to enable GPE outside of transaction */
> >     >            acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> >     >    } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> >     >               atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD)
> >     >           pr_debug(PREFIX "GPE storm detected\n");
> >     >           set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
> >   
> This problem is fixed two days ago, it is not completely fair to mention 
> it here.
> >     b. When EC GPE storm is detected, the EC GPE will be disabled and 
> > EC will work in polling mode while doing EC transaction. In such case 
> > maybe EC transaction is not finished. But when timeout happens, it 
> > will still be regarded as finishing the EC transaction.
> >   
> Ok. Fixed, now -ETIME is returned in this case.
> >        This error is related with the following source code:
> >            > {
> >            >    delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY); 
> >  //Maybe the preemptible schedule happens here.If the current jiffies
> >  is greater than the predefined jiffies after the process is returned 
> > from preempt_schedule, OS will have no opportunity to do the EC transaction.
> >  It means that EC transaction is not finished. But it is still regarded as 
> > finishing EC transaction. It is incorrect.
> >            >     while (time_before(jiffies, delay)) {
> >             >            gpe_transaction(ec, acpi_ec_read_status(ec));
> >             >            msleep(1);
> > //as msleep is realized by using the function of schedule_timeout, 
> > maybe the current jiffies is already greater than the predefined jiffies 
> > before finishing EC transaction. In such case the EC transaction is
> > not finished. But it is also regarded as finishing. It is incorrect.
> >             >            if (ec_transaction_done(ec))
> >             >                    goto end;
> >             >    }
> >   
> ec_transaction_done() returns true only if there is finished transaction 
> stored in
> acpi_ec. It does not matter if it is late to check for this result from 
> timeout point of view.
> the same ideology was put into driver before this patch:
> "ACPI: Avoid bogus EC timeout when EC is in Polling mode"
> >      c. There is no detailed change log although a lot is changed.(
> > Including the EC work mode, the detect mechanism of EC GPE storm). 
> > It is not easy to understand.     
> >
> >      At the same time this commit can't handle the EC notification
> > event in the following case:
> >          EC GPE Interrupt storm is detected and EC GPE will be disabled
> > when doing EC transaction. If EC notification event happens while doing
> > EC transaction(EC GPE is disabled), the SCI_EVT bit of EC status
> > register is cleared before OS issuing query command. In such case the EC
> > notification event will be lost.
> >   
> As I said already, there is no way EC will clear SCI bit before driver 
> issues
> the Query command to it (thus reading the event).
> Even more, this same behavior was in the driver for ages and it did
> not broke once.
> >   Based on the above analysis ,IMO the two patches are not appropriate.
> >
> >   
> This is the best analysis I've seen so far :) Thanks, it is really 
> entertaining.
> Please use latest version next time, it is attached for your convenience.

Hm, the attached patch conflicts with
acpi-ec-dont-degrade-to-poll-mode-at-storm-automatically.patch currently in
-mm.  Should we Andrew to drop that patch?

Rafael
