From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Getting the initrd dsdt table running
Date: Tue, 18 Nov 2003 16:09:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031118150934.GA1715@enigma.daemon.sh>
References: <0HOB00CMINOCSC@mailhost.njit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0HOB00CMINOCSC-PYEadblV/CkRaffoSZVBSIdd74u8MsAO@public.gmane.org>
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


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi...

* Brian Peyton <bpeyton-DUV0O6k01bo@public.gmane.org> [2003-11-15 09:42 +0100]:
> I've got a Dell Inspirion 5100.
>=20
> I'm trying to get 2.6.0-test9 working with the initrd dsdt table patch.  I
> normally don't use an initrd, and on his page it says that if I don't use=
 an
> initrd I can just set the initrd to the binary lookingish .aml file that
> iasl produces.  So in my grub.conf file I have the line:
> Initrd /boot/initrd
>=20
> Where the contents of initrd is the .aml file.  From dmesg it still says =
not
> detected.  How can I fix this?

the contents of the initrd is not the AML only, it also contains a magic
signature:

echo "INITRDDSDT123DSDT123" >> /boot/initrd # magic signature
cat DSDT.aml >> /boot/initrd


otherwise, you are sure that the patch is included in the kernel? what
is the exact output (dmesg)?

cheers,
 sebastian

--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ujYureHfL3pi+bQRAmn+AJ0elWpuR6zi9/aEW+v32UBmN4CPCwCeJsZ4
cCA7SgOo8TvZYkaqx6AJeDs=
=gaOs
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
