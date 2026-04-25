Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53C2E040D;
	Sat, 25 Apr 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154723; cv=none; b=GUTEJiQiOpm1Nu2QZW2/NnxYLZISpKOzXda7jWwqZ+Ud0hcwDDsx1RbHH5IgScfHsxf+Bffq3HnGbu6RcSJ6P7u5tG23zHBdKnm7RjpdTPeOhTn6CprV3nKCjR+AiJq7NsprTBj9vyWSQ+VdlaTFg9Z37rL5//TXyiaf0Rf6s1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154723; c=relaxed/simple;
	bh=y1SuYU0Q0WNNvUkbuphHCJbSi2MtZr1sZT1WkQngKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poa1oO5a3Hfm8oNHTPLXhq/oHpt0tBUoIvJUIwtE4SANmjmcrktUl9AOFSkIH0M4X3lC+UXD1zN0SR+CfdNTMpSZBqwJysFt8YVw/MbmIhGJhrSu3PSnc464gY8QTK/rPNSPLUcV3WsyNAt6xuwLkD0O4RrdVgj4zqX9MU/nUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=RRtG9cHH; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="RRtG9cHH"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id C4A22BC0B4;
	Sun, 26 Apr 2026 00:57:45 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 55A3ABC081;
	Sun, 26 Apr 2026 00:57:45 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2A3681FD3FD;
	Sun, 26 Apr 2026 00:57:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154265;
	bh=lbSloGeEDYG886uDWQJIpyuZd2CkaLS35LXOgIJRno0=; h=From:To:Subject;
	b=RRtG9cHHPYZY1CWjAevgEMSEE1oTlSfZOeeyic1CD0nSC6ql0HrMPK8uJwCnnw/ug
	 KSqa5qwJuD2HKGcoJmLOiagsVl+TjG/aJMpws1oS/jvUzpMMmgp1RAau/b+206y2wA
	 d+SGT8hkoGIiiHZURKkmCbwwYQyyu+Ci/fMWWRrQmWNfvCnbZgTW8mGCJ9DySkM1ej
	 x/O32eyJmxTIkeVdfSQcc6QReTFwpf69dAJ/vydRw8QH7J5f58aZynzIAhHWdALiRX
	 LVJ/mQUhwEGmevcwqzC28aTAQM9dRgECxZ9gHmJRbeuTTYoY6BDt55dRH7EJ3SSFtg
	 kWysleHbIWilA==
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
Subject: [RFC v2 03/10] acpi/x86: s2idle: Add support for adding a delay after
 begin MS calls
Date: Sat, 25 Apr 2026 23:57:27 +0200
Message-ID: <20260425215734.14116-4-lkml@antheas.dev>
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
 <177715426490.3677825.2518839464906311984@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Certain platform/USB devices interact with Modern Standby firmware
notifications. This is particularly true with Asus, where the keyboards
are wired up to turn off their backlight during the Display Off
notification using a predetermined delay. While for Asus Keyboards this
does not cause an issue, it does manifest in ROG Ally devices, where the
controller waits for the animation to complete before saving its state.

In Windows, this is not a problem, because there is an ample delay after
these calls and before LPS0, typically seconds to minutes.

Therefore, introduce a delay quirk after these calls, to ensure affected
devices have time to uninitialize, and attach it to acpi_s2idle_dev_ops
so it can be consumed by device drivers.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 include/linux/acpi.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f5aefba8b191..8b48f999e0e9 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -517,6 +518,9 @@ static struct acpi_scan_handler lps0_handler = {
 
 static int acpi_s2idle_begin_lps0(void)
 {
+	struct acpi_s2idle_dev_ops *handler;
+	int delay = 0;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return acpi_s2idle_begin();
 
@@ -552,6 +556,13 @@ static int acpi_s2idle_begin_lps0(void)
 					lps0_dsm_func_mask_microsoft,
 					lps0_dsm_guid_microsoft);
 
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
+		if (handler->begin_delay && handler->begin_delay > delay)
+			delay = handler->begin_delay;
+	}
+	if (delay > 0)
+		msleep(delay);
+
 	return acpi_s2idle_begin();
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..a416e5c5798a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1154,6 +1154,7 @@ struct acpi_s2idle_dev_ops {
 	void (*prepare)(void);
 	void (*check)(void);
 	void (*restore)(void);
+	int begin_delay;
 };
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
-- 
2.53.0


