From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: State of ACPI on my Compaq Presario 2100z
Date: Wed, 1 Sep 2004 02:24:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409010224.10507.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3809453.1AIG61slH7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--nextPart3809453.1AIG61slH7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear ACPI team,

I've contacted you guys a while ago about the problems with my Compaq Presa=
rio=20
2100, back then specifically my problems with a slowdown when running on=20
battery and suspend problems. I even soldered up some parallel port LED's=20
back then, but never got to put them to good use.

Since then, ACPI is working even worse than before, now the notebook doesn'=
t=20
shut down properly anymore. The last message is "Power off." (when doing=20
shutdown -h now), or "Sending acpi_power_off" (when doing echo -n disk=20
> /sys/power/state).

Battery, AC, thermal zone and CPU info works fine.

Suspending to memory suspends the notebook, but opening the lid again (or=20
pressing the power button) only results in a sub-second wake-up (fan starts=
,=20
hd starts ever so slightly, lcd stays off), then all goes dark again -=20
everything off. Pressing the power button again just starts regular boot.

Suspending to disk seems to work with every module unloaded and outside of =
X.=20
Trying the same from within X is a totally different (ugly) problem=20
alltogether. But that's not important to me anyway.

I'm currently running kernel 2.6.9-rc1-mm2 (acpi 20040816).

As I did back then, I am very interested in helping out troubleshooting the=
=20
problem. I am a software developer, but I just don't know where to start=20
here. If somebody wishes to speculate what may be wrong (with suspend/powe=
=20
off) from a birds-eye view, I might find a place to start my journey into=20
ACPI.

But in any case, thanks to all of you for your continued hard work - you gu=
ys=20
are truly an asset to the open source community!

Thanks,
   Andre

--nextPart3809453.1AIG61slH7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBNZU6tofNKe8dDvARAqBBAJ4qJ/GX9hjiHezYtef6DuSzo6rSGACeJ9vY
0Me8HUmW/4IU3ggMmCmXSUY=
=PYxY
-----END PGP SIGNATURE-----

--nextPart3809453.1AIG61slH7--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
