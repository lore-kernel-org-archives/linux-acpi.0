From: Len Brown <lenb@kernel.org>
Subject: Re: Lenovo 3000 V100 dmidecode
Date: Fri, 18 Jan 2008 21:19:35 -0500
Message-ID: <200801182119.35645.lenb@kernel.org>
References: <20070731093750.77657b2f@medusa.mythic.magic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57558 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757005AbYASCTw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 21:19:52 -0500
In-Reply-To: <20070731093750.77657b2f@medusa.mythic.magic>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ktabic <ktabic@ktabic.co.uk>
Cc: linux-acpi@vger.kernel.org

On Tuesday 31 July 2007 04:37, ktabic wrote:
> BIOS Information
> =A0=A0=A0=A0=A0=A0=A0=A0Vendor: LENOVO
> =A0=A0=A0=A0=A0=A0=A0=A0Version: 62ETC1WW (1.11 )
> =A0=A0=A0=A0=A0=A0=A0=A0Release Date: 04/20/2007
> =A0=A0=A0=A0=A0=A0=A0=A0Address: 0xE8600
> =A0=A0=A0=A0=A0=A0=A0=A0Runtime Size: 96768 bytes
> =A0=A0=A0=A0=A0=A0=A0=A0ROM Size: 1024 kB
> =A0=A0=A0=A0=A0=A0=A0=A0Characteristics:
=2E..
> =A0=A0=A0=A0=A0=A0=A0=A0BIOS Revision: 1.11
>=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: LENOVO
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: 07635CG
> =A0=A0=A0=A0=A0=A0=A0=A0Version: LENOVO3000 V100

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
