From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: ACPI, klaptopdaemon patch - battery status in KDE3
Date: Wed, 14 Aug 2002 22:50:09 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020814225009.A17815@tarnation.dyndns.org>
References: <20020815001634.36933.qmail@web14203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020815001634.36933.qmail-Km5/rSCkvXWA/QwVtaZbd3CJp6faPEW9@public.gmane.org>; from h_brunsting-/E1597aS9LQAvxtiuMwx3w@public.gmane.org on Wed, Aug 14, 2002 at 05:16:34PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "H. Brunsting" <h_brunsting-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And lo, upon Wed, Aug 14, 2002 at 05:16:34PM -0700, H. Brunsting spaketh th=
usly:

> It refers to proc/acpi/ac_adapter/AC/state, and on my
> system this entry
> shows up as proc/acpi/ac_adapter/ACAD/state - ACAD
> instead of AC. I don't
> know if this is being caused by my laptop not
> conforming to the standard or
> the standard acpi software, either case it's worth
> noting, because I am sure
> I am not the only one having this problem (which is
> now solved by editing
> the source of portable.cpp). I'm not really a cpp
> coder, but I'm sure
> another line checking proc/acpi/ac_adapter/ACAD/state
> in the same way as it
> is done with AC will solve the problem for most
> people.
>=20

The acpi patch for gkrellm has the same problem, and
not just with the AC adapter, but with almost all the=20
acpi devices (battery, thermal, etc.). The simple
solution is to patch your copy of the code with the right
paths for your box, but the correct solution is probably
to match any directory under (for example) /proc/acpi/ac_adapter
(presumably if there's more than one directory, there's more
than one such device).

There's gotta be a better way to check for the newer ACPI
stuff than seeing if one of the expected files exists anyways...

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1bFuEACgkQwXDG7ZQN91coKwCeJJZArunca3vfI5CB2evdOYJl
swIAoJ46Ubegc5G17/6dkuCJOkDwuaZ9
=zC3E
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
