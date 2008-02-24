From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Introduce PM_EVENT_HIBERNATE (was: Re: i915 hibernation patch (was: Re: 2.6.25-rc2 System no longer ...))
Date: Sun, 24 Feb 2008 12:25:20 +0100
Message-ID: <200802241225.21510.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <1203826599.30621.25.camel@mtlp> <200802241211.48000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52285 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbYBXL03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Feb 2008 06:26:29 -0500
In-Reply-To: <200802241211.48000.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mirco Tischler <mt-ml@gmx.de>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Alexey Starikovskiy <astarikovskiy@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sunday, 24 of February 2008, Rafael J. Wysocki wrote:
> On Sunday, 24 of February 2008, Mirco Tischler wrote:
> >=20
> > On Sa, 2008-02-23 at 19:13 +0100, Rafael J. Wysocki wrote:
> > > Index: linux-2.6/drivers/usb/host/u132-hcd.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.orig/drivers/usb/host/u132-hcd.c
> > > +++ linux-2.6/drivers/usb/host/u132-hcd.c
> > > @@ -3214,14 +3214,19 @@ static int u132_suspend(struct platform_
> > >                  return -ESHUTDOWN;
> > >          } else {
> > >                  int retval =3D 0;
> > > -                if (state.event =3D=3D PM_EVENT_FREEZE) {
> > > +
> > > +		switch (state.event) {
> > > +		case PM_EVENT_FREEZE:
> > >                          retval =3D u132_bus_suspend(hcd);
> > > -                } else if (state.event =3D=3D PM_EVENT_SUSPEND) =
{
> > > +			break;
> > > +		case PM_EVENT_SUSPEND:
> > > +		case PM_EVENT_HIBERNATE:
> > >                          int ports =3D MAX_U132_PORTS;
> > >                          while (ports-- > 0) {
> > >                                  port_power(u132, ports, 0);
> > >                          }
> > > -                }
> > > +			break;
> > > +		}
> > >                  if (retval =3D=3D 0)
> > >                          pdev->dev.power.power_state =3D state;
> > >                  return retval;
> > =EF=BB=BFHmm. Doesn't compile for me in 2.6.25-rc2-git7:
> >=20
> >   CC [M]  drivers/usb/host/u132-hcd.o
> > drivers/usb/host/u132-hcd.c: In function =E2=80=98u132_suspend=E2=80=
=99:
> > drivers/usb/host/u132-hcd.c:3224: error: expected expression before
> > =E2=80=98int=E2=80=99
> > drivers/usb/host/u132-hcd.c:3225: error: =E2=80=98ports=E2=80=99 un=
declared (first use
> > in this function)
> > drivers/usb/host/u132-hcd.c:3225: error: (Each undeclared identifie=
r is
> > reported only once
> > drivers/usb/host/u132-hcd.c:3225: error: for each function it appea=
rs
> > in.)
> > make[3]: *** [drivers/usb/host/u132-hcd.o] Error 1
> > make[2]: *** [drivers/usb/host] Error 2
> > make[1]: *** [drivers/usb] Error 2
> > make: *** [drivers] Error 2
> >=20
> > This fixes it:
> >=20
> > Thanks
> > Mirco
> >=20
> > ---
> > From: Mirco Tischler <mt-ml@gmx.de>
> >=20
> > Fixes the following compile error caused by commit
> > 3a2d5b700132f35401f1d9e22fe3c2cab02c2549

Ah, I see it's merged already.

Thanks for the fix, btw! :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
