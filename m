From: ykzhao <yakui.zhao@intel.com>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Fri, 06 Nov 2009 09:23:38 +0800
Message-ID: <1257470618.3804.23.camel@localhost.localdomain>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
	 <20091027165345.3237d3df@infradead.org>
	 <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
	 <43e72e890911021909ke760ee1sd68caa92f66d1727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18119 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbZKFBZH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Nov 2009 20:25:07 -0500
In-Reply-To: <43e72e890911021909ke760ee1sd68caa92f66d1727@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-11-03 at 11:09 +0800, Luis R. Rodriguez wrote:
> On Mon, Nov 2, 2009 at 7:02 PM, Len Brown <lenb@kernel.org> wrote:
> >> > I get this when modprobing some module I am working on. I figured it
> >> > was the module's fault but the EIP points to something else so I am
> >> > not sure. I get the following repeating about 4 times on 2.6.32-rc5:
> >>
> >>
> >> you can get this if your own code leaves interrupts disabled in a
> >> kernel thread and then lets the cpu go idle...
> >
> > Unclear.
> >
> > acpi_enter_idle_bm() assumes that it is entered with irqs enabled,
> > and so it we unconditionally disables IRQs.
> >
> > Then we unconditionally re-enable them.
> >
> > The problem seems to be that right after we enable them,
> > we find that they are actually disabled, perhaps as
> > a side-effect of SMM.
> >
> > Is your machine a Dell, per chance?
> 
> Nope.
> 
> > Please test the patches in this bug report:
> > http://bugzilla.kernel.org/show_bug.cgi?id=14101
> 
> In my case it was as Arjan pointed out and I've fixed it in my driver.
> Sorry for not reporting back and thanks for your review.
Hi, Luis
   It is very great that this issue is fixed in your driver. 
But it seems that there exist so many similar issues on kerneloops.
   >BUG: scheduling while atomic: swapper/0/0x10000100
   >Call Trace:
 [<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
 [<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
 [<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
  
   >BUG: scheduling while atomic: swapper/0/0x10010000
   >Call Trace:
 [<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
 [<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
 [<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
 [<ffffffff8151de43>] ? start_secondary+0xa9/0xab

   From the above log it seems that the preempt_count is 0x10010000, which means that
this happens in softirq. After the cpu is waked up from C-state, the interrupt is enabled.
Then it can handle the interrupt ISR and soft IRQ if the interrupt is triggered. 
Is the above issue caused by that the might_sleep is called in the ISR/softIRQ?

Hi, Luis
   Can you describe how you fix this issue in your driver? It will be great if you can
give us some example codes that can trigger this issue.

Thanks.
   
> 
>   Luis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

