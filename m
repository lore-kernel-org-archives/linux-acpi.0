From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Tue, 24 Feb 2004 15:43:18 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040224144318.GA9702@dominikbrodowski.de>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30532261994827259=="
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040224125628.GA438@elf.ucw.cz>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org


--===============30532261994827259==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2004 at 01:56:28PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > Export an array of supported frequencies in sysfs
> > [scaling_available_frequencies]
>=20
> Would it be possible to export [frequency/voltage] pairs, and allow
> user to change it?

IMO, NO! While this might be a necessity for powernow-k7, the generic acpi-=
io
driver should stay clean of such overrides et al. If you need to modify the
ACPI tables, there are other ways.

	Dominik

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAO2MGZ8MDCHJbN8YRAoJlAJwI0z7ED7Y0eMdZC2HNDevULBIf2wCeMN1H
Xd21LwEyOjqZkcOX/XGmH+w=
=lrLn
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--


--===============30532261994827259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

--===============30532261994827259==--
