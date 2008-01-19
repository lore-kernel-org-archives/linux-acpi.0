From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Compal HEL8X
Date: Sat, 19 Jan 2008 00:05:38 -0500
Message-ID: <200801190005.38246.lenb@kernel.org>
References: <620719eb0711040521v5503be45y1c06d725fa348b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45851 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbYASFFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 00:05:52 -0500
In-Reply-To: <620719eb0711040521v5503be45y1c06d725fa348b87@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josue Resende <josue.resende@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 04 November 2007 08:21, Josue Resende wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: COMPAL
> =A0 =A0 =A0 =A0 Product Name: HEL81I
> =A0 =A0 =A0 =A0 Version: *
> =A0 =A0 =A0 =A0 Serial Number: 2057336701224
> =A0 =A0 =A0 =A0 UUID: 5D703279-5869-11DB-9D7E-0016D457FA87
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: Not Specified
> =A0 =A0 =A0 =A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: COMPAL
> =A0 =A0 =A0 =A0 Product Name: HEL8X

Thanks for the dmidecode output.

Do you notice any functional difference when booting with...

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

=2E..in particular, please check sound and wifi.

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
