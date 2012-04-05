From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Thu, 5 Apr 2012 11:20:26 +0800
Message-ID: <CAC=cRTOA2YGvBUxNrx0aDAT0ivUaRKFjL0RLrRr8+Kz18CfTmA@mail.gmail.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	<201204010923.18330.rjw@sisk.pl>
	<1333266346.2387.110.camel@rui.sh.intel.com>
	<201204011049.08609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60012 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab2DEDU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Apr 2012 23:20:27 -0400
In-Reply-To: <201204011049.08609.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Lin Ming <ming.m.lin@intel.com>, Aaron Lu <aaron.lu@amd.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>, Huang Ying <ying.huang@intel.com>

Hi, Rafael,

On Sun, Apr 1, 2012 at 4:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, April 01, 2012, Zhang Rui wrote:
>> On =E6=97=A5, 2012-04-01 at 09:23 +0200, Rafael J. Wysocki wrote:
>> > Hi,
>> >
>> > Sorry for the delayed response, I've been travelling recently.
>> >
>> > On Sunday, April 01, 2012, Lin Ming wrote:
>> > > On Sun, 2012-04-01 at 13:56 +0800, Aaron Lu wrote:
>> > > > Hi,
>> > > >
>> > > > On Sun, Apr 01, 2012 at 01:27:33PM +0800, Lin Ming wrote:
>> > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (device->power.sta=
tes[state].flags.explicit_set) {
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If state is D3 Col=
d, try to evaluate _PS3 first */
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (state =3D=3D ACPI=
_STATE_D3_COLD) {
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 explicit_set =3D (ps - 1)->flags.explicit_set;
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 object_name[3] -=3D 1;
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > >
>> > > > > I'm not sure whether this works or not.
>> > > > >
>> > > > > From ACPI spec,
>> > > > >
>> > > > > _PS3 "is used to put the specific device into its D3hot or D=
3 state"
>> > > > >
>> > > > > D3 neither means D3hot nor D3cold. It's an old term before D=
3hot and
>> > > > > D3cold were introduced.
>> > > > I guess D3 has to mean something, right? :-)
>> >
>> > Well, not necessarily.
>> >
>> > The problem is what state the _PS3 method puts the device into: D3=
_hot or
>> > D3_cold.
>> >
>> > Unfortunately, as far as I can say, ACPI 4.0 didn't specify any "o=
fficial"
>> > mapping between the "old" D3 and the "new" D3_{hod|cold} states, s=
o we need to
>> > figure out something. =C2=A0In my opinion, the only reasonable app=
roach is to
>> > assume that the state _PS3 puts the device into is always D3_cold,=
 becuase
>> > _PS3 may remove power completely from the device. =C2=A0It may not=
 do that, but
>> > we _must_ assume it does that in general.
>> >
>> There is a problem that I can think of.
>> Say currently, ACPI always returns D3 when _PS3 exists.
>
> I'm not sure what you mean exactly, but please see below.
>
>> And this "ACPI_STATE_D3" is translated to PCI_D3hot.
>> But with this approach, we're going to put these devices to PCI_D3co=
ld
>> instead, right?
>> I'm not against this approach, but this may affect a lot of PCI devi=
ces,
>> which we need to take care of, no?
>
> Do you mean acpi_pm_device_sleep_state() should be modified? =C2=A0It=
 doesn't
> refer to whether or not _PS3 exists, as far as I can say.
>
> In the acpi_pci_set_power_state() code path, on the other hand, there=
 are
> two potentially problematic situations when PCI wants to put the devi=
ce into
> PCI_D3hot (which need not map 1:1 onto ACPI D3_hot), one of which is =
when _PS3
> is present, and the other is when neither _PS3, nor _PR3 is present.
>
> If _PS3 is present, then _PR3 may or may not be present. =C2=A0In the=
 latter case
> we can only execute _PS3 in the hope it does the right thing, but as =
long
> as we restore the device's configuration registers while resuming it =
(which is
> done by all of our PCI device resume callback routines as far as I ca=
n say),
> the only possible difference is the resume latency (which may be grea=
ter if
> power is removed from the device entirely).

Another difference between D3Hot and D3Cold for PCI devices is config
space availability.  That is, in D3Hot, you can access D3Hot, while in
D3Cold you can not do that.  For example, PME poll logic need to be
disabled if we put device into D3Cold.

>=C2=A0However, in that case we shouldn't
> turn off the device's power resources after _PS3 has been executed (i=
f we
> turned them off, power would be removed from the device, which wouldn=
't be
> what PCI wanted). =C2=A0So, to handle this particular case we need to=
 pass
> ACPI_STATE_D3_HOT to acpi_bus_set_power(), meaning "avoid going into =
D3_cold,
> if possible".
>
> In both _PS3 and _PR3 are present, we should evaluate _PS3 and then t=
urn off
> the power resources listed as "off" by _PR3 (and turn on the power re=
soruces
> listed by it as "on"), but we need to restore the configuration regis=
ters of
> the device while resuming it. =C2=A0I think this is handled correctly=
 without
> modifications.
>
> If neither _PS3 nor _PR3 is present, we shouldn't turn off the device=
's
> power resources, because PCI doesn't want power to be removed from th=
e device.

=46or PCI device plugged into system via slot (not integrated into PCH
or motherboard), there is no ACPI handle associate with it, so that
there are neither _PS3 nor _PR3 presented.  But it is still possible
to turn off the device power via the associated PCIe port, which has
_PS3 and/or _PR3 presented.  I think that situation is reasonable too.

> In summary, if PCI wants the device to be put into PCI_D3hot and _PS3=
 is
> present, we should evaluate _PS3. =C2=A0However, we shouldn't turn th=
e device's
> power resources off unless _PR3 is present, in which case we can turn=
 off
> the power resources listed by it as "off".

How to turn the device's power resources off without _PR3?  It may be
possible via PCIe port as I said above.  Do you mean that?  Or
something else?

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
