From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 3/5] ACPI / processor: Introduce map_gic_id() to get
 apic id from MADT or _MAT method
Date: Thu, 20 Feb 2014 11:59:37 +0800
Message-ID: <53057DA9.3010307@linaro.org>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <1392740638-2479-4-git-send-email-hanjun.guo@linaro.org> <5304C0C4.3080601@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44711 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaBTD7p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Feb 2014 22:59:45 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so1268093pdj.16
        for <linux-acpi@vger.kernel.org>; Wed, 19 Feb 2014 19:59:45 -0800 (PST)
In-Reply-To: <5304C0C4.3080601@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lan Tianyu <tianyu.lan@intel.com>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Joe Perches <joe@perches.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Sudeep,

Thanks for your comments, please refer to the replies below. :)

On 2014=E5=B9=B402=E6=9C=8819=E6=97=A5 22:33, Sudeep Holla wrote:
> Hi Hanjun,
>
> On 18/02/14 16:23, Hanjun Guo wrote:
>> Get apic id from MADT or _MAT method is not implemented on arm/arm64=
,
>> and ACPI 5.0 introduces GIC Structure for it, so this patch introduc=
es
>> map_gic_id() to get apic id followed the ACPI 5.0 spec.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/processor_core.c |   26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_=
core.c
>> index 4dcf776..d316d9b 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -71,6 +71,27 @@ static int map_lsapic_id(struct acpi_subtable_hea=
der *entry,
>>   	return 0;
>>   }
>>  =20
>> +static int map_gic_id(struct acpi_subtable_header *entry,
>> +		int device_declaration, u32 acpi_id, int *apic_id)
>> +{
>> +	struct acpi_madt_generic_interrupt *gic =3D
>> +		(struct acpi_madt_generic_interrupt *)entry;
>> +
>> +	if (!(gic->flags & ACPI_MADT_ENABLED))
>> +		return -ENODEV;
>> +
>> +	/* In the GIC interrupt model, logical processors are
>> +	 * required to have a Processor Device object in the DSDT,
>> +	 * so we should check device_declaration here
>> +	 */
>> +	if (device_declaration && (gic->uid =3D=3D acpi_id)) {
>> +		*apic_id =3D gic->gic_id;
> I have mentioned this earlier, it's not clear yet to me how does this=
 work ?
> It needs more clarity in the form of comment here at-least as the ACP=
Iv5.0 is
> also not so clear or explicit on how to handle this.

Yes, I noticed your comments and had a reply for that, after a
long consideration for this, I would withdraw my previous comments
before, please refer to the comments below.

>
> Here you are expecting gic->uid =3D acpi_id which is fine, while acpi=
_map_cpuid
> matches apic_id with cpu_physical_id(which must be MPIDR in ARM{32,64=
}). The
> latter imposes restriction that gic->gic_id has to be MPIDR. Does tha=
t mean we
> are imposing restriction on GIC ID to be MPIDR ? If so please documen=
t it here
> and please explain the reason behind that choice.

On x86 and IA64, APIC/SAPIC ID is the hardware id of the logical
processor, and UID is just a unique ID to identify the processor in DSD=
T, it
can be any value, and even can be strings defined in ASL if I remember
that correctly.

The processor driver also follows that guidance now, and GIC structure=20
in MADT
actually represents a processor (GICC) in the system, so I would let
gic->gic_id as MPIDR(processor hardware ID) for now to avoid confusions
and keep consistency with current ACPI driver.

UID can be any value and it depends on implementation, so it can be MPI=
DR
also, it will not conflict with GIC ID and can works fine in acpi proce=
ssor
driver now.

>
> I would expect _UID to be MPIDR rather than GIC ID but you may have s=
ome reasons
> for this choice.

I think they both can be MPIDR for now, is this ok to you?

we can update the code when the new ACPI spec is coming out if there
is a clear explanation for GIC ID and UID in GIC structures, does this =
make
sense to you?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
