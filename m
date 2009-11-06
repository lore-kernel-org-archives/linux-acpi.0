From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Thu, 5 Nov 2009 17:50:20 -0800
Message-ID: <43e72e890911051750r3a42b4fbn222ccc48916eac00@mail.gmail.com>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
	<20091027165345.3237d3df@infradead.org> <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
	<43e72e890911021909ke760ee1sd68caa92f66d1727@mail.gmail.com>
	<1257470618.3804.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:60047 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZKFBuf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2009 20:50:35 -0500
Received: by iwn10 with SMTP id 10so528123iwn.4
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2009 17:50:40 -0800 (PST)
In-Reply-To: <1257470618.3804.23.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 5, 2009 at 5:23 PM, ykzhao <yakui.zhao@intel.com> wrote:
> On Tue, 2009-11-03 at 11:09 +0800, Luis R. Rodriguez wrote:
>> On Mon, Nov 2, 2009 at 7:02 PM, Len Brown <lenb@kernel.org> wrote:
>> >> > I get this when modprobing some module I am working on. I figur=
ed it
>> >> > was the module's fault but the EIP points to something else so =
I am
>> >> > not sure. I get the following repeating about 4 times on 2.6.32=
-rc5:
>> >>
>> >>
>> >> you can get this if your own code leaves interrupts disabled in a
>> >> kernel thread and then lets the cpu go idle...
>> >
>> > Unclear.
>> >
>> > acpi_enter_idle_bm() assumes that it is entered with irqs enabled,
>> > and so it we unconditionally disables IRQs.
>> >
>> > Then we unconditionally re-enable them.
>> >
>> > The problem seems to be that right after we enable them,
>> > we find that they are actually disabled, perhaps as
>> > a side-effect of SMM.
>> >
>> > Is your machine a Dell, per chance?
>>
>> Nope.
>>
>> > Please test the patches in this bug report:
>> > http://bugzilla.kernel.org/show_bug.cgi?id=3D14101
>>
>> In my case it was as Arjan pointed out and I've fixed it in my drive=
r.
>> Sorry for not reporting back and thanks for your review.
> Hi, Luis
> =C2=A0 It is very great that this issue is fixed in your driver.
> But it seems that there exist so many similar issues on kerneloops.
> =C2=A0 >BUG: scheduling while atomic: swapper/0/0x10000100
> =C2=A0 >Call Trace:
> =C2=A0[<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
> =C2=A0[<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
> =C2=A0[<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
>
> =C2=A0 >BUG: scheduling while atomic: swapper/0/0x10010000
> =C2=A0 >Call Trace:
> =C2=A0[<ffffffff812d2efa>] ? acpi_idle_enter_bm+0x284/0x2bf
> =C2=A0[<ffffffff813f931b>] ? cpuidle_idle_call+0x9b/0xf0
> =C2=A0[<ffffffff81010e12>] ? cpu_idle+0xb2/0x100
> =C2=A0[<ffffffff8151de43>] ? start_secondary+0xa9/0xab
>
> From the above log it seems that the preempt_count is 0x10010000,
> which means that this happens in softirq.

What's the preempt_count and how does it get changed?

> After the cpu is awoken from C-state, the interrupt is enabled.
> Then it can handle the interrupt ISR and soft IRQ if the interrupt is=
 triggered.
> Is the above issue caused by that the might_sleep is called in the IS=
R/softIRQ?

Think so.

> =C2=A0 Can you describe how you fix this issue in your driver? It wil=
l be great if you can
> give us some example codes that can trigger this issue.

You can view the git commit here:

http://tinyurl.com/add-rx-support-ath9k-htc

Its a bit big but anything that has to do with mutex->spinlock is what =
fixed it.

Let me summarize what I did.

I took Arjan's tip for granted:

"you can get this if your own code leaves interrupts disabled in a
kernel thread and then lets the cpu go idle..."

So I went and checked code I might have which would do this. In my
case my USB irq handler was taking a nap with mutex lock somewhere
down the pipeline, once the workqueue has been kicked off and it grabs
the mutex_lock() and the ISR then wants to contend but sleeps.

I changed the ISR code to spin_lock_irqsave() while it pumps skbs into
an skb queue I had set up, and changed my workqueue which eats those
skbs on the skb queue to use spin_lock_bh() (this is also wrong so I
just changed it to irq_save as well).

=46WIW the git tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/ath9k_htc.git

and the commit was 88f284ae6a6a7ed7404bcf52c1a5f0692b01ea7f

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
