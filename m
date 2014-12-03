From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] dell-smo8800: Add more acpi ids and change description
 of driver
Date: Wed, 3 Dec 2014 05:43:23 -0800
Message-ID: <20141203134323.GI75099@vmdeb7>
References: <1411994748-11229-1-git-send-email-pali.rohar@gmail.com>
 <20140929205604.GA34181@vmdeb7>
 <201411230338.26239@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45120 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaLEDgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2014 22:36:54 -0500
Content-Disposition: inline
In-Reply-To: <201411230338.26239@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, Nov 23, 2014 at 03:38:26AM +0100, Pali Roh=E1r wrote:
> Oops, I lost this mail somewhere...
>=20
> I copied these ids from windows driver inf file. I did not tested=20
> them because I do not have machine which reports these ids. It=20
> looks like all SMOXX devices have same acpi structure (one IRQ).=20
> So adding ids could not break anything (if acpi device will not=20
> have for some reason IRQ specified, device probe function will=20
> fail).

Please resend with a complete message body and the typo fix below.

>=20
> On Monday 29 September 2014 22:56:04 Darren Hart wrote:
> > On Mon, Sep 29, 2014 at 02:45:48PM +0200, Pali Roh=E1r wrote:
> >=20
> > Please see Documentation/SubmittingPatches, 15) The canonical
> > patch format, and provide a complete message body.
> >=20
> > Have you validated each of the 6 ACPI IDs added to the driver?
> >=20
> > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > ---
> > >=20
> > >  drivers/platform/x86/Kconfig        |    4 ++--
> > >  drivers/platform/x86/dell-smo8800.c |   10 ++++++++--
> > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/Kconfig
> > > b/drivers/platform/x86/Kconfig index 3bbcbf1..ba9ee4f
> > > 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -128,10 +128,10 @@ config DELL_WMI_AIO
> > >=20
> > >  	  be called dell-wmi-aio.
> > > =20
> > >  config DELL_SMO8800
> > >=20
> > > -	tristate "Dell Latitude freefall driver (ACPI
> > > SMO8800/SMO8810)" +	tristate "Dell Latitude freefall driver
> > > (ACPI SMO88XX)"
> > >=20
> > >  	depends on ACPI
> > >  	---help---
> > >=20
> > > -	  Say Y here if you want to support SMO8800/SMO8810
> > > freefall device +	  Say Y here if you want to support
> > > SMO88XX freefall device
> >=20
> > "devices" now that multiple are supported.
> >=20
> > Thanks,
>=20
> --=20
> Pali Roh=E1r
> pali.rohar@gmail.com



--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
