From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v3] ACPI: D3 states cleanup
Date: Fri, 27 Apr 2012 15:48:46 +0800
Message-ID: <CAC=cRTNcvgREd4C-MZfBLa_6F94o=jG9avM0Ooyv3hKhFH4vTg@mail.gmail.com>
References: <1335143029.4927.45.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34266 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab2D0Hsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Apr 2012 03:48:47 -0400
In-Reply-To: <1335143029.4927.45.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, aaron.lu@amd.com

Hi, Ming,

On Mon, Apr 23, 2012 at 9:03 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> There are two ACPI D3 states defined now:
> ACPI_STATE_D3 and ACPI_STATE_D3_COLD.
>
> But the uses of these states are not clear/correct in some code.
> For example, some code refer ACPI_STATE_D3 as D3hot and others refer
> it as D3cold.
>
> This patch introduces ACPI_STATE_D3_HOT to refer to ACPI D3hot state.
> D3hot is only valid if _PR3 present.
> And changes ACPI_STATE_D3 to refer to ACPI D3cold state only.
> Also redefines ACPI_STATE_D3_COLD the same as ACPI_STATE_D3.

The changelog should say why we make the change instead of how we make
the change.  The code itself can tell me how we have done well.  I
prefer to see the description about

- the history of ACPI_STATE_D3, ACPI_STATE_D3_HOT, ACPI_STATE_D3_COLD
- if no _PR3, _PS3 may put device into D3_HOT or D3_COLD, decided by
platform.  But we will assume _PS3 will put device into D3_COLD,
because it is safe to treat device in D3_HOT as D3_COLD, but not in
contrary way.

And I think it will be more clear if we list the power state
supporting under various combination, for example,

- has _PS3, no _PR3
  - Valid states: D3_COLD
  - Set power state
    - D3_COLD: exec _PS3

> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>
> v3: D3hot is only valid if _PR3 present
>
> =C2=A0drivers/acpi/power.c =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/acpi/scan.c =C2=A0 =C2=A0| =C2=A0 17 +++++++----------
> =C2=A0drivers/pci/pci-acpi.c | =C2=A0 =C2=A04 ++--
> =C2=A0include/acpi/actypes.h | =C2=A0 =C2=A07 ++++---
> =C2=A04 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 7049a7d..330bb4d 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -631,7 +631,7 @@ int acpi_power_get_inferred_state(struct acpi_dev=
ice *device, int *state)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We know a device's inferred power state=
 when all the resources
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * required for a given D-state are 'on'.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D ACPI_STATE_D0; i < ACPI_STATE_D3; i=
++) {
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D ACPI_STATE_D0; i < ACPI_STATE_D3_HO=
T; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D &devi=
ce->power.states[i].resources;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list->coun=
t < 1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 767e2dc..7417267 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -869,7 +869,7 @@ static int acpi_bus_get_power_flags(struct acpi_d=
evice *device)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Enumerate supported power management st=
ates
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D ACPI_STATE_D0; i <=3D ACPI_STATE_D3=
; i++) {
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D ACPI_STATE_D0; i <=3D ACPI_STATE_D3=
_HOT; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct acpi_de=
vice_power_state *ps =3D &device->power.states[i];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char object_na=
me[5] =3D { '_', 'P', 'R', '0' + i, '\0' };
>
> @@ -884,21 +884,18 @@ static int acpi_bus_get_power_flags(struct acpi=
_device *device)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_bus_add_power_resource(p=
s->resources.handles[j]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The exist of _P=
R3 indicates D3Cold support */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D ACPI_=
STATE_D3) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 status =3D acpi_get_handle(device->handle, object_name, &handle=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ACPI_SUCCESS(status))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3_=
COLD].flags.valid =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Evaluate "_=
PSx" to see if we can do explicit sets */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_name[2]=
 =3D 'S';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D acp=
i_get_handle(device->handle, object_name, &handle);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ACPI_SUCCE=
SS(status))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ps->flags.explicit_set =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* State is valid =
if we have some power control */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ps->resources.=
count || ps->flags.explicit_set)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* State is v=
alid if there are means to put the device into it.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* D3hot is o=
nly valid if _PR3 present.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ps->resources.=
count ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ps-=
>flags.explicit_set && i < ACPI_STATE_D3_HOT))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ps->flags.valid =3D 1;

I think we should add some comments here about why we do that.  Why
D3_HOT is not valid if only _PS3 presents.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ps->power =3D =
-1; /* Unknown - driver assigned */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0f150f2..1929c0c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -200,7 +200,7 @@ static pci_power_t acpi_pci_choose_state(struct p=
ci_dev *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PCI_D1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACPI_STATE_D2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PCI_D2;
> - =C2=A0 =C2=A0 =C2=A0 case ACPI_STATE_D3:
> + =C2=A0 =C2=A0 =C2=A0 case ACPI_STATE_D3_HOT:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PCI_D3h=
ot;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACPI_STATE_D3_COLD:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PCI_D3c=
old;
> @@ -223,7 +223,7 @@ static int acpi_pci_set_power_state(struct pci_de=
v *dev, pci_power_t state)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[PCI_D0] =3D A=
CPI_STATE_D0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[PCI_D1] =3D A=
CPI_STATE_D1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[PCI_D2] =3D A=
CPI_STATE_D2,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3hot] =3D AC=
PI_STATE_D3,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3hot] =3D AC=
PI_STATE_D3_HOT,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[PCI_D3cold] =3D=
 ACPI_STATE_D3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int error =3D -EINVAL;
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index eba6604..e8bcc47 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -499,9 +499,10 @@ typedef u64 acpi_integer;
> =C2=A0#define ACPI_STATE_D0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (u8) 0
> =C2=A0#define ACPI_STATE_D1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (u8) 1
> =C2=A0#define ACPI_STATE_D2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (u8) 2
> -#define ACPI_STATE_D3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (u8) 3
> -#define ACPI_STATE_D3_COLD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(u8) 4
> -#define ACPI_D_STATES_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ACPI_STATE_D3_COLD
> +#define ACPI_STATE_D3_HOT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (u8) 3
> +#define ACPI_STATE_D3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (u8) 4
> +#define ACPI_STATE_D3_COLD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ACPI_STATE_D3
> +#define ACPI_D_STATES_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ACPI_STATE_D3
> =C2=A0#define ACPI_D_STATE_COUNT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05
>
> =C2=A0#define ACPI_STATE_C0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (u8) 0

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
