From: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Subject: Re: No events when pressing power button
Date: Fri, 2 Aug 2002 02:26:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020802022638.A10668@tarnation.dyndns.org>
References: <Pine.LNX.4.44.0208020007200.7699-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208020007200.7699-100000-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org>; from Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org on Fri, Aug 02, 2002 at 12:11:29AM +0300
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Tony Glader <Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org>
Cc: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And lo, upon Fri, Aug 02, 2002 at 12:11:29AM +0300, Tony Glader spaketh thu=
sly:
>=20

>=20
> What could be wrong? I tried latest acpid rpm and 'cat /proc/acpi/event'=
=20
> without results. Acpid doesn't write nothing to /var/log/acpid when I=20
> press power button.=20

If you want to read from /proc/acpi/event directly, kill acpid. Otherwise,
the event will be consumed by acpid and you'll never see anything on
/proc/acpi/event.

If you want to see things from acpid, you need to define an event (acpid
won't log any activity unless it has an action defined for the event).
The event matching is regex-based, so you can define a single action
(for instance, append to some log file, for debugging) for any event
using '.*' (or any button event using 'button .*'). Take a look at
the example /etc/acpid/events/sample file (I think that's the name).

--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1KJh4ACgkQwXDG7ZQN91e9uACeOkzbL8vz/CRh17tPEVufbdxz
ufsAoNgw1mwuhrIS4rmke03d+B0omm4U
=EbE4
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
