From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Missing acpi-20050101-2.6.10 patch?
Date: Fri, 7 Jan 2005 09:56:05 +0100
Message-ID: <20050107085605.GA19136@fuchi>
References: <1105040016.11930.11.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1105040016.11930.11.camel-7g89Hwo0MwsWlyYapE9R8Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Henrik..

* Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> [2005-01-07 09:45 +0100]:
>=20
> A new release of the acpi patch dating 2005-01-01 was announced at
> http://acpi.sf.net, but it is not present in the download directory at
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2=
=2E6.10/
>=20
> The latest patch available at the above mentioned ftp site is dated
> 2004-12-10 and doesn't contain any patch - only a ChangeSet list.
>=20
> Where can I find the lastest ACPI patch?

acpi-20050101-2.6.10 does not exist. the date given in that filename is
not the date of the release of the patch but the date of the release of
the ACPI-CA implemented by that patch. besides the latest ACPI-CA, a
patch also includes Linux-specific code. please correct me, if i am
wrong, Len. :)
Len released yet another patch yesterday, go download:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6=
=2E10/acpi-20041210-2.6.10.diff.bz2

hth,
 Sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB3k6lreHfL3pi+bQRAluTAJ9wx1yDmfC4NgfkI23vrkD5+4O88wCfaORb
ynSQaxV5YkWQ/oV/YaG2aec=
=HRys
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
