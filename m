From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Thu, 09 Sep 2010 22:36:53 -0600
Message-ID: <4C8A4285020000230002020B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: randy.dunlap@oracle.com
Cc: mjg@redhat.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Randy,=20

=46irst, thank's for your review!
And, sorry I am late to reply the mail.

=E6=96=BC =E4=B8=89=EF=BC=8C2010-09-01 =E6=96=BC 10:11 -0700=EF=BC=8CRa=
ndy Dunlap =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wed,  1 Sep 2010 17:08:39 +0800 Lee, Chun-Yi wrote:
>=20
> > Currently, there have no Poulsbo native video driver to support
> > intel opregion. So, use this stub driver to enable the acpi backlig=
ht
> > control sysfs entry files by requrest acpi_video_register.
> >=20
> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > ---
> >  drivers/gpu/Makefile       |    2 +-
> >  drivers/gpu/stub/Kconfig   |   13 +++++++++
> >  drivers/gpu/stub/Makefile  |    1 +
> >  drivers/gpu/stub/poulsbo.c |   64 ++++++++++++++++++++++++++++++++=
++++++++++++
> >  drivers/video/Kconfig      |    2 +
> >  5 files changed, 81 insertions(+), 1 deletions(-)
> >  create mode 100644 drivers/gpu/stub/Kconfig
> >  create mode 100644 drivers/gpu/stub/Makefile
> >  create mode 100644 drivers/gpu/stub/poulsbo.c
> >=20
> > diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> > index 30879df..cc92778 100644
> > --- a/drivers/gpu/Makefile
> > +++ b/drivers/gpu/Makefile
> > @@ -1 +1 @@
> > -obj-y			+=3D drm/ vga/
> > +obj-y			+=3D drm/ vga/ stub/
> > diff --git a/drivers/gpu/stub/Kconfig b/drivers/gpu/stub/Kconfig
> > new file mode 100644
> > index 0000000..c564140
> > --- /dev/null
> > +++ b/drivers/gpu/stub/Kconfig
> > @@ -0,0 +1,13 @@
> > +config STUB_POULSBO
> > +	tristate "Intel Poulsbo Stub Driver"
> > +        default m
>=20
> Drop the "default m".
>=20

Thank's! Will drop "default m".

> > +        # Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
> > +        # but for select to work, need to select ACPI_VIDEO's depe=
ndencies, ick
> > +        select ACPI_VIDEO if ACPI
>=20
> What does it do when ACPI is not enabled?  Does the driver even build
> when APCI is not enabled?  (given the acpi_video* calls in it)
>=20

This driver will not do anything if API is not enabled. It only call
acpi_video_register/acpi_video_unregister, and acpi/video.h handle it
like the following:

#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
extern int acpi_video_register(void);
extern void acpi_video_unregister(void);
extern int acpi_video_get_edid(struct acpi_device *device, int type,
                               int device_id, void **edid);
#else
static inline int acpi_video_register(void) { return 0; }
static inline void acpi_video_unregister(void) { return; }
static inline int acpi_video_get_edid(struct acpi_device *device, int
type,
                                      int device_id, void **edid)
{
        return -ENODEV;
}
#endif

So, I think don't need add "depends on ACPI_VIDEO". How do you think?

> It also has pci_* calls in it, so it looks like it needs to depend
> on PCI && ACPI, or at least on PCI.
>=20
>=20
Yes, thank's for your review, I will add:
	depends on PCI


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
