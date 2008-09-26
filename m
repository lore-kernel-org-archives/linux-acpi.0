From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 23:10:12 +0800
Message-ID: <1222441812.4023.213.camel@yakui_zhao.sh.intel.com>
References: <20080925170030.15311.27823.stgit@thinkpad>
	 <200809261433.53674.rjw@sisk.pl>
	 <9D7649D18729DE4BB2BD7B494F7FEDC201DE13D8@pdsmsx415.ccr.corp.intel.com>
	 <200809261615.10488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4555 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbYIZPFY (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 11:05:24 -0400
In-Reply-To: <200809261615.10488.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Fri, 2008-09-26 at 16:15 +0200, Rafael J. Wysocki wrote:
> On Friday, 26 of September 2008, Zhao, Yakui wrote:
> > Alan gives a suggestion that after processing the EC notification event, EC driver
> > should continue to issue the query command and process the EC notification
> > event until the query command returns zero. 
> > But this suggestion will break my laptop. On my laptop when issuing the query
> > command, a non-zero query event is  returned but it can't be processed.(There
> > is no corresponding ACPI _Qxx object). At the same time the SCI_EVT bit won't
> > be cleared. In such case OS can't exit the function of acpi_ec_query_handler,
> > which causes that the acpid kernel thread can't work well.
> 
> Well, perhaps we should exit acpi_ec_query_handler() if SCI_EVT is clear _or_
> the processing of an event fails due to the lack of a _Qxx object?  Alex?
> 
> > In fact according to my analysis IMO Alexey's patch will break my laptop.
> 
> That obviously would be a regression.
> 
> > But now the laptop is not in my hand and I can't do the test. After I own the
> > laptop again, I will do the test and attach the corresponding info.
> 
> OK, how much time is it going to take, approximately?
Maybe I can own the laptop again after two days. And I will try to do
the test as early as possible and attach the test result. 
> 
> > At the same time there are two generic issues in this patch:
> >    a. spin_lock is overkill. When 2000 EC I/O read/write are executed, the
> >    CPU interrupt will be disabled for about 1.5ms. This will affect the normal
> >    laptops.
> 
> OTOH, I think we need _some_ locking in there in order to prevent races from
> happening.
Agree with what you said. The locking mechanism is needed to prevent the
races from happening.  
But in current source code the EC transaction is done in control thread.
In such case there is no need to use the spin_lock.(Mutex lock is
already used).
If we add the spin_lock for the broken BIOS/laptops , I agree with this
method and regard it very reasonable. But if this mechanism also affects
the normal laptops,  IMO this is not unreasonable.
> >    b. the local variable that resides in process stack space is used in
> >    interrupt-context.
       The pointer of local variable in the function of
acpi_ec_transaction_unlocked is assigned to ec->t(this is regarded as
the global variable). And ec->t is accessed in interrupt-context.
Although it won't break anything, IMO this looks so ugly.
> Which one?
> 
> Rafael

