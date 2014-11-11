From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Tue, 11 Nov 2014 17:53:25 +0000
Message-ID: <20141111175325.GB3815@sirena.org.uk>
References: <CAJe_ZhcJzC1N4pESC-BTe=MXFJuOw2Pj61TaZEOs52QQHULhSg@mail.gmail.com>
 <2214649.QGmZRRXly3@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QAWTAjsVArRgbJ7t"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33636 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaKKRzA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 12:55:00 -0500
Content-Disposition: inline
In-Reply-To: <2214649.QGmZRRXly3@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-acpi@lists.linaro.org, Jassi Brar <jaswinder.singh@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, "lv.zheng" <lv.zheng@intel.com>


--QAWTAjsVArRgbJ7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 05:33:28PM +0100, Arnd Bergmann wrote:
> On Tuesday 11 November 2014 19:27:07 Jassi Brar wrote:

> > In even simpler terms.... I prefer controller specific
> > encoding(0x50434300) instead of controller specific api
> > (pcc_mbox_request_channel).  For a different class of controller, it
> > is much cleaner to define a new encoding as compared to another
> > xyz_mbox_request_channel() api.

> The problem with this approach is that it still leaves the interface
> as controller specific, because the client now has to know that it
> must pass the PCC identifier instead of an index.

Further to what Arnd is saying here what all these various patterns for
looking up PCC mailboxes are saying to me is that whatever we're doing
there's probably a place for a helper API that implements them; even if
it's just a thin inline wrapper in a header somewhere it saves everyone
having to get it right and means if we do get a DT binding or whatever
they all magically end up with support.

--QAWTAjsVArRgbJ7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYk0UAAoJECTWi3JdVIfQ7bgH/ikIWy25sPc46u4UthVgL8Ol
jNY4CV9Lvx3+q9+IXvzHB5MwkLldDaCJb0vS7cggnfppD6SE2Rm5K7+o/b/JKPYm
GG/3ZISdNpVXpo2wvb+edvI5fydZxLWO2ImhBs6OOmNrkvZXxdfSvTnPbArDHAUJ
riYW4omOTzYN1CP5irZWNYqTPda+QSF+cW4O8BYhU6dKWR1E62IM25ufzO6GPJ34
bJoC416bvFgeZYMQkIQDlTAZARca+h9XAEiPX5WZS9HwEpcbuLltZFERB+/yMq95
wESx51hhA5i8P+5qrHFRjwtc6fMY3NJSF/DKm4S0elqfxgPXru8Ymbjd/klA77o=
=Qerj
-----END PGP SIGNATURE-----

--QAWTAjsVArRgbJ7t--
