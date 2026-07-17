Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640633E3C48;
	Fri, 17 Jul 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329880; cv=pass; b=kIB2Uh+ju0c/C3Zx2MZmDwausF0EiBTjLs2xKwUHV1tACmtNzJwzGGLiyMJB4ic1IXQHr+c7VOMPJ4N5otTSbwsITGNTddfTnY5G2J4VuzvI1wM8yqC0lFCLF562Bh1bLCA7nBvJr95qyGDcB6iuUsPeMxPXHcLg0pm2yYVxWjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329880; c=relaxed/simple;
	bh=ynOxoz3WVjYFWCPhkfa9TJr5/ZQQVNSQU/3KGb0z1NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7yWJE5IGWGklseBNVusuXZfHiNjOlVO8WSQ1R1NBv4z1pfx8kBafWXMjh6GNF6l4P2gH69c+eu9hMrVtksJOOfJkkj8bMZQBAL5tCV8A43TKBJ2PEhA1IIjsbUN5ikczWXweKbzD07XXGV3HTP9lJsWoI3+5o8jCOJMJ3+clxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=StDHzHJU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="StDHzHJU"
ARC-Seal: i=1; a=rsa-sha256; t=1784329854; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dc0vxVwikRCsmnPlZR8nxyj4jQ04DntxZFEDJqS6AWBfNyVCuo7cEt6QRjDWFqge+DbQQmMaD7qB7MIM1oE6GOM4DKgffL4lo374x97EN9ftqrx6MzXXzjq8mTOmmXQklQEoztdih06ZPH9EBomFgcGMgN3H/grQT0XGHmu99XY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784329854; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cgtPPUNk0/oeGD2QhbJSBWvA4wFULY7bdt+FW7ztdt0=; 
	b=Vv13ev9lRRF5urdXRJgpP1lwtzJhefCrsWvOLgUIoB1dxhfHy/bqcNaI4LWOqGZQyeE8LBZs6wjXXPrPbNsYg2pnOZTQe7IsCJPhVJ1+OjhrcpIG9uHQmL8y8H+ivpgnrUbveP5SqXoK2+jR/gR92VyH7Re9OrDBlwj+cb7BNKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784329854;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cgtPPUNk0/oeGD2QhbJSBWvA4wFULY7bdt+FW7ztdt0=;
	b=StDHzHJU9tFrJEoVI6Psz2ZHcVBthOCTuGohMP9u1jERSCIBt4uvr1u2KLVpHUUl
	ZdKfCmXOo4FbziMCdHVDZxMhda9QZZ+muwbL2y3LiUksZyOpOXNXnUi2DjbZHpmaTUJ
	oSd4jlEVoqjb/pCVfSIjL/QcO86ZtgoGF1h9mM+hJz+9xEOsaCJsq3vy59E6b2gIhDA
	0gWIpsmDgoqTqG6PYv3vIw6U7C8hgq4uXQN6WjyP4ncZtqqRSkskd8DjvRxxqx2c/vm
	lt24d4fM+74YLtkUqFEvsuFY4J4I+vHvM7czHD0B5cIyRJZst78diG114FpqUMwaeRS
	3w0c5hOzZQ==
Received: by mx.zohomail.com with SMTPS id 1784329848244512.1159116820515;
	Fri, 17 Jul 2026 16:10:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sat, 18 Jul 2026 07:10:19 +0800
Subject: [PATCH v4 1/3] ACPI: battery: Merge consecutive battery
 notifications
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-b4-acpi-battery-notification-v4-1-599c8ed1072f@rong.moe>
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
In-Reply-To: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Avraham Hollander <anhollander516@gmail.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

It's a very common pattern to emit consecutive battery notifications,
for example:

    Method (_Qxx, 0, NotSerialized)
    {
        Notify (BAT0, 0x80) // Status Change
        Notify (BAT0, 0x81) // Information Change
    }

In this case, the current code path will update battery state twice
within a short period, which is not optimal, as the same data are
fetched twice. Moreover, both notifications are likely to call
power_supply_changed(), causing power_supply_uevent() to read all
battery properties in order to assemble uevents. Even worse, after the
first uevent reaches userspace, some userspace processes start to read
all battery properties in order to refresh their internal states, which
competes with the second notification's handling and uevent assembling.

This generates significant pressure on _STA, _BST and _BIX/_BIF methods.
Not only that, power_supply_ext properties may also rely on some other
ACPI methods, so both uevent assembling and userspace processes call
them. It becomes a nightmare when all these methods share the same ACPI
mutex protecting EC accesses and hence vulnerable to lock starvation.
This is exactly the case of some Lenovo devices, where the mentioned EC
query pattern eventually leads to a catastrophic situation that a bunch
of ACPI methods (including but not limited to the mentioned ones) fail
to acquire the same mutex due to timeout. These devices don't handle
mutex acquisition failure gracefully and return garbage data, causing
even more chaos.

Improve battery notification handling by merging at most 16 consecutive
battery notifications within 10ms using a delayed work, so that they
only refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
underlying ACPI methods.

If more than 16 battery notifications are queued within 10ms, the
firmware/hardware is anyway buggy, and extra notifications will be
dropped.

Tested-by: Jeffrey Wälti <jeffrey@waelti.dev>
Tested-by: Avraham Hollander <anhollander516@gmail.com>
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v4:
- Rebase and adopt devres-based resource management
- Refactor acpi_battery_notify() to hold the mutex across the entire
  function to improve readability and drop unnecessary variables (thanks
  Rafael J. Wysocki)

Changes in v2:
- Address Sashiko's concerns:
  - Return from acpi_battery_notification_worker() early when the fifo
    is empty
  - Use pr_err_ratelimited() for potential event storms
  - Add missing `\n' in a printk message
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Minimalize the critical section of acpi_battery_notify()
---
 drivers/acpi/battery.c | 89 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f5e0eb299610..8b26962745bd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -21,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/unaligned.h>
 
@@ -43,6 +45,9 @@
 
 #define MAX_STRING_LENGTH	64
 
+#define MAX_QUEUED_EVENTS	16
+#define NOTIF_MERGING_MS	10
+
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
@@ -95,6 +100,8 @@ struct acpi_battery {
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
 	struct device *phys_dev;
+	struct kfifo acpi_notif_fifo;
+	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
 	unsigned long update_time;
@@ -1059,14 +1066,24 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_battery_notification_worker(struct work_struct *work)
 {
-	struct acpi_battery *battery = data;
+	struct acpi_battery *battery = container_of(work, struct acpi_battery,
+						    acpi_notif_dwork.work);
 	struct acpi_device *device = battery->device;
+	u32 events[MAX_QUEUED_EVENTS];
 	struct power_supply *old;
+	unsigned int count, i;
 
 	guard(mutex)(&battery->update_lock);
 
+	count = kfifo_out(&battery->acpi_notif_fifo, events, sizeof(events));
+	count /= sizeof(events[0]);
+	if (!count)
+		return;
+
+	pr_debug("merged %u battery notifications within %dms\n", count, NOTIF_MERGING_MS);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1076,19 +1093,46 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	 */
 	if (battery_notification_delay_ms > 0)
 		msleep(battery_notification_delay_ms);
-	if (event == ACPI_BATTERY_NOTIFY_INFO)
-		acpi_battery_refresh(battery);
+
+	for (i = 0; i < count; i++) {
+		if (events[i] == ACPI_BATTERY_NOTIFY_INFO) {
+			acpi_battery_refresh(battery);
+			break;
+		}
+	}
+
 	acpi_battery_update(battery, false);
-	acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
-					dev_name(&device->dev), event,
-					acpi_battery_present(battery));
-	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
-				 event, acpi_battery_present(battery));
+
+	for (i = 0; i < count; i++) {
+		acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
+						dev_name(&device->dev), events[i],
+						acpi_battery_present(battery));
+		acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
+					 events[i], acpi_battery_present(battery));
+	}
+
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat)
 		power_supply_changed(battery->bat);
 }
 
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_battery *battery = data;
+
+	guard(mutex)(&battery->update_lock);
+
+	if (kfifo_avail(&battery->acpi_notif_fifo) >= sizeof(event)) {
+		kfifo_in(&battery->acpi_notif_fifo, &event, sizeof(event));
+		schedule_delayed_work(&battery->acpi_notif_dwork,
+				      msecs_to_jiffies(NOTIF_MERGING_MS));
+
+		return;
+	}
+
+	pr_err_ratelimited("too many battery notifications within %dms\n", NOTIF_MERGING_MS);
+}
+
 static int battery_notify(struct notifier_block *nb,
 			  unsigned long mode, void *_unused)
 {
@@ -1231,6 +1275,29 @@ static int devm_acpi_battery_update_retry(struct device *dev,
 	return ret;
 }
 
+static void acpi_battery_notify_dwork_cleanup(void *data)
+{
+	struct acpi_battery *battery = data;
+
+	cancel_delayed_work_sync(&battery->acpi_notif_dwork);
+	kfifo_free(&battery->acpi_notif_fifo);
+}
+
+static int devm_acpi_battery_init_notify_dwork(struct device *dev,
+					       struct acpi_battery *battery)
+{
+	int ret;
+
+	INIT_DELAYED_WORK(&battery->acpi_notif_dwork, acpi_battery_notification_worker);
+
+	ret = kfifo_alloc(&battery->acpi_notif_fifo,
+			  MAX_QUEUED_EVENTS * sizeof(u32), GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, acpi_battery_notify_dwork_cleanup, battery);
+}
+
 static int acpi_battery_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1272,6 +1339,10 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	result = devm_acpi_battery_init_notify_dwork(dev, battery);
+	if (result)
+		return result;
+
 	result = devm_acpi_install_notify_handler(dev, ACPI_ALL_NOTIFY,
 						  acpi_battery_notify, battery);
 	if (result)

-- 
2.53.0

