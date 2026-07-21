Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582342EEC4
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616911; cv=none; b=DIvfhAiVZohIEp4IYn9KB5ViP1Ada/zYLcJl0/p39j3UkrHDsBNlnvCjYJj9kmY/Tz3k4q1JfHJZK7R3OsvaibZT7rM/f6wEOsHK+Tq4tfxY2jVpW2CFB9mr+7AKy/7RXoU6Nz6PrU6xib8HeON8eHY9h1rv/x+0eEYrb7OqIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616911; c=relaxed/simple;
	bh=IlZ/0IeKP4mmnn6s8JCPzwMroH/vaSwiA2UpQ8RQglw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPJ8NChR8OR++CRVN/tQBTwnRQOjg4y0iKYRL60KsRMWkDkNB/j8EZHjE4eWIn1S0VW3QYfsUfx9aqn8brk24xhcqjWthABHZtlybquRgwjvFIUIO+PHgljdLtF/PNcy9sB2afunHywguG09SITPp/bNT/lMbI0Kt6oQIex3pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lV0YC+S4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lV0YC+S4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso130797035ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616909; x=1785221709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAcFKcy+EqEALwPe3iCzQnqqeeFK6XarTVIxswfGgCg=;
        b=lV0YC+S4eCJw9OKlK2hA0klB/SJhiz6WLLKZH/Gmp7BrSfQpmHysdw4h1Vms+utfHE
         Q7AeV73Xb9eWxTvhB6DCyv0Sq3bTdzo3dPXBOze48sem+cBK2CCzs5Y9vqz5DTVqwE4v
         DiCfqbG0AiSvqJLaX53bSTvGPrI2vvniF8jMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616909; x=1785221709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAcFKcy+EqEALwPe3iCzQnqqeeFK6XarTVIxswfGgCg=;
        b=T71EU/gVicCMAwlNaXYnJUhqZwQznEcSu47qu6wS8NW4ZMGRKvBnpVHIb68rlxb78I
         kljJWo5DtxjQzaLd4V6HNTe2hLGwEJxbTJZPO/wYg1owl3y+fZ7yqBkYFOWopNA038Yt
         NWj7Egtvk4RkIwS/D5qvjqirTVw+dDFOXV7wm0XSv8gfQRsCwiMcnojVcwS2BW4kwiAE
         QhwqhW5s1NxWCLvGRw4gcsMqTjfJE96f756o4RJxNpoYqCWPr5f+IEMCuMWnhNE2MNr6
         LBW3uPgApBNzz0hVs+iTX62kLky8ZqYQAhRKaqxSzz6oL/i+0vDJfr0nKy7qtyJDZh+j
         Uekw==
X-Forwarded-Encrypted: i=1; AHgh+Rq67+u20EE4ysK9QZZ6Sjsmr3r/OxO08olLspyrNqsvf8U/ypymnXMzvwjvxkuHdw0+el7cMB+yFIMu@vger.kernel.org
X-Gm-Message-State: AOJu0YynXFwZWbOYEJCXvRdXM/8WxGlpdlxQc6Lxx7Ga0jyJ/wCmylBE
	2gV48KiqIvln8DxvIULU/J5l7crS5Rh12imc03CyRapX9egY87O1FEVRqEbF63Fjrw==
X-Gm-Gg: AR+sD10cSh2mTyYZ5l9Gk3ffjAVNzyNQvXVNYiYY6y4qu6mk0Ke8KAdWsS0JgXT6S/l
	kaLmGgselexJk2MZGSNgscUYWqwSZWUJQd9VOd0UeL2IgJZ1fMPAub/XZ6gLD4IPLCtaZFMaZV6
	WNvE/0RacwFuIaYp9b1w9wVaw9Dsw3hnfJj7j13jxBuGbQQ9dmC2O1IOJKofAI0lZdNAaI2Uzr+
	OrXP9vTnk9XqOrWYFMhaQ811mLDjCnFapXDMsIj04VpLcjViH0twJAwl8pmwG6s7dOMvhOOJYIn
	6nm4Y1uYwHERwfu/cDRobYVC2FRviLaDB9HupfZarHnGBwjgBiA+/SVdDkPd1m8yHbtj0/IwzMb
	tTVLIxYQv5DFDxUXf1WccADcLe3Shoy4oaFm9QQQMEIGF4RIwg5FU7C6a0MLsSb9d7SUB+j28Vp
	AreNtwRqoawpuq8LFEI3fxR5mzPdvlaYgClbzBoRJEjxI8zR0yLR6MU/VtMCg=
X-Received: by 2002:a17:903:18d:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cf348f9f5amr194323965ad.17.1784616909129;
        Mon, 20 Jul 2026 23:55:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 07/16] usb: core: Move struct usb_port and related APIs to port.h
Date: Tue, 21 Jul 2026 14:54:02 +0800
Message-ID: <20260721065413.2306137-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

|struct usb_port| and its matching container_of() macro should live in
its own port.h, matching the split we have for .c files.

Move them as described. Also move usb_port_is_power_on(), since in the
next change its |struct usb_hub *| parameter will be changed to
|struct usb_port *|, and becomes a non-static function that only
references |struct usb_port|.

port.h is only included from hub.h, as a subsequent patch will directly
use fields from |struct usb_port| in a static inline helper in hub.h.
The USB internal headers don't have header guards to help with this.

Also drop 'extern' from the header declaration of usb_port_is_power_on().
This is not needed in modern C.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Dropped 'extern' (Andy)

Changes since v3:
- New patch (Andy)
---
 drivers/usb/core/hub.c  | 16 ----------
 drivers/usb/core/hub.h  | 48 ++---------------------------
 drivers/usb/core/port.c | 16 ++++++++++
 drivers/usb/core/port.h | 68 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 62 deletions(-)
 create mode 100644 drivers/usb/core/port.h

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8f8624a0d36a..a6c4e4c0368a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3240,22 +3240,6 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
 	return port_dev->ignore_event;
 }
 
-/* Check if a port is power on */
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
-{
-	int ret = 0;
-
-	if (hub_is_superspeed(hub->hdev)) {
-		if (portstatus & USB_SS_PORT_STAT_POWER)
-			ret = 1;
-	} else {
-		if (portstatus & USB_PORT_STAT_POWER)
-			ret = 1;
-	}
-
-	return ret;
-}
-
 static void usb_lock_port(struct usb_port *port_dev)
 		__acquires(&port_dev->status_lock)
 {
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 9ebc5ef54a32..de524c6da9fc 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -15,7 +15,9 @@
 #include <linux/usb/ch11.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/typec.h>
+
 #include "usb.h"
+#include "port.h"
 
 struct usb_hub {
 	struct device		*intfdev;	/* the "interface" device */
@@ -78,51 +80,6 @@ struct usb_hub {
 	struct list_head        onboard_devs;
 };
 
-/**
- * struct usb port - kernel's representation of a usb port
- * @child: usb device attached to the port
- * @dev: generic device interface
- * @port_owner: port's owner
- * @peer: related usb2 and usb3 ports (share the same connector)
- * @connector: USB Type-C connector
- * @req: default pm qos request for hubs without port power control
- * @connect_type: port's connect type
- * @state: device state of the usb device attached to the port
- * @state_kn: kernfs_node of the sysfs attribute that accesses @state
- * @location: opaque representation of platform connector location
- * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
- * @portnum: port index num based one
- * @is_superspeed cache super-speed status
- * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
- * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
- * @early_stop: whether port initialization will be stopped earlier.
- * @ignore_event: whether events of the port are ignored.
- */
-struct usb_port {
-	struct usb_device *child;
-	struct device dev;
-	struct usb_dev_state *port_owner;
-	struct usb_port *peer;
-	struct typec_connector *connector;
-	struct dev_pm_qos_request *req;
-	enum usb_port_connect_type connect_type;
-	enum usb_device_state state;
-	struct kernfs_node *state_kn;
-	usb_port_location_t location;
-	struct mutex status_lock;
-	u32 over_current_count;
-	u8 portnum;
-	u32 quirks;
-	unsigned int early_stop:1;
-	unsigned int ignore_event:1;
-	unsigned int is_superspeed:1;
-	unsigned int usb3_lpm_u1_permit:1;
-	unsigned int usb3_lpm_u2_permit:1;
-};
-
-#define to_usb_port(_dev) \
-	container_of(_dev, struct usb_port, dev)
-
 extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
 extern void usb_hub_remove_port_device(struct usb_hub *hub,
@@ -138,7 +95,6 @@ extern int usb_clear_port_feature(struct usb_device *hdev,
 		int port1, int feature);
 extern int usb_hub_port_status(struct usb_hub *hub, int port1,
 		u16 *status, u16 *change);
-extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
 
 static inline bool hub_is_port_power_switchable(struct usb_hub *hub)
 {
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c0a51d9b06a6..b2e953f137f8 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -22,6 +22,22 @@ static int usb_port_block_power_off;
 
 static const struct attribute_group *port_dev_group[];
 
+/* Check if a port is power on */
+int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
+{
+	int ret = 0;
+
+	if (hub_is_superspeed(hub->hdev)) {
+		if (portstatus & USB_SS_PORT_STAT_POWER)
+			ret = 1;
+	} else {
+		if (portstatus & USB_PORT_STAT_POWER)
+			ret = 1;
+	}
+
+	return ret;
+}
+
 static bool usb_port_allow_power_off(struct usb_device *hdev,
 				     struct usb_hub *hub,
 				     struct usb_port *port_dev)
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
new file mode 100644
index 000000000000..00f7500af336
--- /dev/null
+++ b/drivers/usb/core/port.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * usb hub driver head file
+ *
+ * Copyright (C) 1999 Linus Torvalds
+ * Copyright (C) 1999 Johannes Erdfelt
+ * Copyright (C) 1999 Gregory P. Smith
+ * Copyright (C) 2001 Brad Hards (bhards@bigpond.net.au)
+ * Copyright (C) 2012 Intel Corp (tianyu.lan@intel.com)
+ *
+ *  move struct usb_port to this file.
+ */
+
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/mutex_types.h>
+#include <linux/usb.h>
+
+#include <uapi/linux/usb/ch9.h>
+
+/**
+ * struct usb port - kernel's representation of a usb port
+ * @child: usb device attached to the port
+ * @dev: generic device interface
+ * @port_owner: port's owner
+ * @peer: related usb2 and usb3 ports (share the same connector)
+ * @connector: USB Type-C connector
+ * @req: default pm qos request for hubs without port power control
+ * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
+ * @state_kn: kernfs_node of the sysfs attribute that accesses @state
+ * @location: opaque representation of platform connector location
+ * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
+ * @portnum: port index num based one
+ * @is_superspeed cache super-speed status
+ * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
+ * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @early_stop: whether port initialization will be stopped earlier.
+ * @ignore_event: whether events of the port are ignored.
+ */
+struct usb_port {
+	struct usb_device *child;
+	struct device dev;
+	struct usb_dev_state *port_owner;
+	struct usb_port *peer;
+	struct typec_connector *connector;
+	struct dev_pm_qos_request *req;
+	enum usb_port_connect_type connect_type;
+	enum usb_device_state state;
+	struct kernfs_node *state_kn;
+	usb_port_location_t location;
+	struct mutex status_lock;
+	u32 over_current_count;
+	u8 portnum;
+	u32 quirks;
+	unsigned int early_stop:1;
+	unsigned int ignore_event:1;
+	unsigned int is_superspeed:1;
+	unsigned int usb3_lpm_u1_permit:1;
+	unsigned int usb3_lpm_u2_permit:1;
+};
+
+#define to_usb_port(_dev) \
+	container_of(_dev, struct usb_port, dev)
+
+struct usb_hub;
+
+int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
-- 
2.55.0.229.g6434b31f56-goog

