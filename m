From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Fri, 11 Dec 2009 14:48:21 +0300
Message-ID: <4B223185.80202@suse.de>
References: <20091210100907.GA2446@ucw.cz>	 <1260446205-16868-1-git-send-email-dfeng@redhat.com>	 <4B20E7B2.1010208@suse.de> <1260510373.10543.17.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:47939 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761013AbZLKLsU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 06:48:20 -0500
In-Reply-To: <1260510373.10543.17.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Xiaotian Feng <dfeng@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Pavel Machek <pavel@ucw.cz>

Lin Ming =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thu, 2009-12-10 at 20:21 +0800, Alexey Starikovskiy wrote:
>> Hi Xiaotian,
>>
>> I think, this is another round of "armor vs. bullet" race... It will=
 hold until
>> might_sleep() logic changes again.
>>
>> Please consider using preemptible() -- IMHO this is the check we sho=
uld perform=20
>> in our case of voluntary preemption.
>=20
> preemptible() may not work here because it always returns 0 for
> non-preemptible kernel.
Right, and it means that this machine does not care about low latency t=
hat much.
The reason we introduced the preemption point in the first place, was u=
nacceptable latency
due to very long AML methods on some machines. We don't need this preem=
ption point for normal
operation, this is exactly what voluntary preemption does -- allows tho=
se in hurry to pass by.
If there are none, fine.
>=20
> #ifdef CONFIG_PREEMPT
> # define preemptible()  (preempt_count() =3D=3D 0 && !irqs_disabled()=
)
> # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
> #else
> # define preemptible()  0
> # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
> #endif
>=20
Regards,
Alex.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
