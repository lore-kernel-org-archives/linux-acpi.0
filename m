From: Len Brown <lenb@kernel.org>
Subject: Re: Lenovo 3000 V100 dmidecode
Date: Sun, 10 Feb 2008 21:50:52 -0500
Message-ID: <200802102150.52454.lenb@kernel.org>
References: <20070731093750.77657b2f@medusa.mythic.magic> <200801182119.35645.lenb@kernel.org> <20080210132747.37d9cc8b@griffin.mythic.magic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58453 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbYBKCvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Feb 2008 21:51:08 -0500
In-Reply-To: <20080210132747.37d9cc8b@griffin.mythic.magic>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ktabic <ktabic@ktabic.co.uk>
Cc: linux-acpi@vger.kernel.org

On Sunday 10 February 2008 08:27, ktabic wrote:
> On Fri, 18 Jan 2008 21:19:35 -0500, the sky darkened, lightning flash=
ed and the voice of Len Brown spake thus:
>=20
> > On Tuesday 31 July 2007 04:37, ktabic wrote:
> > > BIOS Information
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Vendor: LENOVO
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: 62ETC1WW=
 (1.11 )
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Release Date: 04/=
20/2007
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Address: 0xE8600
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Runtime Size: 967=
68 bytes
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ROM Size: 1024 kB
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Characteristics:
> > ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIOS Revision: 1.=
11
> > >=20
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: LEN=
OVO
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: 076=
35CG
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: LENOVO30=
00 V100
> >=20
> > Thanks for the dmidecode output.
> >=20
> > Do you notice any functional difference when booting with
> >=20
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >=20
> > Also, please send me the output from acpidump.
> >=20

Thanks for the acpidump.
OSI(Linux) is a NOP on the LENOVO3000 V100.

cheers,
-Len


                If (\_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }

                If (\_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
=2E..
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
