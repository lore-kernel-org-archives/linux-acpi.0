From: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: RE: bug in acpid scripts
Date: Sat, 24 Jul 2004 21:42:10 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090719730.5124.361.camel@localhost>
References: <B44D37711ED29844BEA67908EAF36F03665E4F@pdsmsx401.ccr.corp.intel.com>
Reply-To: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SqjbdPIUOg+g+SA2bZ1Z"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03665E4F-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-SqjbdPIUOg+g+SA2bZ1Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Neat! I'd like to help test your patch, if you wouldn't mind posting it.
Is there anything specific behavior (good or bad) you would like me to
check for?

Russell

On Sat, 2004-07-24 at 09:23, Li, Shaohua wrote:
> I'm working to disable all events sent to acpid (of course including
> button event) when system is resuming. The patch is very
> straightforward. But I need time to verify if it has side effect for
> acpid.=20
>=20
> Thanks,
> Shaohua
>=20
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Garrett
> >Sent: Saturday, July 24, 2004 8:50 PM
> >To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] bug in acpid scripts
> >
> >On Fri, 2004-07-23 at 20:36, Russell Neches wrote:
> >
> >> My system always enters S3 without complaining, and resumes without
> >> complaining. Then it immediately begins a clean shutdown. I had
> assumed
> >> this was caused by general S3 breakage, but the problem is actually
> >> caused by acpid catching the power button event that triggered the
> >> system to resume. It then dutifully calls powerbtn.sh, and the system
> >> shuts down.
> >
> >My current workaround is to make button support modular, and then
> remove
> >the button module during suspend. The power button event then gets
> >ignored on wakeup.
> >
> >--
> >Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
> >
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by BEA Weblogic Workshop
> >FREE Java Enterprise J2EE developer tools!
> >Get your free copy of BEA WebLogic Workshop 8.1 today.
> >http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=-SqjbdPIUOg+g+SA2bZ1Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAw/xHeAQ1TJNf5IRAsFbAJ47hKOhvABPGimK6HA82kEnYil3RQCfXEhb
O6a6fx8g7ux/dmxpYWQYp3E=
=JDPj
-----END PGP SIGNATURE-----

--=-SqjbdPIUOg+g+SA2bZ1Z--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
