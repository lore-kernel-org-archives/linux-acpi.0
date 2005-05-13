From: domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
Subject: [patch 1/1] drivers/acpi/osl.c : replace direct assignment with set_current_state()
Date: Sat, 14 May 2005 00:23:00 +0200
Message-ID: <20050513222259.350112000@nd47.coderock.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=set_current_state-drivers_acpi_osl
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>, domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Christophe Lucas <clucas-FNWCkmgu6Xgh9ZMKESR00Q@public.gmane.org>
Signed-off-by: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>

---
 osl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/acpi/osl.c
===================================================================
--- quilt.orig/drivers/acpi/osl.c
+++ quilt/drivers/acpi/osl.c
@@ -941,7 +941,7 @@ acpi_os_wait_semaphore(
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(1);
 				ret = down_trylock(sem);
 			}

--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
