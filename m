From: Julien Lerouge <julien.lerouge@m4x.org>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Wed, 20 Dec 2006 17:17:05 -0800
Message-ID: <20061221011705.GG29711@debian>
References: <200612192217.43660.corentincj@iksaif.net> <200612200242.24745.lenb@kernel.org> <200612201102.38500.corentincj@iksaif.net> <200612201749.32486.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:36568 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161124AbWLUBqS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 20:46:18 -0500
Content-Disposition: inline
In-Reply-To: <200612201749.32486.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: corentincj@iksaif.net, linux-acpi@vger.kernel.org, sziwan@users.sourceforge.net

Sorry Len, I should have told you earlier,

I have not been active for a long time, and don't plan to be, at least
not on this driver. Corentin is willing to maintain it. I don't know fo=
r
Karol, but you can remove me from the MAINTAINERS.

Also, Corentin should be added to the list of the MAINTAINERS for this
driver.

Thanks,
Julien

On Wed, Dec 20, 2006 at 05:49:32PM -0500, Len Brown wrote:
> Karol and Julien are listed as the MAINTAINERS for asus_acpi.
> Why do I not see their Signed-off-by or Acked-by lines on this patch =
series?

> On Wednesday 20 December 2006 05:02, Corentin CHARY wrote:
> > Le mercredi 20 d=E9cembre 2006 08:42, Len Brown a =E9crit=A0:
> > > On Tuesday 19 December 2006 16:17, Corentin CHARY wrote:
> > > > Hi,
> > > > This set of patch is against 2.6.19. It add support for many
> > > > models, /sys/class/backlight/, Light Sens, etc ... There is als=
o a lot of
> > > > cleanups. And the most important, a new system to handle unsupp=
orted
> > > > models.
> > > >
> > > > Patch from 0 to 10 are change and cleanups in the driver.
> > > > Patch from 11t to 21 add support for new models.
> > > >
> > > > All the following patchs are available here :
> > > > <http://xf.iksaif.net/acpi4asus/2.6.19/>
> > >

> > >
> > > When this series is formatted to apply, what tree is it supposed =
to apply
> > > to?
> > These patchs are done with asus_acpi.c from 2.6.19 . So it can be a=
pplied to=20
> > 2.6.19 and 2.6.20-rc1 (as there is no change for asus_acpi in 2.6.2=
0-rc1).
> >=20
> >=20
> > >
> > > How does it relate to the two asus_acpi patches in the mm tree ri=
ght now --
> > > 13/19 and 19/19 that akpm forwarded to the list yesterday.
> > >
> > The change in the mm tree are :  =20
> > 	- Backlight support
> > 	=3D> It's nearly the same code (patch 10/22)
> > 	- no more useless cast
> > 	=3D> It's ok (patch 7/22)
> > 	- Add support for A6VA, M6V, W5F, V6V, A4S
> > 	=3D> It's ok, but more features are supported in my patchs.
> > 	And the implemention is cleaner, as I use my parse_method()
> > 	function instead of adding special case in get_lcd_status()
> > 	(see patch 5/22 and 6/22)
> > 	- Swap W5A and W3V
> > 	=3D> It's ok,  (patch 19/22)
> > 	- Invert wled status
> > 	=3D> I don't do it, as it's a mistake. I tested on A6T, A6J, F3JM,=
 and the
> > 	wled value don't need to be inverted.

> So should we NAK the two patches that are proposed in -mm
> and ask Andrew to not accept asus_acpi patches and instead direct
> them to acpi4asus-user@lists.sourceforge.net?

> > > How does it relate to the acpi-test tree, which already includes
> > > the backlight patch to asus_acpi from Holger Macht?
> > The change in the acpi-test tree are :
> > 	- Backlight support
> > 	=3D> done
> > 	- no more useless cast
> > 	=3D> done

> Holger's patch is already queued for upstream -- having lived in -mm =
for some time now.
> When you resend the acpi4asus series such that it is properly formatt=
ed,
> please be sure it applies cleanly to what is in acpi release tree.
> (ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/relea=
se/2.6.20/acpi-release-20060707-2.6.20-rc1.diff.gz)

> thanks,
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
