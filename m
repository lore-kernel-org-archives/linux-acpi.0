Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B64408026
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591094; cv=none; b=gqCm0Uwf4IOmp2dRSiz2yFbE6O55pAgFBfDJiD6NzdAyJ4/0D6WO5IyudMb7YKd0PH60Ow6Jltq4UsEMaqkcZXVS3BVyfkztBabMHAGtK9Kvrbh/ZAAj8nspmZM1kqT1R2HMv79XLcNLF9UTGWfMTQZgofm9Sb62flVLHJntbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591094; c=relaxed/simple;
	bh=kZnJ8tsvacPtm2hsnKYc948K+EcW6cihHTgrPPXfZgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prMDNVbNC5XrHC4T5rhwfSewq6eyuP46wdw9+EfLRqt50jtqulEiuJiPsa/KoPr24QblJP+eTgrhhVWlHr+VCmdqrYqemMb5oUE693W7ScugdyHSwcjjpxkfLOTuC9kcwzOrhI+T4KJ/57HxDjosbpVfurm0xBnBermtNxBwh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mvafXXzB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvafXXzB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso16599565ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591088; x=1784195888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKvs9NMfzomWJYoL/uKjqHUhieamWRXdxRMSQh2ZggE=;
        b=mvafXXzB5hTQ6wAKSC9qFAAvdvZq9Qh0JZLPcnybzvqi5j/4LOCDuzu2JqjBmuN4Ep
         xIqlHblhEM8aPpcpO5KcRraNaJgSUWdTM1bWpke8HE84kJknJwSgzRzVFP1oF9UEqiYg
         sN/iJrrYFWNPzHVBOlLIG5l/q5oq4IxNyiSvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591088; x=1784195888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cKvs9NMfzomWJYoL/uKjqHUhieamWRXdxRMSQh2ZggE=;
        b=CC7EBF816Spqfm5+DKcTb2G3TDyaz4yuOsNXJ0mZNfTo1ngMyKsVXBBUGs3n7XAbjr
         Ngb800ERaBcbLHpa8XUZjsTyHMij2ncbaAvbgAaw5+Ap4h8mGzUgYN3o5f2gwDGD2is6
         iEnJ/8ORTUEAURBcG2TyDZB2xXjNXjFos3hRwvAfV5lBPqB4/Dh5drqbQGEDECmaws8n
         yBL70A1XFfonoJ59p9+b2c/LtuIz1/lXSy096Tuw4uWDokJ17kIz5dE/7gej6fzJ6VjI
         draE9/aZgyVITigzZfU31rgZxp0TD9RswG6tc+LV6Nk4xoeOA5K5MIZVv3UhpztGLAI6
         5WXA==
X-Forwarded-Encrypted: i=1; AHgh+RqqaY2htHbujRL8hrEmOPhP/D8I1jCwXfTt39vh3SioyZThYwEEKYc9G3yvJvXkkwFDHrs6XeLZdUSA@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5aDBG7GO8zwcSMr7iA5JcFb9Wp/CJssmVYH8hXoWzm1OJvIR
	QdSwzDUIwRN+SIkDeeDj947X2Bv6okboOc5OGD6Fq6N7mEMn1n8pf2iZmW2UInZ4PA==
X-Gm-Gg: AfdE7cnsPoxl8IJgNlB+s8wWZEoKuxEru3yza+aCt02ug8B3kPihAcY2JRV5hwJDd3e
	0CdomBMo4CZ/SyTzFlVhbJ4lRvI1zsfGSCWnyakVyaCiaB8OUbVBweR72CVCJIT8M1uUVF4sRJw
	BwvxlB12FHX2e//90/9uVw2a1Rjv/Kxp0TpUZdeN9O+HRtBeG3W6Yq+9J0GhZkOEFE6JMiHApRV
	aeeCaUvfPi9VlF7OyVO/OBr5osZlQ8+oDMPcbE0suzaMwXWQrmw6rGI7s6rOOlLRgLkRIJ0ambg
	pfJ0g3iwZBlxdtwwp/MMB4YZL3zwZAxSg6k8eMYScWPn/iLSyMZFt3IpI64virk3ex81UjpXJh4
	nYdAuCdcahIqmTB58ErQTu9uRsbUxLcfY8Mfn10pNnjfZOicfL13vzAO9zI/xpn+DG29KMEBWQm
	ogvHsysYHUOR2FuoQ8CiT5uz7FP9hUYA1VtbjSySr+cydDj5vXxEst0am6ON2Sei7aJI+vcw==
X-Received: by 2002:a17:903:2450:b0:2c6:6424:c79f with SMTP id d9443c01a7336-2ccea348596mr65689615ad.8.1783591087839;
        Thu, 09 Jul 2026 02:58:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:07 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 06/14] usb: core: Move struct usb_port and related APIs to port.h
Date: Thu,  9 Jul 2026 17:57:11 +0800
Message-ID: <20260709095726.704448-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
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

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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
index fe10d72ef39d..6f576efa37b1 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3239,22 +3239,6 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
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
index e8fb2acd77be..206b9f9a5807 100644
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
index 000000000000..f43f6b3b6b1f
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
+extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
-- 
2.55.0.795.g602f6c329a-goog

