From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Wed, 02 Dec 2015 01:48:41 +0100
Message-ID: <2306632.Ddb0M2gLJC@vostro.rjw.lan>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com> <2355752.R19tF0KgU6@vostro.rjw.lan> <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56181 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932279AbbLBASv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 19:18:51 -0500
In-Reply-To: <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Monday, November 30, 2015 06:23:26 PM Andy Lutomirski wrote:
> On Nov 30, 2015 5:41 PM, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> > On Monday, November 30, 2015 03:45:15 PM Andy Lutomirski wrote:
> > > On Nov 30, 2015 2:40 PM, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Monday, November 30, 2015 12:15:27 PM Andy Lutomirski wrote:
> > > > > On Sun, Nov 29, 2015 at 9:19 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > > >
> > > > [cut]
> > > >
> > > > > > From inspection of the code, acpi_pnp.c determines that the device is
> > > > > > a pnp device because pnp0c02 is in acpi_pnp_device_ids.  This causes
> > > > > > the device to have a concrete handler, so no platform device is
> > > > > > created.  However, pnpacpi/core.c rejects it because it has no _CRS
> > > > > > method.  As a result, it's in limbo.
> > > > > >
> > > > > > What's the right thing to do here?  I could modify acpi_pnp.c to
> > > > > > reject the device, which will let the generic platform fallback claim
> > > > > > it.
> > > >
> > > > pnp0c02 is a special device ID.  It is defined by MS as "General ID for
> > > > reserving resources required by PnP motherboard", so having no _CRS for
> > > > that particular device ID doesn't really make sense.
> > > >
> > > > Moreover, we have a PNP driver that (normally) binds to that device ID,
> > > > so a PNP device object should be created for it.
> > >
> > > Given that the pnpacpi driver is going to reject it anyway, it could
> > > make sense to keep it from binding at all (and maybe warn?) so that
> > > the platform fallback code picks it up, though.
> >
> > The point is that we'll create a PNP device for the same device ID on other
> > platforms and that's going to be confusing, isn't it?
> >
> > I guess one option might be to hack the driver in question to accept a
> > device without _CRS and then do what you need to be done for that device.
> >
> 
> The driver being the one I'm writing or the pnpacpi driver?
> 
> Maybe I should ask the vendor if they're willing to drop the pnp0c02
> cid.  This thing is an event-generating device, not a
> resource-managing device.

[cut]

OK, I see what's the problem now.

> >
> > What exactly do you need that platform device for?
> 
> I want some kind of physical device to bind my driver to.  I probably
> want suspend/resume callbacks, too.

I see.

For your use case we could make the PNP layer ignore the pnp0c02 device id if
(a) _CRS is missing and (b) pnp0c02 is in the _CID list (not a _HID).

We have a deeper problem here, but let me discuss that with Rui.

Thanks,
Rafael

