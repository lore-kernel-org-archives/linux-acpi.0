From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -v2 2/3] ACPI, APEI, Add APEI generic error status print support
Date: Wed, 1 Dec 2010 08:04:58 +0800
Message-ID: <AANLkTimLDCy3TebSAtC8b9RbBeyLBqiA=xmSHsQPQfct@mail.gmail.com>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
	<1291085501-31494-3-git-send-email-ying.huang@intel.com>
	<20101129190343.7d7cea12.akpm@linux-foundation.org>
	<1291087752.12648.95.camel@yhuang-dev>
	<20101129194033.393e1f70.akpm@linux-foundation.org>
	<1291100431.12648.165.camel@yhuang-dev>
	<20101130154905.b5c8ab31.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47408 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0LAAFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Nov 2010 19:05:00 -0500
In-Reply-To: <20101130154905.b5c8ab31.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Wed, Dec 1, 2010 at 7:49 AM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> On Tue, 30 Nov 2010 15:00:31 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> > However in this case you are avowedly treating the printks as a
>> > userspace interface, with the intention that software be written t=
o
>> > parse them, yes? =C2=A0So once they're in place, we cannot change =
them? =C2=A0That
>> > makes it more important.
>>
>> If my understanding is correct, Linus still don't like the idea of u=
ser
>> space hardware error tool.
>
> I'm sure he has no problem with a userspace tool ;) Surely what he do=
esn't
> like is the proposed kernel interface.
>
>> =C2=A0On the other hand, if we need this tool, I
>> think printk is not a good tool-oriented hardware error reporting
>> interface for it, because:
>>
>> - There is no overall format or record boundaries for printk, becaus=
e
>> printk is traditionally for 1-2 lines. =C2=A0This makes that printk =
is hard
>> to parse in general.
>
> Well. =C2=A0These things can be addressed by careful choice of output
> format.
>
>> - Messages from different CPUs may be interleaved.
>
> A single printk() should be atomic.
>
>> - Good error reporting is too verbose for kernel log
>>
>> - printk has no internal priority support, so that high severity err=
ors
>> has no more priority than low severity ones.
>>
>>
>> So my opinion is:
>>
>> - Use printk as human oriented hardware error reporting.
>> - Use another tool oriented interface for user space hardware error =
tool
>> if necessary.
>>
>> Do you agree? =C2=A0Do you think printk can be used as a good tool-o=
riented
>> hardware error reporting interface too?
>
> I agree that using printk() is pretty sucky.
>
> However your proposals are waaaaaaaaay too narrow and specific IMO.
> There are several reasons why people want more regular and structured
> kerenl->userspace messaging features. =C2=A0One such requirement is f=
or
> internationalisation: people want messages to come out in some
> non-language-specific manner so that userspace tools can perform
> catalogue lookups and display the messages in the appropriate languag=
e.
> =C2=A0Others (eg google) want to feed the messages into large-scale
> capturing systems for offline analysis. =C2=A0And there are other
> requirements which I forget. =C2=A0Such a messaging/logging system wo=
uld
> also incorporate the requirement to log to a persistent store.
>
> So I think that quite a lot of people would be interested in proposal=
s
> for a new and improved kernel->userspace messaging/logging facility.
> But talking about "hardware error reporting" (especially when it cove=
rs
> only a teeny subset of possible hardware errors!) is very myopic.
>
> And implementing the broad facility would be a pretty big project. =C2=
=A0Simply
> chasing down all the stakeholders and understanding their needs would
> turn one's hair grey.
>
> So we're a bit stuck, really. =C2=A0We would benefit from a quite bro=
ad and
> expensive-to-implement messaging/logging system, but we don't even kn=
ow
> what that will look like yet. =C2=A0You have a small and highly-speci=
fic
> subset of that. =C2=A0If we merge the subset then it probably will li=
ve
> forever even if the broader feature gets written one day, because the
> subset is userspace-visible and adds interfaces which the larger syst=
em
> probably won't even implement.
>
> So... =C2=A0for your pretty narrow and specific problem, perhaps usin=
g
> printk as a stopgap until somethine better to come along is the corre=
ct
> choice.

OK. I will work on the printk based solution, at least as the first ste=
p.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
