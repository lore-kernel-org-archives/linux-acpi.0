From: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Subject: [Fwd: RE: acpi-20030328-2.4.21-pre6.diff on Toshiba hard
	locks]
Date: 29 Apr 2003 13:30:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051641012.7325.14.camel@kahuna-ws.robhughes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hccJpxAJ3yhx1pzqUUjO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-hccJpxAJ3yhx1pzqUUjO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Forgot to include the list on this. It may be of interest or it may not.
And just to refresh everyone, the model in question is a Toshiba
5005-S504.


Thanks,
Rob

-----Forwarded Message-----

> From: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
> To: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
> Subject: RE: [ACPI] acpi-20030328-2.4.21-pre6.diff on Toshiba hard locks
> Date: 25 Apr 2003 23:40:08 -0500
>=20
> Ok, I still don't know exactly what it is, but it's related to loading
> both the sound and the ohci1394 modules. When I rem out the line for
> ohci1394, the system functions as expected. And come to think of it,
> that module always failed to load before, but I'd never taken out of my
> modules.conf. I was also able to boot the older problem kernels
> successfully, *so long as the ohci1394 modules isn't loaded*. So, I
> haven't a clue how to fix this, but at least that's more data.
>=20
> Thanks,
> Rob
>=20
> On Fri, 2003-04-25 at 22:38, Cagle, John (ISS-Houston) wrote:
> > OK, thanks for trying that.  It pretty much rules out the area of code =
I
> > thought might have been involved.  Must be some other bugaboo...
> >=20
> > Good luck,
> > John
> >=20
> > > -----Original Message-----
> > > From: Rob Hughes [mailto:rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org]=20
> > > Sent: Friday, April 25, 2003 9:06 PM
> > > To: Cagle, John (ISS-Houston)
> > > Subject: RE: [ACPI] acpi-20030328-2.4.21-pre6.diff on Toshiba=20
> > > hard locks
> > >=20
> > >=20
> > > Still get a hard lock. Thanks though. About to see what=20
> > > happens with the -rc1 and 20030424 patch.
> > >=20
> > > On Fri, 2003-04-25 at 18:28, Cagle, John (ISS-Houston) wrote:
> > > > Thanks, Rob.  Have you tried using "acpi=3Doldboot" with the=20
> > > new kernel?


--=-hccJpxAJ3yhx1pzqUUjO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Please use bofh key to send me personal data.

iD8DBQA+rsSz/9y+qWKu6HERAkMjAJ9pVf2FObHEN0bfDMfM7/4N/Sb+/ACfXU6h
KXHlgD8CLcbKZILdaWfz1TA=
=CNLB
-----END PGP SIGNATURE-----

--=-hccJpxAJ3yhx1pzqUUjO--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
