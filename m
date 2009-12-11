From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Fri, 11 Dec 2009 19:25:25 +0300
Message-ID: <4B227275.5010201@gmail.com>
References: <20091210100907.GA2446@ucw.cz> <1260446205-16868-1-git-send-email-dfeng@redhat.com> <4B20E7B2.1010208@suse.de> <1260510373.10543.17.camel@minggr.sh.intel.com> <4B223185.80202@suse.de> <20091211161549.GA15760@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46976 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZLKQZW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 11:25:22 -0500
In-Reply-To: <20091211161549.GA15760@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Lin Ming <ming.m.lin@intel.com>, Xiaotian Feng <dfeng@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Pavel Machek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri 2009-12-11 14:48:21, Alexey Starikovskiy wrote:
>  =20
>> Lin Ming ??????????:
>>    =20
>>> On Thu, 2009-12-10 at 20:21 +0800, Alexey Starikovskiy wrote:
>>>      =20
>>>> Hi Xiaotian,
>>>>
>>>> I think, this is another round of "armor vs. bullet" race... It wi=
ll hold until
>>>> might_sleep() logic changes again.
>>>>
>>>> Please consider using preemptible() -- IMHO this is the check we s=
hould perform=20
>>>> in our case of voluntary preemption.
>>>>        =20
>>> preemptible() may not work here because it always returns 0 for
>>> non-preemptible kernel.
>>>      =20
>> Right, and it means that this machine does not care about low latenc=
y that much.
>> The reason we introduced the preemption point in the first place, wa=
s unacceptable latency
>> due to very long AML methods on some machines. We don't need this pr=
eemption point for normal
>> operation, this is exactly what voluntary preemption does -- allows =
those in hurry to pass by.
>> If there are none, fine.
>>    =20
>>> #ifdef CONFIG_PREEMPT
>>> # define preemptible()  (preempt_count() =3D=3D 0 && !irqs_disabled=
())
>>> # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
>>> #else
>>> # define preemptible()  0
>>> # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
>>> #endif
>>>      =20
>
> Well, normally we want low latency even for !CONFIG_PREEMPT kernels.
>
> Actually, explicit preemption points are NOPs for CONFIG_PREEMPT
> kernels, right?
> 									Pavel
>  =20
Right. Do you have code?

Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
