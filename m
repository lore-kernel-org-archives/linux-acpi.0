From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC
 mailbox and channels
Date: Wed, 3 Sep 2014 15:49:21 +0100
Message-ID: <20140903144921.GT29327@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <2819816.9eneSBSqnQ@wuerfel>
 <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
 <5594980.1z2dWMD9C4@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oaK9NA/DDdTag9m3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48286 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbaICOtl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 10:49:41 -0400
Content-Disposition: inline
In-Reply-To: <5594980.1z2dWMD9C4@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--oaK9NA/DDdTag9m3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 01:23:21PM +0200, Arnd Bergmann wrote:
> On Tuesday 02 September 2014 16:15:05 Ashwin Chaugule wrote:

> > Right. At least not in a way DT does. PCC clients know if something
> > needs to be written/read via PCC mailbox and can identify a PCC
> > subspace. (i.e. Mailbox channel). The PCC mailbox is uniquely
> > identified/defined in the spec.

> > #define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10

> > So we could use this ID instead of a string and use that to look up
> > the PCC controller for a PCC client.

> I didn't realize this was the case. Does that mean we can treat
> pcc as a linearly accessible address space the way we do for
> system memory, pci-config etc?

> If that works, we should probably just have a regmap for it rather
> than expose the mailbox API to client drivers.

A regmap doesn't seem to map very well here - as far as I can tell the
addresses referred to are mailboxes rather than registers or memory
addresses.  I could be misunderstanding though.

--oaK9NA/DDdTag9m3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBypuAAoJELSic+t+oim9SQQP/3Hy8CFDBKL/2OuvZvz43cVm
rjPGuVUNpqUttNec/2cc37a0bRT0kWgj4NyNYpbnmXWIr0k7GEQV34I9ob+e2W3X
h8wBIOhnDWINzqHqL/w8K+7SRIZp3boLgkKp7fTGNT3Nqx9Q/Kn33btcPjc8Twht
IkLUTQbXYMj93BDwLGZYQ1KzzmS3QECsUrvq0mOWpGxiV86sOTodtdsuRfSy/OIg
w5VtV8wbG/SRlNRTQUPP92Wp2t2khb9Hdl6DrZ/F8zY0dSexMebBNrGQZ1u0PI9R
AIY5BB1ZKl2vGKb5e0LerkBcEkekHAtopg4/Wk1A4XSiHsddw4+w8BvelbChaffB
o5cQFXfSy4P+RroNbB0n7I53+Ha667LqZ+nzbhNk2g1mwakb4kAuBYN2N1N5ANvL
79CTyYMGaWluLbEq65Hnp0OTtKThSXC+IOM91Qa5ZSAytpF2Gg2d+M4Ht5k2ZdLk
RVxhaYkRZ8wosJbTaefjFA6iOholQGMZcRDHc9q0RYlusHbSu8UyhQufdFu8hw+s
MXIzL4Z3FtMVFrcUzBEuNOyZ80ABjx+ffplnWnLC1CJiYxzXCXbmsUMnXNotQhQy
JulXF7J8qicQd0cU0+aqUCjQc2+bjWQywBhjIitID+8x1kLnszMwo5td1YWKCU+F
GElS3uKbCuzwHq39OhR1
=59OK
-----END PGP SIGNATURE-----

--oaK9NA/DDdTag9m3--
