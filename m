From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: GPE handling
Date: Mon, 12 Nov 2007 08:42:26 +0800
Message-ID: <1194828146.32662.3.camel@sli10-conroe.sh.intel.com>
References: <FC1D1B23302A22499C60C967336B2AE001FF2CA9@pdsmsx411.ccr.corp.intel.com>
	 <47342C26.2040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41191 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758070AbXKLAs0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Nov 2007 19:48:26 -0500
In-Reply-To: <47342C26.2040505@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, 2007-11-09 at 12:45 +0300, Alexey Starikovskiy wrote:
> Shaohua,
> There is cond_resched() before the exit from deferred execution routine,
> specifically to let notify thread a chance to execute.
> Thus by the time deferred execution is exited, notify should be already 
> done,
> and we could safely enable _Lxx again.
> Do you think it is not sufficient?
Certainly not. A resched() can help to give a chance for other threads
to execute, but it's very unreliable. If it works, just because of luck.
We should add a wait there to guarantee.

Thanks,
Shaohua

> 
> Li, Shaohua wrote:
> > Bob & Ming,
> > I'm working on adding wakeup GPE support at system runtime, this
> > capability can help us
> > Identify which device invokes a wakeup event at runtime, this is
> > required for runtime device
> > Power management.
> >
> > Below is the ASL code. For example, _L0c, USB3 will send a wakeup GPE
> > and invoke
> > a notify. In the notify handler, OS will clear USB3's PCI PME status to
> > avoid wakeup
> > event flood. But in current code, acpi_ev_asynch_execute_gpe_method will
> > start an asynchronous
> > execution of notify and return soon. Just before the return,
> > acpi_ev_asynch_execute_gpe_method
> > will reenable GPE 0C. That means GPE is enabled before OS execute
> > notification handler and USB3's
> > PCI PME status is cleared, and cause GPE flood. Ideally, I think we
> > should delay GPE enable
> > of _L0c till notification handler is finished or simply the method _L0c
> > is really finished.
> > What do you think?
> >
> > Thanks,
> > Shaohua
> >
> >
> >         Method (_L0C, 0, NotSerialized)
> >         {
> >             Notify (\_SB.PCI0.USB3, 0x02)
> >         }
> >
> >         Method (_L0D, 0, NotSerialized)
> >         {
> >             Notify (\_SB.PCI0.USB7, 0x02)
> >         }
> >
> >         Method (_L0E, 0, NotSerialized)
> >         {
> >             Notify (\_SB.PCI0.USB4, 0x02)
> >         }
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
