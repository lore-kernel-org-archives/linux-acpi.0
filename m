From: Robert Stark <rstark-viLzafFedAGELgA04lAiVw@public.gmane.org>
Subject: ACPI + loop(AES) + swsusp
Date: Mon, 5 Aug 2002 10:26:08 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208050914050.15185-100000@xborg.ipp-hgw.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Linux Mailinglists <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-crypto-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've patched kernel-2.4.18 with acpi-20020726-2.4.18.diff, patch-acpi-acpi20020726-swsusp11,
and use Jari's loopaes. All partitions, also the root partition are encrypted symmetric.

I work on a Sony-PCG-FX501 and ACPI and loopaes do all the things they should do.
Have tested swsusp on the same machine without loopaes( and standard loop device )
successfully, but when i have an loop device losetuped and send an 'echo 4 > /proc/acpi/sleep'
then swsusp says "Strange, loopX not stopped" and abort suspend. After this error all loop devices
are under load and i must reboot the system.

Is there a way get this envoirement to work ?


Robert Stark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9TjajmSoJ6yS8v8oRAlb+AKCgCOG1vzmeKTxHv3deVblv/i1CTQCeNqmt
kQZUnV/Qo6bZU9BYYG3LqNc=
=9So0
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
