From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - HP Pavilion dv9410us - 30B9
Date: Fri, 18 Jan 2008 23:43:49 -0500
Message-ID: <200801182343.49613.lenb@kernel.org>
References: <553eb53a0710142117u1e82c642pae8d82d7ae2e31b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34839 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761410AbYASEoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:44:03 -0500
In-Reply-To: <553eb53a0710142117u1e82c642pae8d82d7ae2e31b7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fred Bauer <fred.w.bauer@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 15 October 2007 00:17, Fred Bauer wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Hewlett-Packard
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: HP Pavilion dv9000 (GA355UA#ABA=
)
> =A0=A0=A0=A0=A0=A0=A0=A0Version: Rev 1
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: CNF7282S2L
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: 434E4637-3238-3253-324C-001B2469B587
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
> =A0=A0=A0=A0=A0=A0=A0=A0SKU Number: GA355UA#ABA
> =A0=A0=A0=A0=A0=A0=A0=A0Family: 103C_5335KV
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Quanta
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: 30B9

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
