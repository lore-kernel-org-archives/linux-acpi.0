From: Dimitri Rebrikov <dimitri.rebrikov-kyawv7ubMNaakBO8gow8eQ@public.gmane.org>
Subject: AE_TIME on Operations in EC ( Embedded Controller ec.c )
Date: Mon, 15 Sep 2003 10:44:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F657BDB.9080805@t-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi,

after i installed 2.4.22 on my Notebook i couldn't get
any battery information more. (i.e. nothing in /proc/acpi/battery)

BTW. I had no problem with ACPI before (2.4.18+ACPI and 2.4.20+ACPI)

The corresponding error message in log was:

Sep  5 12:49:57 mitnb kernel: evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Sep  5 12:49:57 mitnb kernel:  psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node cee7cdc8), AE_TIME

Other embedded controls (i.e. thermal, fan etc) were not affected by this problem.

After some testing i located (i belief) the issue:
The values of ACPI_EC_UDELAY_COUNT and/or  ACPI_EC_UDELAY are too small
for my Hardware.

Here is the comparision between 2.4.20+ACPI and 2.4.22:

./linux-2.4.20/drivers/acpi/ec.c:#define ACPI_EC_UDELAY		1000	/* Poll @ 100us increments */
./linux-2.4.20/drivers/acpi/ec.c:#define ACPI_EC_UDELAY_COUNT	10000	/* Wait 10ms max. during EC ops */

./linux-2.4.22/drivers/acpi/ec.c:#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
./linux-2.4.22/drivers/acpi/ec.c:#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */

This means that the wait time for a EC operation in 2.4.22 was reduced with factor 100.

After i increase the value of ACPI_EC_UDELAY_COUNT to 10000
my problems gone. Now i can use the whole functionality of ACPI.

I don't know is there something in the ACPI specifikation defining max. wait time during EC op,
or the values in ec.c was investigated by testing.

My Hardware: (Clevo D270S Notebook, Pentium 4 M 1.8)
http://www.clevo.com.tw/products/D220S.asp

Regards
Dimitri



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
