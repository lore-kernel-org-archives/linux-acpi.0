From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: Several problems on a toshiba S3000-X11
Date: Fri, 27 Sep 2002 11:01:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927160108.GA1232@draal.physics.wisc.edu>
References: <20020927142320.GB2821@lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020927142320.GB2821-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ?ric Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

?ric Brunet [ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org] wrote:
> Hi !
>=20
> I am using acpi-20020829 with a 2.4.20pre5 kernel on a toshiba satellite
> 3000-X11, with the custom DSDT made by Bruno Ducrot. The previous acpi
> patch I used was acpi-20020503 (I think) with the native DSDT.
> I also use the toshiba_3000 module by Bruno.
>=20
> I have one big problem: my computer shuts down without warning. I have
> also some minor problems, and I will begin with those.
>=20
> 	MINOR PROBLEMS
> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> When I read the battery state for the first couple of times, the
> /proc/acpi files claim that I have two batteries present, and that both
> batteries have a charge of 2040 mAh (capacity is 4000 mAh). After a
> couple of readings, I have the truth (only one battery and whatever
> capacity I have left.) That's annoying, and it didn't happen with my
> previous kernel. I don't now if it comes from the patched DSDT or from
> the new version of the acpi patch.

Ah...that's why I switched back to my native dsdt.  Maybe Bruno has a
2-battery machine!  ;)

> When ACPI assigns interrupts at boot, I get
> 	ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> Now I am __nearly__ sure that there was a version of the ACPI patch where
> the interrupts were more evenly distributed. Did I dream that or was a
> patch reverted ?

I have never seen the interrupts more evenly distributed (my interrupt
distribution is identical to yours).  But I would like them to be!
Having all this stuff share interrupts causes no end of problems.

> (note that I have only tried vanilla acpi patch; acpi patch + this two
> liners; and acpi patch + this two liners + patched DSDT.  Maybe S1 works
> fine with acpi patch + patched DSDT __without__ this two liners. I will
> check)

I am not using a patched dsdt...I tried the tosh3k patched dsdt and it
improved nothing but messed up the battery, as you observed above.

> 		MAJOR PROBLEM
> 		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> So the computer shuts down, without warning, while it is not particulary
> hot, with nothing written in the logs, while the user was just using vim
> in a xterm, at irregular times, and it can happen two or three times in
> an afternoon.

So mine has stopped turning itself off (I don't know how or why it
stopped turning off).  Now it hangs and continues to run.  (I sent an
earlier report about this, but nobody seems to be paying attention to us
;)  I left it running for a while and noticed that after I moved the
mouse the screen unblanked after like 1/2 hour.  It's still processing,
just one clock tick per minute or something...  Also the clock was
horribly off after reboot.

> I have an hypothesis; somehow I think there is something wrong in the
> reading of the temperature. When I read the temperature, there are some
> very unnatural pics; the computer was at 53 degree, then jumps 3 seconds
> at 60 and comes back at 53. I believe that, some time to time, this
> unnatural jump goes over the critical trippoint and the computer shuts
> down in emergency.

I have still never seen the temperature swings you mention.

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2UgMQACgkQjwioWRGe9K10kQCg8XBsHQc7pFIwblWFf/096BNj
rEEAoJhITTi8mWm+jUtkHtT80/xHeh5C
=EZX4
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
