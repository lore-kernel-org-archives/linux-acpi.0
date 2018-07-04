From: Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] ACPI / battery: Safe unregistering of
 hooks
Date: Wed, 4 Jul 2018 12:27:15 +0200
Message-ID: <20180704102715.GA9067@Mindship-05.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A hooking API was implemented for 4.17 in fa93854f7a7ed63d followed by
hooks for Thinkpad laptops in 2801b9683f740012. The Thinkpad drivers
did not support the Thinkpad 13 and the hooking API crashes on
unsupported batteries by altering a list of hooks during unsafe
iteration. Thus, Thinkpad 13 laptops could no longer boot.

Additionally, a lock was kept in place and debugging information was
printed out of order.

Signed-off-by: Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

This time with a more informative commit message (no functional changes).

 drivers/acpi/battery.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b0113a58..d79ad844 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -717,10 +717,11 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 			 */
 			pr_err("extension failed to load: %s", hook->name);
 			__battery_hook_unregister(hook, 0);
-			return;
+			goto end;
 		}
 	}
 	pr_info("new extension: %s\n", hook->name);
+end:
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_register);
@@ -732,7 +733,7 @@ EXPORT_SYMBOL_GPL(battery_hook_register);
 */
 static void battery_hook_add_battery(struct acpi_battery *battery)
 {
-	struct acpi_battery_hook *hook_node;
+	struct acpi_battery_hook *hook_node, *tmp;
 
 	mutex_lock(&hook_mutex);
 	INIT_LIST_HEAD(&battery->list);
@@ -744,15 +745,15 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
 	 * when a battery gets hotplugged or initialized
 	 * during the battery module initialization.
 	 */
-	list_for_each_entry(hook_node, &battery_hook_list, list) {
+	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
 		if (hook_node->add_battery(battery->bat)) {
 			/*
 			 * The notification of the extensions has failed, to
 			 * prevent further errors we will unload the extension.
 			 */
-			__battery_hook_unregister(hook_node, 0);
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
+			__battery_hook_unregister(hook_node, 0);
 		}
 	}
 	mutex_unlock(&hook_mutex);
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
