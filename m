Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE15372664;
	Sat, 25 Apr 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154285; cv=none; b=ABzAiSwP88GXnYv6D52jz07UkcCBjENfrD8kIHER37m/QJcqkRmsr3gFr6UXTnp33dosWR7cHBtuojnixsC124x5KgFjg6nPHVcYpYcAa2UXOC3V/a7FvbhEF8EWGdG+KrPo0DxyxLLIte9U2uMJ0MdUCYOnveV3zyfhONOQ208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154285; c=relaxed/simple;
	bh=vVC+6cEYtxb7gqifqa0c+6H57bwcrwtW76mDTsXp5XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzXWBR3K6Wld4IUvCh+g4msnq8BHqO7Z4o42XMd9K0DUjAlZ6f7jFkzllZBCBj0RDju31bHSD7NKiyvMKnC1ptEKOpnQ1ue2D6KP0W45gtELQIDGz05ZGeuQ03TLPwd6p5rlg+kWUdGmfEQu9rptBcHJxKnfq7zGk7BGBNaWMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ojGcwztk; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ojGcwztk"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id C9BF440741;
	Sat, 25 Apr 2026 21:57:53 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id A8970402E9;
	Sat, 25 Apr 2026 21:57:52 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6C2BD1FD47E;
	Sun, 26 Apr 2026 00:57:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154272;
	bh=VDnSj6l9qWHOv14nX7xw1TlanZttqCNOtiOgraz8eL0=; h=From:To:Subject;
	b=ojGcwztkxYvjv8/R/NTlBKORQJe7LABAhp1JHdmlfFQHwoRBShWclaUleElSEQNip
	 ec0nfWez5M30kJnEfZOVc/zzv2i5SRdXWwk84qYJfppV0wP3nMY3haviTmJhLes90Z
	 qzmTEr/sIiDFFOpqnJETUJ/dUZgUE5ZQZfsMalZW81vJ5wW4aQqmNaXvpUvlXv9VBy
	 LRRp2s4ASuWh4fRxhl4t+ML6igyZjXZZVdzs7jSLMypY9s+l2+gauEyIlYc3mzvMX7
	 ea87VWtK/IPkzoZi+LEcyWzTs9mpzw++sajILsKxXGzVVoAefDs/trGLvSHAvreBfq
	 DDc7WWrd88J6g==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 09/10] acpi/x86: s2idle: Listen to idle hints to perform MS
 transitions
Date: Sat, 25 Apr 2026 23:57:33 +0200
Message-ID: <20260425215734.14116-10-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715427215.3678391.3356729107738629691@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Modern Standby capable devices allow controlling their appearance by
userspace to appear inactive or asleep while the system is still running.
Expose these states to userspace as idle hints, so userspace can
leverage "dark resume" states to perform background tasks while the
system appears asleep.

If userspace is not idle-aware, transition to snooze and back to active
as part of the normal begin() and end() callbacks, so that normal
functionality (e.g., pulsing the power light) is maintained.

In addition, in case we have fired the intent to turn display on
notification and are in the resume idle state, the transition to s2idle
is undefined behavior. Therefore, momentarily transition to active and
back to snooze and emit an error, instead of bailing.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/Kconfig      |   1 +
 drivers/acpi/x86/s2idle.c | 226 +++++++++++++++++++++++++++++++-------
 2 files changed, 186 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6f4b545f7377..08622ace9c67 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -14,6 +14,7 @@ menuconfig ACPI
 	select NLS
 	select CRC32
 	select FIRMWARE_TABLE
+	select HINT if X86 && SUSPEND # s2idle idle hint
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 8b48f999e0e9..357d6f9406dc 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/hint.h>
 #include <linux/suspend.h>
 
 #include "../sleep.h"
@@ -67,6 +68,9 @@ static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
 static int lps0_dsm_state;
 
+static enum hint_idle_option current_idle = HINT_IDLE_ACTIVE;
+static enum hint_idle_option presuspend_idle = HINT_IDLE_ACTIVE;
+
 /* Device constraint entry structure */
 struct lpi_device_info {
 	char *name;
@@ -439,9 +443,171 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
+static int acpi_s2idle_idle_probe(void *drvdata, unsigned long *choices)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (lps0_dsm_func_mask_microsoft > 0) {
+		*choices |= BIT(HINT_IDLE_ACTIVE);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_DISPLAY_OFF | 1 << ACPI_LPS0_DISPLAY_ON))
+			*choices |= BIT(HINT_IDLE_INACTIVE);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_SLEEP_ENTRY | 1 << ACPI_LPS0_SLEEP_EXIT))
+			*choices |= BIT(HINT_IDLE_SNOOZE);
+		if (lps0_dsm_func_mask_microsoft &
+		    (1 << ACPI_LPS0_TURN_ON_DISPLAY))
+			*choices |= BIT(HINT_IDLE_RESUME);
+	}
+
+	if (lps0_dsm_func_mask > 0) {
+		*choices |= BIT(HINT_IDLE_ACTIVE);
+		if (acpi_s2idle_vendor_amd()) {
+			if (lps0_dsm_func_mask &
+			    (1 << ACPI_LPS0_DISPLAY_OFF_AMD |
+			     1 << ACPI_LPS0_DISPLAY_ON_AMD))
+				*choices |= BIT(HINT_IDLE_INACTIVE);
+		} else {
+			if (lps0_dsm_func_mask & (1 << ACPI_LPS0_DISPLAY_OFF |
+						  1 << ACPI_LPS0_DISPLAY_ON))
+				*choices |= BIT(HINT_IDLE_INACTIVE);
+		}
+	}
+
+	return 0;
+}
+
+static int acpi_s2idle_idle_get(struct device *dev, enum hint_idle_option *idle)
+{
+	*idle = current_idle;
+	return 0;
+}
+
+static int acpi_s2idle_idle_set(struct device *dev, enum hint_idle_option idle)
+{
+	if (idle >= HINT_IDLE_LAST)
+		return -EINVAL;
+
+	if (idle == current_idle)
+		return 0;
+
+	acpi_handle_debug(lps0_device_handle,
+			  "Idle state transition from %d to %d\n",
+			  current_idle, idle);
+
+	/* Resume can only be entered if we are on the snooze state. */
+	if (idle == HINT_IDLE_RESUME) {
+		if (current_idle != HINT_IDLE_SNOOZE)
+			return -EINVAL;
+
+		if (lps0_dsm_func_mask_microsoft > 0)
+			acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+
+		current_idle = HINT_IDLE_RESUME;
+		return 0;
+	}
+
+	/*
+	 * The system should not be able to re-enter snooze from resume as it
+	 * is undefined behavior. As part of setting the idle to "Resume",
+	 * userspace promised a transition to "Inactive" or "Active".
+	 */
+	if (current_idle == HINT_IDLE_RESUME &&
+	    idle == HINT_IDLE_SNOOZE)
+		return -EINVAL;
+
+	/*
+	 * When leaving snooze, always fire the resume notification first if
+	 * the device supports it. This is to counteract buggy firmware
+	 * (e.g., Lenovo) that expects the resume notification to fire always.
+	 */
+	if (current_idle == HINT_IDLE_SNOOZE && idle < current_idle &&
+	    lps0_dsm_func_mask_microsoft > 0) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+	}
+
+	/* Resume is the Snooze state logic-wise. */
+	if (current_idle == HINT_IDLE_RESUME)
+		current_idle = HINT_IDLE_SNOOZE;
+
+	if (current_idle < idle) {
+		for (; current_idle < idle; current_idle++) {
+			switch (current_idle + 1) {
+			case HINT_IDLE_INACTIVE:
+				if (lps0_dsm_func_mask > 0)
+					acpi_sleep_run_lps0_dsm(
+						acpi_s2idle_vendor_amd() ?
+							ACPI_LPS0_DISPLAY_OFF_AMD :
+							ACPI_LPS0_DISPLAY_OFF,
+						lps0_dsm_func_mask,
+						lps0_dsm_guid);
+
+				if (lps0_dsm_func_mask_microsoft > 0)
+					acpi_sleep_run_lps0_dsm(
+						ACPI_LPS0_DISPLAY_OFF,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+				break;
+			case HINT_IDLE_SNOOZE:
+				if (lps0_dsm_func_mask_microsoft > 0)
+					acpi_sleep_run_lps0_dsm(
+						ACPI_LPS0_SLEEP_ENTRY,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+				break;
+			default:
+				break;
+			}
+		}
+	} else if (current_idle > idle) {
+		for (; current_idle > idle; current_idle--) {
+			switch (current_idle) {
+			case HINT_IDLE_INACTIVE:
+				if (lps0_dsm_func_mask > 0)
+					acpi_sleep_run_lps0_dsm(
+						acpi_s2idle_vendor_amd() ?
+							ACPI_LPS0_DISPLAY_ON_AMD :
+							ACPI_LPS0_DISPLAY_ON,
+						lps0_dsm_func_mask,
+						lps0_dsm_guid);
+				if (lps0_dsm_func_mask_microsoft > 0)
+					acpi_sleep_run_lps0_dsm(
+						ACPI_LPS0_DISPLAY_ON,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+				break;
+			case HINT_IDLE_SNOOZE:
+				if (lps0_dsm_func_mask_microsoft > 0)
+					acpi_sleep_run_lps0_dsm(
+						ACPI_LPS0_SLEEP_EXIT,
+						lps0_dsm_func_mask_microsoft,
+						lps0_dsm_guid_microsoft);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct hint_ops acpi_s2idle_hint_ops = {
+	.idle_probe = acpi_s2idle_idle_probe,
+	.idle_get = acpi_s2idle_idle_get,
+	.idle_set = acpi_s2idle_idle_set,
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
+	struct device *hdev;
+
 	if (lps0_device_handle)
 		return 0;
 
@@ -508,6 +674,15 @@ static int lps0_device_attach(struct acpi_device *adev,
 	 */
 	acpi_ec_mark_gpe_for_wake();
 
+	/*
+	 * Add idle hint handler to lps0_device_handle.
+	 */
+	hdev = devm_hint_register(&adev->dev, "s2idle", NULL,
+				  &acpi_s2idle_hint_ops);
+	if (IS_ERR(hdev))
+		acpi_handle_err(adev->handle,
+				"Failed to register idle hint device\n");
+
 	return 0;
 }
 
@@ -538,23 +713,14 @@ static int acpi_s2idle_begin_lps0(void)
 			lpi_constraints_table = ERR_PTR(-ENODATA);
 	}
 
-	/* Display off */
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_DISPLAY_OFF_AMD :
-					ACPI_LPS0_DISPLAY_OFF,
-					lps0_dsm_func_mask, lps0_dsm_guid);
-
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
-
-	/* Modern Standby entry */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
+	presuspend_idle = current_idle;
+	if (current_idle == HINT_IDLE_RESUME) {
+		acpi_handle_err(
+			lps0_device_handle,
+			"Unexpected idle state: Resume. Transitioning to active and back.\n");
+		acpi_s2idle_idle_set(NULL, HINT_IDLE_ACTIVE);
+	}
+	acpi_s2idle_idle_set(NULL, HINT_IDLE_SNOOZE);
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
 		if (handler->begin_delay && handler->begin_delay > delay)
@@ -636,30 +802,8 @@ static void acpi_s2idle_end_lps0(void)
 {
 	acpi_s2idle_end();
 
-	if (!lps0_device_handle || sleep_no_lps0)
-		return;
-
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		/* Intent to turn on display */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
-		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
-	}
-
-	/* Display on */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_DISPLAY_ON_AMD :
-					ACPI_LPS0_DISPLAY_ON,
-					lps0_dsm_func_mask, lps0_dsm_guid);
+	if (lps0_device_handle && !sleep_no_lps0)
+		acpi_s2idle_idle_set(NULL, presuspend_idle);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
-- 
2.53.0


