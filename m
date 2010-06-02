From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPICA Release 20100528 linuxized patches
Date: Wed, 02 Jun 2010 13:37:56 +0400
Message-ID: <4C062674.5020509@suse.de>
References: <1275296862.7586.64.camel@minggr.sh.intel.com> <1275444837.3431.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:44200 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab0FBJiA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 05:38:00 -0400
In-Reply-To: <1275444837.3431.11.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Ming,

In this case please revert whole patch #11, there is no reason to inclu=
de it without this piece.

Regards,
Alex.

02.06.2010 06:13, Lin Ming =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi, Len
>=20
> It's reported that patch 11 has a bug, see
> http://www.acpica.org/bugzilla/show_bug.cgi?id=3D863
>=20
> Please apply this new version of mbox, the only difference is as belo=
w.
>=20
> Alexey,=20
>=20
> The reporter confirmed that removing the "Handle the simple case here=
"
> code fixes bug 863.
>=20
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfl=
dio.c
> index 38293fd..00a444f 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -698,15 +698,7 @@ acpi_ex_extract_from_field(union acpi_operand_ob=
ject *obj_desc,
>  	ACPI_MEMSET(buffer, 0, buffer_length);
>  	access_bit_width =3D ACPI_MUL_8(obj_desc->common_field.access_byte_=
width);
> =20
> -	/* Handle the simple case here */
> -
> -	if ((obj_desc->common_field.start_field_bit_offset =3D=3D 0) &&
> -	    (obj_desc->common_field.bit_length =3D=3D access_bit_width)) {
> -		status =3D acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
> -		return_ACPI_STATUS(status);
> -	}
> -
> /* TBD: Move to common setup code */
> =20
>  	/* Field algorithm is limited to sizeof(u64), truncate if needed */
> =20
>=20
>=20
>=20
> On Mon, 2010-05-31 at 17:07 +0800, Lin Ming wrote:
>> Hi, Len
>>
>> ACPICA Release 20100528 linuxized patches attached.
>> Applied cleanly on top of linus tree(67a3e12).
>>
>> [PATCH 01/14] ACPICA: Add comment: _BCL cannot be sorted on the fly
>> [PATCH 02/14] ACPICA: Fix namestring associated with AE_NO_HANDLER e=
xception
>> [PATCH 03/14] ACPICA: iASL/Core: Add support for _WDG/_WED MS method=
s
>> [PATCH 04/14] ACPICA: Expand initialization counters to 32 bits
>> [PATCH 05/14] ACPICA: Limit maximum time for Sleep() operator
>> [PATCH 06/14] ACPICA: Core: Replace all %d format specifiers with %u=
 (unsigned)
>> [PATCH 07/14] ACPICA: Expand device initialization counters to 32 bi=
ts
>> [PATCH 08/14] ACPICA: Truncate I/O addresses to 16 bits for Windows =
compatibility
>> [PATCH 09/14] ACPICA: Performance enhancement for namespace search a=
nd access
>> [PATCH 10/14] ACPICA: Update flags for operand object
>> [PATCH 11/14] ACPICA: Enable multi-byte EC transfers
>> [PATCH 12/14] ACPICA: Optimization: Reduce the number of namespace w=
alks
>> [PATCH 13/14] ACPICA: Add signatures for undefined tables: ATKG, GSC=
I, IEIT
>> [PATCH 14/14] ACPICA: Update version to 20100528
>>
>> Lin Ming

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
