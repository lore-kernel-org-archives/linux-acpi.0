From: Mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Thermal zones fan control
Date: Mon, 16 Jun 2003 12:45:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030616104510.GC686@mizu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

  (2.5.70-bk19, ACER TM630)
  What does control fans on thermal zones ? (ACPI || BIOS) ??

  What is the value of temperature  for "fan ON/OFF"? (thermal/.../cooling_=
mode)


  The fans of thermal zones dont start when temperature is higher or
  less. They are at the same state all time. ( i have to restart
  computer to change cooling_mode) I am afraid about my laptop, because
  of high temperature.

here is my acpi info:

#cat /proc/acpi/thermal/THRC/polling_frequenci:
	<polling disabled>
=09
#cat /proc/acpi/thermal/THRC/state:
	state:                   ok

#cat /proc/acpi/thermal/THRC/cooling_mode:
	cooling mode:            active

#cat /proc/acpi/thermal/THRC/trip_points:
	critical (S5):           100 C
	passive:                 86 C: tc1=3D2 tc2=3D5 tsp=3D300 devices=3D0xcfeee=
760=20
#cat /proc/acpi/thermal/THRC/temperature:
	temperature:             38 C


Thx

			mizu
--=20
        -[ Mizu ]-
#-------------------------#
[-> E-mail:michal_AT_zimen.sk   =20
[-> ICQ:97165392
[-> WWW: http://www.mizu.sk


--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7Z+29kFXwDL4DRkRAuCuAJ44Y83tLUacGpGdW1RdlQr5WPDPWgCdHdnV
vCwRkRAmf7BSofGp4oicPbk=
=1Ail
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
