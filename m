From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: [PATCH 2.6] update passive cooling algorithm
Date: Mon, 12 Jan 2004 18:39:22 +0100
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <20040112173922.GA6154@dominikbrodowski.de>
References: <20040111211255.GA31105@dominikbrodowski.de>
	<20040112154611.GH14031@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57847486923559766=="
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040112154611.GH14031@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org


--===============57847486923559766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2004 at 04:46:11PM +0100, Ducrot Bruno wrote:
> On Sun, Jan 11, 2004 at 10:12:55PM +0100, Dominik Brodowski wrote:
> > [Len, could you test and verify this patch, and push it to Linus, pleas=
e?]
> >=20
> > The current algorithm used by Linux ACPI for passive thermal management=
 has
> > two shortcomings:
>=20
> ...
>=20
> > +/* If a passive cooling situation is detected, primarily CPUfreq is us=
ed, as it
> > + * offers (in most cases) voltage scaling in addition to frequency sca=
ling, and
> > + * thus a cubic (instead of linear) reduction of energy. Also, we allo=
w for
> > + * _any_ cpufreq driver and not only the acpi-cpufreq driver.
> > + */
>=20
> Just a stupid question:
>=20
> What is best if processor heat issues (apart turning on the fan)?
>=20
> Reducing voltage of the processor, but still allowing it to run execution
> at 100% (which is the case if the processor is heating), or reduce
> amount of time allowed for the processor to execute?

voltage scaling. It offers a much better (quadratic) saving than clock
modulation (linear saving). Doing both [and you need to do it, as the CPU
won't run with fewer volts at the same frequency] gives you cubic savings.

	Dominik

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAtvKZ8MDCHJbN8YRAsQhAJ45hhFDMKiU02RqV/vuBIrbL/51oACfUNoK
BLgQ9ImjnuvyQT8gS/pNHEI=
=VjvN
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============57847486923559766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

--===============57847486923559766==--
