From: Jose Luis Domingo Lopez <linux-kernel-xyiX3/p4JzBDPfheJLI6IQ@public.gmane.org>
Subject: Re: Linux v2.6.13-rc3
Date: Wed, 13 Jul 2005 21:45:40 +0200
Message-ID: <20050713194540.GC29529@localhost>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org> <200507131259.04855.rjw@sisk.pl> <Pine.LNX.4.58.0507131145310.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131145310.17536-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday, 13 July 2005, at 11:53:08 -0700,
Linus Torvalds wrote:

> Len, ACPI people - can we fix this regression, please?
>=20
> Rafael even pinpoints exactly which patches are causing the problem, so=
=20
> why didn't they get reverted before sending them off to me?
>=20
> Grumble. I don't like being sent known-bad patches when we're trying to=
=20
> calm things down.
>=20
Also related to ACPI, a patch went in recently that prevents some boxes (at
least mine) to power off properly via ACPI. The patch is:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdif
f;h=3Dcee5dab4856f51c5cad3aecc630ad0a4d2217a85

As the commit log says, this was somewhat expected. I sent a message a
couple of days ago both to the list and to Eric W. Biederman, with no
response so far. Message Subject: is:
[2.6.12-git8] ACPI shutdown fails to power off machine
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D112094139204799&w=3D2

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc2)


--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1W9kao1/w/yPYI0RAjzUAJoC1fqYNqjEa9DzjjdyvELkDdUWQgCgg/MH
9awrCGEqA4SqGfkH9fXBQXc=
=r8FG
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
