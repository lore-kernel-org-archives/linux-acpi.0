From: Ciro Mattia Gonano <gonano-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org>
Subject: Re: ACPI Battery status on Acer TravelMate a-550XV
Date: Tue, 10 Dec 2002 11:11:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021210101144.GC625@amaranthum.com>
References: <20021113105405.GA1994@amaranthum.com>
Reply-To: gonano-oqfuaKpTAUt/+UGKtYOvpA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021113105405.GA1994-bcIZUBUPgRYEEoCn2XhGlw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> So, that's my problem: with vanilla kernel acpi support I was not able to=
 see my
> laptop's battery status, and for acpi AC Adapter was online all the time =
(it
> showed me on-line also if really the cable was not on).
> So, I tried to apply acpi-20021101-2.4.20-rc1.diff.gz to a 2.4.20-rc1 ker=
nel,
> and something seemed to have changed...
>
I'm proud to announce to all of you that kernel 2.4.20 patched with
acpi-20021205-2.4.20.diff.gz works fine in my laptop, now. The battery stat=
us
reflects the real status, as the AC Adapter status, thermal and processor :)
Thanks a lot for your great work!!!
Now, my next goal is to write a kernel module to make the launchkeys work..=
. ^_^
Thanks again!

Adieu,
--=20
Lestat de Lioncourt  -- a.k.a --  Ciro Mattia Gonano
 Undergraduate student in Computer Science at University of Bologna
 IHGGer #1049   <=3D>  ICQ#: 52631406   <=3D>   URL: http://www.CS.UniBO.It=
/~gonano
 Debian admin at Students.CS.UniBO.It <=3D> look at headers for my JabberID=
 & GPG

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE99b3gcioIad74aSURArUuAJ9B6d2WIcEY/D4DkqT/KaGMZicsWACggTxq
yrFCsIFSsFekFoViL0kYhYw=
=8WCC
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
