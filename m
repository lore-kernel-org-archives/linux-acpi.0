From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Sat, 20 Nov 2010 10:04:39 +0800
Message-ID: <AANLkTincYS7G1yb2ukT67qvpjwQmptXzQZabLQLYrEqn@mail.gmail.com>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
	<AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44345 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303Ab0KTCEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Nov 2010 21:04:40 -0500
In-Reply-To: <AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Nov 19, 2010 at 11:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Nov 19, 2010 at 12:10 AM, Huang Ying <ying.huang@intel.com> w=
rote:
>>
>> This is used by APEI ERST and GEHS. But it is a generic hardware
>> error reporting mechanism and can be used by other hardware error
>> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.
>
> Yeah, no.
>
> Really.
>
> We don't want some specific hardware error reporting mechanism.
> Hardware errors are way less common than other errors, so making
> something that is special to them just isn't very interesting.
>
> I seriously suggest that the only _sane_ way to handle hardware error=
s is to
> =C2=A0(a) admit that they are rare
> =C2=A0(b) not try to use some odd special mechanism for them
> =C2=A0(c) just 'printk' them so that you can use the absolutely most
> standard way to report them, and one that administrators are already
> used to and has support for network logging with existing tools etc.

We thought about 'printk' for hardware errors before, but it has some
issues too.

1) It mixes software errors and hardware errors. When Andi Kleen
maintained the Machine Check code, he found many users report the
hardware errors as software bug to software vendor instead of as
hardware error to hardware vendor. Having explicit hardware error
reporting interface may help these users.

2) Hardware error reporting may flush other information in printk
buffer. Considering one pin of your ECC DIMM is broken, tons of 1 bit
corrected memory error will be reported. Although we can enforce some
kind of throttling, your printk buffer may be full of the hardware
error reporting eventually.

3) We need some kind of user space hardware error daemon, which is
used to enforce some policy. For example, if the number of corrected
memory errors reported on one page exceeds the threshold, we can
offline the page to prevent some fatal error to occur in the future,
because fatal error may begin with corrected errors in reality. printk
is good for administrator, and may be not good enough for the hardware
error daemon.

But yes, printk is convenient for administrator or end user. So we
plan to printk some summary information about hardware errors too. But
leave the full hardware error information to the hardware error
specific interface, so that the administrator can get some clue and
hardware error information will not flush the printk buffer.

> =C2=A0(d) and if you want to make them persistent and NMI-safe, just =
do
> that on the _printk_ level. That way, any NMI-safeness or persistency
> helps everybody.
>
> I really see _zero_ point to some hw-error-specific model.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
