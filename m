From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPICA Release 20100528 linuxized patches
Date: Wed, 02 Jun 2010 14:06:45 +0400
Message-ID: <4C062D35.3010900@suse.de>
References: <1275296862.7586.64.camel@minggr.sh.intel.com> <1275444837.3431.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:56395 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0FBKGr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 06:06:47 -0400
In-Reply-To: <1275444837.3431.11.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Ming,

02.06.2010 06:13, Lin Ming =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
I would guess we need to zero the whole buffer here... Buffer length is=
 sizeof(ACPI_INTEGER), we read only 8 bits,
everything else is packed with garbage.
> -		status =3D acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
> -		return_ACPI_STATUS(status);
> -	}
> -
Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
