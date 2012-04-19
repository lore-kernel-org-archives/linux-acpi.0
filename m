From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [RFC PATCH] PCIe: Add PCIe runtime D3cold support
Date: Thu, 19 Apr 2012 10:47:29 +0800
Message-ID: <CAC=cRTOJEyfou68Lt3x0Ro8YLsKkQTri1Hd1g4usL+3eXbUGCQ@mail.gmail.com>
References: <4F8790F6.5080408@intel.com>
	<201204172303.07419.rjw@sisk.pl>
	<CAC=cRTMR=axVV4x9Qa9vO+UXs_s73fOWkeW5mocUEkvKe9J+Dw@mail.gmail.com>
	<201204182300.48882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55585 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2DSCra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Apr 2012 22:47:30 -0400
In-Reply-To: <201204182300.48882.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thu, Apr 19, 2012 at 5:00 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, April 18, 2012, huang ying wrote:
>> On Wed, Apr 18, 2012 at 5:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> > On Tuesday, April 17, 2012, huang ying wrote:
>> >> On Tue, Apr 17, 2012 at 5:30 AM, Rafael J. Wysocki <rjw@sisk.pl> =
wrote:
>> >> > On Monday, April 16, 2012, huang ying wrote:
>> >> >> Hi,
>> >> >>
>> >> >> On Sat, Apr 14, 2012 at 3:41 AM, Rafael J. Wysocki <rjw@sisk.p=
l> wrote:
>> >> >> > Hi,
>> >> >> >
>> >> >> > On Friday, April 13, 2012, Yan, Zheng wrote:
>> >> >> >> Hi all,
>> >> >> >>
>> >> >> >> This patch adds PCIe runtime D3cold support, namely cut pow=
er supply for functions
>> >> >> >> beneath a PCIe port when they all have entered D3. A device=
 in D3cold can only
>> >> >> >> generate wake event through the WAKE# pin. Because we can n=
ot access to a device's
>> >> >> >> configure space while it's in D3cold, pme_poll is disabled =
for devices in D3cold.
>> >> >> >>
>> >> >> >> Any comment will be appreciated.
>> >> >> >>
>> >> >> >> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>> >> >> >> ---
>> >> >> >> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.=
c
>> >> >> >> index 0f150f2..e210e8cb 100644
>> >> >> >> --- a/drivers/pci/pci-acpi.c
>> >> >> >> +++ b/drivers/pci/pci-acpi.c
>> >> >> >> @@ -224,7 +224,7 @@ static int acpi_pci_set_power_state(str=
uct pci_dev *dev, pci_power_t state)
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D1] =3D=
 ACPI_STATE_D1,
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D2] =3D=
 ACPI_STATE_D2,
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3hot=
] =3D ACPI_STATE_D3,
>> >> >> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3cold] =3D=
 ACPI_STATE_D3
>> >> >> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3cold] =3D=
 ACPI_STATE_D3_COLD
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 };
>> >> >> >> =C2=A0 =C2=A0 =C2=A0 int error =3D -EINVAL;
>> >> >> >>
>> >> >> >
>> >> >> > Please don't use that ACPI_STATE_D3_COLD thing, it's not def=
ined correctly.
>> >> >> >
>> >> >> > We should define ACPI_STATE_D3_COLD =3D=3D ACPI_STATE_D3 and=
 add ACPI_STATE_D3_HOT
>> >> >> > instead. =C2=A0I'll prepare a patch for that over the weeken=
d if no one has done
>> >> >> > that already.
>> >> >> >
>> >> >> >> @@ -296,7 +296,8 @@ static void acpi_pci_propagate_run_wake=
(struct pci_bus *bus, bool enable)
>> >> >> >>
>> >> >> >> =C2=A0static int acpi_pci_run_wake(struct pci_dev *dev, boo=
l enable)
>> >> >> >> =C2=A0{
>> >> >> >> - =C2=A0 =C2=A0 if (dev->pme_interrupt)
>> >> >> >> + =C2=A0 =C2=A0 /* PME interrupt isn't available in the D3c=
old case */
>> >> >> >> + =C2=A0 =C2=A0 if (dev->pme_interrupt && !dev->runtime_d3c=
old)
>> >> >> >
>> >> >> > This whole thing is wrong. =C2=A0First off, I don't think th=
at the runtime_d3cold
>> >> >> > flag makes any sense. =C2=A0We already cover that in dev->pm=
e_support.
>> >> >>
>> >> >> PCIe devices and PCIe root port may have proper PME interrupt =
support
>> >> >> (that is, dev->pme_interrupt =3D true), but the process of rem=
ote wakeup
>> >> >> from D3cold is as follow:
>> >> >>
>> >> >> 1) In D3cold, the power of the main link is turned off, aux po=
wer is
>> >> >> provided (PCIe L2 link state)
>> >> >> 2) Device detect condition to resume, then assert #WAKE pin
>> >> >> 2) ACPI circuit linked with #WAKE pin, and will generate a GPE=
 for that
>> >> >> 3) GPE handler will resume device with ACPI (via _PS3 and _PR0=
), the
>> >> >> power of the main link is turned on, after a while, link goes =
into L0
>> >> >> state
>> >> >> 4) The PME message is sent to root port, pme interrupt generat=
ed
>> >> >
>> >> > This isn't how it's supposed to work in theory. =C2=A0If the de=
vice can signal PME
>> >> > from D3cold, it should be able to reestablish the link and send=
 a PME
>> >> > message from there. =C2=A0dev->pme_interrupt set means exactly =
that.
>> >> >
>> >> > ACPI is only supposed to be needed for things that don't send P=
ME
>> >> > messages (in your case the PME interrupt generated by the port =
is essentially
>> >> > useless, because the wakeup event has already been signaled thr=
ough ACPI).
>> >> >
>> >> >> So, for deivce, dev->pme_interrupt =3D true and dev->pme_suppo=
rt
>> >> >> advocate it support PME in D3cold. =C2=A0But we still need ACP=
I to setup
>> >> >> run wake for the device.
>> >> >
>> >> > OK, so this is nonstandard.
>> >>
>> >> This is the standard behavior. =C2=A0Please refer to PCI Express =
Base
>> >> Sepcification Revision 2.0, section 5.3.3.2 Link Wakeup. =C2=A0In=
 D1, D2
>> >> and D3hot state, PCIe device can transit the link from L1 to L0 s=
tate,
>> >> and send the PME message. =C2=A0In D3cold, the main link is power=
ed off,
>> >> PCIe device will use a STANDARD sideband signal WAKE# to signal w=
akeup
>> >> firstly, then platform (power controller in spec) will power on t=
he
>> >> main link for the device, after main link is back to L0, the PME
>> >> message is send to root port, pme interrupt is generated. =C2=A0S=
o in
>> >> theory, the wake up process can be divided into platform part (wh=
ich
>> >> power on the main link) and PCIe part (which send PME).
>> >
>> > That's fine. =C2=A0However, the platform part should be completely=
 transparent
>> > to the PCI bus type, then. =C2=A0It just should power up the link =
to allow a
>> > PME message to be transmitted through it.
>>
>> Yes.
>>
>> >[...]
>> >
>> >> > So don't use pci_set_power_state() for that, because it's essen=
tially
>> >> > a different operation. =C2=A0You need a pci_platform_remove_pow=
er() helper or
>> >> > similar for that.
>> >> >
>> >> > What ACPI method exactly is used to remove power from the devic=
e?
>> >>
>> >> The ACPI method executed is as follow:
>> >>
>> >> - _PS3 (if exist)
>> >> - Power resources in _PR3 is turned on
>> >> - Power resources in _PR0 is turned off
>> >> - Power resources in _PR3 is turned off
>> >
>> > I'd rather think
>> >
>> > - make sure that _PR3 resources are referenced
>> > - drop references (from this device) for all other power resources
>> > - execute _PS3 (if any)
>> > - drop references for _PR3 resources
>> >
>> > if Section 7.2.11 of ACPI 5.0 is to be followed.
>>
>> Yes. =C2=A0You are right.
>>
>> >> I think the process can fit pci_set_power_state() quite well, so =
why
>> >> invent another helper for that?
>> >
>> > OK, we can special case it, perhaps.
>> >
>> > Suppose we have a "this device may be put into D3_cold" flag.
>> >
>> > Who's going to decide whether to put it into D3_hot or D3_cold?
>>
>> In most cases, I think it is OK to put device into D3_cold if that i=
s
>> supported.
>
> Well, there may be PM QoS latency requirements preventing us from doi=
ng so.

Yes.

>> But there should be some special case where D3_cold is not
>> desirable, for example, we can put SSD into D3_cold safely, but it i=
s
>> not quite safe to put HDD into D3_cold. =C2=A0So we want to introduc=
e a
>> flag: "may_power_off" like in the following patch
>>
>> https://lkml.org/lkml/2012/3/29/41
>>
>> It gives device driver a chance to prevent the device to be put into=
 D3_cold.
>
> I see. =C2=A0So your proposal is that the flag might be used to indic=
ate to
> whoever carries out power transitions of devices that power must not =
be
> removed from this particular device, right?

Yes.

> In that case we can put that flag into struct dev_pm_info after all, =
but
> perhaps the name should indicate more precisely what it is about. =C2=
=A0Something
> like "power_must_be_on" maybe?

I am not good at naming in English :)
I will accept your proposal.

>> > [...]
>> >
>> >> >> > So now please tell me what exactly you want to achieve and w=
hy you want to do
>> >> >> > that in the first place.
>> >> >
>> >> > Well, is there any chance to get that information?
>> >>
>> >> You mean the runtime_d3cold flag? That flag is used to tell
>> >> acpi_pci_run_wake() that we need ACPI wakeup setup for the device
>> >> because that is needed by D3cold. =C2=A0The ACPI wakeup setup her=
e means
>> >> turn on power resources needed by wake up (_PRW) and execute _DSW=
=2E
>> >>
>> >> If you mean the whole patch, we want to implement runtime D3cold
>> >> support, which can save more power than D3hot.
>> >
>> > So, do I think correctly that you'd like to put devices into D3_co=
ld
>> > if that's possible via ACPI and to be able to wake it up from that=
 state
>> > using remote wakeup?
>>
>> Yes. =C2=A0Support both remote wakeup and host wakeup.
>
> OK, so we need to clean up the ACPI D3_HOT/D3_COLD mess first. =C2=A0=
Then, we need
> to change PCI so that devices are not put into D3cold (by ACPI) if on=
ly D3hot
> is requested by the caller of pci_set_power_state().
>
> Having done that, we can modify pci_set_power_state() to handle D3col=
d as
> a special case (essentially, it should check that case before doing a=
nything
> else). =C2=A0Finally, we need to teach the ACPI notify handler about =
the WAKE#
> event and we need to add the 100 ms wait to the device resume code pa=
th
> somewhere (I guess in pci_set_power_state() for the D3cold->D0 transi=
tion).

Yes.  Sound good to me.

> Now, there's one more thing to consider. =C2=A0Namely, if a PCIe endp=
oint is put
> into D3hot (via native PM) and then the port it is connected to is pu=
t into
> D3_hot (via native PM), does that transfer the endpoint into D3cold?

No.

But if a PCIe endpoint is put into D3hot and then the port it is
connected is put into D3_cold (via ACPI), this will transfer the
endpoint into D3_cold, and if the port is put into D0 afterwards, all
subordinate endpoint devices will be put into D0 (because of power on
reset).  I think what we need to do here is:

- when choose power state, if any subordinate device has
power_must_be_on set, will not choose D3_cold

- when put PCIe port from D3_cold to D0, resume all subordinate
devices too.  We design a method to do that in following patch:

https://lkml.org/lkml/2012/3/29/38

Where we will register all subordinate devices via
acpi_power_resource_register_device(endpoint_device,
bridget_acpi_handle).

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
