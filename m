From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v2] ACPI: D3 states cleanup
Date: Fri, 20 Apr 2012 23:14:40 +0800
Message-ID: <CAF1ivSYxoN3dbrNztY4BGLFYg6wGvCyypLgwXuOFam7uKtBB1w@mail.gmail.com>
References: <1334884749.4927.6.camel@minggr>
	<1334900255.4927.36.camel@minggr>
	<20120420074725.GA30140@localhost.amd.com>
	<201204201312.54949.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57839 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab2DTPOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Apr 2012 11:14:42 -0400
In-Reply-To: <201204201312.54949.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@amd.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Huang, Ying" <ying.huang@intel.com>

On Fri, Apr 20, 2012 at 7:12 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, April 20, 2012, Aaron Lu wrote:
>> Hi,
>>
>> On Fri, Apr 20, 2012 at 01:37:35PM +0800, Lin Ming wrote:
>> > > > > > There are two ACPI D3 states defined now:
>> > > > > > ACPI_STATE_D3 and ACPI_STATE_D3_COLD.
>> > > > > >
>> > > > > > But the uses of these states are not clear/correct in some=
 code.
>> > > > > > For example, some code refer ACPI_STATE_D3 as D3hot and ot=
hers refer
>> > > > > > it as D3cold.
>> > > > > >
>> > > > > > This patch introduces ACPI_STATE_D3_HOT to refer to ACPI D=
3hot state.
>> > > > > > And changes ACPI_STATE_D3 to refer to ACPI D3cold state on=
ly.
>> > > > > > Also redefines ACPI_STATE_D3_COLD the same as ACPI_STATE_D=
3.
>> > > > > >
>> > > > >
>> > > > > With this patch now, if a device has _PS3, then we will set =
its D3hot
>> > > > > flag valid. This doesn't feel right to me, since per our dis=
cussion the
>> > > > > other day, we should assume _PS3 will put the device into D3=
cold.
>> > > > >
>> > > > > Or do you mean: if _PS3 is available, then both D3hot and D3=
cold is
>> > > > > valid from the perspective of acpi, it is the individual dri=
ver's
>> > > > > responsibility to decide which state is actually valid and w=
ill be used.
>> > > >
>> > > > Right.
>> > > >
>> > > > ACPI_STATE_D3(same as ACPI_STATE_D3_COLD now) is always valid.
>> > > >
>> > >
>> > > I mean, if _PS3 is available, can we say D3hot is valid?
>> >
>> > Yes.
>> >
>>
>> OK, now I'm confused...
>>
>> First, let me try to clarify the meaning of acpi power state's valid
>> flag.
>>
>> By valid, I suppose it means the device can be in that state, instea=
d of
>> we have a way to program this device to go into that state.
>>
>> e.g. D0 is valid means the device can be in D0 state, and D3_cold is
>> valid means the device can be in D3_cold state. We unconditionally s=
et
>> these two states as valid, because we know every device supports the=
se
>> two states. But we might not be able to put the device into that sta=
te
>> in software, since we might not have _PS0 or _PS3 control methods fo=
r it.
>>
>> And if we do have the _PSx or _PRx control methods, we knows we have=
 a
>> way to put the device into that state, and hence the device should b=
e
>> able to support that power state, so we will set that state as valid=
 too.
>>
>> Is this correct?
>>
>> For D3hot, obviously not all device supports this state, so we will =
need
>> to figure it out through the acpi table.
>> I remembered Rafael said the following words the other day in a repl=
y to
>> my evaluate_ps3_when_entering_d3_cold_patch:
>>
>> --------------------------------------------------------------------=
---
>> I'd rather say that with _PR3 we have the opportunity to avoid remov=
ing
>> power completely from the device. =A0In other words, D3_hot is suppo=
rted (and
>> it is supported _only_ in that case).
>> --------------------------------------------------------------------=
---
>>
>> So I think here is a problem, that if a device has only _PS3, why sh=
ould
>> we say D3hot is supported? Is there a reason for this that I missed?
>
> OK, I agree. =A0We need to special case the situation in which _PR3 i=
s not
> present, but _PS3 is. =A0IOW, we should do something like this in the=
 loop in
> acpi_bus_get_power_flags():
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* State is valid if we have some powe=
r control */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ps->resources.count
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| (ps->flags.explicit_set && =
i < ACPI_STATE_D3))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps->flags.valid =3D 1;

Will add below change.

-               /* State is valid if we have some power control */
-               if (ps->resources.count || ps->flags.explicit_set)
+               /*
+                * State is valid if we have some power control
+                * D3hot state is only valid if _PR3 present
+                */
+               if (ps->resources.count ||
+                   (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT))
                        ps->flags.valid =3D 1;

Rafael,

can I still add your ACK when send updated patch?

Thanks,
Lin Ming

>
> Thanks,
> Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
