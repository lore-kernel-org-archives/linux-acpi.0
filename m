From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Sony Vaio SZ650N
Date: Fri, 18 Jan 2008 23:44:31 -0500
Message-ID: <200801182344.31282.lenb@kernel.org>
References: <47191223.1020405@citycable.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34855 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762516AbYASEoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:44:46 -0500
In-Reply-To: <47191223.1020405@citycable.ch>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "nothingness@citycable.ch" <nothingness@citycable.ch>
Cc: linux-acpi@vger.kernel.org

On Friday 19 October 2007 16:22, nothingness@citycable.ch wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: Sony Corporation
> =A0 =A0 =A0 =A0 Product Name: VGN-SZ650N
> =A0 =A0 =A0 =A0 Version: J002QRYN
> =A0 =A0 =A0 =A0 Serial Number: 28205633-3023572
> =A0 =A0 =A0 =A0 UUID: A04662C0-0EBE-11DC-88DD-0013A9FFC26B
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: N/A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0=20
> =A0 =A0 =A0 =A0 Family: N/A =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=20
>=20
> Handle 0x0002, DMI type 2, 9 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: Sony Corporation
> =A0 =A0 =A0 =A0 Product Name: VAIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0

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
