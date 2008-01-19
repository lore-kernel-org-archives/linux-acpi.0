From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode reportn - Dialogue Flybook V5
Date: Fri, 18 Jan 2008 22:24:11 -0500
Message-ID: <200801182224.11568.lenb@kernel.org>
References: <756ca4210708160737k3fdca0fat58477488c8e00c45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39571 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760572AbYASDYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:24:25 -0500
In-Reply-To: <756ca4210708160737k3fdca0fat58477488c8e00c45@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian ABTrafco <abtrafco@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 16 August 2007 10:37, Brian ABTrafco wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: Dialogue Technology Corporation
> =A0 =A0 =A0 =A0 Product Name: Flybook V5
> =A0 =A0 =A0 =A0 Version: Not Applicable
> =A0 =A0 =A0 =A0 Serial Number: Not Applicable
> =A0 =A0 =A0 =A0 UUID: 01010101-0101-0101-0101-010101010101
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: Not Specified
> =A0 =A0 =A0 =A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: Dialogue Technology Corporation
> =A0 =A0 =A0 =A0 Product Name: Flybook V5

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
