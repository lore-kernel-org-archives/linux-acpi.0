From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
 detect
Date: Mon, 12 Jul 2010 09:12:13 -0600
Message-ID: <4C3BBD6D020000230001CD30@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: dri-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Mattew,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-07-12 =E6=96=BC 03:27 +0100=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
> On Sun, Jul 11, 2010 at 08:12:57PM -0600, Joey Lee wrote:
>=20
> > He tested the drm blacklist patch can works fine on his computer, i=
t's
> > also works on VESA mode because the acpi _BCM, _BQC direct change
> > brightness by opregion.
> >=20

Sorry, I write a wrong information, the MSI poulsbo netbook change
brightness by ec command in _BCM, _BQC, not opregion.

> > What can we do for this situtation? I mean if the BIOS have opregio=
n
> > implementation but there have no opensource drm driver or native vi=
deo
> > driver support opregion on Linux?
>=20
> The cleanest way would be to implement a stub backlight control drive=
r=20
> for the chip - there should be enough information in the source of th=
e=20
> poulsbo drm to do that.=20

M... Follow your suggestion, I am tracing the i915 drm driver and
Poulsbo drm driver from here:

http://sourceforge.net/mailarchive/message.php?msg_name=3D49C2ADA8.2090=
405%40shipmail.org

I am not sure fully understood your suggestion... Did you mean we can
extract some parts from Poulsbo drm driver and put it to a stub
backlight control driver for Poulsbo? Where can we put the stub driver?
Do we still put it in i915 drm?=20

On the other hand, the Poulsbo is a old and stop ship chip, do we still
want to add a special driver for it?

> The main problem with the blacklist approach is=20
> that there's no guarantee that all poulsbo systems will have a workin=
g=20
> acpi method, and I /think/ there's a couple more PCI IDs that ought t=
o=20
> be covered in any case. On the other hand doing it properly does invo=
lve=20
> writing rather a lot more code, and the fact that Intel have shown=20
> absolutely no interest in making their hardware work means that the=20
> quick hack might be the most reasonable thing to do.
>=20

Thank's for your remind, I fully agreed cann't guarantee all poulsbo
systems have working acpi method. But, I am sure the MSI U110/U115 have
workable acpi backlight method.
Do you think it's good to put the special DMI detection in msi-laptop
driver to enable the the acpi backlight control by call
acpi_video_register in acpi video? But will cause msi-laptop driver
dependency to acpi video driver.

Need your kindly suggestion!


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
