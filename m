From: Ethan Glasser-Camp <glasse-IL7dBOYR4Vg@public.gmane.org>
Subject: Re: Oops during startup
Date: Tue, 8 Jun 2004 14:35:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040608183525.GB613@paladin>
References: <20040602013512.GA570@paladin> <1086157732.2833.155.camel@zion.2good.net> <20040602161747.GA563@paladin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040602161747.GA563-FdgSi869q7U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2004 at 12:17:47PM -0400, Ethan Glasser-Camp wrote:
> On Wed, Jun 02, 2004 at 08:28:52AM +0200, David Eriksson wrote:
> > I suggest that you first verify that you have the latest version of the
> > BIOS and Embedded Controller Program. Compare the numbers provided by
> > your BIOS with those on this page:
> >=20
> > http://www-3.ibm.com/pc/support/site.wss/document.do?lndocid=3DMIGR-423=
58
>=20
> I have upgraded the EC to the most recent version. No changes -- same
> oops during startup.

Today, I got my old T-30 back, complete with decals. The same oops
happens on startup of 2.6.6. The work order says that in addition to
replacing the fan and CDRW drive, they updated the BIOS. So I'm pretty
certain the BIOS is causing a kernel oops. I tried the patch by
Shaohua Li but I still get the kernel oops.=20

What else can I do? Should I put a bunch of printks all over the
place, to see where the crash is, and under what conditions? Should I
try more versions of the kernel? Would you like to see the tables for
the machine?

Ethan Glasser-Camp

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFAxgbtJATS9vswN4oRAkNEAJ9kiu+VwnvmJzvbdXnrOExLqp08RACfdTiJ
Nxr4CoDzgaiZvtzuqzRHsI8=
=TIX/
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
