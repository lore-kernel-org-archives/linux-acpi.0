From: "Joey Lee" <jlee@suse.com>
Subject: Re: [PATCH 1/2] ACPICA: Introduce acpi_os_phys_table_override
 function
Date: Mon, 29 Aug 2011 02:24:25 -0600
Message-ID: <4E5BD9590200002300030F07@novprvlin0050.provo.novell.com>
References: <1314179290-31526-1-git-send-email-trenn@suse.de>
 <1314179290-31526-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from novprvlin0050.provo.novell.com ([137.65.248.33]:50989 "EHLO
	novprvlin0050.provo.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026Ab1H2IYg (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Mon, 29 Aug 2011 04:24:36 -0400
In-Reply-To: <1314179290-31526-2-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: devel@acpica.org, jnelson-suse@jamponi.net, lenb@kernel.org, x86@kernel.org, eric.piel@tremplin-utc.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

=E6=96=BC =E4=B8=89=EF=BC=8C2011-08-24 =E6=96=BC 11:48 +0200=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> Currently it's only possible to feed acpica with virtual
> address for table overriding.
> This patch introduces a function which allows the OS to
> pass physical addresses for table overriding.
>=20
> This is necessary to allow early table overridings of
> arbitrary ACPI tables.
>=20
> An extra flag like ACPI_TABLE_ORIGIN_OVERRIDE is not used,
> because physical address overriding is rather transparent
> (the same way acpica expects to get tables from reserved
> memory BIOS regions which is the normal way).
>=20
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: devel@acpica.org
> CC: linux-acpi@vger.kernel.org
> CC: lenb@kernel.org
> ---

This patch works fine to me on Acer TravelMate 8572.

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thank's
Joey Lee

>  drivers/acpi/acpica/tbinstal.c |   15 +++++++++++++++
>  drivers/acpi/acpica/tbutils.c  |   18 +++++++++++++++++-
>  drivers/acpi/osl.c             |   11 +++++++++++
>  include/acpi/acpiosxf.h        |    4 ++++
>  4 files changed, 47 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbi=
nstal.c
> index 62365f6..b9b9d2a 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -242,6 +242,21 @@ acpi_tb_add_table(struct acpi_table_desc *table_=
desc, u32 *table_index)
>  		table_desc->pointer =3D override_table;
>  		table_desc->length =3D override_table->length;
>  		table_desc->flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
> +	} else {
> +		acpi_physical_address address =3D 0;
> +		u32 table_len =3D 0;
> +		status =3D acpi_os_phys_table_override(table_desc->pointer,
> +						     &address, &table_len);
> +		if (ACPI_SUCCESS(status) && table_len && address) {
> +			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
> +				   "Phys table override, replaced with:",
> +				   table_desc->pointer->signature,
> +				   ACPI_CAST_PTR(void, table_desc->address)));
> +			table_desc->address =3D address;
> +			table_desc->pointer =3D acpi_os_map_memory(address,
> +								 table_len);
> +			table_desc->length =3D table_len;
> +		}
>  	}
> =20
>  	/* Add the table to the global root table list */
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbut=
ils.c
> index 0f2d395..df85afe 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -499,8 +499,24 @@ acpi_tb_install_table(acpi_physical_address addr=
ess,
>  		table_to_install =3D override_table;
>  		flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
>  	} else {
> -		table_to_install =3D mapped_table;
> +		u32 table_len =3D 0;
> +		acpi_physical_address tmp_addr =3D 0;
> +
> +		status =3D acpi_os_phys_table_override(mapped_table,
> +						     &tmp_addr, &table_len);
> +		if (ACPI_SUCCESS(status) && table_len && tmp_addr) {
> +			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
> +				   "Phys table override, replaced with:",
> +				   mapped_table->signature,
> +				   ACPI_CAST_PTR(void, address)));
> +			acpi_os_unmap_memory(mapped_table,
> +					     sizeof(struct acpi_table_header));
> +			mapped_table =3D acpi_os_map_memory(address,
> +					  sizeof(struct acpi_table_header));
> +			address =3D tmp_addr;
> +		}
>  		flags =3D ACPI_TABLE_ORIGIN_MAPPED;
> +		table_to_install =3D mapped_table;
>  	}
> =20
>  	/* Initialize the table entry */
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index fa32f58..49b5fa6 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -522,6 +522,17 @@ acpi_os_table_override(struct acpi_table_header =
* existing_table,
>  	return AE_OK;
>  }
> =20
> +acpi_status
> +acpi_os_phys_table_override(struct acpi_table_header *existing_table=
,
> +			    acpi_physical_address *address, u32 *table_length)
> +{
> +	if (!existing_table)
> +		return AE_BAD_PARAMETER;
> +
> +	table_length =3D 0;
> +	return AE_OK;
> +}
> +
>  static irqreturn_t acpi_irq(int irq, void *dev_id)
>  {
>  	u32 handled;
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 4543b6f..0bef969 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -95,6 +95,10 @@ acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
>  		       struct acpi_table_header **new_table);
> =20
> +acpi_status
> +acpi_os_phys_table_override(struct acpi_table_header *existing_table=
,
> +			    acpi_physical_address *address, u32 *table_length);
> +
>  /*
>   * Spinlock primitives
>   */
> --=20
> 1.7.3.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
