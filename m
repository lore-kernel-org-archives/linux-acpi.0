From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v3] ACPI: D3 states cleanup
Date: Fri, 4 May 2012 13:23:19 +0800
Message-ID: <CAF1ivSb+FWm6LUUA65em7mZSKiG0GSHEUe3VQgZ-TEuTjqoLcQ@mail.gmail.com>
References: <1335143029.4927.45.camel@minggr>
	<20120423015247.GA1119@localhost.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57040 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751301Ab2EDFXU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2012 01:23:20 -0400
In-Reply-To: <20120423015247.GA1119@localhost.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Mon, Apr 23, 2012 at 9:52 AM, Aaron Lu <aaron.lu@amd.com> wrote:
> On Mon, Apr 23, 2012 at 09:03:49AM +0800, Lin Ming wrote:
>> There are two ACPI D3 states defined now:
>> ACPI_STATE_D3 and ACPI_STATE_D3_COLD.
>>
>> But the uses of these states are not clear/correct in some code.
>> For example, some code refer ACPI_STATE_D3 as D3hot and others refer
>> it as D3cold.
>>
>> This patch introduces ACPI_STATE_D3_HOT to refer to ACPI D3hot state=
=2E
>> D3hot is only valid if _PR3 present.
>> And changes ACPI_STATE_D3 to refer to ACPI D3cold state only.
>> Also redefines ACPI_STATE_D3_COLD the same as ACPI_STATE_D3.
>>
>
> Reviewed-by: Aaron Lu <aaron.lu@amd.com>
>
> Thanks,
> Aaron
>
>> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Len,

Will you apply this patch?

Thanks,
Lin Ming

>> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>> ---
>>
>> v3: D3hot is only valid if _PR3 present
>>
>> =A0drivers/acpi/power.c =A0 | =A0 =A02 +-
>> =A0drivers/acpi/scan.c =A0 =A0| =A0 17 +++++++----------
>> =A0drivers/pci/pci-acpi.c | =A0 =A04 ++--
>> =A0include/acpi/actypes.h | =A0 =A07 ++++---
>> =A04 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index 7049a7d..330bb4d 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -631,7 +631,7 @@ int acpi_power_get_inferred_state(struct acpi_de=
vice *device, int *state)
>> =A0 =A0 =A0 =A0* We know a device's inferred power state when all th=
e resources
>> =A0 =A0 =A0 =A0* required for a given D-state are 'on'.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 for (i =3D ACPI_STATE_D0; i < ACPI_STATE_D3; i++) {
>> + =A0 =A0 for (i =3D ACPI_STATE_D0; i < ACPI_STATE_D3_HOT; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D &device->power.states[i].resour=
ces;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list->count < 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 767e2dc..7417267 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -869,7 +869,7 @@ static int acpi_bus_get_power_flags(struct acpi_=
device *device)
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Enumerate supported power management states
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 for (i =3D ACPI_STATE_D0; i <=3D ACPI_STATE_D3; i++) {
>> + =A0 =A0 for (i =3D ACPI_STATE_D0; i <=3D ACPI_STATE_D3_HOT; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_device_power_state *ps =3D &=
device->power.states[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 char object_name[5] =3D { '_', 'P', 'R',=
 '0' + i, '\0' };
>>
>> @@ -884,21 +884,18 @@ static int acpi_bus_get_power_flags(struct acp=
i_device *device)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_bus=
_add_power_resource(ps->resources.handles[j]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* The exist of _PR3 indicates D3Cold supp=
ort */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D ACPI_STATE_D3) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_get_handle=
(device->handle, object_name, &handle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_SUCCESS(status))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->po=
wer.states[ACPI_STATE_D3_COLD].flags.valid =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Evaluate "_PSx" to see if we can do e=
xplicit sets */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 object_name[2] =3D 'S';
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_get_handle(device->handl=
e, object_name, &handle);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_SUCCESS(status))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps->flags.explicit_set =3D=
 1;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* State is valid if we have some power co=
ntrol */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ps->resources.count || ps->flags.expli=
cit_set)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* State is valid if there are means to =
put the device into it.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* D3hot is only valid if _PR3 present.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ps->resources.count ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ps->flags.explicit_set && i < ACP=
I_STATE_D3_HOT))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps->flags.valid =3D 1;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps->power =3D -1; /* Unknown - driver as=
signed */
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 0f150f2..1929c0c 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -200,7 +200,7 @@ static pci_power_t acpi_pci_choose_state(struct =
pci_dev *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCI_D1;
>> =A0 =A0 =A0 case ACPI_STATE_D2:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCI_D2;
>> - =A0 =A0 case ACPI_STATE_D3:
>> + =A0 =A0 case ACPI_STATE_D3_HOT:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCI_D3hot;
>> =A0 =A0 =A0 case ACPI_STATE_D3_COLD:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCI_D3cold;
>> @@ -223,7 +223,7 @@ static int acpi_pci_set_power_state(struct pci_d=
ev *dev, pci_power_t state)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D0] =3D ACPI_STATE_D0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D1] =3D ACPI_STATE_D1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D2] =3D ACPI_STATE_D2,
>> - =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D3hot] =3D ACPI_STATE_D3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D3hot] =3D ACPI_STATE_D3_HOT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PCI_D3cold] =3D ACPI_STATE_D3
>> =A0 =A0 =A0 };
>> =A0 =A0 =A0 int error =3D -EINVAL;
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
>> index eba6604..e8bcc47 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -499,9 +499,10 @@ typedef u64 acpi_integer;
>> =A0#define ACPI_STATE_D0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 0
>> =A0#define ACPI_STATE_D1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 1
>> =A0#define ACPI_STATE_D2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 2
>> -#define ACPI_STATE_D3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 3
>> -#define ACPI_STATE_D3_COLD =A0 =A0 =A0 =A0 =A0 =A0 =A0(u8) 4
>> -#define ACPI_D_STATES_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_STATE_D3=
_COLD
>> +#define ACPI_STATE_D3_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 3
>> +#define ACPI_STATE_D3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 4
>> +#define ACPI_STATE_D3_COLD =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_STATE_D3
>> +#define ACPI_D_STATES_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_STATE_D3
>> =A0#define ACPI_D_STATE_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A05
>>
>> =A0#define ACPI_STATE_C0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u8) 0
>> --
>> 1.7.2.5
>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
