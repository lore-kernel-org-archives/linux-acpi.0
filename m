From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Tue, 01 Dec 2015 00:10:06 +0100
Message-ID: <1516170.Kd599zLure@vostro.rjw.lan>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com> <CALCETrVSywZt9=_axGu9GYarkezd+j7mKJJ_TS9NXZZg7qAZ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65169 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752648AbbK3WkT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 17:40:19 -0500
In-Reply-To: <CALCETrVSywZt9=_axGu9GYarkezd+j7mKJJ_TS9NXZZg7qAZ0A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Monday, November 30, 2015 12:15:27 PM Andy Lutomirski wrote:
> On Sun, Nov 29, 2015 at 9:19 PM, Andy Lutomirski <luto@amacapital.net> wrote:

[cut]

> > From inspection of the code, acpi_pnp.c determines that the device is
> > a pnp device because pnp0c02 is in acpi_pnp_device_ids.  This causes
> > the device to have a concrete handler, so no platform device is
> > created.  However, pnpacpi/core.c rejects it because it has no _CRS
> > method.  As a result, it's in limbo.
> >
> > What's the right thing to do here?  I could modify acpi_pnp.c to
> > reject the device, which will let the generic platform fallback claim
> > it.

pnp0c02 is a special device ID.  It is defined by MS as "General ID for
reserving resources required by PnP motherboard", so having no _CRS for
that particular device ID doesn't really make sense.

Moreover, we have a PNP driver that (normally) binds to that device ID,
so a PNP device object should be created for it.

> > I could modify pnpacpi to accept the device despite the lack of
> > _CRS, so a pnp device will be created.

I'm not sure if that's going to work, you'd need to try it.

The PNP layer is built around resources management, so the lack of resources
to manage may uncover some dusty corners in it.

> > I could bind directly as an
> > ACPI driver (somewhat suboptimal because apparently that's frowned
> > upon).

The policy here is "avoid that if reasonably possible", but in this particular
case there should be a PNP device.

> > I could also write *both* an ACPI driver and platform driver
> > and call acpi_create_platform_device from the ACPI driver, but that
> > seems a bit ugly.
> >
> > Thoughts?
> 
> If this is firmware bug (the ACPI spec suggests that _CRS may be
> mandatory for non-natively-enumerable things like this), then there's
> also a chance that the vendor will fix it.  On the other hand, maybe
> this is already compliant and we should just interpret missing _CRS as
> an empty set of resources.  (By inspection of the ASL, it really does
> look like this thing has no resources beyond the ACPI methods in it.)

OK, so it this in the context of the WMI bus type you're working on?

Rafael

