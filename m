From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 21/22] driver core: Start processing deferred probes
 earlier
Date: Tue, 6 Oct 2015 11:45:15 +0100
Message-ID: <20151006104515.GJ12635@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-22-git-send-email-tomeu.vizoso@collabora.com>
 <56130D43.10200@gmail.com>
 <CAL_JsqKBKSsvEuoufc=xesSvcA1bf-X43O0YOvuntUJE5NYCJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g2qYG+WgOEFhwE/z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKBKSsvEuoufc=xesSvcA1bf-X43O0YOvuntUJE5NYCJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--g2qYG+WgOEFhwE/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 09:49:38PM -0500, Rob Herring wrote:
> On Mon, Oct 5, 2015 at 6:52 PM, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > The purpose of the *_sync initcall levels is to allow the corresponding
> > initcall level to use multiple threads of execution instead of a single
> > thread.  The *_sync level provides a location for a wait for all of the
> > threads at the corresponding init level to complete.  This is better
> > explained in the git log:

> The things I was worried about like clk and regulator disabling are
> actually late_initcall_sync, so maybe late_initcall is fine here after
> all.

> However, looking at other *_initcall_sync users, I'm not so sure they
> are doing the same abuse.

They're trying to run at the point where we've completed deferred
probe processing - in other words, at the sync point.  What they really
want is an additional callback at the point where the syncs have
actually happened.

--g2qYG+WgOEFhwE/z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6Y6AAoJECTWi3JdVIfQKRUH/1mUtCLtXBhE6vc5lYkjXBIb
Xz0SlNQV6+vB/ju/WLw70Iy6uI2+VVsfRaohtrBTt7T28dgBiAl4ifXVrnpWZn6W
7KNEkk+mzqycPjG1U///Ix/H0RtXCeY6Sqlpxp1H5PrsrICH0f/gAH9fUPGsF+97
REDaPHVF6NpXBuqjlEGp1g//4r/+z+Q24uM8UpidP4icBdEdDNY009mzD7WFSYPj
dR+ro490GcBNvP4xAjmZxsHbXHgHqPY0v04uHuDQXoE0C2UBu7zA7FsKKqYIemiv
j2DI56Doz4/a2BP1CHH3SWBAA//Md0eMAUML4xmMoy1S7MIY79M6GMtIY25L5IY=
=J/s4
-----END PGP SIGNATURE-----

--g2qYG+WgOEFhwE/z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
