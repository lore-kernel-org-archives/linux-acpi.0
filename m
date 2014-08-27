From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 27 Aug 2014 20:09:02 +0100
Message-ID: <20140827190902.GR17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140827102708.GW17528@sirena.org.uk>
 <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Evn4vN4dDfpEHe6L"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36480 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaH0TJQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 15:09:16 -0400
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--Evn4vN4dDfpEHe6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:
> On 27 August 2014 06:27, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:

> >> +static struct mbox_controller *
> >> +mbox_find_pcc_controller(char *name)
> >> +{
> >> +     struct mbox_controller *mbox;
> >> +     list_for_each_entry(mbox, &mbox_cons, node) {
> >> +             if (mbox->name)
> >> +                     if (!strcmp(mbox->name, name))
> >> +                             return mbox;
> >> +     }
> >> +
> >> +     return NULL;
> >> +}

> > This doesn't look particularly PCC specific?

> Call this mbox_find_controller_by_name() instead?

That certainly looks like what it's doing.  Probably also make the name
that gets passed in const while you're at it.

> >>       /* Sanity check */
> >> -     if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
> >> +
> >> +     /*
> >> +      * PCC clients and controllers are currently not backed by
> >> +      * platform device structures.
> >> +      */
> >> +#ifndef CONFIG_PCC
> >> +     if (!mbox->dev)
> >> +             return -EINVAL;
> >> +#endif

> > It seems better to make this consistent - either enforce it all the time
> > or don't enforce it.

> So this is where it got really messy. We're trying to create a

The messiness is orthogonal to my comment here - either it's legal to
request a mailbox without a device or it isn't, it shouldn't depend on a
random kernel configuration option for a particular mailbox driver which
it is.

> "device" out of something that isn't. The PCCT, which is used as a
> mailbox controller here, is a table and not a peripheral device. To
> treat this as a device (without faking it by manually putting together
> a struct device), would require adding a DSDT entry which is really a
> wrong place for it. Are there examples today where drivers manually
> create a struct driver and struct device and match them internally?
> (i.e. w/o using the generic driver subsystem)

Arguably that's what things like cpufreq end up doing, though people
tend to just shove a device into DT.  Are you sure there isn't any
device at all in ACPI that you could hang this off, looking at my
desktop I see rather a lot of apparently synthetic ACPI devices with
names starting LNX including for example LNXSYSTM:00?

> The main reason why I thought this Mailbox framework looked useful
> (after you pointed me to it) for PCC was due to its async notification
> features. But thats easy and small enough to add to the PCC driver
> itself. We can also add a generic controller lookup mechanism in the
> PCC driver for anyone who doesn't want to use ACPI. I think thats a
> much cleaner way to handle PCC support. Adding PCC as a generic
> mailbox controller is turning out to be more messier that we'd
> originally imagined.

If PCC is described by ACPI tables how would non-ACPI users be able to
use it?

--Evn4vN4dDfpEHe6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/izLAAoJELSic+t+oim9iskP/i2HXXbKcdATrRo2PJqXZwgK
KMA297IfFcp0bzR0UP246f22y0ZPrQZDctjAkjAJykWNV4YexdiiO4LWVtjUBPUI
eiAgozpIKtgdUIngnDZvWHmE3jcjpUq/q7t0ovcPu6itxB42QZUoesFx8/MuLrPT
WXrX4cTsZxJcxhQN51iEKuoMT9H/5wy9OGj6jwzhTUJ0eidNUZpNmw93BDPU9EOR
txwThNdcjKEfMaPZ/KtNmVnmdmD8imv10UmqjrNWtYLoqzc7b7t5k+8k6rjWv+l8
KyOWfI0TN+jsCjNIhnCcH1am9AlVI3udzexsw/MHhZyYArhnTCINr7OQrF/IV9t0
36ZRz4Cse1d4ZeRdNgO9LYDVTcS2mBwjRxuCbpp8uhZkM0KLjNl4XaiS7tap3DkL
wV8pjiOUYbQqIlsjouelpsE694DE6A1cDTUi75B5kTKezYc37k3Osc1Mpd1ym0Up
qVIMgPONxqwGyAd880Nkjq28DzpCKsfull26MCYvdQFw205SvJCT7ge0jzNeYoYV
6aWE4GUfZrFmalYunS1bhpR45z7KRVuHedpKF07hkVtRagJiy7go5eZCYnG+IYF5
zjghPDU34billOjhsyv02eIziWXBnzK0SDVhEUlWapG1t9TzUlcxoIon4kFbtz/H
Cn6BU8AWiCJr8b6A5Sa7
=c5ts
-----END PGP SIGNATURE-----

--Evn4vN4dDfpEHe6L--
