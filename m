From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Acer Aspire 3100
Date: Sun, 3 Feb 2008 17:29:41 -0500
Message-ID: <200802031729.41807.lenb@kernel.org>
References: <fe8041900708061139j3c027f40v9cc4f6ccad1be998@mail.gmail.com> <200802031430.23592.lenb@kernel.org> <1202068109.8866.6.camel@jo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38451 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYBCW3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 17:29:55 -0500
In-Reply-To: <1202068109.8866.6.camel@jo-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jo <bissonjonathan@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 03 February 2008 14:48, jo wrote:
> No problem=20
>=20
> Here it is...
>=20
> Thanks
>=20
> Le dimanche 03 f=C3=A9vrier 2008 =C3=A0 14:30 -0500, Len Brown a =C3=A9=
crit :
> > Thanks for the dmidecode.
> >=20
> > please send me the output from acpidump.
> >=20
> > -Len
> >=20
> > BIOS Information
> > 	Vendor: Acer
> > 	Version: V2.83
> > 	Release Date: 03/21/2007
> > 	Address: 0xE48B0
> > 	Runtime Size: 112464 bytes
> > 	ROM Size: 1024 kB
> > 	Characteristics:
> > ...
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> > 	Manufacturer: Acer           =20
> > 	Product Name: Aspire 3100    =20
> > 	Version: V2.83
> > 	Serial Number: LXAX60Y180720115D31601
> > 	UUID: 6356DBD0-2A29-1BD4-04E3-0016D4D77FFF
> > 	Wake-up Type: Power Switch
> > 	SKU Number: Not Specified
> > 	Family: Not Specified
> >=20
> > Handle 0x0002, DMI type 2, 8 bytes
> > Base Board Information
> > 	Manufacturer: Acer
> > 	Product Name: Navarro
> > 	Version: N/A
> > 	Serial Number: LXAX60Y180720115D31601
>=20

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

Like other Acers...
LINX is written but never read, a NOP
OSTB is compared to >=3D4 only, so the Linux branch above is a NOP
OSTP return value is never referneced, a NOP

However, TPOS is referenced in the ATA _STM and _PS0 method,
wher it is compared equal to 0x40.  OSI(Linux) will disable
that code (whatever it does).

So unless you find the power management of your HDD to be better
with acpi_osi=3DLinux at suspend/resume time,
we'll stick with the default of acpi_osi=3D!Linux for all Acer.

thanks,
-Len


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
