From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for acer aspire 5052 laptop
Date: Sun, 20 Jan 2008 18:50:21 -0500
Message-ID: <200801201850.21464.lenb@kernel.org>
References: <d8d1b9d10801190430r106a5fa6w94cb5191061201d4@mail.gmail.com> <d8d1b9d10801190658g2ef41ab8k7a61e258c03dc28d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48612 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949AbYATXuf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jan 2008 18:50:35 -0500
In-Reply-To: <d8d1b9d10801190658g2ef41ab8k7a61e258c03dc28d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artem Goncharov <artem.goncharov@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 09:58, Artem Goncharov wrote:
> Hi. For my laptop using acpi_osi=3DLinux seems to be working better, =
but
> I'm not completely sure in that.
>=20
>=20
> What I don't like is the following cut from /var/log/messages
>=20
> >Jan 19 14:19:09 blending kernel: PCI: MSI quirk detected. MSI deacti=
vated.
> >Jan 19 14:19:09 blending kernel: assign_interrupt_mode Found MSI cap=
ability
> >Jan 19 14:19:10 blending kernel:last message repeated 3 times
> >Jan 19 14:19:09 blending kernel: pci_hotplug: PCI Hot Plug PCI Core
> version: 0.5
> >Jan 19 14:19:09 blending kernel: ACPI Exception
> (processor_core-0819): AE_NOT_FOUND, Processor Device is not present
> [20070126]

if this one happens with latest 2.6.24-rc,
then please file a bug and attch your acpidump output here:
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI

>=20
> That is true in both cases (with and without acpi_osi=3DLinux option.
>=20
>=20
> However I'm attaching dmidecode for my laptop.
>=20
>=20
>=20
> P.S.
> >Jan 19 14:19:09 blending kernel: ACPI: System BIOS is requesting _OS=
I(Linux)
>=20
>=20
>=20
> # dmidecode 2.7
> SMBIOS 2.4 present.
> 35 structures occupying 1106 bytes.
> Table at 0x000F1790.
>=20
> Handle 0x0000, DMI type 0, 24 bytes.
> BIOS Information
> =A0 =A0 Vendor: Acer
> =A0 =A0 Version: v1.3303
> =A0 =A0 Release Date: 01/23/07
> =A0 =A0 Address: 0xE5230
> =A0 =A0 Runtime Size: 110032 bytes
> =A0 =A0 ROM Size: 1024 kB
> =A0 =A0 Characteristics:
=2E..
>=20
> Handle 0x0001, DMI type 1, 27 bytes.
> System Information
> =A0 =A0 Manufacturer: Acer, inc.
> =A0 =A0 Product Name: Aspire 5050
> =A0 =A0 Version: Not Applicable
> =A0 =A0 Serial Number: LXAV40Y0867120E60B2502
> =A0 =A0 UUID: C09465D5-4F87-D811-BCCB-001B240E64F7
> =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 SKU Number: Not Specified
> =A0 =A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
> =A0 =A0 Manufacturer: Acer, Inc.
> =A0 =A0 Product Name: Prespa M

Please capture the output from acpidump and send that to me.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
