From: Ronald Hitz <Ronald.Hitz-1NtEGJHV5g0@public.gmane.org>
Subject: Fwd: Re: 2.6.8 using 2.6.7 dsdt in initrd patch won't load dsdt
Date: Wed, 15 Sep 2004 15:50:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1C7aB8-0008Gh-00@mail1.isc.de>
Reply-To: Ronald.Hitz-1NtEGJHV5g0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Ronald Hitz <Ronald.Hitz-1NtEGJHV5g0@public.gmane.org> -----

Date: Wed, 15 Sep 2004 07:58:04 +0200
=46rom: Ronald Hitz <Ronald.Hitz-1NtEGJHV5g0@public.gmane.org>
User-Agent: Mutt/1.5.6+20040722i
To: Ois=EDn Mac Fheara=ED <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Reply-To: Ronald.Hitz-1NtEGJHV5g0@public.gmane.org
Subject: Re: [ACPI] 2.6.8 using 2.6.7 dsdt in initrd patch won't load dsdt

Hi Oisin,

since I've compiled my DSDT yesterday and load successfully,
I tell You, that with 2.6.8.1 there is an option in the kernel to load
an custom dsdt, where have to tell exactly( full path), where the dsdt
is and it was loaded successfully.

Maybe that helps You.


Regards

Ronald Hitz

On Tue, Aug 31, 2004 at 09:55:28AM +0100, Ois=EDn Mac Fheara=ED wrote:
> Hi all, sorry to bring more mundanity to the list, but this has been real=
ly=20
> annoying me for the last day or two.
>=20
> I (probably) fixed my DSDT, compiled it successfully, and have tried nume=
rous=20
> ways of loading it at boot through an initrd patch (I couldn't find a 2.6=
=2E8=20
> patch, but the 2.6.7 patch I found seemed to apply well enough, without m=
uch=20
> fuzzing...).
> The machine appears to find it, but it doesn't actually load it.
> If anyone knows why not, or if I did something obviously wrong, please le=
t me=20
> know.
>=20
> thanks,
> Ois=EDn
>=20
> here's the relevant output in dmesg - I believe if it had loaded the tabl=
es=20
> from the custom DSDT, it would have said so just after the "ACPI: Subsyst=
em=20
> revision nnnn" line (and I can tell that it hasn't, as it refers to an er=
ror=20
> in the DSDT I had fixed, by changing both references to Z00D to Z00C):
>=20
> ACPI: Looking for DSDT in initrd ... found (at offset 26218)!
>  found customized DSDT with 16040 bytes!
> Freeing initrd memory: 41k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=3D1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040816
> evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs at=
=20
> 0000000000008020 on int 0x9
> evgpeblk-0989 [07] ev_create_gpe_block   : Found 5 Wake, Enabled 0 Runtim=
e=20
> GPEs in this block
> evgpeblk-0980 [07] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs at=
=20
> 0000000000008030 on int 0x9
> evgpeblk-0989 [07] ev_create_gpe_block   : Found 1 Wake, Enabled 1 Runtim=
e=20
> GPEs in this block
> Completing Region/Field/Buffer/Package=20
> initialization:.................................................. =20
> psargs-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
-----------> search_node dfda3228 start_node dfda3228 return_node 00000000
---------------
snip



--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBSEisIZtySvzDl4oRArr/AKCWGIcg/6cEG7gdSdwDcmURHZcX0QCgvG9P
JhU4rJhIDz+8BYs0VBDiY4E=
=Qm1q
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
