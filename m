From: Manish Prasad <mprasad-EX0cT3Az47bauI2f2gSDlQ@public.gmane.org>
Subject: Battery Query
Date: Sun, 27 Apr 2003 23:40:03 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.53.0304272213420.29828@compserv2>
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

Hi

I'm working with a DELL Inspiron 2600, 2.4.20 kernel, acpi patch 20021212.
I'm reading /proc/acpi/battery/BAT1/status and redirecting the o/p to a
file. I'm doing this continuously in a loop using a script. /proc..../info
shows battery type as LION and OEM info: SANYO. Two questions:

1) The queried status value (remaining capacity) changes only about every
   75 seconds (differences in status values of the order of 40 mAh,
   approx). Is it because that's the frequency with which the battery
   updates its exposed status information? Is this usually the case with
   other laptops too ?
2) Running the above script for 5 minutes locks up the machine spewing out
   an error message like:
   Error: Looking up [STAT] in namespace, AE_NOT_FOUND
   [psparse-???] Error: Method execution failed, AE_NOT_FOUND
   .... and after a while it begins throwing this message non-stop:
   acpi_battery_get_status: Error evaluating _BST
   exresnte-0112 [58233] Ex_resolve_node_to_val: No object attached to
   node c12eed88.

Also the DSDT code statement just below Method BST reads NotSerialized,
if that could be of any consequence.

Any opinions/suggestions/insight on what's possibly happening would be
greatly appreciated.

Thanks a bunch!
--Manish



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
