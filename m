From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Wed, 20 Dec 2006 17:49:32 -0500
Message-ID: <200612201749.32486.lenb@kernel.org>
References: <200612192217.43660.corentincj@iksaif.net> <200612200242.24745.lenb@kernel.org> <200612201102.38500.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35341 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030417AbWLTWut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 17:50:49 -0500
In-Reply-To: <200612201102.38500.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, sziwan@users.sourceforge.net, julien.lerouge@free.fr

Karol and Julien are listed as the MAINTAINERS for asus_acpi.
Why do I not see their Signed-off-by or Acked-by lines on this patch se=
ries?

On Wednesday 20 December 2006 05:02, Corentin CHARY wrote:
> Le mercredi 20 d=E9cembre 2006 08:42, Len Brown a =E9crit=A0:
> > On Tuesday 19 December 2006 16:17, Corentin CHARY wrote:
> > > Hi,
> > > This set of patch is against 2.6.19. It add support for many
> > > models, /sys/class/backlight/, Light Sens, etc ... There is also =
a lot of
> > > cleanups. And the most important, a new system to handle unsuppor=
ted
> > > models.
> > >
> > > Patch from 0 to 10 are change and cleanups in the driver.
> > > Patch from 11t to 21 add support for new models.
> > >
> > > All the following patchs are available here :
> > > <http://xf.iksaif.net/acpi4asus/2.6.19/>
> >

> >
> > When this series is formatted to apply, what tree is it supposed to=
 apply
> > to?
> These patchs are done with asus_acpi.c from 2.6.19 . So it can be app=
lied to=20
> 2.6.19 and 2.6.20-rc1 (as there is no change for asus_acpi in 2.6.20-=
rc1).
>=20
>=20
> >
> > How does it relate to the two asus_acpi patches in the mm tree righ=
t now --
> > 13/19 and 19/19 that akpm forwarded to the list yesterday.
> >
> The change in the mm tree are :  =20
> 	- Backlight support
> 	=3D> It's nearly the same code (patch 10/22)
> 	- no more useless cast
> 	=3D> It's ok (patch 7/22)
> 	- Add support for A6VA, M6V, W5F, V6V, A4S
> 	=3D> It's ok, but more features are supported in my patchs.
> 	And the implemention is cleaner, as I use my parse_method()
> 	function instead of adding special case in get_lcd_status()
> 	(see patch 5/22 and 6/22)
> 	- Swap W5A and W3V
> 	=3D> It's ok,  (patch 19/22)
> 	- Invert wled status
> 	=3D> I don't do it, as it's a mistake. I tested on A6T, A6J, F3JM, a=
nd the
> 	wled value don't need to be inverted.

So should we NAK the two patches that are proposed in -mm
and ask Andrew to not accept asus_acpi patches and instead direct
them to acpi4asus-user@lists.sourceforge.net?

> > How does it relate to the acpi-test tree, which already includes
> > the backlight patch to asus_acpi from Holger Macht?
> The change in the acpi-test tree are :
> 	- Backlight support
> 	=3D> done
> 	- no more useless cast
> 	=3D> done

Holger's patch is already queued for upstream -- having lived in -mm fo=
r some time now.
When you resend the acpi4asus series such that it is properly formatted=
,
please be sure it applies cleanly to what is in acpi release tree.
(ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release=
/2.6.20/acpi-release-20060707-2.6.20-rc1.diff.gz)

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
