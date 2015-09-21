From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 08/22] regulator: core: Probe regulators on demand
Date: Mon, 21 Sep 2015 12:39:10 -0700
Message-ID: <20150921193910.GC30445@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-9-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="185D1s7FREAUfc0L"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442844182-27787-9-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--185D1s7FREAUfc0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 04:02:48PM +0200, Tomeu Vizoso wrote:
> When looking up a regulator through its OF node, probe it if it hasn't
> already.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--185D1s7FREAUfc0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAFzdAAoJECTWi3JdVIfQ2zwH+QEiY7KvkRTrQivBaNwqD7pF
wO3WsjhHARp655WHplMXNuznFcoolyGwMwantObK5yu8Odun4gGswAaaPaVDt6lN
dwNrM6ACnpBUh7RqJmMT5u4kHA3PGQgRO0ocXXawgE48YtHjvneDhMYJYpYTMzJj
w1wPZ76bKMY8pucWcz0Ul1bjVEhxatpkPhx9cYFJg+rjrGrO+Hw12iG2UrH/tYJL
iZywNZDSfLZp3SMGOF58hfWuT4EgKd+bQg5YjesG2h866q5QbiEK80prL7RdmCu3
3BzYCf2bB0HY6VRJA/nuIERojGGckbKzFgngYqIEDFK7phxefwllzovJXDFbTSk=
=vqxu
-----END PGP SIGNATURE-----

--185D1s7FREAUfc0L--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
