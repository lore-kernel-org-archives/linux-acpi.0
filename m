From: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [-mm PATCH 15/32] drivers/acpi: fix-up schedule_timeout() usage
Date: Mon, 15 Aug 2005 11:16:59 -0700
Message-ID: <20050815181659.GR2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size. Also use
msecs_to_jiffies() instead of direct HZ division to avoid rounding
errors.

Signed-off-by: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

---

 drivers/acpi/osl.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/acpi/osl.c 2.6.13-rc5-mm1-dev/drivers/acpi/osl.c
--- 2.6.13-rc5-mm1/drivers/acpi/osl.c	2005-08-07 10:05:19.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/acpi/osl.c	2005-08-12 13:20:41.000000000 -0700
@@ -315,8 +315,7 @@ acpi_status acpi_os_remove_interrupt_han
 
 void acpi_os_sleep(acpi_integer ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(((signed long)ms * HZ) / 1000);
+	schedule_timeout_interruptible(msecs_to_jiffies(ms));
 }
 
 EXPORT_SYMBOL(acpi_os_sleep);
@@ -866,8 +865,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(1);
+				schedule_timeout_interruptible(1);
 				ret = down_trylock(sem);
 			}
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
