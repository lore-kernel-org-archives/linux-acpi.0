From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RFC 2/4: fix memory allocating issue
Date: Wed, 19 Jan 2005 11:17:11 +0800
Message-ID: <1106104625.12957.274.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
free enough memory before suspend, so memory allocation will not fail.

Thanks,
Shaohua

---

 2.5-root/drivers/acpi/osl.c      |    2 ++
 2.5-root/drivers/acpi/pci_link.c |    2 +-
 2.5-root/kernel/power/main.c     |   18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff -puN kernel/power/main.c~free_enough_memory_before_suspend kernel/power/main.c
--- 2.5/kernel/power/main.c~free_enough_memory_before_suspend	2005-01-18 13:01:37.765974048 +0800
+++ 2.5-root/kernel/power/main.c	2005-01-18 13:55:09.625697152 +0800
@@ -19,6 +19,8 @@
 
 #include "power.h"
 
+#define FREE_PAGE_NUMBER (100)
+
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops * pm_ops = NULL;
@@ -49,6 +51,7 @@ void pm_set_ops(struct pm_ops * ops)
 static int suspend_prepare(suspend_state_t state)
 {
 	int error = 0;
+	unsigned int free_pages;
 
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
@@ -64,9 +67,19 @@ static int suspend_prepare(suspend_state
 	system_state = SYSTEM_SUSPEND;
 	smp_wmb();
 
+	if ((free_pages = nr_free_pages()) < FREE_PAGE_NUMBER) {
+		pr_debug("PM: free some memory\n");
+		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
+		if (nr_free_pages() < FREE_PAGE_NUMBER) {
+			error = -ENOMEM;
+			printk(KERN_ERR "PM: No enough memory\n");
+			goto Freemem;
+		}
+	}
+
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
-			goto Thaw;
+			goto Freemem;
 	}
 
 	if ((error = device_suspend(state)))
@@ -75,9 +88,10 @@ static int suspend_prepare(suspend_state
  Finish:
 	if (pm_ops->finish)
 		pm_ops->finish(state);
- Thaw:
+ Freemem:
 	system_state = SYSTEM_RUNNING;
 	smp_wmb();
+ Thaw:
 	thaw_processes();
 	pm_restore_console();
 	return error;
diff -puN drivers/acpi/osl.c~free_enough_memory_before_suspend drivers/acpi/osl.c
--- 2.5/drivers/acpi/osl.c~free_enough_memory_before_suspend	2005-01-18 13:01:37.767973744 +0800
+++ 2.5-root/drivers/acpi/osl.c	2005-01-18 13:54:30.171695072 +0800
@@ -145,6 +145,8 @@ acpi_os_vprintf(const char *fmt, va_list
 void *
 acpi_os_allocate(acpi_size size)
 {
+	if (system_state == SYSTEM_SUSPEND)
+		return kmalloc(size, GFP_ATOMIC);
 	return kmalloc(size, GFP_KERNEL);
 }
 
diff -puN drivers/acpi/pci_link.c~free_enough_memory_before_suspend drivers/acpi/pci_link.c
--- 2.5/drivers/acpi/pci_link.c~free_enough_memory_before_suspend	2005-01-18 13:02:10.745960328 +0800
+++ 2.5-root/drivers/acpi/pci_link.c	2005-01-18 13:03:26.860389176 +0800
@@ -315,7 +315,7 @@ acpi_pci_link_set (
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc( sizeof(*resource)+1, GFP_KERNEL);
+	resource = acpi_os_allocate(sizeof(*resource)+1);
 	if(!resource)
 		return_VALUE(-ENOMEM);
 
_




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
