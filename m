From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] free enough memory before suspend/resume
Date: Fri, 21 Jan 2005 15:49:03 +0800
Message-ID: <1106293740.19407.62.camel@sli10-desk.sh.intel.com>
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

Free enough memory before suspend.

SIgned-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 2.5-root/kernel/power/main.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN kernel/power/main.c~free_memory_before_suspend kernel/power/main.c
--- 2.5/kernel/power/main.c~free_memory_before_suspend	2005-01-20 13:07:49.007943712 +0800
+++ 2.5-root/kernel/power/main.c	2005-01-20 13:09:58.067323704 +0800
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
@@ -60,6 +63,16 @@ static int suspend_prepare(suspend_state
 		goto Thaw;
 	}
 
+	if ((free_pages = nr_free_pages()) < FREE_PAGE_NUMBER) {
+		pr_debug("PM: free some memory\n");
+		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
+		if (nr_free_pages() < FREE_PAGE_NUMBER) {
+			error = -ENOMEM;
+			printk(KERN_ERR "PM: No enough memory\n");
+			goto Thaw;
+		}
+	}
+
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
_




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
