From: Ciro Mattia Gonano <lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org>
Subject: ACPI Battery status on Acer TravelMate a-550XV
Date: Wed, 13 Nov 2002 11:54:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021113105405.GA1994@amaranthum.com>
Reply-To: lestat-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
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


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all.
I'm quite a newbie in kernel hacking, and the same (and maybe more ;) ) in =
acpi
hacking.
So, that's my problem: with vanilla kernel acpi support I was not able to s=
ee my
laptop's battery status, and for acpi AC Adapter was online all the time (it
showed me on-line also if really the cable was not on).
So, I tried to apply acpi-20021101-2.4.20-rc1.diff.gz to a 2.4.20-rc1 kerne=
l,
and something seemed to have changed...
The AC Adapter status works fine (it reflects the real status on/off-line o=
f the
cable), the power button also works fine, but the battery still doesn't wor=
k :(
I use "acpi" cmd to view the status, and, while the first time I run it, it
always outputs me:

lilith:~# acpi -V
     Battery 1: charging, 98%, charging at zero rate - will never fully cha=
rge.
     Thermal 1: ok, 37.0 degrees C
  AC Adapter 1: on-line

starting from the second time, it outputs me the real status, something like
this:

lilith:~# acpi -V
     Thermal 1: ok, 50.0 degrees C
  AC Adapter 1: off-line

=2E.and the battery couldn't be viewed anymore.
I tried to unplug the battery, and then replug in (while the laptop was on =
AC,
obviously), and I received some error messages:

    ACPI-0251: *** Error: Looking up [STAT] in namespace, AE_ALREADY_EXISTS

=2E.and obviously the battery still doesn't exists, for acpi.
I tried to look in the drivers/acpi/ dir, and to work around the error, but=
 I
couldn't be able to do much... :(
Some hints?

My laptop's an Acer TravelMate a-550XV, some OLD informations about what I =
done
on it can be found on http://www.CS.UniBO.It/~gonano/a-550XV.htm , and at t=
he
moment I run on it Debian unstable, with acpid-1.0.1 and acpi 0.06.

Thanks in advance...

Adieu,
--=20
Lestat de Lioncourt  -- a.k.a --  Ciro Mattia Gonano
 Undergraduate student in Computer Science at University of Bologna
 IHGGer #1049   <=3D>  ICQ#: 52631406   <=3D>   URL: http://www.CS.UniBO.It=
/~gonano
 Debian admin at Students.CS.UniBO.It <=3D> look at headers for my JabberID=
 & GPG

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE90i9NcioIad74aSURAosRAJ9hhO31wOxO+1UYFnMinEINPJpngQCfSjdx
sricL/Fy/LTqfJT/Eo7K45A=
=Q31T
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
