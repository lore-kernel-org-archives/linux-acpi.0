From: M G Berberich <berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org>
Subject: Store(Local0, Local0); Nvidia
Date: Sat, 17 Aug 2002 19:48:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020817174826.GA12124@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I tried to fix the dsdt table of my Sony Vaio FX502, because it does
not power off itself, but only found 10=20

  Store(Local0,Local0)

errors.=20

Store Local0 to Local0 does not make much sense for me, it seems to be
a kind of NOP. Should these be fixed? How?

BTW., I had on of these on my GA-6BXD too, and changing it to=20
(Store(0x0,local0)) does not change the behavior at all. It also does
not power off if shut down.


I could not get the NVidia-driver to coexist with acpi, it chrashes
the machine if startet with an acpi-patched kernel.

The interrupts change if acpi is used:

   |  with ACPI       | without ACPI
---+------------------+----------------
16 |                  | NVidia
17 |  EMU10k1, NVidia | EMU10k1
18 |  eth0            | eth0
19 |  sym53c8xx, usb  | sym53c8xx, usb

I doubt this is the reason, but anyone knows fore sure?

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9Xoxqnp4msu7jrxMRAkG5AJ48vk1yTTUsiJk+wi9I94xY/rDgoACgggt8
pQgL7uz2988ASM2CelEl3Ew=
=8fXQ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=3Dsourceforge1&refcode1=3Dvs3390
