From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Re: laptop and suspend/hibernate woes)
Date: Fri, 18 Jan 2008 16:24:06 -0500
Message-ID: <200801181624.06247.lenb@kernel.org>
References: <476EFF6E.1010108@easystreet.net> <20071224012040.GU4925@syrinxpc.com> <47752FD2.9050108@easystreet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59756 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306AbYARVYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 16:24:19 -0500
In-Reply-To: <47752FD2.9050108@easystreet.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Shisei Niski <joeniski@easystreet.net>
Cc: linux-acpi@vger.kernel.org

> ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not foun=
d.
> <this one disturbs me - i found a few references to it, but nothing t=
hat
> adresses it directly>

Ignore this, it is due to a bogus intramfs DSDT override
patch that Ubuntu adds to their product.

> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=3D!Linux"
> <adding "acpi_osi=3D!Linux" to the command line made no difference, a=
nd
> these messages still appeared>

okay good to know.

> On Friday 28 December 2007 12:18, Joe Shisei Niski wrote:=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Clevo C=
o.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: M570RU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: CLEVO:M570RU=
-1.00.04SL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Serial Number: Not Ap=
plicable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID: 0090F560-EE55-0=
000-0000-000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Wake-up Type: Power S=
witch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SKU Number: Not Speci=
fied
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Family: Not Specified


Thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
