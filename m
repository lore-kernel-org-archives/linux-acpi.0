From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron 8200)
Date: Wed, 18 Feb 2004 21:49:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040218204907.GA14856@dominikbrodowski.de>
References: <200402181320.29381.mailinglists@glomann.de> <1077111155.2028.3.camel@personal-118.mip.sdu.dk> <200402182017.47960.mailinglists@glomann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402182017.47960.mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Maybe this is caused by the CPU being put into an idle mode (C-State). If
the HD is active, bm_activity [*] will be high and C3 will be disabled for
this time, so you won't hear the noise then. The difference between 2.4. and
2.6. is the different HZ value -- in 2.4., the sound was of ~100Hz
frequency, now it's 1kHz...

	Dominik

[*] you can see that in /proc/acpi/processor/*/power

On Wed, Feb 18, 2004 at 08:17:47PM +0100, Thomas Glomann wrote:
> On Wednesday 18 February 2004 14:32, Mads Paulin wrote:
> > Hi Thomas,
> >
> > funny you mention it, I thought I was going crazy.
> >
> > I experienced the same thing, and discovered it to be the hard drive.
> >
> > Try to spind the drive down using hdparm and see if that helps.
> >
> nope, putting the drive to sleep doesn't do the trick. the sound remains.=
=20
> Moreover I don't see how this "solution" was meant to work? Does the soun=
d=20
> reappear when you wake up your disk or does it keep silent after a nice=
=20
> "onetime" sleep?
> > Obviously this is not a solution, but if it helps, kernel 2.6 could have
> > some other way of controlling the disk than 2.4.
> >
> Still it doesn't explain why that sound is gone when disabling the whole=
=20
> acpi-system.
> > The noise disappears when my hdd is under heavy load.
> > - Maybe you just cant here it then, or it actually disappears because it
> > is no longer idle
> >
> well thats true. as long as the disk is Not idle, the noise is gone. But=
=20
> returns right after.
>=20
> > Regards
> > Mads
>=20
> So any other ideas?
>=20
>=20
> Thomas
>=20
>=20
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM8/DZ8MDCHJbN8YRAv8NAJ49BFIx48nf7UbddWrSSWgYJGlcpgCfaHe5
XCnnEwzatgGng/nQ87TRJGk=
=O/iD
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
