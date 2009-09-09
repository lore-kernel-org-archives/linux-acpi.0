From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on Topstar N01
Date: Wed, 9 Sep 2009 11:41:31 -0300
Message-ID: <200909091141.32061.herton@mandriva.com.br>
References: <200909050229.55665.herton@mandriva.com.br> <200909071626.03334.herton@mandriva.com.br> <9b2b86520909080603u798eb14dn29dadeeb1b4a87df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:45089 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZIIOle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 10:41:34 -0400
In-Reply-To: <9b2b86520909080603u798eb14dn29dadeeb1b4a87df@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

Em Ter 08 Set 2009, =E0s 10:03:31, Alan Jenkins escreveu:
> On 9/7/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
> > Em S=E1b 05 Set 2009, =E0s 10:02:32, Alan Jenkins escreveu:
> >> On 9/5/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrot=
e:
> >> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> >> > functionality with Topstar N01 netbook. Besides hotkeys there ar=
e
> >> > other functions exposed by its ACPI firmware, but for now only
> >> > hotkeys reporting on Topstar N01 is supported. Topstar is a chin=
ese
> >> > manufacturer, its website can be currently reached at
> >> > http://www.topstardigital.cn/
> >> >
> >> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br=
>
> >> >
> >> > +static void __exit acpi_topstar_exit(void)
> >> > +{
> >> > +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> >> > +
> >> > +	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n=
");
> >>
> >> Oh... and this type of message always strikes me as gratuitous.  r=
mmod
> >> doesn't happen during normal operation.  So if the user removed th=
e
> >> module... they know they did it.  They can check lsmod if they for=
get
> >> and are not sure.
> >>
> >> If (as a developer) you want to be sure the acpi driver was really
> >> unregistered, you can (and probably should) look in sysfs.
> >
> > Hi, thanks for review. I addressed all issues you pointed out, and
> > renamed the
> > driver to topstar-laptop as suggested by Corentin Chary. I'll attac=
h also
> > the
> > diff on top of previous topstar_acpi.c as reference (before the ren=
ame
> > and without Kconfig/Makefile changes). I only compiled tested it, a=
s
> > because of bank holidays here will only be able to retest wednesday=
 this,
> > but the changes
> > are safe anyway. Here is new version of the patch (feel free to add=
 your
> > Reviewed-by to it):
> >
> > From e4fb36e01af04248e1a4ddda0964187e4b7fdb4a Mon Sep 17 00:00:00 2=
001
> > From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > Date: Mon, 7 Sep 2009 16:12:48 -0300
> > Subject: [PATCH] topstar-laptop: add new driver for hotkeys support=
 on
> > Topstar N01
> >
> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> > functionality with Topstar N01 netbook. Besides hotkeys there are
> > other functions exposed by its ACPI firmware, but for now only
> > hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> > manufacturer, its website can be currently reached at
> > http://www.topstardigital.cn/
> >
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
>=20
> Great!
>=20
> Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>=20
> I found two more style points to bug you with.
>=20
> > +
> > +#include <linux/module.h>
>=20
> The other drivers explicitly include <linux.init.h> for __init.  The
> LDD3 book says to do so as well.
>=20
> It also seems conventional to include <linux/kernel.h> for printk.
> (LDD3 thinks module.h is enough, but I disagree since module.h doesn'=
t
> directly include kernel.h).
>=20
> > +#include <acpi/acpi_bus.h>
> > +#include <acpi/acpi_drivers.h>
>=20
> [whereas the different prefix for the ac_types.h etc suggested that w=
e
> should get away without them]

I will replace them with <linux/acpi>, seems better.

I'll fix the other two and repost the patch.

>=20
> > +
> > +static int is_tps_dev;
> > +
>=20
> bool?
>=20
> "is_tps_dev" seems confused.  I think the phrase should be either "is
> a tps _laptop_" or "_has_ a tps device".  Perhaps "found_tps_dev"
> would be even better.
>=20
> > []'s
> > Herton
>=20
> And the same to you :-).
> Alan
>=20

--=20
[]'s
Herton
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
