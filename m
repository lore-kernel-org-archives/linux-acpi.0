From: Damian Kolkowski <damian-8hv6UaVLA0HLQ3KC8Z2sWkB+6BGkLq7r@public.gmane.org>
Subject: [BUG] - Thermal or BIOS on VIA_kt-400
Date: Mon, 22 Dec 2003 11:54:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031222105415.ALLYOURBASEAREBELONGTOUS.B13664@kolkowski.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On my new kernel 2.4.23 + acpi-20031203 + (-ck1 && -fix1 on -ck1 for 2.4.23)
my _thermal_ module shows always "40 C" - why?

Is this M/B thermal, or what?
In 2.4.22-rc2 (and -ac3 on that kernel) it was CPU thermal.

Take care.

P.S. I use this to cooling my CPU is this correct for kt-400 and athlon-xp?

setpci -v -H1 -s 0:0.0 D2=3D$(printf %x $((0x$(setpci -H1 -s 0:0.0 D2) | 0x=
80)))
setpci -v -H1 -s 0:0.0 D5=3D$(printf %x $((0x$(setpci -H1 -s 0:0.0 D5) | 0x=
02)))

It's the same as _athcool_ program, when it's on.
I found it on:
http://www.daniel.nofftz.net/linux/Athlon-Powersaving-HOWTO.html

--=20
# Damian *dEiMoS* Ko=B3kowski # http://kolkowski.no-ip.org/ #

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5s1WzbCEkrLF3gMRAqvbAKCNeK6KBYRabdmkqW1F1A+nzmvZBgCgra/y
XdVlYh4a0zZitofVYcSCnFc=
=pemu
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
