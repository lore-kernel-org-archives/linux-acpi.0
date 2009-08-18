From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Tue, 18 Aug 2009 10:13:59 +0300
Message-ID: <20090818071359.GA3713@localdomain.by>
References: <20090812201034.GA2983@localdomain.by>
 <1250498613.28336.68.camel@minggr.sh.intel.com>
 <20090817113059.GA3245@localdomain.by>
 <d3f22a0908170622x7dd9ce73m5c3ea86406cc9935@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752794AbZHRHKl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d3f22a0908170622x7dd9ce73m5c3ea86406cc9935@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <lin@minggr.cn>
Cc: Lin Ming <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (08/17/09 21:22), Lin Ming wrote:
> > rc6-git2
> > 25 successful reboots.
> >
> > I'll need some more time to test against rc5.
> >
> > /*should I also test DSDT in case region-debug.patch fixed the problem?=
*/
>=20
> Yes, please also help to test the custome DSDT.
> region-debug.patch is just a debug patch.
> We need to root cause the problem clearly and then work out a clean solut=
ion.
>=20

Hi, Lin
Looks like DSDT didn't solve the problem (oops on 4th reboot).

So:
region-debug.patch	+
DSDT			-

/* Is that possible? */

Should I Cc rui.zhang@intel.com?

	Sergey

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkqKVLcACgkQfKHnntdSXjQdbwP/bed9mCj98LEhpyIy5P8SbWFN
60Wn8mnZqTKGw2Q9kIETcZH46jzAmYEWTYqtLcrQAjGW8giLExEdHMh6fKZIxvTF
0nyZpY5eKbvT2ZS4nz5AD+XnOgiJxi6Px8tPFv/SSlQgdnp1wrEjslx9poxFnYJq
EgKLbBAsXyqjodCq1FA=
=GV4N
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
