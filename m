From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - FSC AMILO Pi 1556
Date: Fri, 18 Jan 2008 23:33:33 -0500
Message-ID: <200801182333.33390.lenb@kernel.org>
References: <843771192296565@webmail31.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60319 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761839AbYASEdq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:33:46 -0500
In-Reply-To: <843771192296565@webmail31.yandex.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Virus Q <qvirus@yandex.ru>
Cc: linux-acpi@vger.kernel.org

On Saturday 13 October 2007 13:29, Virus Q wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: AMILO Pi 1556
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: Not Applicable
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 5311A8AF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 00278868-CD63-0010-9AC8-B203A3B3CC3=
2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: AMILO Pi 1556

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
