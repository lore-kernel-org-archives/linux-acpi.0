From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Compal HEL80 Notebook
Date: Fri, 18 Jan 2008 23:20:14 -0500
Message-ID: <200801182320.15049.lenb@kernel.org>
References: <470746EB.2000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40718 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761656AbYASEU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:20:29 -0500
In-Reply-To: <470746EB.2000707@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jochen Kemnade <kemnade@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 06 October 2007 04:27, Jochen Kemnade wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: COMPAL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: HEL80C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 2056773503276
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 980A3401-5238-11DB-9E1A-0016D45584F=
7
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number:
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Intel
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: COMPAL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: HEL8X

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
