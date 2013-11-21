From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] sysfs, acpi, tables: Set file size for each ACPI table
Date: Thu, 21 Nov 2013 11:48:06 +0800
Message-ID: <1385005686.2379.29.camel@rzhang-lenovo>
References: <528B2757.6010406@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19716 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab3KUDqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 22:46:52 -0500
In-Reply-To: <528B2757.6010406@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On =E4=BA=8C, 2013-11-19 at 17:54 +0900, HATAYAMA Daisuke wrote:
> Currently, each of the ACPI tables exported from
> /sys/firmware/acpi/tables is of zero size:
>=20
> $ LANG=3DC ls -ld /sys/firmware/acpi/tables/*
> -r-------- 1 root root 0 Nov 19 09:48 /sys/firmware/acpi/tables/APIC
> -r-------- 1 root root 0 Nov 19 09:48 /sys/firmware/acpi/tables/BOOT
> -r-------- 1 root root 0 Nov 19 14:25 /sys/firmware/acpi/tables/DSDT
> -r-------- 1 root root 0 Nov 19 14:25 /sys/firmware/acpi/tables/FACP
> -r-------- 1 root root 0 Nov 19 14:25 /sys/firmware/acpi/tables/FACS
> -r-------- 1 root root 0 Nov 19 14:25 /sys/firmware/acpi/tables/MCFG
> -r-------- 1 root root 0 Nov 19 14:25 /sys/firmware/acpi/tables/SRAT
> drwxr-xr-x 2 root root 0 Nov 19 09:48 /sys/firmware/acpi/tables/dynam=
ic/
>=20
> due to which, user-land tools fail reading each table. For example:
>=20
> $ acpidump -f /sys/firmware/acpi/tables/SRAT
> Could not get input file size: /sys/firmware/acpi/tables/SRAT
>=20
> To deal with the issue, this patch assigns size of each ACPI table to
> the corresponding sysfs file.
>=20
> $ LANG=3DC ls -hld /sys/firmware/acpi/tables/*
> -r-------- 1 root root  94 Nov 19 16:45 /sys/firmware/acpi/tables/API=
C
> -r-------- 1 root root  40 Nov 19 16:45 /sys/firmware/acpi/tables/BOO=
T
> -r-------- 1 root root 58K Nov 19 16:55 /sys/firmware/acpi/tables/DSD=
T
> -r-------- 1 root root 244 Nov 19 16:55 /sys/firmware/acpi/tables/FAC=
P
> -r-------- 1 root root  64 Nov 19 16:55 /sys/firmware/acpi/tables/FAC=
S
> -r-------- 1 root root  60 Nov 19 16:55 /sys/firmware/acpi/tables/MCF=
G
> -r-------- 1 root root 168 Nov 19 16:45 /sys/firmware/acpi/tables/SRA=
T
> drwxr-xr-x 2 root root   0 Nov 19 16:55 /sys/firmware/acpi/tables/dyn=
amic/
>=20
> Then, user-land tools work well like:
>=20
> $ acpidump -f /sys/firmware/acpi/tables/SRAT
> SRAT @ 0x0000000000000000
>   0000: 53 52 41 54 A8 00 00 00 02 65 56 4D 57 41 52 45  SRAT.....eVM=
WARE
>   0010: 4D 45 4D 50 4C 55 47 20 00 00 04 06 56 4D 57 20  MEMPLUG ....=
VMW
>   0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ............=
=2E...
>   0030: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .(..........=
=2E...
>   0040: 00 00 0A 00 00 00 00 00 00 00 00 00 01 00 00 00  ............=
=2E...
>   0050: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  .........(..=
=2E...
>   0060: 00 00 10 00 00 00 00 00 00 00 F0 BF 00 00 00 00  ............=
=2E...
>   0070: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ............=
=2E...
>   0080: 01 28 00 00 00 00 00 00 00 00 00 00 01 00 00 00  .(..........=
=2E...
>   0090: 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00 00  ...@........=
=2E...
>   00A0: 00 00 00 00 00 00 00 00                          ........
>=20
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Nice catch!

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  drivers/acpi/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 05306a5..095ff1f 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -309,7 +309,7 @@ static void acpi_table_attr_init(struct acpi_tabl=
e_attr *table_attr,
>  		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
>  			table_attr->instance);
> =20
> -	table_attr->attr.size =3D 0;
> +	table_attr->attr.size =3D table_header->length;
>  	table_attr->attr.read =3D acpi_table_show;
>  	table_attr->attr.attr.name =3D table_attr->name;
>  	table_attr->attr.attr.mode =3D 0400;
> --=20
> 1.8.3.1
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
