From: ykzhao <yakui.zhao@intel.com>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Fri, 06 Nov 2009 13:21:36 +0800
Message-ID: <1257484896.3804.54.camel@localhost.localdomain>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
	 <20091027165345.3237d3df@infradead.org>
	 <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
	 <43e72e890911021909ke760ee1sd68caa92f66d1727@mail.gmail.com>
	 <1257470618.3804.23.camel@localhost.localdomain>
	 <43e72e890911051750r3a42b4fbn222ccc48916eac00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:65473 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbZKFFXF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Nov 2009 00:23:05 -0500
In-Reply-To: <43e72e890911051750r3a42b4fbn222ccc48916eac00@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-11-06 at 09:50 +0800, Luis R. Rodriguez wrote:
> On Thu, Nov 5, 2009 at 5:23 PM, ykzhao <yakui.zhao@intel.com> wrote:
> > On Tue, 2009-11-03 at 11:09 +0800, Luis R. Rodriguez wrote:
> >> On Mon, Nov 2, 2009 at 7:02 PM, Len Brown <lenb@kernel.org> wrote:
> >> >> > I get this when modprobing some module I am working on. I figured it
> >> >> > was the module's fault but the EIP points to something else so I am
> >> >> > not sure. I get the following repeating about 4 times on 2.6.32-rc5:
> >> >>
> >> >>
> >> >> you can get this if your own code leaves interrupts disabled in a
> >> >> kernel thread and then lets the cpu go idle...
> >> >
> >> > Unclear.
> >> >
> >> > acpi_enter_idle_bm() assumes that it is entered with irqs enabled,
> >> > and so it we unconditionally disables IRQs.
> >> >
> >> > Then we unconditionally re-enable them.
> >> >
> >> > The problem seems to be that right after we enable them,
> >> > we find that they are actually disabled, perhaps as
> >> > a side-effect of SMM.
> >> >
> >> > Is your machine a Dell, per chance?
> >>
> >> Nope.
> >>
> >> > Please test the patches in this bug report:
> >> > http://bugzilla.kernel.org/show_bug.cgi?id=14101
> >>
> >> In my case it was as Arjan pointed out and I've fixed it in my driver.
> >> Sorry for not reporting back and thanks for your review.
> > Hi, Luis
> >   It is very great that this issue is fixed in your driver.
> > But it seems that there exist so many similar issues on kerneloops.
> >   >BUG: scheduling while atomic: swapper/0/0x10000100
> >   >Call Trace:
> >  [<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
> >  [<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
> >  [<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
> >
> >   >BUG: scheduling while atomic: swapper/0/0x10010000
> >   >Call Trace:
> >  [<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
> >  [<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
> >  [<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
> >  [<ffffffff8151de43>] ? start_secondary+0xa9/0xab
> >
> > From the above log it seems that the preempt_count is 0x10010000,
> > which means that this happens in softirq.
> 
> What's the preempt_count and how does it get changed?
thanks for your help.
After looking at the commit, I understand how this happens.
Now it seems clear that this issue is caused by that might_sleep is
called in the ISR/softirq. Sometimes it is called imlicitly. For
example: it will be called in mutex_lock.
    When it enters the ISR/softirq, we will add
HARDIRQ_OFFSET/SOFTIRQ_OFFSET to preempt_count(0x10000/0x100).
    And the might_sleep will call the function of 
 __cond_resched, which will add the PREEMPT_ACTIVE.


thanks.
> 
> > After the cpu is awoken from C-state, the interrupt is enabled.
> > Then it can handle the interrupt ISR and soft IRQ if the interrupt is triggered.
> > Is the above issue caused by that the might_sleep is called in the ISR/softIRQ?
> 
> Think so.
> 
> >   Can you describe how you fix this issue in your driver? It will be great if you can
> > give us some example codes that can trigger this issue.
> 
> You can view the git commit here:
> 
> http://tinyurl.com/add-rx-support-ath9k-htc
> 
> Its a bit big but anything that has to do with mutex->spinlock is what fixed it.
> 
> Let me summarize what I did.
> 
> I took Arjan's tip for granted:
> 
> "you can get this if your own code leaves interrupts disabled in a
> kernel thread and then lets the cpu go idle..."
> 
> So I went and checked code I might have which would do this. In my
> case my USB irq handler was taking a nap with mutex lock somewhere
> down the pipeline, once the workqueue has been kicked off and it grabs
> the mutex_lock() and the ISR then wants to contend but sleeps.
> 
> I changed the ISR code to spin_lock_irqsave() while it pumps skbs into
> an skb queue I had set up, and changed my workqueue which eats those
> skbs on the skb queue to use spin_lock_bh() (this is also wrong so I
> just changed it to irq_save as well).
> 
> FWIW the git tree is at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/ath9k_htc.git
> 
> and the commit was 88f284ae6a6a7ed7404bcf52c1a5f0692b01ea7f
> 
>   Luis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

