From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 1/6] ACPI: D3cold state is always valid
Date: Thu, 19 Apr 2012 09:35:46 +0800
Message-ID: <CAC=cRTMts3q4s2qYr0Ds3W98WhXXXMa8P2qCAqm-fQcT+HFfDw@mail.gmail.com>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
	<1334641676-14566-2-git-send-email-ming.m.lin@intel.com>
	<CAC=cRTPkFM5=az2B0A22miqt_X+XxcWPLrqPfeeRabho9yx-1Q@mail.gmail.com>
	<201204182313.59916.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48919 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2DSBfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Apr 2012 21:35:47 -0400
In-Reply-To: <201204182313.59916.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.og>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Aaron Lu <aaron.lu@amd.com>

On Thu, Apr 19, 2012 at 5:13 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 17, 2012, huang ying wrote:
>> On Tue, Apr 17, 2012 at 1:47 PM, Lin Ming <ming.m.lin@intel.com> wro=
te:
>> > ACPI_STATE_D3 actually means ACPI D3hot which is not always valid.
>> > Instead, ACPI D3cold is always valid.
>> >
>> > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>> > ---
>> > =C2=A0drivers/acpi/scan.c | =C2=A0 11 ++---------
>> > =C2=A01 files changed, 2 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> > index 767e2dc..fb56388 100644
>> > --- a/drivers/acpi/scan.c
>> > +++ b/drivers/acpi/scan.c
>> > @@ -884,13 +884,6 @@ static int acpi_bus_get_power_flags(struct ac=
pi_device *device)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_bus_add_power_resourc=
e(ps->resources.handles[j]);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The exist of=
 _PR3 indicates D3Cold support */
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D AC=
PI_STATE_D3) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 status =3D acpi_get_handle(device->handle, object_name, &han=
dle);
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ACPI_SUCCESS(status))
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_=
D3_COLD].flags.valid =3D 1;
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > -
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Evaluate=
 "_PSx" to see if we can do explicit sets */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_name=
[2] =3D 'S';
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D =
acpi_get_handle(device->handle, object_name, &handle);
>> > @@ -908,8 +901,8 @@ static int acpi_bus_get_power_flags(struct acp=
i_device *device)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set defaults for D0 and D3 states (a=
lways valid) */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0device->power.states[ACPI_STATE_D0].fla=
gs.valid =3D 1;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0device->power.states[ACPI_STATE_D0].pow=
er =3D 100;
>> > - =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3].flags.v=
alid =3D 1;
>> > - =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3].power =3D=
 0;
>> > + =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3_COLD].fl=
ags.valid =3D 1;
>> > + =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3_COLD].po=
wer =3D 0;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_bus_init_power(device);
>>
>> I think D3_HOT should be always valid, while D3_COLD should be valid
>> for some situation.
>
> This need not be PCI, mind you.
>
>> =C2=A0- has _PS3, no _PR3
>> =C2=A0 =C2=A0- support D3_HOT, D3_COLD
>
> Nope. =C2=A0D3_HOT cannot be supported in that case at the ACPI level=
=2E
>
>> =C2=A0 =C2=A0- set state
>> =C2=A0 =C2=A0 =C2=A0- D3_HOT: do nothing in ACPI
>
> That is not D3_HOT, then, from the ACPI point of view. =C2=A0It is a =
different
> power state.
>
> Suppose you have a non-PCI device that can be only power-manageable v=
ia ACPI
> and that device has only _PS0 and _PS3. =C2=A0How would you put it in=
to D3_HOT,
> in particular?

Normally, we will put it into D3_COLD (via _PS3).

If it is prevented to be put in D3_COLD,
  - If D3_HOT is not marked as supported, we will keep it in D0
  - otherwise, we advocate we put it into D3_HOT, but in fact, it is in=
 D0.

The result is same, but with wrong name.

But there will be some real problem if we have something like CPU
governor.  Because governor may choose D3_HOT for device.

But for PCI device, D3_HOT is supported for the device.

So the bus layer should combine the information from native power
state supported and ACPI power state supported to determine which
power states are supported?  For example, for a PCI device, ACPI
advocates D0 and D3_COLD are supported, and PCI layer may advocate D0,
D3_HOT and D3_COLD are supported.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
