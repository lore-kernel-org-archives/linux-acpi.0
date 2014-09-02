From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC
 mailbox and channels
Date: Wed, 3 Sep 2014 00:03:31 +0100
Message-ID: <20140902230331.GF29327@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eZVQL-2k1XgfFW1_QZb9G_S2d9YLo3PAH1VytvOhDnd-Q@mail.gmail.com>
 <CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
 <2819816.9eneSBSqnQ@wuerfel>
 <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ou2/pFdZC1wHLsdF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47133 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbaIBXDq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 19:03:46 -0400
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--ou2/pFdZC1wHLsdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 04:15:05PM -0400, Ashwin Chaugule wrote:

> > Using platform_data would no be helpful, because there is no platform
> > code to fill that out on ACPI based systems.

> Right. So the question is how do we work around the "mbox->dev" and
> "client->dev" expectations in the Mailbox framework for PCC, given
> that these tables aren't backed by "struct devices" ?

As previously suggested just looking things up in the context of a
device created to represent the PCC controller seems fine; clients know
they're using PCC so can just call a PCC specific API which hides the
mechanics from them (for example, using a global variable to store the
device).

--ou2/pFdZC1wHLsdF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBkzAAAoJELSic+t+oim97F0P/iUhd01NfTKqhM8LWUBTzWdB
FztL2a1Kk+KAOtHtlpHPHyhB2jauDod392RFoo+BFOmJ9lnNKt21TKyWTeI49GuN
RjRgCjxIi3QELheQb3+E7/e0k1NHXEBdHXu7nkBvcm+oP3P+E3umQRlhq7AhgjRe
helHB84+5cV6DUQvbwPS4FlCL/v9mUpyKZP3tD1L3ICC/n/70zk6f876EnSAWLVn
zY3jpWIXlb7BZ1Kvdaeajgri9l1js4NomgTDR6rqi+rTA2e4pcljyVsfQSR4l71B
fN28mwmuK3ks1IGRgjPJkXYN/POjsKXCSiGYodTV7W56TeV4RTSA4/udE8vjne8J
iY48Qi2XrGhua6/AxWUr/bSxwqsuOA2AqEujRIVEds7jHOpmGvYL1M/8yLu7SrRx
3KC6HZctbf5Rtie3VYr2Tq8W5M7C85dcBEcxjF/3b4XU2sSZKPhrMrDQ7ex/9uEH
h1E++abMQARix2DXYTWkMzVetKFQ/EdBwKXjG+0Ej5kBbW4+WAUelNrv6ytr6usw
Ai6AudOsKI4AyPqBLdW5yllqNaLqaljCppZpYu4Fu6qcIIwqBH8+rP2AK4TAAgOO
9uoWiVn9VeWMc2pkFJ1KLmtGYWjE9JEYMyVuH5v9GVHB59InnQQMc6alpRv+9wMu
0UnIZJN0bN+Mg0V6/uAV
=m5Oq
-----END PGP SIGNATURE-----

--ou2/pFdZC1wHLsdF--
