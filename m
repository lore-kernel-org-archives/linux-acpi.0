From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC
 mailbox and channels
Date: Wed, 3 Sep 2014 16:36:01 +0100
Message-ID: <20140903153601.GW29327@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eZVQL-2k1XgfFW1_QZb9G_S2d9YLo3PAH1VytvOhDnd-Q@mail.gmail.com>
 <CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
 <2819816.9eneSBSqnQ@wuerfel>
 <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
 <20140902230331.GF29327@sirena.org.uk>
 <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qCb2VTfFGdRLn6RH"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48371 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaICPgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 11:36:19 -0400
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--qCb2VTfFGdRLn6RH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 11:23:21AM -0400, Ashwin Chaugule wrote:
> On 2 September 2014 19:03, Mark Brown <broonie@kernel.org> wrote:

> > As previously suggested just looking things up in the context of a
> > device created to represent the PCC controller seems fine; clients know
> > they're using PCC so can just call a PCC specific API which hides the
> > mechanics from them (for example, using a global variable to store the
> > device).

> IIUC, this means, either modifying the existing
> mbox_controller_register() to know when a PCC mbox is being added, or
> have another PCC specific API for registering as a mailbox? Then, in

Why would you have to do that - can't the PCC specific API manage to
hide this?

--qCb2VTfFGdRLn6RH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBzVdAAoJELSic+t+oim9X3cP/3Vgl2pNqd93cp71xuWDbmpK
292OPaEad/5lzGFV6Wp3AAUM82HWjx111W7247EI8kjaGKANp/CnANqLLeeZY5zt
imTNfh+b6TFDkGvOcwykVIxEzAU1YJub/Jv6kAew3VMlL4i39kUPI+qfrrezc4xm
Ms9uGroN5mLC8zcBiM9L+eBFp+2bgortbDjwjFWbhOK5GPJl7WsFRe2xKg8Yj1dj
/WFFzceIUG3ehSWWebSqXL1cQhc8BtOgum5maV2COP9jJI97zC7NPZ45lsxZWGP/
YLwuVDg+0ce35kbMYyPRamSv6czXz+Wihe7sNyue486Q9X36PdkFH7f7CMoG1vHZ
XprAFKmyQYij36U7wcQsAocU5UY+u33ZJ7nEGNBwfcn8sxrkO6phMClmeA+IM6qi
BuA2wQLuL8+xJSEkyl6wokrnL5/CNJ1fYgpl2cBEtThgUm8rskuA/0xiV6Na9jQP
L5wT5zKlFChFUhYJKlL3O34czr52a1aUNcypuBvYui++JVVuKrO4bLf+pln3Wnn/
mwfyryImYZBmYaOZ4MJd3p10+HAkfxDY8OIUoHuzdpFve6iB9RjFYY0tYofcIrHA
YcsGKkLKa6d1ptCKD4i8wwvSwq9Dobl4FAaSNeMDr0ZHG+Y11PF/QIcKiW/NSUrC
TRhXYq+WR4aCbUIQuanU
=Oxzf
-----END PGP SIGNATURE-----

--qCb2VTfFGdRLn6RH--
