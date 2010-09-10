From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Thu, 09 Sep 2010 22:53:28 -0600
Message-ID: <4C8A4668020000230002021A@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@suse.de
Cc: mjg@redhat.com, mjg59@srcf.ucam.org, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Greg,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2010-09-01 =E6=96=BC 08:00 -0700=EF=BC=8CGr=
eg KH =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wed, Sep 01, 2010 at 05:08:39PM +0800, Lee, Chun-Yi wrote:
> > +static struct pci_device_id pciidlist[] =3D {
> > +	{0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8108}, \
> > +	{0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_PSB_8109}, \
> > +	{0, 0, 0}
> > +};
>=20
> Now that you have this, just use:
> 	MODULE_DEVICE_TABLE(pci, pciidlist);
> instead of:
>=20
> > +MODULE_ALIAS("pci:v00008086d00008108sv*sd*bc*sc*i*");
> > +MODULE_ALIAS("pci:v00008086d00008109sv*sd*bc*sc*i*");
>=20
> As the proper alias will automatically get generated from the
> MODULE_DEVICE_TABLE() macro.
>=20

Thank's for your review and kindly suggestion.
It's useful to me! :-)

And it works fine on my Poulsbo machine, I will use:
	MODULE_DEVICE_TABLE(pci, pciidlist);


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
