From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 07/22] regulator: core: Remove regulator_list
Date: Mon, 21 Sep 2015 12:38:03 -0700
Message-ID: <20150921193803.GB30445@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-8-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mL5prfgbrp62Xbpc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45038 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbbIUTjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2015 15:39:32 -0400
Content-Disposition: inline
In-Reply-To: <1442844182-27787-8-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--mL5prfgbrp62Xbpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 04:02:47PM +0200, Tomeu Vizoso wrote:
> As we are already registering a device with regulator_class for each
> regulator device, regulator_list is redundant and can be replaced with
> calls to class_find_device() and class_for_each_device().

I've done an initial review of this and will push it to git so it can go
into the various test systems.  It's on a branch by itself so if there's
issues it's easy to back out, either from testing or from review from me
or others.  If we get to the point of merging the whole series then I'll
tag the code for cross merging.

Thanks a lot for working on this, this is something I'd started looking
at myself and it's a lot easier to just review code from someone else!

--mL5prfgbrp62Xbpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAFyaAAoJECTWi3JdVIfQZUcH/2HNlmY6r0wXnfZMPMPZsaDF
pPd0wuulBDbxTcQugqQ1UzpL+vfRoKWf32LSFv28jrwthjeuDxwbwwi8saY9veX/
IVODs4WrklXP3/wN/jIKP+RPRs9rrwFRPG4wyUyimcFyfSBXGP0R2s6AhTlGyvb2
F1jtAuamFqN+IVqdK0lHxVz1gD6Vs9cSevDBmb2R3rL/eC7uID0nmDiFEmCNdfwI
NXvGMqbq7w/8z3nZrE4XBefrliQsKsZbESYjFQjbd+B6V7tAXVgsQur23JnZ4d8y
HYONwxosLQ1elklP31TIj5Gutf/imyg4IwrIhSECHGjbtRT2nbjyRHqExKWPtQQ=
=GJqK
-----END PGP SIGNATURE-----

--mL5prfgbrp62Xbpc--
