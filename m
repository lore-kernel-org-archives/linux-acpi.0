From: Juhani Rautiainen <jrauti-X3B1VOXEql0@public.gmane.org>
Subject: Asus A7V and ACPI blacklisting
Date: Sat, 13 Sep 2003 19:38:56 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0309131936480.11235-100000@kotijr>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I've been using my Asus A7V long time with ACPI on without any
harmful effects (BIOS version is 1011). I noticed that in somepoint
in 2.4.22-pre series it was blacklisted with acpi=ht (my machine didn't
shutdown completely anymore after upgrade). I've been using acpi=force 
boot option ever since without any problems.  What's the point of acpi=ht 
anyway  on this platform?  It's not very likely that hyperthreading is 
going to be found on old AMD processors. Couldn't it just be acpi=off if 
it's even necessary. BTW the address where to report working systems in 
arch/i386/kernel/dmi_scan.c comments doesn't work.

Regards,
        Juhani
-- 
Juhani Rautiainen				jrauti-X3B1VOXEql0@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
