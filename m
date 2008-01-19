From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Sony VGN-SZ38GP_C
Date: Fri, 18 Jan 2008 22:59:03 -0500
Message-ID: <200801182259.03692.lenb@kernel.org>
References: <87ir6eyjt0.fsf@c0nc3pt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54169 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758284AbYASD7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:59:21 -0500
In-Reply-To: <87ir6eyjt0.fsf@c0nc3pt.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Di Marco <dmr@c0nc3pt.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 13 September 2007 05:51, Alessandro Di Marco wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Sony Corporation
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: VGN-SZ38GP_C
> =A0=A0=A0=A0=A0=A0=A0=A0Version: J0020Y9W
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: 28247270-7003707
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: CEBBB8E0-5B3C-11D9-8796-0013A98B94A4
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
>=20
> Handle 0x0002, DMI type 2, 10 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Sony Corporation
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: VAIO =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0

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
