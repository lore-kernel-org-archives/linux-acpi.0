From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: acpi_power_off
Date: Sun, 06 Jun 2004 16:27:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C329BD.6040003@pca.it>
References: <HYSPW8$1309D80CA450E8BBB2E00C5851F6C4B0@libero.it> <40C324EE.6080602@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40C324EE.6080602-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi mailing acpi mailing <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 06/06/2004 04:06 PM, Uwe Maier wrote:
> I've seen this problem with sysvinit 2.85-16 on unstable too.
> I think it has nothing to do with ACPI but with the debian package. It's
> sufficient to downgrade to 2.8-15 to have a proper power off again.
I saw the problem one evening (2- or 1-day ago) on 2 different Debian
unstable, but as the day after I upgraded again, well, now I don't have
that problem anymore. In fact, 2.85-16 is no more in unstable:
=====
gismo:/home/luca# apt-cache policy sysvinit
sysvinit:
  Installed: 2.85-18
  Candidate: 2.85-18
  Version Table:
 *** 2.85-18 0
        500 ftp://sunsite.cnlab-switch.ch unstable/main Packages
        100 /var/lib/dpkg/status
     2.85-15 0
        500 ftp://sunsite.cnlab-switch.ch testing/main Packages
     2.84-2woody1 0
        500 ftp://sunsite.cnlab-switch.ch stable/main Packages
gismo:/home/luca#
=====

For more infos, see this Debian bugs [1] [2].

Thx, bye,
Gismo / Luca

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=252547
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=252598
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAwym8VAp7Xm10JmkRAqUMAJ9oSp0+Ce3euyl/nTiCktLJ9KpxnQCfbyIP
y+Mg/y5q4nXKbd9MMWHa3Lg=
=9G0N
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
