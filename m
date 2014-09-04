From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v5 1/2] Mailbox: Add support for Platform
 Communication Channel
Date: Thu, 4 Sep 2014 23:20:19 +0100
Message-ID: <20140904222019.GR29327@sirena.org.uk>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org>
 <5470309.KpxVtJyk9p@wuerfel>
 <CAJ5Y-eYj4vv3rmyaEiO5e9fmbeHX0eM1S9OuNn5R=9dPza_39Q@mail.gmail.com>
 <4354903.8scPjxmpFT@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M+v2aDNX3KeyWL9I"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50519 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbaIDWUe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 18:20:34 -0400
Content-Disposition: inline
In-Reply-To: <4354903.8scPjxmpFT@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--M+v2aDNX3KeyWL9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2014 at 09:00:11PM +0200, Arnd Bergmann wrote:
> On Thursday 04 September 2014 13:24:25 Ashwin Chaugule wrote:
> > On 4 September 2014 04:56, Arnd Bergmann <arnd@arndb.de> wrote:

> > >> +     /* Flip CMD COMPLETE bit */
> > >> +     iowrite16(0, &generic_comm_base->status);

> > > using writel_relaxed/writew_relaxed should be more efficient here.

> > x86 doesn't seem to have the write*_relaxed variants? They seem to
> > have read*_relaxed though.

> That sounds highly inconsistent and should probably be fixed.

Will has a series for this but it needed some revisions for consistency
with DMA.

--M+v2aDNX3KeyWL9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCOWgAAoJELSic+t+oim9Tw0P+waVdw/V/JqUDKkU/kgOWoLe
vn5HTXiSHhxdEZT1f/ZCxPrvpcWYvj6ok60jslmilMeYPmruhklRFF3trbXcecl0
rw8E0TsruCtT7TSDJfLpv35zLPObPisv0sxGzXC5aK/hEoSZxht0qF8bKcaeR5d3
aO0RewPu7BYndB2xsZPZwhKIbGPQ+PK1jsCbCS4tvEh3FxLoRsxkjZcHhPQeBZR8
b0zuQOwn1uHMd5hx+deiCiNFi0ByvvwcjUE0B1ed9JQSdoImesFkGBP9r1Z4PoXb
6qjU1GqXUI/N3C7jYbaS7Ggl7e7wActJuF7GSx2y0tIGy1U2EBs3lrk5ICvru1PM
wF4Ab8U5grZknxQf28ewS1bUBdk7Kz+qhxYFYqCWQlLOuhted/GFy2zNPkLFzjzv
QwpezIld3PngUXlW9VFbI184G2xUjw6UaMje6Oedtnzeqzu4F6mKtNsha9JGfVvj
vs6vwpVT/T5woOMpChd741nXQP+iwiaQsnexR85zhMdaS3LzcmTqMbdRdmHKkkLN
3uVXWlyuAdiooOX5a7yETi3yP8xbKpCRIkAV6GPjf7SbdGZIYCDLbcDGDAqHcorV
xC48PDdJAKwI9iPg28UHhfpabunT10rn6FizGdQQiuuHsMeHaaMts9sMSvnXi/bc
HyWc9mmR+2ucC7Hy3+Lt
=eNYS
-----END PGP SIGNATURE-----

--M+v2aDNX3KeyWL9I--
