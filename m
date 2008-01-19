From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - HP dv6000 30B8
Date: Sat, 19 Jan 2008 00:11:17 -0500
Message-ID: <200801190011.17684.lenb@kernel.org>
References: <134ef2900711041501s4c753808hba0e253d9e0785ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53585 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbYASFLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 00:11:31 -0500
In-Reply-To: <134ef2900711041501s4c753808hba0e253d9e0785ff@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dimitri Michaux <dimitri.michaux@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 04 November 2007 18:01, Dimitri Michaux wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: Hewlett-Packard
> =A0 =A0 =A0 =A0 Product Name:
> =A0 =A0 =A0 =A0 Version: Rev 1
> =A0 =A0 =A0 =A0 Serial Number:
> =A0 =A0 =A0 =A0 UUID: Not Settable
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number:
> =A0 =A0 =A0 =A0 Family: 103C_5335KV
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: Quanta
> =A0 =A0 =A0 =A0 Product Name: 30B8

Is this a production BIOS?
It is unusual to have no "Product Name" above.
What name is on the sticker on the box -- something
from the Pavilion dv6000 family?

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
