From: Franck SICARD <franck.sicard-ogSpCaIBj4NeoWH0uzbU5w@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 11:03:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502090345.GA1790@megaruth>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local> <20030502103102.A2867@fermat.unipv.it>
Reply-To: Franck SICARD <Franck.Sicard-ogSpCaIBj4NeoWH0uzbU5w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030502103102.A2867-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
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


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2003 at 10:31:02AM +0200, Daniele Boffi wrote:
> Indeed, it seem that after rebooting my machine forgets about the fact th=
at I
> was playing with the fan status. What I don't understand in Raul's messag=
e is
> why I should compile a new kernel. The one I have is OK and does not seem=
 to be
> screwed up by my experiments with the fan.

he want that you compile a new kernel to do a test (you could choose
any other action that is CPU hungry (compile X11, crack prime number,
=2E..)). By doing so the temperature of the CPU should increase, and then
you will see if the fan switch on.
There is no risk that you burn your CPU. if the fan don't go up and you
system freeze, just switch it off (no panic you have time) and report to
the list that the fan did not switch on.

	Franck

--=20
Franck SICARD            <Franck.Sicard-ogSpCaIBj4NeoWH0uzbU5w@public.gmane.org>           http://3demi.n=
et/
PGP key=3DDFDFA865 fingerprint=3D8E2E 167E 9503 461B AD76 D962 2EEE 9869 DF=
DF A865

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sjRxLu6Yad/fqGURAgxhAJ43JtFBWyXk3XGjwJVdzVMwLDRFggCfQccH
mheQ/TWQU653IVzO4OzS9Y0=
=zwKG
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
