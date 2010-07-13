From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
 detect
Date: Tue, 13 Jul 2010 02:13:39 -0600
Message-ID: <4C3CACD3020000230001CDCE@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: dri-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Matthew,=20

=46irst, thank's for your kindly suggestion.

=E6=96=BC =E4=B8=80=EF=BC=8C2010-07-12 =E6=96=BC 16:19 +0100=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > On the other hand, the Poulsbo is a old and stop ship chip, do we s=
till
> > want to add a special driver for it?
>=20
> Yeah, that's my concern. There's millions of things in the wild and=20
> Intel continue to refuse to take responsibility for them, so it's not=
=20
> clear to me that it's worth putting the effort into writing a "correc=
t"=20
> driver.
>=20

Yes, fully agreed!=20

> > Thank's for your remind, I fully agreed cann't guarantee all poulsb=
o
> > systems have working acpi method. But, I am sure the MSI U110/U115 =
have
> > workable acpi backlight method.
> > Do you think it's good to put the special DMI detection in msi-lapt=
op
> > driver to enable the the acpi backlight control by call
> > acpi_video_register in acpi video? But will cause msi-laptop driver
> > dependency to acpi video driver.
>=20
> Mm. Well, we *know* that opregion won't work on Poulsbo as is (even=20
> Intel's driver doesn't implement it), so there's no way this patch ca=
n=20
> make things any worse. On the other hand, if anyone ships an OS with=20
> this hack *and* a native psb driver, I'm going to look sad for some=20
> time.
>=20

Please then me add the MSI U110/U115 support in msi-laptop driver. I am
sure the acpi baclight method works fine on U110/U115 and I hope the
_REAL_ opensource kernel user will not have a invalid backlight control
function.

=46or the native psb driver, if have anyone want to ship it with newest
msi-laptop driver, then he must need take care anything in KMP, like:
disable msi-laptop or put it to modprobe blacklist.
Because the native psb driver doesn't not included in kernel mainline.

On the other hand, the Poulsbo already stop to chip, there will not hav=
e
many machine ship the native psb driver with newest msi-laptop.


Thank's a lot!
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
