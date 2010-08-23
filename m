From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
 detect
Date: Mon, 23 Aug 2010 06:43:19 -0600
Message-ID: <4C72F987020000230001F296@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de
List-Id: linux-acpi@vger.kernel.org

Hi Matthew,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-08-23 =E6=96=BC 12:49 +0100=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Aug 23, 2010 at 07:40:48PM +0800, Lee, Chun-Yi wrote:
> > There have some machines not support by i915 drm driver, e.g. MSI U=
110/U150,
> > there are use poulsbo chip and drm driver not support it because le=
gal issue.
> > Those machines's acpi backlight control actually work fine and don'=
t need apply
> > the intel opregion support.
> > So, add intel drm blacklist to intel_opregion_present, it can enabl=
e the acpi
> > brightness interface on Poulsbo/Morrestown.
>=20
> I'm still kind of reluctant about this - doing the blacklisting here=20
> means that there's no way for a native driver to inhibit registration=
=20
> from occuring until after opregion setup has taken place, and we foun=
d=20
> that that was necessary on some 915 so I suspect it is on gma500 as

I read the bug:
 https://bugzilla.kernel.org/show_bug.cgi?id=3D11259#c28
And your patch comment:
 https://patchwork.kernel.org/patch/13147/

I think there have some machines implement _BCL by using opregion, so
causes the issues. But, there sill have many machines implement _BCL by
using EC to control backlight.
Unfortunately, there have no way can detect the difference.

> =20
> well. Perhaps it should just be done as a module option, and then=20
> distributions who want to deal with this case could set it by default=
?
>=20

OK, I put a module option also a way to fix the issue for those machine=
s
that were implemented acpi method by call EC. I will put a module optio=
n
in acpi video driver then send to you after testing finished.

> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_0)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_1)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_2)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_3)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_4)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_5)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_6)=
 },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_VGA_7)=
 },
>=20
> Moorestown doesn't have ACPI, so I don't think there's any need to=20
> include these.
>=20

OH! OK, thank's  for your review!

Joey Lee
