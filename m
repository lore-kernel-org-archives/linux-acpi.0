From: "Antonio G. - Geotronix" <antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org>
Subject: Getting things clear.
Date: Fri, 27 Sep 2002 18:28:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927162855.GA1806@geolandia.home>
Reply-To: antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename="msg.pgp"
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi guys.

Sorry to bother you on the devel list but it seems that most of you read
only this one :-)

I'm interested in debugging ACPI and more over I belong to a LUG where
I've been told to learn how to implement ACPI on laptops so that I can
"teach" the others how to get things working on their own.

However I've noticed that even though you guys are doing a great work on
acpi there is a lack of good howto's that explain the esentials of ACPI.
THe howto on the acpi homepage is dated january 2001 and I presume is
rather outdated.

I seem to understand that a good acpi implementation (including swsusp)
is done by applying the following patches to 2.4.18 kernel (as there's
non swsusp for 2.4.19):

*) kacpid.patch
*) acpi-2002---.diff
*) acpid (for intercepting acpi signals for use on gui monitoring
software for instance)
*) a acpi complying gui app for the window manager.

*) pmtools is needed for debugging purposes

Am i missing something?

Thanks
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Per informazioni si veda http://www.gnupg.org

iD8DBQE9lIdHIRaQQEznKxURAtSTAJ9GGh2sWjy1HI+bTmz94XyiUqWNsACgzatF
juXEvf8bvX4xcxOk1AHj1TU=
=yMkK
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
