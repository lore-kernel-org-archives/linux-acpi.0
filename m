From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of Acer Travelmate 5520 with Turion 64 x2
Date: Fri, 18 Jan 2008 19:06:18 -0500
Message-ID: <200801181906.18164.lenb@kernel.org>
References: <20070720114448.GA25463@szyszka.in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46992 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454AbYASAGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 19:06:43 -0500
In-Reply-To: <20070720114448.GA25463@szyszka.in.waw.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zbyszek Szmek <zbyszek@in.waw.pl>
Cc: linux-acpi@vger.kernel.org

On Friday 20 July 2007 07:44, Zbyszek Szmek wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Acer
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: TravelMate 5520
> =A0=A0=A0=A0=A0=A0=A0=A0Version: 0100 =A0 =A0 =A0 =A0 =A0=20
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: LXTKT0X03472505E342000
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: 92832300-1FE7-11DC-AD33-93244F26716C
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
> =A0=A0=A0=A0=A0=A0=A0=A0SKU Number: Not Specified
> =A0=A0=A0=A0=A0=A0=A0=A0Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Acer
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: TravelMate 5520

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
