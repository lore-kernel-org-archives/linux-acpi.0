From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 04/22] of: add function to allow probing a device from
 a OF node
Date: Fri, 23 Oct 2015 08:54:19 +0900
Message-ID: <20151022235419.GF29919@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-5-git-send-email-tomeu.vizoso@collabora.com>
 <10119606.2TraDKGPVy@vostro.rjw.lan>
 <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60205 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965593AbbJVXyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2015 19:54:43 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2015 at 03:03:37PM +0200, Tomeu Vizoso wrote:
> On 22 October 2015 at 03:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > Same question as from Greg: How does a subsystem know whether or not to use
> > this function?

> Maybe I don't understand the comment, but as the commit message says,
> subsystems can use this when looking up resources for drivers. Or you
> mean that this information should be in the API docs?

I'm pretty sure what he's suggesting here is changing to "should always"
(ie, explain the situations when a subsystem would do this, including
decision criteria if it's optional).

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKXcqAAoJECTWi3JdVIfQoIUH/AqLDwelzoR7SJowYvkLfv1Y
UZ2nrTLT1Xs64yonbRXmc+odvRUImMbxaFTy+phSb6sxKYXEQQeaTG1UKnqCsXs7
UR10/8ymjyPqy7regz8otNabTXAz87f/Yf8qiBQ3X/LzQP+U+Q1FVe+dWOICBPgd
qPD4JAD1iW29SSw1+S6fvHkihXnXZQT7TdPinHZbfKso48gFksYlZqlf4BYRGN7u
jR4MmoYepEjNESYqWjSgmaKE8qBN/DbC26r0bMpLt/9uqjr/OweoAqHMgATcZMv2
w98cU1QM5aESLt+LK9dtRekAw6MZP9UNlUHMBGoGs5xq+6rJoargysZzoY2G3OM=
=NIr/
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
