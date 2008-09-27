From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Sat, 27 Sep 2008 13:59:30 +0800
Message-ID: <1222495170.4023.283.camel@yakui_zhao.sh.intel.com>
References: <20080925170030.15311.27823.stgit@thinkpad>
	 <200809261615.10488.rjw@sisk.pl>
	 <1222441812.4023.213.camel@yakui_zhao.sh.intel.com>
	 <200809261739.38396.rjw@sisk.pl>
	 <1222486760.4023.266.camel@yakui_zhao.sh.intel.com>
	 <48DDC6B7.8020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51393 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbYI0Fyj (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Sat, 27 Sep 2008 01:54:39 -0400
In-Reply-To: <48DDC6B7.8020208@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Sat, 2008-09-27 at 09:37 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> >      Of course such laptops can still work well except that CPU
> > interrupt will be disabled for some extra time after Alexey's patch is
> > applied .(The some extra time depends on how many EC Inb/out operations
> > are executed).
> >
> >   
> spinlock is released after each I/O, so by your own calculation
> it is disabled for 1.5 usec.
Yes. The CPU interrupt is disabled for about 0.7usec while doing every
EC I/O access.(Inb/outb).
This affect is very tiny. But when the time is accumulated for many EC
I/O access, it seems that the CPU will be disabled for longer time.

> You can then multiply this number by lifetime of the universe,
> it does not mean anything.
> 
> Regards,
> Alex.
> > In my email the purpose that I point out 2000 EC I/O read/write
> > operation doesn't indicate that 2000 EC I/O read/write will be executed
> > per second. What I want to say is that EC I/O read/write is slow
> > operation. If quite a lot of EC I/O read/write are accessed for some
> > reasons in some time, the CPU interrupt will be disabled for a long
> > time.  In such case the normal laptop will be affected by this. (Of
> > course maybe the affect will be very tiny).
> >    In fact in kernel source code if the race can be resolved by other
> > synchronization protection mechanism, the spin_lock had better be
> > avoided. 
> >   
> Please explain, I'd like to make poster of it :)
As in the current patch the gpe_transaction is accessed in the two
different routines(Control thread, Interrupt-context), spin_lock is
necessary to prevent the race. 
I agree with what you have done.  

> 

