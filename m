From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region
 from Trigger resources
Date: Tue, 22 Aug 2017 14:04:27 +0000
Message-ID: <BN6PR1201MB013138E0E32481E623C35715F8840@BN6PR1201MB0131.namprd12.prod.outlook.com>
References: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>
List-Id: linux-acpi@vger.kernel.org

+EDAC, Boris and Tony for RAS comments.

Any comments from ACPI folks?

Thanks,
Yazen

> -----Original Message-----
> From: Ghannam, Yazen
> Sent: Thursday, August 10, 2017 1:58 PM
> To: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org;
> Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Subject: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region =
from
> Trigger resources
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> ACPI defines a number of instructions to use for triggering errors. Howev=
er
> we are currently removing the address resources from the trigger resource=
s
> for only the WRITE_REGISTER_VALUE instruction. This leads to a resource
> conflict for any other valid instruction.
>=20
> Remove the WRITE_REGISTER_VALUE instruction check to fix the resource
> conflict with other instructions.
>=20
> Fixes: b4e008dc53a3 ("ACPI, APEI, EINJ, Refine the fix of resource confli=
ct")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index ec50c32ea3da..e0f201ea161d 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -281,7 +281,6 @@ static struct acpi_generic_address
> *einj_get_trigger_parameter_region(
>  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
>  	for (i =3D 0; i < trigger_tab->entry_count; i++) {
>  		if (entry->action =3D=3D ACPI_EINJ_TRIGGER_ERROR &&
> -		entry->instruction =3D=3D ACPI_EINJ_WRITE_REGISTER_VALUE &&
>  		entry->register_region.space_id =3D=3D
>  			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
>  		(entry->register_region.address & param2) =3D=3D (param1 &
> param2))
> --
> 2.7.4
