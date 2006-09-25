From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [12/12] acpi: set fake hid
Date: Mon, 25 Sep 2006 17:58:22 +0800
Message-ID: <1159178302.5351.27.camel@localhost.localdomain>
References: <1158918880.11985.88.camel@localhost.localdomain>
	 <4513D02A.8020106@kolumbus.fi>
	 <1159176682.5351.11.camel@localhost.localdomain>
	 <4517A40A.9090106@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26405 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750863AbWIYJ4m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 05:56:42 -0400
In-Reply-To: <4517A40A.9090106@kolumbus.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com

On Mon, 2006-09-25 at 12:40 +0300, Mika Penttil=C3=A4 wrote:
> Zhang Rui wrote:
> > On Fri, 2006-09-22 at 14:59 +0300, Mika Penttil=C3=A4 wrote:=20
> >  =20
> >> +static int acpi_pci_bridge_match(struct acpi_device *device)
> >> +{
> >> +       acpi_status status;
> >> +       acpi_handle handle;
> >> +
> >> +       /* pci bridge has _PRT but isn't PNP0A03 */
> >> +       status =3D acpi_get_handle(device->handle, METHOD_NAME__PR=
T, &handle);
> >> +       if (ACPI_FAILURE(status))
> >> +               return -ENODEV;
> >> +       if (!acpi_match_ids(device, "PNP0A03"))
> >> +               return -ENODEV;
acpi_pci_bridge_match will return 0, if we found a
pci-pci bridge. Because it has a PRT table and its
HID is _NOT_ "PNP0A03".
> >> +       return 0;
> >> +}
> >> +
> >>
> >>
> >> You seem to handle pci-pci bridge here incorrectly (returns -ENODE=
V from match to PNP0A03)
> >>
> >>    =20
> > Is there any pci-pci bridge that has a _HID of "PNP0A03"?
> >
> > thanks,
> > --Rui
> >
> >  =20
> Don't know, but isn't the purpose here for acpi_pci_bridge_match() to=
=20
> match pci-pci bridges also? They won't just because they aren't PNP0A=
03.
>=20
> --Mika
According to the ACPI spec, only ACPI PCI Root Bridge has a _HID of
"PNP0A03".


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
