From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output for my laptop
Date: Fri, 18 Jan 2008 18:43:04 -0500
Message-ID: <200801181843.04957.lenb@kernel.org>
References: <200707100947.58962.lourdas_v@yahoo.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57021 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbYARXnS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 18:43:18 -0500
In-Reply-To: <200707100947.58962.lourdas_v@yahoo.gr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasileios Lourdas <lourdas_v@yahoo.gr>
Cc: linux-acpi@vger.kernel.org

On Tuesday 10 July 2007 02:47, Vasileios Lourdas wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: FUJITSU SIEMENS
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: AMILO Pi 1536
> =A0=A0=A0=A0=A0=A0=A0=A0Version: Not Applicable
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: 53102817
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: 00659C5C-CD63-0010-A350-E07A70B44E78
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
> =A0=A0=A0=A0=A0=A0=A0=A0SKU Number: Not Specified
> =A0=A0=A0=A0=A0=A0=A0=A0Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: FUJITSU SIEMENS
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: AMILO Pi 1536

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
