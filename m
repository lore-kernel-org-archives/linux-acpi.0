From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH]  do not select ACPI_VIDEO in poulsbo stub driver
Date: Wed, 17 Nov 2010 00:34:42 -0700
Message-ID: <4CE42042020000230002406A@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: mingo@elte.hu, lenb@kernel.org, airlied@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rui,

=E6=96=BC =E4=B8=89=EF=BC=8C2010-11-17 =E6=96=BC 11:16 +0800=EF=BC=8CZh=
ang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wed, 2010-11-17 at 11:04 +0800, Joey Lee wrote:
> > Hi Rui,=20
> >=20
> > =E6=96=BC =E4=B8=89=EF=BC=8C2010-11-17 =E6=96=BC 08:42 +0800=EF=BC=8C=
Zhang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> > > On Tue, 2010-11-16 at 15:34 +0800, Joey Lee wrote:
> > > > Hi Rui,=20
> > > >=20
> > > > Sorry about this patch will not work on my MSi poulsbo machine.
> > > >=20
> > > > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-11-16 =E6=96=BC 14:04 +0800=EF=
=BC=8CZhang Rui =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > > the poulsbo stub driver should not select ACPI video driver.
> > > > >=20
> > > > > The reason why i915 driver selects ACPI video driver is that =
it needs some
> > > > > cooperation between these two drivers during initialization, =
or else the
> > > > > system may hang.
> > > > >=20
> > > > > So if users want ACPI backlight control, please set CONFIG_AC=
PI_VIDEO manually.
> > > > >=20
> > > > > http://marc.info/?l=3Dlinux-acpi&m=3D128952659018533&w=3D2
> > > > >=20
> > > > > CC: Ingo Molnar <mingo@elte.hu>
> > > > > CC: Dave Airlie <airlied@redhat.com>
> > > > > CC: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > > ---
> > > > >  drivers/gpu/stub/Kconfig   |   11 +----------
> > > > >  drivers/gpu/stub/poulsbo.c |    5 +----
> > > > >  2 files changed, 2 insertions(+), 14 deletions(-)
> > > > >=20
> > > > > Index: linux-2.6/drivers/gpu/stub/Kconfig
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > --- linux-2.6.orig/drivers/gpu/stub/Kconfig
> > > > > +++ linux-2.6/drivers/gpu/stub/Kconfig
> > > > > @@ -1,16 +1,7 @@
> > > > >  config STUB_POULSBO
> > > > >  	tristate "Intel GMA500 Stub Driver"
> > > > >  	depends on PCI
> > > > > -	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> > > > > -	# but for select to work, need to select ACPI_VIDEO's depen=
dencies, ick
> > > > > -	select VIDEO_OUTPUT_CONTROL if ACPI
> > > > > -	select BACKLIGHT_CLASS_DEVICE if ACPI
> > > > > -	select INPUT if ACPI
> > > > > -	select ACPI_VIDEO if ACPI
> > > > >  	help
> > > > >  	  Choose this option if you have a system that has Intel GM=
A500
> > > > >  	  (Poulsbo) integrated graphics. If M is selected, the modu=
le will
> > > > > -	  be called Poulsbo. This driver is a stub driver for Pouls=
bo that
> > > > > -	  will call poulsbo.ko to enable the acpi backlight control=
 sysfs
> > > > > -	  entry file because there have no poulsbo native driver ca=
n support
> > > > > -	  intel opregion.
> > > > > +	  be called Poulsbo.
> > > > > Index: linux-2.6/drivers/gpu/stub/poulsbo.c
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > --- linux-2.6.orig/drivers/gpu/stub/poulsbo.c
> > > > > +++ linux-2.6/drivers/gpu/stub/poulsbo.c
> > > > > @@ -11,8 +11,6 @@
> > > > > =20
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/pci.h>
> > > > > -#include <linux/acpi.h>
> > > > > -#include <acpi/video.h>
> > > > > =20
> > > > >  #define DRIVER_NAME "poulsbo"
> > > > > =20
> > > > > @@ -29,12 +27,11 @@ static DEFINE_PCI_DEVICE_TABLE(pciidlist
> > > > > =20
> > > > >  static int poulsbo_probe(struct pci_dev *pdev, const struct =
pci_device_id *id)
> > > > >  {
> > > > > -	return acpi_video_register();
> > > > > +	return 0;
> > > > >  }
> > > >=20
> > > > Sorry, we cann't remove to call acpi_video_register, because th=
e acpi
> > > > video will not generate because there have some poulsbo machine=
 declare
> > > > Intel opregion in DSDT but the i915 driver not support poulsbo.
> > > >=20
> > > I'm confused.
> > > It's the i915 driver that supports Intel Opregion.
> > > i.e. for a poulsbo machine with Intel Opregion, loading ACPI vide=
o
> > > driver won't help neither.
> > >=20
> >=20
> > Matthew have a patch:
> >=20
> >       * http://git.kernel.org/?p=3Dlinux/kernel/git/lenb/linux-acpi=
-2.6.git;a=3Dcommitdiff;h=3D74a365b3f354fafc537efa5867deb7a9fadbfe27
> >=20
> > This patch do:
> >=20
> > - ACPI video driver will not register if it check the DSDT have opr=
egion table declare.
> > - i915_opregion will call acpi_video_register after it initialised =
the DIDL field in opregion.
> >=20
> > That means acpi video driver will blocked when have opregion declar=
e in
> > DSDT until i915 drm driver call acpi_video_register. The patch fixe=
d
> > BKO#11259, but introduced a side effect: If there have Intel video =
chip
> > not supported by Intel drm driver, the acpi_video_register will nev=
er
> > called, then some machine have good acpi backlight interface
> > implementation will never have acpi brightness sysfs interface for
> > userland control. e.g. any Poulsbo netbook.
> >=20
> > Matthew's comment to talk about the side effect: Intel IGD opregion=
 and
> > GMA500
> >=20
> > There have some machines declare opregion in DSDT but they also
> > implement the backlight control by EC in _BCM. Like: MSI poulsbo
> > netbook.
> > Before introduce the above patch to kernel, those machine's acpi
> > backlight control works fine. On current kernel, those machines
> > backlight control broken.
> >=20
> > One function workable with old kernel but broken by new kernel, now=
=2E
> >=20
> Oh, I see what the problem is.
> You're right, this patch doesn't make sense. Sorry for the noise. :)
>=20
> thanks,
> rui

No problem, and thank's for your review and take care :-)

Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
