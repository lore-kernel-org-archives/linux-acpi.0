Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE2257843;
	Fri, 13 Mar 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407065; cv=none; b=bosxSHLZqWJ06GFONw8zyp2Lyhd1jp5W7peHnYqVMNcw6WlxcG7LHJVBcmY2rZNoJ+aHqjsQAhzAjxBiAWEZ63XSqPWUmSPPyGQ9pkQi5pUTSGqrUP5KVmpqdfATpUAPPT3noBxx6YP0ydjzTt1E5cBtMtAl5Skr2aBLEZIbmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407065; c=relaxed/simple;
	bh=pxYkOcxPbmqk71KzpcBiQQjg1yzVdLr2W8OQtuAonmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6GJ/mutlHsbV+ts20bACT5KQfAsA7stWdGRrL8d5mw05LFXrv54xc7hxnAwcGN/VcA+7QvGlc+BZduX/0wBjtZe7ueHxYgzbDvqy9kRGFB85V35/zrwIvYN4U94FRmG/9Oudbnux4H7hMtCUBROWE15gjXWtN8xMOvu1ZZxZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgsSIxFc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgsSIxFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E701EC2BC87;
	Fri, 13 Mar 2026 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407065;
	bh=pxYkOcxPbmqk71KzpcBiQQjg1yzVdLr2W8OQtuAonmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgsSIxFcVcbVIUufYpAERUSkWzV/Yb1fdfYuuG+a3N0wPC03PDrUgy1N7E5jhWG0z
	 A444KjXyEk53na2KLbKVuggYVcx1U6vMxnDRXrTVNnZa3BJpxxU/rKlg065xjgDEIf
	 PDETzZiRkt2USsG6SXqac9fKLfW8y8FKxB1luHZDw1/pDUX31+vQ/FL8DXSZ0tc94q
	 eg65B3yycckx6kW6rgCybQ8DYkii57CfIci03J7Ie3Kjpi62Jy8GOJGfRhyfzzocmT
	 G48fQqtGGISFTYrqKQDQBYFNy/Pr6AD1iKlzfBpQTcKzClLWK9XRqkE7kr9aLFJaTC
	 BrC06kWqNmhXw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 5/8] ACPI: event: Redefine acpi_notifier_call_chain()
Date: Fri, 13 Mar 2026 13:59:17 +0100
Message-ID: <2056097.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that acpi_notifier_call_chain() only uses its device argument
to retrieve the pnp.device_class and pnp.bus_id values from there, so
it can be redefined to take pointers to those two strings as parameters
istead of a struct acpi_device pointer.

That allows all of its callers to pass a string literal as its first
argument, so they won't need to initialize pnp.device_class in
struct acpi_device objects operated by them any more, and its
signature becomes more similar to acpi_bus_generate_netlink_event()
then.

Update the code as per the above.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c         |    3 ++-
 drivers/acpi/acpi_video.c |    9 ++++++---
 drivers/acpi/battery.c    |    3 ++-
 drivers/acpi/event.c      |    7 ++++---
 include/acpi/acpi_bus.h   |    3 ++-
 5 files changed, 16 insertions(+), 9 deletions(-)

--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -133,7 +133,8 @@ static void acpi_ac_notify(acpi_handle h
 		acpi_bus_generate_netlink_event(adev->pnp.device_class,
 						  dev_name(&adev->dev), event,
 						  (u32) ac->state);
-		acpi_notifier_call_chain(adev, event, (u32) ac->state);
+		acpi_notifier_call_chain(ACPI_AC_CLASS, acpi_device_bid(adev),
+					 event, ac->state);
 		power_supply_changed(ac->charger);
 	}
 }
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1566,7 +1566,8 @@ static void acpi_video_bus_notify(acpi_h
 		break;
 	}
 
-	if (acpi_notifier_call_chain(device, event, 0))
+	if (acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+				     event, 0))
 		/* Something vetoed the keypress. */
 		keycode = 0;
 
@@ -1607,7 +1608,8 @@ static void acpi_video_device_notify(acp
 		if (video_device->backlight)
 			backlight_force_update(video_device->backlight,
 					       BACKLIGHT_UPDATE_HOTKEY);
-		acpi_notifier_call_chain(device, event, 0);
+		acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+					 event, 0);
 		return;
 	}
 
@@ -1640,7 +1642,8 @@ static void acpi_video_device_notify(acp
 	if (keycode)
 		may_report_brightness_keys = true;
 
-	acpi_notifier_call_chain(device, event, 0);
+	acpi_notifier_call_chain(ACPI_VIDEO_CLASS, acpi_device_bid(device),
+				 event, 0);
 
 	if (keycode && (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS)) {
 		input_report_key(input, keycode, 1);
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1081,7 +1081,8 @@ static void acpi_battery_notify(acpi_han
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
-	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
+	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
+				 event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat)
 		power_supply_changed(battery->bat);
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -24,12 +24,13 @@
 /* ACPI notifier chain */
 static BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
 
-int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
+int acpi_notifier_call_chain(const char *device_class,
+			     const char *bus_id, u32 type, u32 data)
 {
 	struct acpi_bus_event event;
 
-	strscpy(event.device_class, dev->pnp.device_class);
-	strscpy(event.bus_id, dev->pnp.bus_id);
+	strscpy(event.device_class, device_class);
+	strscpy(event.bus_id, bus_id);
 	event.type = type;
 	event.data = data;
 	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -625,7 +625,8 @@ int acpi_dev_install_notify_handler(stru
 void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
 				    acpi_notify_handler handler);
-extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
+extern int acpi_notifier_call_chain(const char *device_class,
+				    const char *bus_id, u32 type, u32 data);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
 



