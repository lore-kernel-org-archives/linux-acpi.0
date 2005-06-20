From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 2/4] acpi/osl: correct HZ dependencies
Date: Mon, 20 Jun 2005 23:50:56 +0200
Message-ID: <20050620215055.606254000@nd47.coderock.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=msleep-drivers_acpi_osl.patch
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>


The osl driver has a few dependencies on HZ which are not
handled correctly for all values. Use msleep_interruptible() and
jiffies_to_msecs() to rectify the situation. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
---
 osl.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: quilt/drivers/acpi/osl.c
===================================================================
--- quilt.orig/drivers/acpi/osl.c
+++ quilt/drivers/acpi/osl.c
@@ -317,8 +317,7 @@ acpi_os_remove_interrupt_handler(u32 irq
 void
 acpi_os_sleep(acpi_integer ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(((signed long) ms * HZ) / 1000);
+	msleep_interruptible((unsigned int)ms);
 }
 EXPORT_SYMBOL(acpi_os_sleep);
 
@@ -938,7 +937,7 @@ acpi_os_wait_semaphore(
 		// TODO: A better timeout algorithm?
 		{
 			int i = 0;
-			static const int quantum_ms = 1000/HZ;
+			unsigned int quantum_ms = jiffies_to_msecs(1);
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
