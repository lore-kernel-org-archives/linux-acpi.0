From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] bug in acpi_os_wait_semaphore
Date: Wed, 3 Mar 2004 15:37:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040303143725.GA1657@ergo.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I have found a tiny bug in acpi_os_wait_semaphore, which has caused my mutex
problems. If Acquire is called on a mutex with a non-zero, non-infinity
timeout, a bad return value check will cause the timeout to expire instantly.

Here's a one-line patch against osl.c in 2.6.3-mm4 (I hope that's current
enough):

--- ../../../linux-2.6.3-nopreempt/drivers/acpi/osl.c   2004-03-03 10:37:10.000000000 +0100
+++ osl.c       2004-03-03 15:11:11.000000000 +0100
@@ -892,7 +892,7 @@
                        static const int quantum_ms = 1000/HZ;
 
                        ret = down_trylock(sem);
-                       for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
+                       for (i = timeout; (i > 0 && ret != 0); i -= quantum_ms) {
                                current->state = TASK_INTERRUPTIBLE;
                                schedule_timeout(1);
                                ret = down_trylock(sem);


Sebastian

-- 
Man gewoehnt sich an allem, auch am Dativ.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
