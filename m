From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for amilo m1425
Date: Sat, 19 Jan 2008 00:09:24 -0500
Message-ID: <200801190009.24509.lenb@kernel.org>
References: <1eca66a80711041110r6ae7ad12wb20c118839ad1767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42486 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbYASFJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 00:09:40 -0500
In-Reply-To: <1eca66a80711041110r6ae7ad12wb20c118839ad1767@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Iacopo Masi <iacopo.masi.list@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 04 November 2007 14:10, Iacopo Masi wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: FUJITSU SIEMENS
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: Amilo M1425
> =A0=A0=A0=A0=A0=A0=A0=A0Version: To Be Filled By O.E.M.
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: To Be Filled By O.E.M.
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: 4082AA1C-BEB9-D911-ADD3-D6DC313E4FEF
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: To be filled by O.E.M.

(is this a production BIOS?)


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
