From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: [ACPI] [PATCH 1/2] 2.6: use scaling_available_freqs in
	acpi-cpufreq-ioport driver
Date: Fri, 12 Mar 2004 15:52:44 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040312145244.GD4813@dominikbrodowski.de>
References: <20040220083149.GA10215@dominikbrodowski.de>
	<20040224125628.GA438@elf.ucw.cz>
	<20040224210040.GA8166@dreamcraft.com.au>
	<20040224221642.GB9145@elf.ucw.cz>
	<20040226172823.GJ2869@poupinou.org>
	<20040226215006.GB397@elf.ucw.cz>
	<20040301175430.GY2869@poupinou.org>
	<20040301180325.GA562@elf.ucw.cz>
	<20040303162255.GK2869@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1602445788=="
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040303162255.GK2869@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Tomasz Ciolek <tmc@dreamcraft.com.au>, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org


--===============1602445788==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 05:22:55PM +0100, Bruno Ducrot wrote:
> > --- clean/include/linux/cpufreq.h	2004-01-09 20:24:26.000000000 +0100
> > +++ linux/include/linux/cpufreq.h	2004-03-01 19:02:48.000000000 +0100
> > @@ -316,6 +316,7 @@
> >  	unsigned int	index;     /* any */
> >  	unsigned int	frequency; /* kHz - doesn't need to be in ascending
> >  				    * order */
> > +	unsigned int	voltage;   /* mV */
> >  };
>=20
> Well, why not?

Four reasons:

1.) not all cpufreq drivers which use frequency table helpers know the
voltage

2.) most cpufreq drivers don't need to know the voltage -- they need to know
a value [=3D=3Dindex] to be written to some sort of register [msr/io/whatev=
er].

3.) sizeof(struct cpufreq_table_entry)

4.) the overrides discussed for k{7,8} are very driver-specific and do
neither belong into the cpufreq core nor into the cpufreq frequency table
helpers.=20

	Dominik

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUc68Z8MDCHJbN8YRAiyAAJ47iGm9DqdcaYU8YPV36BShJfCedwCgoVJv
rZOCul6U17JR1azLrKkRVVY=
=2OEH
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--


--===============1602445788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

--===============1602445788==--
