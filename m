From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: Kernel instability problem
Date: Tue, 13 Aug 2002 08:18:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020813081825.A798@tarnation.dyndns.org>
References: <200208130037.51909.jasonb42lists@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200208130037.51909.jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>; from jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org on Tue, Aug 13, 2002 at 12:37:51AM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Jason Bowman <jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If you haven't already, try disabling your sound... gaim will (by default)
play a sound when you receive a message, xine probably tries at least=20
opening the sound device when it loads, and KDE starts aRts, I believe, whi=
ch,
like Gnome's Esound, will open the sound device in order to multiplex deskt=
op
sounds. Maybe there's a conflict somewhere brought about by ACPI (did you t=
urn
off "Plug 'n Play OS" in the BIOS?).

And lo, upon Tue, Aug 13, 2002 at 12:37:51AM -0400, Jason Bowman spaketh th=
usly:
>=20
> Hello all,
>=20
> I have an HP zt1190 laptop, reportedly the same as the xt1100 series. I h=
ave=20
> found that whenever I use an ACPI kernel (I have tried 2.4.18 w/ 20020611=
=20
> 20020726 patches) and run gaim my machine freezes. This also happens with=
=20
> xine. Gaim freezes when someone sends me a message, xine at startup. Runn=
ing=20
> KDE 3.0.1 the display remains in a frozen state, nothing moves/changes/et=
c. I=20
> can't switch to an virtual desktops either.
>=20
> Anyone have any clues? I would like to investigate why this happens and h=
elp=20
> to fix it, however I don't know what to try next. Pointers appreciated.
>=20
> Thanks,
> Jason B.
>=20
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code1
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1Y+REACgkQwXDG7ZQN91fnrACfZOIT1RJyO0MqmIvavb524qbm
lpIAoIJsNstqDz0zBKkMUfyxRf89l4zK
=4582
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
