From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Fri, 28 Mar 2008 19:39:19 +0000
Message-ID: <20080328193919.fb23bcc8.miknix@gmail.com>
References: <20080314151712.34836918.miknix@gmail.com>
	<1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
	<20080326175139.d59ff46d.miknix@gmail.com>
	<1206585013.8282.17.camel@sli10-desk.sh.intel.com>
	<20080327160346.424052fe.miknix@gmail.com>
	<1206668215.12574.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:3959 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbYC1T0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Mar 2008 15:26:08 -0400
Received: by ug-out-1314.google.com with SMTP id z38so834952ugc.16
        for <linux-acpi@vger.kernel.org>; Fri, 28 Mar 2008 12:26:05 -0700 (PDT)
In-Reply-To: <1206668215.12574.8.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 28 Mar 2008 09:36:55 +0800
Shaohua Li <shaohua.li@intel.com> wrote:

>=20
> On Thu, 2008-03-27 at 16:03 +0000, =C2ngelo Miguel Arrifano wrote:
> > On Thu, 27 Mar 2008 10:30:13 +0800
> > Shaohua Li <shaohua.li@intel.com> wrote:
> >=20
> > >=20
> > > On Thu, 2008-03-27 at 01:51 +0800, =C2ngelo Miguel Arrifano wrote=
:
> > > > PATCH
> > > > - -------------------------------------------------------------=
----
> > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > > index f688c21..fb096ee 100644
> > > > - --- a/drivers/acpi/Kconfig
> > > > +++ b/drivers/acpi/Kconfig
> > > > @@ -196,6 +196,14 @@ config ACPI_THERMAL
> > > >           recommended that this option be enabled, as your
> > > > processor(s)
> > > >           may be damaged without it.
> > > >=20
> > > > +config ACPI_QUICKSTART
> > > > +       tristate "Quickstart"
> > > > +       default y
> > > default m?
> > >=20
> > >=20
> > > > +
> > > > +static struct quickstart_driver_data {
> > > > +       struct quickstart_btn *btn_lst;
> > > > +       struct quickstart_btn *pressed;
> > > > +} quickstart_data =3D {
> > > > +       .btn_lst =3D NULL,
> > > > +       .pressed =3D NULL,
> > > > +};
> > > They are NULL, you don't need initialize them.
> > >=20
> > >=20
> > > > + * Platform driver structs
> > > > + */
> > > > +static ssize_t buttons_show(struct device *dev,
> > > > +                                       struct device_attribute=
 *attr,
> > > > +                                       char *buf);
> > > > +static ssize_t pressed_button_show(struct device *dev,
> > > > +                                       struct device_attribute=
 *attr,
> > > > +                                       char *buf);
> > > > +static ssize_t pressed_button_store(struct device *dev,
> > > > +                                       struct device_attribute=
 *attr,
> > > > +                                        const char *buf,
> > > > +                                        size_t count);
> > > > +static DEVICE_ATTR(pressed_button, 0666, pressed_button_show,
> > > > +                                        pressed_button_store);
> > > this file can be changed by non-root?
> >=20
> > The only thing that writing to this file does is clearing the
> > pressed button.
> > Is it a bad idea that can be changed by non-root?
> Just abnormal, eg. non-root can clear it but root might not read it
> (though it doesn't happen in current case but possible if runtime eve=
nt
> support).
>=20
> > > > +
> > > > +/* ACPI Driver functions */
> > > > +static void quickstart_acpi_notify(acpi_handle handle, u32 eve=
nt,
> > > > void *data)
> > > > +{
> > > > +       struct quickstart_acpi *quickstart =3D data;
> > > > +
> > > > +       if (!quickstart)
> > > > +               return;
> > > > +
> > > > +       if (event =3D=3D QUICKSTART_EVENT_WAKE) {
> > > > +               quickstart_data.pressed =3D quickstart->btn;
> > > > +               printk(KERN_ERR "quickstart: Quickbutton %s
> > > > pressed.\n",
> > > > +
> > > > acpi_device_bid(quickstart->device));
> > > > +       } else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
> > > > +               printk(KERN_ERR "quickstart: Runtime button %s
> > > > pressed.\n\t"
> > > > +                      "please report on linux-acpi@vger.kernel=
=2Eorg",
> > > > +
> > > > acpi_device_bid(quickstart->device));
> > > > +       }
> > > Please remove above printks. they are misleading, which isn't an =
error.
> > > please send an ACPI event to userspace in the notify, we need it =
for
> > > runtime.
> >=20
> > According to the Microsoft paper, runtime hot button reporting is o=
ptional.
> > My laptop doesn't report them and on the SF.net project page there =
was no
> > reports of people with hardware supporting this.
> > Sorry, I don't have a way to test this..
> Did you tried suspend/resume. From the doc, resume can send a
> notification too. Just calling acpi event eject routines, an event ej=
ect
> model can be well integrated into existing acpi daemons.

Yes, suspend to mem works.
When the laptop is in suspend state, if DVD button is pressed the lapto=
p resumes
and the platform driver receives a notify. The driver then exports the
button name to the sysfs pressed_button file.

>=20
> > > > +       }
> > > I'd suggest the GHID info should be exported to sysfs too. It's h=
ard to
> > > judge what a button is just per its name. You know it but an
> > > inexperienced user doesn't.
> >=20
> > I also would like to have a more descriptive information about the =
button but
> > the returned buffer is a BYTE/WORD/DWORD with a decimal number tell=
ing the button
> > usage ID.
> >=20
> > Looking at my DSDT piece of code:
> >=20
> > Method (GHID, 0, NotSerialized)
> > {
> >    If (LEqual (HOTB, 0x05))
> >    {
> >       Notify (DBTN, 0x02)
> >       Store (0x00, HOTB)
> >    }
> >=20
> >    Return (Buffer (0x01)
> >    {
> >       /* 0000 */    0x04
> >    })
> > }
> >=20
> > IMHO, a value like 0x04 for button usageID is totally useless..
> Ok, I got it. Maybe we need tool to help user identify what purpose a
> button is, but sounds impossible till the button can trigger runtime
> event.

I've noticed that HP laptops have the same names for button
devices (at least dv6k, dv8k and tx series). Maybe other vendors do thi=
s as well?
If this holds true, maybe building a vendor table for getting
button name -> description correspondence? .. just an idea ..

>=20
> Thanks,
> Shaohua
>=20

Thanks all,
- --=20
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
Linwizard Developer
http://miknix.homelinux.com
PGP Pubkey 0x3D92BB0B

- - -
Computers are like air conditioners.  Both stop working, if you open wi=
ndows.
	-- Adam Heath
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFH7UlnNahyoD2SuwsRApPtAJ9GcFwvwuAgCyCnS87XaGI+nHAbYgCeM65K
lvOIGf01TPFzAgqFbSoFJYY=3D
=3DvrGR
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
