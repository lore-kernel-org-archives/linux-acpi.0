From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Thu, 28 Aug 2014 11:15:00 +0100
Message-ID: <20140828101500.GM17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
 <20140827190902.GR17528@sirena.org.uk>
 <2961329.Rr1sZlGzgn@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svmQjK5QKgwU1LJ9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37563 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934503AbaH1KPH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 06:15:07 -0400
Content-Disposition: inline
In-Reply-To: <2961329.Rr1sZlGzgn@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--svmQjK5QKgwU1LJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 10:39:01AM +0200, Arnd Bergmann wrote:
> On Wednesday 27 August 2014 20:09:02 Mark Brown wrote:

> > That certainly looks like what it's doing.  Probably also make the name
> > that gets passed in const while you're at it.

> The mailbox API intentionally does not have an interface for
> that: you are supposed to get a reference to an mbox controller
> from a phandle or similar, not by knowing the name of the controller.

Right, and what he's trying to work around here is that ACPI has chosen
to provide a generic binding for some mailboxes which isn't associated
with anything we represent as a device and he doesn't want to provide
that device as a Linux virtual thing.

> Unfortunately, the three patches that Ashwin posted don't have a
> caller for this function, so I don't know what it's actually used for.
> Why do we need this function for pcc, and what are the names that
> can be passed here?

AFAICT the names he's interested in will be defined by the ACPI specs.
It does seem like we should be providing a device for the controller and
then either using references in ACPI to look it up if they exist or a
lookup function for this particular namespace that goes and fetches the
device we created and looks up in its context.

--svmQjK5QKgwU1LJ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/wEhAAoJELSic+t+oim9slEP/AtiZ1nhCiQiaK2P1VNMW+Zp
xiELvkEZo5iE1CzLLgtbPUWKnmCCVkVrtyKvM/0/WtWkRL4hPiabGz73vxUlvTYL
hzRqxyMwPKJmrB3ye8YeNnwKltPpSothgnAdrjX8vbia5JYcEaxr10koHo+ekPel
LCp0AgNP2ydXB9+XNfK6Z4KQeJlnv2RuoRN05FTv8AC9r0evUBNxb5vCE/q8JTTK
uMwrSHQMfvynEFT/Mzu/bQ6jfyJOaGQEG/woJx7d14czsmmo8rtTigPuuE0s27zP
M5EOBHA/PU7V76sS8P4aM35xhgT28/rdeyxg43CE1SCIzrhmyttu7bQLPrKCdqg1
+aluu+GjJ6PZrqIroCWMTmYjXnkEKh2k6KS8uT89V3dk5rfNgQWf0yqFDXTjgajw
kxj9WbatxVQxk4t2xoJt6NoU9MW5g9jITDs8sFuUeXy4s8MMjrZycY2jCvQDthxm
ALZzaosaqDtqlPMCVQpuo57pVsDPQOu+nPVB0Q8CnY6HCaJo3zGZf+XPH6WTwKI3
sqTUcv0JkVrBIu+O8y0YM/d99SOqElEHcgOpCV1Eec32Lm1pRgI9vQfjYUQRhVjL
2FoAvX8gfKqJBVeRpxTOJKaVYZjecOraWgfi7/qmHjT2IF/1zA9rjlRQgLeI1UXx
ne/HgVnHU/zouW6miDYg
=BPj4
-----END PGP SIGNATURE-----

--svmQjK5QKgwU1LJ9--
