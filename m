From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Acpi slows down my new Asus portable quite a lot
Date: Tue, 15 Jul 2003 13:22:57 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2lluzedzy.fsf@tnuctip.rychter.com>
References: <20030715142915.GB4920@casa.fluido.as>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030715142915.GB4920-Ap7NVfYj2GpM1YnL2Vgg6w@public.gmane.org> (Carlo E. Prelz's
 message of "Tue, 15 Jul 2003 16:29:15 +0200")
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

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Carlo" =3D=3D Carlo E Prelz <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org> writes:
[...]
 Carlo> As you can see, 99.9 of the cpu time is sucked by events/0. In
 Carlo> 2.4 kernels, the fat process is called keventd, but the result
 Carlo> is the same.
[...]

I see the same thing on 2.4.22-pre5, keventd sometimes decides to run a
lot and consume CPU time. When it happens, keventd doesn't run all the
time, but runs for a while, then stops, then runs again.

I've noticed this doesn't happen if I don't use ALSA. But once ALSA has
been used, this happens even after ALSA has been unloaded.

I don't know if this is ACPI's fault or ALSA's fault. In fact, I don't
even know where and how to report it properly.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FGKmLth4/7/QhDoRAg50AJ458PNFdAZDsOzDGzW5ZrYs/YHcsACg2D5K
agfOJD1E8d5J6mNDisiTdLw=
=Qfxv
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
