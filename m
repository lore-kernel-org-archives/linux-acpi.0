From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 19/22] Swap W3V and W5A
Date: Tue, 19 Dec 2006 23:20:48 +0100
Message-ID: <200612192320.48843.corentincj@iksaif.net>
References: <200612192220.35487.corentincj@iksaif.net> <20061219134604.5331de02.randy.dunlap@oracle.com>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:60626 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933047AbWLSWUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 17:20:50 -0500
In-Reply-To: <20061219134604.5331de02.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Sorry, I forget .. It's just because 5 comes after 3, and the list is o=
rdered.

Le mardi 19 d=E9cembre 2006 22:46, vous avez =E9crit=A0:
> On Tue, 19 Dec 2006 22:20:35 +0100 Corentin CHARY wrote:
> > Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> > ---
>
> Please tell us _why_ you are making a change, not just what
> the change is.
>
> >  asus_acpi.c |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> >
> > --- a/drivers/acpi/asus_acpi.c  2006-12-15 16:19:24.000000000 +0100
> > +++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:19:08.000000000 +0100
> > @@ -177,8 +177,8 @@
> >                 V6J,            //V6J
> >                 V6V,            //V6V
> >                 W1N,            //W1000N
> > -               W5A,            //W5A
> >                 W3V,            //W3030V
> > +               W5A,            //W5A
> >                 xxN,            //M2400N, M3700N, M5200N, M6800N, S=
1300N,
> > S5200N
> >                 //(Centrino)
> >                 DEF,            //Default values
> > @@ -636,25 +636,25 @@
> >          .display_get =3D "\\ADVG"},
> >
> >         {
> > -        .name =3D "W5A",
> > -        .bt_switch =3D "BLED",
> > +        .name =3D "W3V",
> > +        .mled_set =3D "MLED",
> >          .wled_set =3D "WLED",
> >          .lcd_switch =3D xxN_PREFIX "_Q10",
> > +        .lcd_status =3D "\\BKLT",
> >          .brightness_set =3D "SPLV",
> >          .brightness_get =3D "GPLV",
> >          .display_set =3D "SDSP",
> > -        .display_get =3D "\\ADVG"},
> > +        .display_get =3D "\\INFB"},
> >
> >         {
> > -        .name =3D "W3V",
> > -        .mled_set =3D "MLED",
> > +        .name =3D "W5A",
> > +        .bt_switch =3D "BLED",
> >          .wled_set =3D "WLED",
> >          .lcd_switch =3D xxN_PREFIX "_Q10",
> > -        .lcd_status =3D "\\BKLT",
> >          .brightness_set =3D "SPLV",
> >          .brightness_get =3D "GPLV",
> >          .display_set =3D "SDSP",
> > -        .display_get =3D "\\INFB"},
> > +        .display_get =3D "\\ADVG"},
> >
> >         {
> >          .name =3D "xxN",
> >
> > --
>
> ---
> ~Randy

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
