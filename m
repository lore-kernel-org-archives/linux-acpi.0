From: Mark Crichton <crichton-dZkOyQknF4g@public.gmane.org>
Subject: Toshiba M15-S405, acpi-20030328 and acpi-20030424
Date: Fri, 2 May 2003 15:06:47 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502190647.GB22122@odo.ecs.umass.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
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


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

I'm having a small problem with the recent acpi patch for 2.4.21-rc1
(20030424) on my Toshiba laptop.

What appears to happen is that the kernel hard locks.  It appears to be
locking after init has started, where I try to read out from the HW
clock.  The downside to this is that I dont have a syslog of the event,
so I can only really speculate about this.

I also get a few "No installed handler for fixed event [00000000]"
during boot as well.  Passing "acpi=off", of course, avoids the message
and the lock.

Using the acpi-20030328 patch on 2.4.21-rc1 yields a fully working
kernel and ACPI interface.

Anyone have any ideas?  I've tried to look at what changed between
20030424 and 20030328, and can't figure out what it may be.  Also, if
anyone needs more info, let me know.

Thanks,
Mark Crichton

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (SunOS)

iD8DBQE+ssHGOfj2Ja/u/oARAn13AJ0R/taoPPgzVhKao3rT4n6Bg2E2RQCdEqTX
tWafKsqotw1TYok+hSjovto=
=zNI0
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
