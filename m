From: Nathan Conrad <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Subject: Hard drive problems with S3
Date: Sat, 26 Jun 2004 12:04:08 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040626160408.GA20345@bungled.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I recently figured out that S3 mode now nearly works on my
computer. Thanks for all of the work that has been done with it. My
Sony Vaio FXA49 laptop is configured to use S3BIOS to suspend. I start
the suspend by echoing 3 to /proc/acpi/sleep. It suspends and then
resumes properly. But, once resumed the hard drive seems to be not
able to read any data. I can move around my X cursor, switch virtual
consoles, etc.... but once I try to do something that requires a hard
drive access, the process hangs and my hard drive light turns on. I
don't hear any hard drive activity at this time.

Are there any sugestions on how to resolve this problem?

Another issue is that the backlight does not turn back on, but the
video output is viewable on the LCD (although it is very hard to see).

--=20
Nathan J. Conrad=20
Chapel Hill, NC, USA                 http://bungled.net
GPG: F4FC 7E25 9308 ECE1 735C  0798 CE86 DA45 9170 3112

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3Z54zobaRZFwMRIRAvojAJ9wqIaTpxB6JLEw0fbHq0HCoAi2UQCfScUw
UWzM0qUSARo4c1y7wQlFgmg=
=w9oU
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
