From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Sat, 27 Sep 2008 11:39:20 +0800
Message-ID: <1222486760.4023.266.camel@yakui_zhao.sh.intel.com>
References: <20080925170030.15311.27823.stgit@thinkpad>
	 <200809261615.10488.rjw@sisk.pl>
	 <1222441812.4023.213.camel@yakui_zhao.sh.intel.com>
	 <200809261739.38396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36674 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYI0De3 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 23:34:29 -0400
In-Reply-To: <200809261739.38396.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Fri, 2008-09-26 at 17:39 +0200, Rafael J. Wysocki wrote:

> > > OK, how much time is it going to take, approximately?
> > Maybe I can own the laptop again after two days. And I will try to do
> > the test as early as possible and attach the test result. 
I test the patch on my box. And it won't break the box. I am sorry for
that I give the incorrect judgement before doing the test.
     On my box sometimes the SCI_EVT bit of EC status is cleared in
course of issuing Query command. But after the query command is
finished, the SCI_EVT is always set. (If the SCI_EVT bit is set in the
course of issuing query command, my laptop will be broken.).
> > > > At the same time there are two generic issues in this patch:
> > > >    a. spin_lock is overkill. When 2000 EC I/O read/write are executed, the
> > > >    CPU interrupt will be disabled for about 1.5ms. This will affect the normal
> > > >    laptops.
> > > 
> > > OTOH, I think we need _some_ locking in there in order to prevent races from
> > > happening.
> > Agree with what you said. The locking mechanism is needed to prevent the
> > races from happening.  
> > But in current source code the EC transaction is done in control thread.
> > In such case there is no need to use the spin_lock.(Mutex lock is
> > already used).
> 
> IOW, it's done synchronously.
> 
> > If we add the spin_lock for the broken BIOS/laptops , I agree with this
> > method and regard it very reasonable. But if this mechanism also affects
> > the normal laptops,  IMO this is not unreasonable.
"Normal" laptops means that : EC follows the ACPI spec, there is no EC
GPE storm, EC GPE interrupt can be triggered normally for every EC
transaction, the SCI_EVT bit won't be cleared before issuing query
command.   Of course it can work in the current source code. 
     Of course such laptops can still work well except that CPU
interrupt will be disabled for some extra time after Alexey's patch is
applied .(The some extra time depends on how many EC Inb/out operations
are executed).

In my email the purpose that I point out 2000 EC I/O read/write
operation doesn't indicate that 2000 EC I/O read/write will be executed
per second. What I want to say is that EC I/O read/write is slow
operation. If quite a lot of EC I/O read/write are accessed for some
reasons in some time, the CPU interrupt will be disabled for a long
time.  In such case the normal laptop will be affected by this. (Of
course maybe the affect will be very tiny).
   In fact in kernel source code if the race can be resolved by other
synchronization protection mechanism, the spin_lock had better be
avoided. 
   


> That really depends on how the "normal" laptops are affected and to what
> extent.  Also, I'm not sure what the meaning of "normal" is in that case.
> Namely, if you define "normal" as "working with our current code well" and
> everything else as "broken", then the entire discussion doesn't make sense
> from that point on.
> 
> The question is whether there are machines that _should_ work correctly and
> they don't because _we_ try to handle them in a wrong way.  If the answer is
> "yes", then our current code is inadequate and we have to change it, this way
> or another.  I personally think that the Alex's patch goes in the right
> direction.
> 
> > > >    b. the local variable that resides in process stack space is used in
> > > >    interrupt-context.
> >        The pointer of local variable in the function of
> > acpi_ec_transaction_unlocked is assigned to ec->t(this is regarded as
> > the global variable). And ec->t is accessed in interrupt-context.
> > Although it won't break anything, IMO this looks so ugly.
> 
> Well, I can agree with that.  We can embed the 'struct transaction_data'
> (or whatever it's going to be called) in 'struct acpi_ec' and copy the values
> into it instead of using the pointer (ISTR, this is how it was done in the
> first iterations of the Alex's patch and the pointer was my idea).
> 
> Thanks,
> Rafael

