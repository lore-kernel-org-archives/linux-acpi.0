From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
Date: Sun, 8 Dec 2013 19:40:40 +0000
Message-ID: <20131208194040.GN29268@sirena.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de>
 <20131206135825.GG29268@sirena.org.uk>
 <201312080344.56317.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1097733504947585587=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201312080344.56317.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Jon Masters <jonathan@jonmasters.org>, Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-acpi@vger.kernel.org


--===============1097733504947585587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEFDyIIeORe/70g6"
Content-Disposition: inline


--PEFDyIIeORe/70g6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2013 at 03:44:56AM +0100, Arnd Bergmann wrote:
> On Friday 06 December 2013, Mark Brown wrote:

> > OTOH if it's well encapsulated, is going to be required for any kind of
> > ACPI use and gets to the point where people are OK with it by itself
> > then I'm not sure what we'd gain by keeping it out of tree - it'd make
> > the real system patch sets bigger and harder to review.

> I'd agree as soon as someone can convince me that we actually want ACPI
> support in the kernel for ARM64 servers. As far as I'm concerned it's qui=
te
> possible that the people who have worked on this for the past couple of
> years behind closed doors know what they are doing and it will all be
> good, but it's also possible that it turns into a huge trainwreck once
> we see multiple implementations that have fundamentally incompatible
> requirements regarding what they want from ACPI and we end up not doing
> it at all. I just don't have enough information at this point to know whi=
ch
> of the two is true and I'd like to ensure that accepting the patches
> that meet your criteria above would not be seen as an endorsement to do
> crazy stuff later.

I do share all your concerns about the closed door stuff, and I'm also
not convinced that they'll be able to control the things people try to
do with it if it does become at all successful. =20

That said I don't think anyone could be in any reasonable doubt as to
the concerns that people have at this point and I do worry that keeping
everything out of tree will both increase reviwer fatigue if it does end
up getting merged and increase the chances that we end up with a
deployed fiat accomplait being submitted.  We can always add dire
warnings and so on to the code and Kconfig to try to remind people but
so long as it's neither getting in the way of anything else nor making
any real decisions (as opposed to basics for the core spec) I'm not sure
how much we gain, if it never goes anywhere it can just sit and rot
quietly in a corner until it gets in the way.

--PEFDyIIeORe/70g6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpMs1AAoJELSic+t+oim9c7oP/jzTkeve1eLG+2mPnFcqXN8M
mc5vM6s2PIC3HfLAe1UilKSy+73FFlZ8mXcwE+8Xv+xQrzhnTlTiLj9rwez+CH3l
SQ2fqZS3+Xuwg++Mp5tVPMlYBS94z908lvvjdvdG9pq63jrK25Sq9KgaspFPsRa/
BX7EGp21V20z0WjCuo+AY4kNqOVL2ZhcKlpdsJZk0Ls/niaL45mk4As5+Sv+j5OE
rSTs90o1Pg5fMq3WOQjuaItN2/u29Wz8onhy5N5pi2AboJoVvw40ZlAKLOE2e25X
kdW6c93sAdvi8NMhnmdidLt78EtrXgmwf2GkVU81Lfukx6eSFiEuCnfFT/Apf0J1
Oo2X22OJnS9kR70nRDLZ7U/ntL2H2fhqJQN/aQVclAxkmk3IbpBDMgZb7TasPV+C
zVnBNGmAo1RVCPYNDrlGiJHB1dGZyJNqCGkz9FcE9T0HGFc/MsZ/4FfoFFBW1t8d
tGZYTUDFrfEVvcXZA0V3E9gS+cP4JZIzN9yEZRizkXI1v5BzBzlafOPJh7pHQaJi
+lxZE9OL9RQ9sS7Nw/d3sY0cStGhH1GDIgSaUy9BQjXLrNiBk0oqIDoHrj49POlO
T9gt2klIAndLloCCPBARiI72KCTG5Kf1vdlRrknMFZkB15P7EDHOs0Pw2u88wbch
8UWhPdVWfjk9Ciz6xgdG
=F/wQ
-----END PGP SIGNATURE-----

--PEFDyIIeORe/70g6--


--===============1097733504947585587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1097733504947585587==--
