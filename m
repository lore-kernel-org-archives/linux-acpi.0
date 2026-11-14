Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616002;
	b=h62oaUNgAhXEq6KXtGOOi3WFF60/yJ5dXJsaWi//4avIpBdD8xc1UG6C2FX3J5q5tPls
	 1iNwjP7IZEd0A2b5wg9XkGLrNU53gXAq0nCgTD8cOK3M1yyCVLTET4lLYkSdlJqLo/V0P
	 ky0MXPpRiDFKkGe2dRn/e9MJIRfhqWzsT/VSAdgToLflJpvd12aYscRE/ZBMw4ROAP6E2
	 WqzXz4pLmKQtfXMHBX+zmdEK7RHNMef8Zc/WA1KOEPoJ4wJWtfPA51/GUm4qa8zEMi3DI
	 1Dh/QG5S969E9gl+yeawb9WQ2mxPxQRRxIPDfQY7xJDEDLInBWA8HwkGMbeLNYDd4Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616002;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=Jv6yDs3LTT1v1znBlsGVv5ch1NifUwAZdkQWosCA1T0=;
	b=H1TtiyWIU1OVNAyKnPJx136WbZGBK0ga8g8TsGGI/ciwCTs5Fif4k7SmgIK3nIiOh+y0
	 KDuNzegeTwZz5kdGu/jj+xLxMVmRxE/PCMSeiyiDvt6AunnWFZapZAFfb1qRvL+slU0RV
	 l9rtpenDyWn6I68p5P5YTNm4Fa5KmaHBGOgiOxG9F951GqsQdmXa3AOZGy8J3ipE8Jq+I
	 MjLwUYdqFC1hiYrFFGLq7D+CfXceXD5kbl+Hks5n60vUbqpP5pRpHGavjvytvgefTNxKA
	 L0Y6uo/o7sHTMeiM5ikorZXEtPibHyfUY/FdTWpQ8q4a0LUyYuavQNOLjJgio+DGYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=e9wDeplc;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E553606A32D;
	Sat, 14 Nov 2026 00:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E553606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=e9wDeplc
Received: from abreu.speedport.ip (p5b13abd5.dip0.t-ipconnect.de [91.19.171.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 025554C2F3FFF2;
	Sat, 14 Nov 2026 01:26:33 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: battery: Refresh the battery asynchronously after system resume
Date: Sat, 14 Nov 2026 01:26:12 +0100
Message-ID: <20261114002612.219894-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794615994; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=Jv6yDs3LTT1v1znBlsGVv5ch1NifUwAZdkQWosCA1T0=; 
	b=e9wDeplc2GUNVHUN+hNfJis/3FlC1vN7/rDFFc1/k5b6c7LV7xRp2CF1dW1L7YtYhDLbC8xRRKf9
	Uz+O4+HwncuaJv+fdN0+lK89VXvOG6RnwEbvVLTVWCadwKGWnnepvrrtF/GxcQ8TrpmSclkvXRX53c
	Mnc/Tyx9QDERhZsxVRrkwWSO3XV3kf7xJG3h6fhFi+PMIPIHYhiYyyUhJKu8kR1RiE2a5EnVZHslIw
	iUeUeX9wGEku4gPuqyu4dGlPvb+vY5xwW75YZvG7tk2+yzgPwLJb3d+0jp9SG7Qqh5GB3nqhkJ+pPV
	fPN3t237KfR2S63XT0zKYOLyGW3cF9kA==

The PM_POST_SUSPEND notifier evaluates _BIX, _BTP and _BST synchronously,
and the notifier chain is the last step of the system resume: the write to
/sys/power/state, and so systemd-sleep and everything waiting for it, only
returns after it.

On a Dell XPS 13 9310 nearly all of the PM_POST_SUSPEND notifier chain is
battery_notify() (143 ms with the function_graph tracer):

    @ 143043.5 us |        } /* battery_notify [battery] */
    @ 143513.1 us |      } /* notifier_call_chain */
    @ 143536.0 us |  } /* pm_notifier_call_chain */

Queue the refresh on system_freezable_wq instead.

Time from "Restarting tasks: Done" (end of thaw_processes) to "PM: suspend
exit" for suspend-to-idle cycles of 8 s with sleepgraph, in ms, on Linux
7.4-rc1 with other resume changes, which do not run in this phase:

                  panel lit at suspend       panel off at suspend
    before        24.5  26.7  27.3  29.4     58.8  60.4  85.2
    after         10.7  10.8  15.9  17.7      5.7   8.3   9.3
    median        27.0 -> 13.4               60.4 -> 8.3

After the change, pm_notifier_call_chain(PM_POST_SUSPEND) takes
0.7-0.9 ms (function_graph, three cycles, hwrng_pm_notifier() being the
largest), so the rest of the phase is outside the notifier chain.  The
refresh still runs after each resume (kprobes, three cycles):
battery_notify() returns after 4-8 us, acpi_battery_pm_worker() starts
0.02-0.2 ms later and takes 17.8-18.6 ms, and it ends after rtcwake has
already returned.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Assisted-by: claude-opus-5.5 (Claude Code), analysis and patch
    draft; I reviewed it.

 drivers/acpi/battery.c | 63 +++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6edea559a5bce..4e2a79d356ef9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -105,6 +105,7 @@ struct acpi_battery {
 	struct kfifo acpi_notif_fifo;
 	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
+	struct work_struct pm_work;
 	struct list_head list;
 	unsigned long flags;
 
@@ -1293,40 +1294,48 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	pr_err_ratelimited("too many battery notifications within %dms\n", NOTIF_MERGING_MS);
 }
 
-static int battery_notify(struct notifier_block *nb,
-			  unsigned long mode, void *_unused)
+static void acpi_battery_pm_worker(struct work_struct *work)
 {
-	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
-						    pm_nb);
-
-	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
-		guard(mutex)(&battery->update_lock);
-
-		if (!acpi_battery_present(battery))
-			return 0;
-
-		if (battery->bat) {
-			acpi_battery_refresh(battery);
-		} else {
-			int result;
+	struct acpi_battery *battery = container_of(work, struct acpi_battery,
+						    pm_work);
 
-			scoped_guard(mutex, &battery->property_lock) {
-				result = acpi_battery_get_info(battery);
-				if (result)
-					return result;
-			}
+	guard(mutex)(&battery->update_lock);
 
-			result = sysfs_add_battery(battery);
-			if (result)
-				return result;
-		}
+	if (!acpi_battery_present(battery))
+		return;
 
+	if (battery->bat) {
+		acpi_battery_refresh(battery);
+	} else {
 		scoped_guard(mutex, &battery->property_lock) {
-			acpi_battery_init_alarm(battery);
-			acpi_battery_get_state(battery);
+			if (acpi_battery_get_info(battery))
+				return;
 		}
+
+		if (sysfs_add_battery(battery))
+			return;
 	}
 
+	scoped_guard(mutex, &battery->property_lock) {
+		acpi_battery_init_alarm(battery);
+		acpi_battery_get_state(battery);
+	}
+}
+
+static int battery_notify(struct notifier_block *nb,
+			  unsigned long mode, void *_unused)
+{
+	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
+						    pm_nb);
+
+	/*
+	 * Evaluating _BIX, _BTP and _BST takes tens of milliseconds on some
+	 * systems, and the PM notifier chain delays the end of the system
+	 * resume, so do it asynchronously.
+	 */
+	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION)
+		queue_work(system_freezable_wq, &battery->pm_work);
+
 	return 0;
 }
 
@@ -1516,6 +1525,7 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	INIT_WORK(&battery->pm_work, acpi_battery_pm_worker);
 	battery->pm_nb.notifier_call = battery_notify;
 	return register_pm_notifier(&battery->pm_nb);
 }
@@ -1525,6 +1535,7 @@ static void acpi_battery_remove(struct platform_device *pdev)
 	struct acpi_battery *battery = platform_get_drvdata(pdev);
 
 	unregister_pm_notifier(&battery->pm_nb);
+	cancel_work_sync(&battery->pm_work);
 }
 
 /* this is needed to learn about changes made in suspended state */
-- 
2.54.0

