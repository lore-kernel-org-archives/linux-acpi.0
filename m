From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode request in kern.log  - toshiba satellite A200
Date: Sat, 19 Jan 2008 00:13:35 -0500
Message-ID: <200801190013.35973.lenb@kernel.org>
References: <6527b60f0711081808i46c32e2bk8a50e43bc379b660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53643 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYASFNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 00:13:51 -0500
In-Reply-To: <6527b60f0711081808i46c32e2bk8a50e43bc379b660@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian <brwahl@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 08 November 2007 21:08, Brian wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: TOSHIBA
> =A0 =A0 =A0 =A0 Product Name: Satellite A200
> =A0 =A0 =A0 =A0 Version: PSAE0C-AH308C
> =A0 =A0 =A0 =A0 Serial Number: 67481368K
> =A0 =A0 =A0 =A0 UUID: 174D3746-1B7F-11DC-8D90-001B38146262
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: 012345678912345678912345678
> =A0 =A0 =A0 =A0 Family: ABCDEFGHIJKLMNOPQRSTUVWXYZ
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: TOSHIBA
> =A0 =A0 =A0 =A0 Product Name: ISKAE

Thanks for the dmidecode output.

Do you notice any functional difference when booting with...

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

=2E..in particular, please check sound, wifi, and hibernate.

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
