From: Kevin Fenzi <kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: redhat comment about intel not taking patches?
Date: Mon, 10 Feb 2003 11:16:05 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030210181607.2876.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


RedHat is playing with enabling ACPI in their next release. (At least
in the beta for the next release: phoebe). 

Noticed this changelog comment in the phoebe kernel: 

* Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- - remove ACPI again because Intel is unwilling to take patches

What patches are they talking about? 

Is there any way we could fix up the communication breakdown between
RedHat/Intel?

It would be great if ACPI would work out of the box on my laptop with
a RedHat kernel. At a minimum I guess it would require acpi to be able
to detect the compaq *PNP stuff and remove the * so the table works. 

Any comments/thoughts?

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+R+xn3imCezTjY0ERAle1AJ0WGVKSRzTTXYU+Y5R3Ie+VszaKaQCeNFDY
9gfOUY3HK9arInbqQcBlZiQ=
=kDHa
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
