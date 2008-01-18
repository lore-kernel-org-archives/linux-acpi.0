From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (HP pavilion dv5000)
Date: Fri, 18 Jan 2008 18:27:47 -0500
Message-ID: <200801181827.47446.lenb@kernel.org>
References: <4679A480.1020507@cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42625 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762658AbYARX2K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 18:28:10 -0500
In-Reply-To: <4679A480.1020507@cosy.sbg.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Tamme <mtamme@cosy.sbg.ac.at>
Cc: linux-acpi@vger.kernel.org

On Wednesday 20 June 2007 18:04, Martin Tamme wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Hewlett-Packard
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: HP Pavilion dv5000 (RG959EA#ABD=
)
> =A0=A0=A0=A0=A0=A0=A0=A0Version: F.23
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: CND63436SJ
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: CAB23257-2998-11DB-BA5A-0016D43EC990
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
> =A0=A0=A0=A0=A0=A0=A0=A0SKU Number: RG959EA#ABD
> =A0=A0=A0=A0=A0=A0=A0=A0Family: 103C_5335KV
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Hewlett-Packard
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: 30A7

With 2.6.22, did you notice any functional difference with "acpi_osi=3D=
!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=3DLinux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
