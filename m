From: Raul Aranda Blasco <raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org>
Subject: Re: fan control
Date: 01 May 2003 20:56:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051815380.608.17.camel@localhost>
References: <20030501185137.C926@fermat.unipv.it>
	 <1051813408.607.3.camel@localhost>  <20030501203309.B1662@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BHSDArTaMpQdHXhB3k/9"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030501203309.B1662-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-BHSDArTaMpQdHXhB3k/9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-01 at 20:33, Daniele Boffi wrote:
> I think I didn't explain the question correctly. The fans and the thermal=
 zones
> do work well. No problems at all. I was just wondering about the conseque=
nces
> of playing with the fans (like I did with changing their status). If I re=
boot,
> then the next session is OK..., but within the same session, suppose I ju=
st
> switch the fans from one to two and then back to one. Then, I start some =
heavy
> job and the temperature increases. Will then the kernel spin the fun up o=
r my
> previous action prevents it from doing so?

  That's what I meant before

  After changing the fan speeds and stopping them, try to compiling a
kernel and use "acpi -V" to see how the temperature goes up and the fan
starts to work (managed by the thermal zone).


--=20
Un saludo
    Raul Aranda Blasco
    raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org
    http://elistan.dragon-lance.net

--=-BHSDArTaMpQdHXhB3k/9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sW3UThWTEkNSi5cRAg2YAJ0fE7z6jHMlHS3BUceUpecWI0PIuQCdGm/q
80fj5cIq7FtBKqJZS4Sf9xc=
=Nj/B
-----END PGP SIGNATURE-----

--=-BHSDArTaMpQdHXhB3k/9--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
