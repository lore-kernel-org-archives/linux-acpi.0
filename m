From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Wed, 25 Feb 2004 00:50:29 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040225004109.AB48.COUNT0@localnet.com>
References: <403ADBCC.9060108@verizon.net> <1077686228.5911.93.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077686228.5911.93.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

You can enable S1/S3 with SMP with the "noirqbalance" boot parameter (to
disable kirqd which refuses to die during suspend) and this patch:

diff -Nru a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c	2004-01-09 01:59:19.000000000 -0500
+++ b/kernel/power/main.c	2004-01-25 19:59:35.000000000 -0500
@@ -144,11 +144,13 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
+#if 0
 	/* Suspend is hard to get right on SMP. */
 	if (num_online_cpus() != 1) {
 		error = -EPERM;
 		goto Unlock;
 	}
+#endif
 
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();

-Huw
-- 
Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
