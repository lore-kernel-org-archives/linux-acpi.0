From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: Re: "ACPI: EC: missing confirmations, switch off interrupt mode"
	wastes time on startup
Date: Thu, 26 Mar 2009 22:54:07 +0100
Message-ID: <4e5e476b0903261454h1525c30chdc86dbcb1cf3cb5c@mail.gmail.com>
References: <4e5e476b0903260847m1de3e976ne20279df359176cf@mail.gmail.com>
	 <9b2b86520903260958r790e5459r553308311522e88f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:35834 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbZCZVyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 17:54:10 -0400
In-Reply-To: <9b2b86520903260958r790e5459r553308311522e88f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Mar 26, 2009 at 5:58 PM, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> On 3/26/09, Corrado Zoccolo <czoccolo@gmail.com> wrote:
>
> [CC linux-acpi]
>
> Thanks for reporting this bug / issue. =C2=A0Your hardware is probabl=
y
> defective by design - that is, it doesn't follow the ACPI spec. =C2=A0=
But
> we can't blame users for that :-).
>
> I take it this isn't a regression, i.e. if you've tried earlier
> kernels, it's never worked any better?

This is new hardware, and 2.6.29 is the first kernel I installed, so I
can't say.

>
> You say this is a severe delay - but your logs show 0.5 seconds only,
> is that right? =C2=A0Just to get it clear.
>
Right, but Arjan showed that 1s boot time for kernel is possible, so
0.5s is quite severe respect to this :).
I'm still way far from 1s, though, due to an other issue that wastes
>1s, i.e. tsc clocksource unstable.

> Currently there is no option to force polling, sorry. =C2=A0I'm _gues=
sing_
> this was a deliberate omission. =C2=A0But I can sympathise that even =
0.5s
> boot delay is bad on a netbook.
>
Yes. Do you think that changing olpc_ec_timeout kernel parameter may
help in getting the timeout sooner?

> Feel free to create a new bugzilla entry. =C2=A0You can attach the fu=
ll
> output of dmesg, but acpidump is probably not required. =C2=A0What wo=
uld be
> really helpful is if you could file on bugzilla, and attach a full
> debug trace. =C2=A0I.e. as well as the normal dmesg, attach the dmesg
> output after recompiling with this change:
>

bug: http://bugzilla.kernel.org/show_bug.cgi?id=3D12949
full debug dmesg: http://bugzilla.kernel.org/attachment.cgi?id=3D20695

Thanks,
Corrado

--=20
_______________________________________________________________________=
___

dott. Corrado Zoccolo                          mailto:czoccolo@gmail.co=
m
PhD - Department of Computer Science - University of Pisa, Italy
-----------------------------------------------------------------------=
---
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
