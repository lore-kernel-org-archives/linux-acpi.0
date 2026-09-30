Received: from outbound.st.icloud.com (st-2004j-snip4-11.eps.apple.com [57.103.78.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A774A3D4A
	for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807232; cv=none; b=AkxjDFwFIogzVAuy0JkruAEEK7jfgQUIrPliCcxVO/WtwZqWbrU8bBm/JLcMF/y9XBqqwXQDGKpYjEQo9NizTu0hasmXlttjg5DKBVIWO6Yl6kSomdl0DAGaBEl3BOBsC3+ippwyokB/jh264AT15gcZO3Rhf84tVlDMZQspnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807232; c=relaxed/simple;
	bh=i1O079X/0u88rFovVuiYfO0R5EGVj8VR73DdfUkZmN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vgyjh7CC9kOhH/feciMyOixoGQc3nOBUzddQuhWpvPHk9jcmoWn9i+jdXd46r2DG5vxfn1X9x9Ee1a9XFg2NETURKJ0LvVOTcY5I2P92dN0o8tjD9Hl5MuFQD4sHw7MUevUk17FK4NWp3THpc78DpT6FHWTg9yW+r4po6r+wnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brough.org; spf=pass smtp.mailfrom=brough.org; dkim=pass (2048-bit key) header.d=brough.org header.i=@brough.org header.b=Yt4YctEP; arc=none smtp.client-ip=57.103.78.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brough.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brough.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brough.org header.i=@brough.org header.b="Yt4YctEP"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id D0965180015A;
	Wed, 30 Sep 2026 22:27:03 +0000 (UTC)
X-ICL-RepId: 01a0f46d-adaf-7c85-9627-b4a62691a8ca
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhLBUMEXRxIDlYCWwdLVxQEElwfUwpcMFsKXBhQAxwfSx8TC1NWUAJWDVQFGQRAFxkKUFABS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKCUAfTB9bQ1gZVVBUEVdQC1kCQg9ICl4HWQBCD00DQwZTCkMBSAZABEZYH0scUgN3CUAfTB9bQ1gZVU4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brough.org; s=sig1; t=1790807227; x=1793399227; bh=v4Fz6N8XqHnccoY9swbW+buM9qq0cZIDNNBmXeyMzbs=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Yt4YctEPA2uICrDmwhVVpGqXIhTx3ONFbC+IpRMFpAFCMCJuHXn2QPUBcFzlBoip1PbiDwXwnppopaFLPL8GWzs+BK2gAKiUFzB6ihvWuRrQd5aAuDxxtk/dS4M/4P5vNHZ8uvfeF9egDm8wSyP4mJ4mTGgUHPeKAO0lThhs0WECOsYhxCM6j7HZCgxJyvZd6Z+i0k8Ye95ibuOo4boLIGyOA/SHjp/hsqwNbn+ISzxDVC5fy/gG3dMTwnsN47UndToCQAS39bIclk95nVV/jKboovBVplBJO9Q+iPQTK1VmcB4Vu0KPPlv9RH+e6vGiyEwJUhSFNZBU5aQbcQg4UQ==
mail-alias-created-date: 1646594351620
Received: from jb-desktop (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id 5272618000A6;
	Wed, 30 Sep 2026 22:27:02 +0000 (UTC)
From: Jordan Brough <jordan@brough.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Jordan Brough <jordan@brough.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 2/3] ACPI: battery: add unified battery hook mechanism for ACPI and SBS batteries
Date: Wed, 30 Sep 2026 16:26:34 -0600
Message-ID: <20260930222650.1883805-3-jordan@brough.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260930222650.1883805-1-jordan@brough.org>
References: <20260930222650.1883805-1-jordan@brough.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MSBTYWx0ZWRfX9cj3LeP4G6+x
 bVVbCTHgsrO9ROaZcz4sFCsC73I6Wh825kvS/P5yqeOHGfvdkaSVqQE9gBKXQ+yeXx0vDCbFhlH
 XicRDskpy8iGaS9dahuGmcMx9UlkJM5Q3HLradGX+uRkszZKgXx5dtFjEmpjBzL/fHoAsWBtN6o
 uB6iSfxHwa6tlpIuy0CCRaeGCwuAbtufMlhQMBONM0D0dZNnbDg2iRPBkEh4Fp20DPopLoOeY1K
 5UO56NvJdSJdKi4YkMbb1BOq3oZxmFQCTt2goBBGDBh6jVUHB5m8tPETVGzupXhxvKbC5dr80O2
 KDV6s9UqdPKtbt92NvlpfxBT8ak5mQPs8sULtN28XyMQZwerkjhmD8BECNFwAc=
X-Proofpoint-GUID: uYUBdnRuWe6nkDl0bC4jptLhno2hehX6
X-Proofpoint-ORIG-GUID: uYUBdnRuWe6nkDl0bC4jptLhno2hehX6
X-Authority-Info-Out: v=2.4 cv=Uu9u9uwB c=1 sm=1 tr=0 ts=6abd8cb8
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VTue-mJiAAAA:8 a=gFGppuTrAAAA:8
 a=clkLA2RcRcy5BvjdG-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22 a=_Y0xhhAoguY4gwfEQMhp:22
X-JNJ: AAAAAAAB33u/p/l7yAmWcuHWcq7C9UG5nBs64ymfQxeZsTZ151qU8GUNlPTg33Yu1RXPFo7lrbpn4x1pDJv15mRkrz7xusDe+xTh1fRXl6GcspxtC03ff+czvFydSxMuOyxS3+6vQ7z4s5MK4EXv+2rajCNwrNGVMo9iCBoLqVFRwjd6z3BLvp0AhIE1ueaQ9IKwll7siW52fBsxqaOfRBxFFDn72lnRVVAuoqEtoDvkIL/BMlESnTu9u/1v+wyoIOoOUULBGiACkJc4vDZHi3IQXfUTx3TrKYMecZNrRXtrGmuXPd9sMvKzafQNTanx8XZQ0i9+CP8YvgAFQSWrrTKAXwBgRXf7y31IpO/hMSNIlnSclK1SnjubpEdDo6JNX6FhGa2MCCE90RKv3UMSUcM9pbTiMXz+JihXA3yWNxak27Tvllaw02YTKnfUk0IYFFZjMrViReKGx4q8HaLkUd+yl6PWzxybhsEhNdm3ASRE4xjRsQ8pQwq8paro+aKW45V0V+j6/9BXZ7/POLOlbMOigZxVgyIElYKwLpOqzU590NlP6eSr56S7vAT6p2nRivypsSYpO00yUseCpTZTT+FhOCtmZV0bXUy0VFW+lfs6zSVtHvYbPRb7RMwNeFnsPiZwJRVTgIwqekahV16EuI77gKjvVjnOgN+YRIA8zIVEkvRieUQXuI32P9CGig5rMLtthYbgXG40egcLB7hCc9rBzVewfq0HbfIS4AyZpu5MfLngOVnTNxL6iN3OsbcgZDfyLmMpxw==

The battery hook API only works with ACPI Control Method batteries
(battery.c). Machines with a Smart Battery System battery (sbs.c) have no
equivalent, so drivers cannot attach extra power_supply properties to them.

Move the hook list and registration code out of battery.c into a new
battery_hooks.c that both battery.c and sbs.c use, through
acpi_battery_add_hooks() and acpi_battery_remove_hooks(), which are
exported in the ACPI_BATTERY_HOOKS namespace. The exported hook functions
are unchanged.

The new file is built only when ACPI_BATTERY or ACPI_SBS is, through a
hidden ACPI_BATTERY_HOOKS symbol that they select. Since the hook lists
now live there, registered hooks stay registered when battery.ko or
sbs.ko is reloaded, and battery_hook_exit() is no longer needed.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Jordan Brough <jordan@brough.org>
---
 drivers/acpi/Kconfig         |   5 ++
 drivers/acpi/Makefile        |   1 +
 drivers/acpi/battery.c       | 166 +----------------------------------
 drivers/acpi/battery_hooks.c | 159 +++++++++++++++++++++++++++++++++
 drivers/acpi/sbs.c           |   8 +-
 include/acpi/battery.h       |   9 ++
 6 files changed, 185 insertions(+), 163 deletions(-)
 create mode 100644 drivers/acpi/battery_hooks.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..d0278f13e96f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -171,8 +171,12 @@ config ACPI_AC
 	  To compile this driver as a module, choose M here:
 	  the module will be called ac.
 
+config ACPI_BATTERY_HOOKS
+	tristate
+
 config ACPI_BATTERY
 	tristate "Battery"
+	select ACPI_BATTERY_HOOKS
 	select POWER_SUPPLY
 	default y
 	help
@@ -445,6 +449,7 @@ config ACPI_HOTPLUG_IOAPIC
 config ACPI_SBS
 	tristate "Smart Battery System"
 	depends on X86 && ACPI_EC
+	select ACPI_BATTERY_HOOKS
 	select POWER_SUPPLY
 	help
 	  This driver supports the Smart Battery System, another
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..eb744dc81d3f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_ACPI_NHLT)		+= nhlt.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
+obj-$(CONFIG_ACPI_BATTERY_HOOKS)	+= battery_hooks.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 306bb2088ca6..0d74f998eae6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -54,6 +54,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("ACPI_BATTERY_HOOKS");
 
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
@@ -105,7 +106,7 @@ struct acpi_battery {
 	struct kfifo acpi_notif_fifo;
 	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
-	struct list_head list;
+	struct acpi_battery_hooks_list_entry hooks_list_entry;
 	unsigned long flags;
 
 	struct mutex property_lock; /* Protects properties below. */
@@ -808,164 +809,6 @@ static struct attribute *acpi_battery_attrs[] = {
 };
 ATTRIBUTE_GROUPS(acpi_battery);
 
-/*
- * The Battery Hooking API
- *
- * This API is used inside other drivers that need to expose
- * platform-specific behaviour within the generic driver in a
- * generic way.
- *
- */
-
-static LIST_HEAD(acpi_battery_list);
-static LIST_HEAD(battery_hook_list);
-static DEFINE_MUTEX(hook_mutex);
-
-static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
-{
-	struct acpi_battery *battery;
-
-	/*
-	 * In order to remove a hook, we first need to
-	 * de-register all the batteries that are registered.
-	 */
-	list_for_each_entry(battery, &acpi_battery_list, list) {
-		if (!hook->remove_battery(battery->bat, hook))
-			power_supply_changed(battery->bat);
-	}
-	list_del_init(&hook->list);
-
-	pr_info("hook unregistered: %s\n", hook->name);
-}
-
-void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
-{
-	mutex_lock(&hook_mutex);
-	/*
-	 * Ignore already unregistered battery hooks. This might happen
-	 * if a battery hook was previously unloaded due to an error when
-	 * adding a new battery.
-	 */
-	if (!list_empty(&hook->list))
-		acpi_battery_hook_unregister_unlocked(hook);
-
-	mutex_unlock(&hook_mutex);
-}
-EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
-
-void acpi_battery_hook_register(struct acpi_battery_hook *hook)
-{
-	struct acpi_battery *battery;
-
-	mutex_lock(&hook_mutex);
-	list_add(&hook->list, &battery_hook_list);
-	/*
-	 * Now that the driver is registered, we need
-	 * to notify the hook that a battery is available
-	 * for each battery, so that the driver may add
-	 * its attributes.
-	 */
-	list_for_each_entry(battery, &acpi_battery_list, list) {
-		if (hook->add_battery(battery->bat, hook)) {
-			/*
-			 * If a add-battery returns non-zero,
-			 * the registration of the hook has failed,
-			 * and we will not add it to the list of loaded
-			 * hooks.
-			 */
-			pr_err("hook failed to load: %s", hook->name);
-			acpi_battery_hook_unregister_unlocked(hook);
-			goto end;
-		}
-
-		power_supply_changed(battery->bat);
-	}
-	pr_info("new hook: %s\n", hook->name);
-end:
-	mutex_unlock(&hook_mutex);
-}
-EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
-
-static void devm_acpi_battery_hook_unregister(void *data)
-{
-	struct acpi_battery_hook *hook = data;
-
-	acpi_battery_hook_unregister(hook);
-}
-
-int devm_acpi_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook)
-{
-	acpi_battery_hook_register(hook);
-
-	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister, hook);
-}
-EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
-
-/*
- * This function gets called right after the battery sysfs
- * attributes have been added, so that the drivers that
- * define custom sysfs attributes can add their own.
- */
-static void battery_hook_add_battery(struct acpi_battery *battery)
-{
-	struct acpi_battery_hook *hook_node, *tmp;
-
-	mutex_lock(&hook_mutex);
-	INIT_LIST_HEAD(&battery->list);
-	list_add(&battery->list, &acpi_battery_list);
-	/*
-	 * Since we added a new battery to the list, we need to
-	 * iterate over the hooks and call add_battery for each
-	 * hook that was registered. This usually happens
-	 * when a battery gets hotplugged or initialized
-	 * during the battery module initialization.
-	 */
-	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
-		if (hook_node->add_battery(battery->bat, hook_node)) {
-			/*
-			 * The notification of the hook has failed, to
-			 * prevent further errors we will unload the hook.
-			 */
-			pr_err("error in hook, unloading: %s",
-					hook_node->name);
-			acpi_battery_hook_unregister_unlocked(hook_node);
-		}
-	}
-	mutex_unlock(&hook_mutex);
-}
-
-static void battery_hook_remove_battery(struct acpi_battery *battery)
-{
-	struct acpi_battery_hook *hook;
-
-	mutex_lock(&hook_mutex);
-	/*
-	 * Before removing the hook, we need to remove all
-	 * custom attributes from the battery.
-	 */
-	list_for_each_entry(hook, &battery_hook_list, list) {
-		hook->remove_battery(battery->bat, hook);
-	}
-	/* Then, just remove the battery from the list */
-	list_del(&battery->list);
-	mutex_unlock(&hook_mutex);
-}
-
-static void __exit battery_hook_exit(void)
-{
-	struct acpi_battery_hook *hook;
-	struct acpi_battery_hook *ptr;
-	/*
-	 * At this point, the acpi_bus_unregister_driver()
-	 * has called remove for all batteries. We just
-	 * need to remove the hooks.
-	 */
-	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
-		acpi_battery_hook_unregister(hook);
-	}
-	mutex_destroy(&hook_mutex);
-}
-
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
 	bool extended_info_available = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
@@ -1052,7 +895,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		battery->bat = NULL;
 		return result;
 	}
-	battery_hook_add_battery(battery);
+	acpi_battery_add_hooks(&battery->hooks_list_entry, battery->bat);
 	return 0;
 }
 
@@ -1061,7 +904,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 	if (!battery->bat)
 		return;
 
-	battery_hook_remove_battery(battery);
+	acpi_battery_remove_hooks(&battery->hooks_list_entry);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 }
@@ -1571,7 +1414,6 @@ static int __init acpi_battery_init(void)
 static void __exit acpi_battery_exit(void)
 {
 	platform_driver_unregister(&acpi_battery_driver);
-	battery_hook_exit();
 }
 
 module_init(acpi_battery_init);
diff --git a/drivers/acpi/battery_hooks.c b/drivers/acpi/battery_hooks.c
new file mode 100644
index 000000000000..ca3f9876cb09
--- /dev/null
+++ b/drivers/acpi/battery_hooks.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Battery Hooks
+ *
+ * Provides helpers for registering and unregistering battery hooks for
+ * drivers that use platform-specific extensions to ACPI-enumerated
+ * batteries (both ACPI Control Method batteries and Smart Battery System
+ * batteries).
+ */
+
+#define pr_fmt(fmt) "ACPI: battery: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <acpi/battery.h>
+
+static LIST_HEAD(acpi_battery_list);
+static LIST_HEAD(battery_hook_list);
+static DEFINE_MUTEX(hook_mutex);
+
+static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
+{
+	struct acpi_battery_hooks_list_entry *entry;
+
+	/*
+	 * In order to remove a hook, we first need to
+	 * de-register all the batteries that are registered.
+	 */
+	list_for_each_entry(entry, &acpi_battery_list, list_entry) {
+		if (!hook->remove_battery(entry->battery, hook))
+			power_supply_changed(entry->battery);
+	}
+	list_del_init(&hook->list);
+
+	pr_info("hook unregistered: %s\n", hook->name);
+}
+
+void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
+{
+	guard(mutex)(&hook_mutex);
+
+	/*
+	 * Ignore already unregistered battery hooks. This might happen
+	 * if a battery hook was previously unloaded due to an error when
+	 * adding a new battery.
+	 */
+	if (!list_empty(&hook->list))
+		acpi_battery_hook_unregister_unlocked(hook);
+}
+EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
+
+void acpi_battery_hook_register(struct acpi_battery_hook *hook)
+{
+	struct acpi_battery_hooks_list_entry *entry;
+
+	guard(mutex)(&hook_mutex);
+
+	list_add(&hook->list, &battery_hook_list);
+	/*
+	 * Now that the driver is registered, we need
+	 * to notify the hook that a battery is available
+	 * for each battery, so that the driver may add
+	 * its attributes.
+	 */
+	list_for_each_entry(entry, &acpi_battery_list, list_entry) {
+		if (hook->add_battery(entry->battery, hook)) {
+			/*
+			 * If a add-battery returns non-zero,
+			 * the registration of the hook has failed,
+			 * and we will not add it to the list of loaded
+			 * hooks.
+			 */
+			pr_err("hook failed to load: %s\n", hook->name);
+			acpi_battery_hook_unregister_unlocked(hook);
+			return;
+		}
+
+		power_supply_changed(entry->battery);
+	}
+	pr_info("new hook: %s\n", hook->name);
+}
+EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
+
+static void devm_acpi_battery_hook_unregister(void *data)
+{
+	struct acpi_battery_hook *hook = data;
+
+	acpi_battery_hook_unregister(hook);
+}
+
+int devm_acpi_battery_hook_register(struct device *dev,
+				    struct acpi_battery_hook *hook)
+{
+	acpi_battery_hook_register(hook);
+
+	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister, hook);
+}
+EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
+
+/*
+ * This function gets called right after the battery sysfs
+ * attributes have been added, so that the drivers that
+ * define custom sysfs attributes can add their own.
+ */
+void acpi_battery_add_hooks(struct acpi_battery_hooks_list_entry *entry,
+			    struct power_supply *battery)
+{
+	struct acpi_battery_hook *hook_node, *tmp;
+
+	entry->battery = battery;
+
+	guard(mutex)(&hook_mutex);
+
+	list_add(&entry->list_entry, &acpi_battery_list);
+	/*
+	 * Since we added a new battery to the list, we need to
+	 * iterate over the hooks and call add_battery for each
+	 * hook that was registered. This usually happens
+	 * when a battery gets hotplugged or initialized
+	 * during the battery module initialization.
+	 */
+	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
+		if (hook_node->add_battery(entry->battery, hook_node)) {
+			/*
+			 * The notification of the hook has failed, to
+			 * prevent further errors we will unload the hook.
+			 */
+			pr_err("error in hook, unloading: %s\n", hook_node->name);
+			acpi_battery_hook_unregister_unlocked(hook_node);
+		}
+	}
+}
+EXPORT_SYMBOL_NS_GPL(acpi_battery_add_hooks, "ACPI_BATTERY_HOOKS");
+
+void acpi_battery_remove_hooks(struct acpi_battery_hooks_list_entry *entry)
+{
+	struct acpi_battery_hook *hook;
+
+	guard(mutex)(&hook_mutex);
+	/*
+	 * Before removing the hook, we need to remove all
+	 * custom attributes from the battery.
+	 */
+	list_for_each_entry(hook, &battery_hook_list, list)
+		hook->remove_battery(entry->battery, hook);
+
+	/* Then, just remove the battery from the list */
+	list_del(&entry->list_entry);
+	entry->battery = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(acpi_battery_remove_hooks, "ACPI_BATTERY_HOOKS");
+
+MODULE_DESCRIPTION("ACPI battery hooks");
+MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f10bbf13c242..f80a6294953a 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -36,6 +36,7 @@
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("ACPI_BATTERY_HOOKS");
 
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
@@ -54,6 +55,7 @@ struct acpi_battery {
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_sbs *sbs;
+	struct acpi_battery_hooks_list_entry hooks_list_entry;
 	unsigned long update_time;
 	char name[8];
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
@@ -555,6 +557,8 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
+	acpi_battery_add_hooks(&battery->hooks_list_entry, battery->bat);
+
       end:
 	pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -566,8 +570,10 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
 
-	if (battery->bat)
+	if (battery->bat) {
+		acpi_battery_remove_hooks(&battery->hooks_list_entry);
 		power_supply_unregister(battery->bat);
+	}
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index 08c7e37996bf..6360f102a4e8 100644
--- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -18,9 +18,18 @@ struct acpi_battery_hook {
 	struct list_head list;
 };
 
+struct acpi_battery_hooks_list_entry {
+	struct list_head list_entry;
+	struct power_supply *battery;
+};
+
 void acpi_battery_hook_register(struct acpi_battery_hook *hook);
 void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
 int devm_acpi_battery_hook_register(struct device *dev,
 				    struct acpi_battery_hook *hook);
 
+void acpi_battery_add_hooks(struct acpi_battery_hooks_list_entry *entry,
+			    struct power_supply *battery);
+void acpi_battery_remove_hooks(struct acpi_battery_hooks_list_entry *entry);
+
 #endif
-- 
2.56.0

