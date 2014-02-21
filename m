From: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH v5 3/5] ACPI / processor: Introduce map_gic_id() to get
 apic id from MADT or _MAT method
Date: Fri, 21 Feb 2014 12:37:19 +0000
Message-ID: <5307487F.6000308@arm.com>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <1392740638-2479-4-git-send-email-hanjun.guo@linaro.org> <5304C0C4.3080601@arm.com> <53057DA9.3010307@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52356 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbaBUMgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2014 07:36:48 -0500
In-Reply-To: <53057DA9.3010307@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep.Holla@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lan Tianyu <tianyu.lan@intel.com>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Joe Perches <joe@perches.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <Marc.Zyngier@arm.com>

Hi Hanjun,

(Adding MarcZ for his views on GIC)

On 20/02/14 03:59, Hanjun Guo wrote:
> Hi Sudeep,
>=20
> Thanks for your comments, please refer to the replies below. :)
>=20
> On 2014=E5=B9=B402=E6=9C=8819=E6=97=A5 22:33, Sudeep Holla wrote:
>> Hi Hanjun,
>>
>> On 18/02/14 16:23, Hanjun Guo wrote:
>>> Get apic id from MADT or _MAT method is not implemented on arm/arm6=
4,
>>> and ACPI 5.0 introduces GIC Structure for it, so this patch introdu=
ces
>>> map_gic_id() to get apic id followed the ACPI 5.0 spec.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   drivers/acpi/processor_core.c |   26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor=
_core.c
>>> index 4dcf776..d316d9b 100644
>>> --- a/drivers/acpi/processor_core.c
>>> +++ b/drivers/acpi/processor_core.c
>>> @@ -71,6 +71,27 @@ static int map_lsapic_id(struct acpi_subtable_he=
ader *entry,
>>>   	return 0;
>>>   }
>>>  =20
>>> +static int map_gic_id(struct acpi_subtable_header *entry,
>>> +		int device_declaration, u32 acpi_id, int *apic_id)
>>> +{
>>> +	struct acpi_madt_generic_interrupt *gic =3D
>>> +		(struct acpi_madt_generic_interrupt *)entry;
>>> +
>>> +	if (!(gic->flags & ACPI_MADT_ENABLED))
>>> +		return -ENODEV;
>>> +
>>> +	/* In the GIC interrupt model, logical processors are
>>> +	 * required to have a Processor Device object in the DSDT,
>>> +	 * so we should check device_declaration here
>>> +	 */
>>> +	if (device_declaration && (gic->uid =3D=3D acpi_id)) {
>>> +		*apic_id =3D gic->gic_id;
>> I have mentioned this earlier, it's not clear yet to me how does thi=
s work ?
>> It needs more clarity in the form of comment here at-least as the AC=
PIv5.0 is
>> also not so clear or explicit on how to handle this.
>=20
> Yes, I noticed your comments and had a reply for that, after a
> long consideration for this, I would withdraw my previous comments
> before, please refer to the comments below.
>=20
>>
>> Here you are expecting gic->uid =3D acpi_id which is fine, while acp=
i_map_cpuid
>> matches apic_id with cpu_physical_id(which must be MPIDR in ARM{32,6=
4}). The
>> latter imposes restriction that gic->gic_id has to be MPIDR. Does th=
at mean we
>> are imposing restriction on GIC ID to be MPIDR ? If so please docume=
nt it here
>> and please explain the reason behind that choice.
>=20
> On x86 and IA64, APIC/SAPIC ID is the hardware id of the logical
> processor, and UID is just a unique ID to identify the processor in D=
SDT, it
> can be any value, and even can be strings defined in ASL if I remembe=
r
> that correctly.
>=20
OK, but that's not the case on ARM{32,64}. My main concern here is if w=
e don't
make this definitions clear enough, the vendors might produce ACPI tabl=
es with
whatever suits them and we may end up supporting them. Since we are sta=
rting
with clean slate, we can avoid getting into such situations. I will be =
to be
more elaborate this time.

The GIC ID is referred as the local GIC=E2=80=99s hardware ID in ACPIv5=
=2E0.
IIUC, since GICC is per-cpu entry, it has to GIC CPU interface ID.

Now how does it differ from MPIDR ? e.g. ARM TC2(multi cluster system)
	GIC ID		MPIDR			Comment
	0		0x000			CA15_0
	1		0x001			CA15_1
	2		0x100			CA7_0
	3		0x101			CA7_1
	4		0x102			CA7_2

> The processor driver also follows that guidance now, and GIC structur=
e=20
> in MADT
> actually represents a processor (GICC) in the system, so I would let
> gic->gic_id as MPIDR(processor hardware ID) for now to avoid confusio=
ns
> and keep consistency with current ACPI driver.
>=20

Yes that's my worry "... so I would let gic->gic_id as MPIDR(processor =
hardware
ID)" as it contradicts the definition.

1. Yes today GIC CPU ID is enumerated in the code and we don't need it,=
 but
   that doesn't mean the GICC contain whatever(of vendor choice). IMO i=
t should
   be CPU interface ID as per the definition.

2. It's better you post this patch as part of ARM64 port for easier
   understanding on how this gets used as its ARM specific anyway.
   That gives better/complete picture at least for review purposes.

> UID can be any value and it depends on implementation, so it can be M=
PIDR
> also, it will not conflict with GIC ID and can works fine in acpi pro=
cessor
> driver now.
>=20

Agreed UID can be anything, but your initial ARM64 APCI patches were as=
suming it
to be MPIDR. Since MPIDR is not specified anywhere else in the ACPI tab=
les and
it is required for some boot methods like PSCI and may be others, I am =
for
mandating _UID in processor object to be MPIDR. If you agree please mak=
e it
explicit in the comments.

>>
>> I would expect _UID to be MPIDR rather than GIC ID but you may have =
some reasons
>> for this choice.
>=20
> I think they both can be MPIDR for now, is this ok to you?
>=20

Yes for _UID and no for GIC ID, they need to represent the hardware. We=
 can see
how to manage in this in ACPI. Initially I went by the name "cpu_physic=
al_id"
in acpi_map_cpuid but it looks like it's cpuid->apicid mapping on x86. =
So that
should not be problem.

> we can update the code when the new ACPI spec is coming out if there
> is a clear explanation for GIC ID and UID in GIC structures, does thi=
s make
> sense to you?

Yes, that's for next version of ACPI but we don't know that yet. IIUC y=
ou are
trying to implement ACPI port for ARM64 based on ACPIv5.0 through these=
 patches
right ? Hence I pushing you to be more explicit through comments as ACP=
Iv5.0 is
not clear enough.

Regards,
Sudeep


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
