From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: OneTouch support on Satellite 3k, and possible thermal control policy for some Omnibook laptop. (was Report:...)
Date: Tue, 23 Jul 2002 15:34:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020723153359.B18822@draal.physics.wisc.edu>
References: <1024676521.1631.27.camel@buckelwal> <20020623131509.GA27185@poup.poupinou.org> <1025269713.29998.41.camel@buckelwal> <20020628134952.GA6289@poup.poupinou.org> <20020629212817.A28170@kocom.akoenecke.de> <20020629212435.GA9078@poup.poupinou.org> <20020723074335.GB116@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020723074335.GB116-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Tue, Jul 23, 2002 at 09:43:35AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pavel Machek [pavel-+ZI9xUNit7I@public.gmane.org] wrote:
> Hi!
> > > * Freitag, 28. Juni 2002 um 15:49 (+0200) schrieb Ducrot Bruno:
> > > >=20
> > > > On Fri, Jun 28, 2002 at 03:08:33PM +0200, Gert Wollny wrote:
> > > > >=20
> > > > > The buttons still give no events.=20
> > > >=20
> > > > Yep, but I don't know actually if it is a bug in the AML or in ACPI=
-CA.
> > >=20
> > > Maybe the same problem as on my Toshiba Satellite 3000-514: It gives
> > > events only with a "eisa_set_level_irq(9)"-Statement in
> > > "acpi/pci_irq.c" (Thanks to Dominik Brodowski).
> > > But -- after a S1 and a following wakeup the one and only event
> > > recognized is the power-button (then without acpi-debug-messages in
> > > /v/l/m).
> >=20
> > Interresting.  Thank for the info.  I will look at that.
> >=20
> >=20
> > BTW, I just realized that the HP Omnibook XE3-GF and the Satellite 3000=
 series
> > are made by the same ODM (Compal), and share identical information
> > for the embedded controller in their DSDT.
> > So far, I think the chipset implied is the same.
>=20
> Wow... I have omnibook xe3 on the table (athlon one, ALI chipset, is
> it -GF?)

Neato!  Thanks for pointing your project out!  Attached is a patch for
your omnibook tools for the Compal ACL00 laptop (which is identical to
the Toshiba 3k but doesn't report the same BIOS strings).  Works great!
This laptop is the Excalibur LT-430-S sold by ASLab
(http://www.aslab.com).

I presume once the ACPI code is complete and everyone has patched
dsdt's, the omnibook and tosh3k modules won't be necessary, right?

Otherwise, it might be nice to combine this pile of code.  ;)

Ducrot, is it possible to control the fan with your tosh3k module?  I
notice that it reads fan status but:
    echo 1 >> /proc/toshiba3k/fan
doesn't do anything.  :(  Also attached is a patch for your tosh3k
module to work with this laptop.

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omnibook.acl00.diff"
Content-Transfer-Encoding: quoted-printable

Only in omnibook-2002-07-17.bob: dmi.o
Only in omnibook-2002-07-17.bob: ec.o
diff -cr omnibook-2002-07-17/main.c omnibook-2002-07-17.bob/main.c
*** omnibook-2002-07-17/main.c	Wed Jul 17 00:31:18 2002
--- omnibook-2002-07-17.bob/main.c	Tue Jul 23 09:24:49 2002
***************
*** 59,64 ****
--- 59,65 ----
  	{ "HP OmniBook XT1000",	1, 0, 1 },
  	{ "HP OmniBook 500 FA",	1, 0, 0 },
  	{ "S3000-100",		1, 0, 1 },	/* Toshiba Satellite 3000-100 */
+ 	{ "*",	        	1, 0, 1 },	/* Compal ACL00 (doesn't report a name) */
  	{ NULL,  		0, 0, 0 }	/* Unsupported model */
  };
 =20
***************
*** 327,332 ****
--- 328,342 ----
  	return 0;
  }
 =20
+ static int __init is_acl00(void)
+ {
+ 	if ((strncmp(omnibook_dmi_ident[OMNIBOOK_SYS_VENDOR], COMPAL_SIGNATURE, =
strlen(COMPAL_SIGNATURE)) !=3D 0) &&
+ 		(strncmp(omnibook_dmi_ident[OMNIBOOK_BOARD_NAME], ACL00_SIGNATURE, strl=
en(ACL00_SIGNATURE)) !=3D 0))
+ 		return -ENODEV;
+ 	printk(KERN_INFO "%s: Compal ACL00 laptop detected.\n", MODULE_NAME);
+ 	return 0;
+ }
+=20
  static int __init omnibook_ident(void)
  {=09
  	int model =3D 0;
***************
*** 335,341 ****
  	if (omnibook_dmi_scan_machine() !=3D 0)
  		return -EIO;
 =20
! 	if ((is_omnibook() =3D=3D 0) || (is_toshiba3k() =3D=3D 0))
  	{=09
  		while (omnibook_models[model].name)
  		{
--- 345,351 ----
  	if (omnibook_dmi_scan_machine() !=3D 0)
  		return -EIO;
 =20
! 	if ((is_omnibook() =3D=3D 0) || (is_toshiba3k() =3D=3D 0) || (is_acl00()=
 =3D=3D 0))
  	{=09
  		while (omnibook_models[model].name)
  		{
Only in omnibook-2002-07-17.bob: main.o
diff -cr omnibook-2002-07-17/misc/dmi_strings.txt omnibook-2002-07-17.bob/m=
isc/dmi_strings.txt
*** omnibook-2002-07-17/misc/dmi_strings.txt	Tue Jul 16 01:23:33 2002
--- omnibook-2002-07-17.bob/misc/dmi_strings.txt	Tue Jul 23 09:16:01 2002
***************
*** 69,71 ****
--- 69,84 ----
  Asset Tag: No Asset Tag.
 =20
  ---------------------------------------------
+=20
+ BIOS Vendor: COMPAL
+ BIOS Version: V2.10C
+ BIOS Release: 03/25/02
+ System Vendor: COMPAL.
+ Product Name: *.
+ Version: *.
+ Serial Number: *.
+ Board Vendor: Null.
+ Board Name: ACL00.
+ Board Version: Null.
+ Asset Tag: No Asset Tag.
+=20
diff -cr omnibook-2002-07-17/omnibook.h omnibook-2002-07-17.bob/omnibook.h
*** omnibook-2002-07-17/omnibook.h	Wed Jul 17 00:21:33 2002
--- omnibook-2002-07-17.bob/omnibook.h	Tue Jul 23 09:22:45 2002
***************
*** 26,30 ****
--- 26,32 ----
  #define OMNIBOOK_SIGNATURE		"HP OmniBook PC"
  #define TOSHIBA_SIGNATURE		"TOSHIBA"
  #define S3K_SIGNATURE			"S3000" /* Toshiba Satellite 3000 */
+ #define COMPAL_SIGNATURE                "COMPAL"
+ #define ACL00_SIGNATURE                 "ACL00"
 =20
  /* End of file */
Only in omnibook-2002-07-17.bob: omnibook.o

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tosh3k.acl00.diff"
Content-Transfer-Encoding: quoted-printable

Only in tosh3k-0.1.0.bob/: test_ioctl
diff -cr tosh3k-0.1.0/tosh3k.c tosh3k-0.1.0.bob/tosh3k.c
*** tosh3k-0.1.0/tosh3k.c	Sun May 19 14:34:41 2002
--- tosh3k-0.1.0.bob/tosh3k.c	Tue Jul 23 13:26:58 2002
***************
*** 707,712 ****
--- 707,713 ----
  		char           *model;
  	}               supported[] =3D {
  		{ "TOSHIBA", "S3000" },
+                 { "COMPAL", "*" },
  		{ NULL, NULL }
  	};
 =20
Only in tosh3k-0.1.0.bob/: tosh3k.o

--WhfpMioaduB5tiZL--

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj09vbcACgkQjwioWRGe9K3nogCdGbXnbfUhdXhZSe/pHFFYjH2B
LtoAn1C1e3XECSCoCFDTycIZH9Qg4ZnO
=r4N5
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
