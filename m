From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Mon, 28 Dec 2009 14:12:33 +0300
Message-ID: <4B3892A1.9010303@suse.de>
References: <20091210100907.GA2446@ucw.cz> <1260446205-16868-1-git-send-email-dfeng@redhat.com> <4B20E7B2.1010208@suse.de> <1260510373.10543.17.camel@minggr.sh.intel.com> <4B223185.80202@suse.de> <20091211161549.GA15760@elf.ucw.cz> <4B227275.5010201@gmail.com> <20091211173424.GC15760@elf.ucw.cz> <4B3849F6.1080403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:58903 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751168AbZL1LMf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2009 06:12:35 -0500
In-Reply-To: <4B3849F6.1080403@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alexey Starikovskiy <aystarik@gmail.com>, Lin Ming <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Xiaotian Feng =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 12/12/2009 01:34 AM, Pavel Machek wrote:
>>
>>>>> If there are none, fine.
>>>>>
>>>>>> #ifdef CONFIG_PREEMPT
>>>>>> # define preemptible()  (preempt_count() =3D=3D 0&&  !irqs_disab=
led())
>>>>>> # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
>>>>>> #else
>>>>>> # define preemptible()  0
>>>>>> # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
>>>>>> #endif
>>>>>>
>>>>
>>>> Well, normally we want low latency even for !CONFIG_PREEMPT kernel=
s.
>>>>
>>>> Actually, explicit preemption points are NOPs for CONFIG_PREEMPT
>>>> kernels, right?
>>
>>> Right. Do you have code?
>>
>> I'd prefer to spend my time with patches to areas that actually do
>> take cleanup patches.
>=20
> What's the status of this now? We can still see the sleeping function
> call warning or enable irq at resume stage.
> If acpi wants low latency even for !CONFIG_PREEMPT kernels, what's wr=
ong
> with V2 patch?
>=20
> We should not set any preemption points in irq or atomic. Since we ha=
ve
> a simple fix, and it did fix bugs, why should
> we make things more complex?
We should not do anything complex here, you are right.
Consider me ACK your patch.

Thanks,
Alex

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
