From: Andreas Happe <andreashappe-hi6Y0CQ0nG0@public.gmane.org>
Subject: hp omnibook problems
Date: Wed, 11 Sep 2002 14:02:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <slrnanuc75.mp.andreashappe@marvin.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

i'm trying to use acpi with my hp omnibook 6100 (it seems that my
notebook is unable to shutdown proberly without acpi). This problem
happens with kernel versions 2.5.33, 2.5.34 (and some former
versions... to be true, it never really works ) and several bios versions
(2.02, 2.1, 2.22).

i have enabled ACPI and PM support (CONFIG_PM && CONFIG_ACPI enabled).
Booting of the system stops with a:
    ACPI-1155: ***Error: Method execution failed, AE_NOT_EXISTS
failure message (it also tells me that i'm using version 20020829).

well, i was curious and tried enabling debug messages for acpi
(CONFIG_ACPI_DEBUG) to gather more information but the only result was a
kernel oops instead of the failure message...

andreas happe




-------------------------------------------------------
In remembrance
www.osdn.com/911/
