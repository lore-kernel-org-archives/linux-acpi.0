Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823319;
	b=mwhxHjF9EkRBadhSFTQassmSG6v5BcUGh6wd+vIX+yBUKtGNEII6ZLU8yM09/k08j+R2
	 FB7Pdqj2BEkaC0i/G4yqOVEM5UhfVvtJAGIeUAwvkVHfegunWt4Q2d15eEp7u7cg4B6Ha
	 1+XoAnW6Cjrb/m6h2PjkoIPzm88yDpHnkccsxKpnZp1I4pl/dgNJ9gnyL65o9nP/pHSPC
	 iwMB3bV5GgxB4h3WTwQMFyXquYwwLh947AIPhkX09S3Atz0a9JmKWqT4oRPTGJppy3bnq
	 yxHbf/4rjj6VjZQCG2+On9EhGRp0qRz1wYILWt2SJ23Cc1mkuBlo/eK8bWqLphpvpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=oXrr0kr58+nulwdQ+acEPKeJfaPwa1Ov8Mw/TJIMCck=;
	b=l12KEfOxYS8yMlIAM7lRHAVyVJ0DNySHUo2LPhQu7cKuySTXGOCSqyFdQnm2PxXFrV9l
	 D21RMUPKt55USLo4IkZslirGLFkYLb2hHyluLckH/fMgDjX0Zr/q8ZUfmqhiI9q+cynyV
	 VSzJr2t0lH1WejNXcE35YkOxB9/tRT7iV3kY0vdKrg4i2aCeXNkpu03rcOXmuqLEgBW36
	 zyqnwBYkj9R7bnrUECwvBt8wZg7shcn/poVd7wyFinEcIrNos0taJtv2gYjEaYfLTDV/I
	 a4DUkNT7fsqWF4eOXkHPrGV7dh4oqJWM/aRFY/UJ8E5marQBAOQw7Zh6ovrpb1OQT7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwTZW4hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569B6071AC1;
	Wed,  4 Nov 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwTZW4hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEAF1F000C1;
	Wed,  4 Nov 2026 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823319;
	bh=oXrr0kr58+nulwdQ+acEPKeJfaPwa1Ov8Mw/TJIMCck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GwTZW4hzrVnieptgPEh8s0MvubmcKjE0duybhCHFSHzFQHX/d2z4n09XKVsY4sXPb
	 yKYV8XwriWFrCUD7MM+g40mxfhYrmIDMscP/uPypgiTZGJV1jTk2Gp6MGN8220YZOs
	 4Fa/4cVPtk25Z6lsZ0dB6Xyy3p3kdB45qdDtAY+ogn0J7ZDJubgAE359GmSsH3op94
	 G276juRNk1WIGMMYJh5nuGJDBi6PqhqCyGcurxnIQ/iE78CxSGI74p7v2Grb3xomDg
	 fV4c6FZoOqkVEsQSBpb7P3oNXbzlErt9mH4/ak1X3wQ4S2xRLyEJwn5b5b0IfsrNq5
	 BH4vmeGAVTbPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 2/3] ACPI: glue: Change (un)register_acpi_dev_type() to void
 functions
Date: Wed, 04 Nov 2026 21:13:25 +0100
Message-ID: <2080936.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3471545.44csPzL39Z@rafael.j.wysocki>
References: <3471545.44csPzL39Z@rafael.j.wysocki>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The register_acpi_dev_type() and unregister_acpi_dev_type() return
values are effectively ignored in all cases (either directly or up
in the call chain), so make them both void and adjust two callers of
register_acpi_dev_type() accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c         | 14 ++++++--------
 drivers/thunderbolt/acpi.c  |  4 ++--
 drivers/thunderbolt/tb.h    |  4 ++--
 drivers/usb/core/usb-acpi.c |  4 ++--
 drivers/usb/core/usb.h      |  4 ++--
 include/acpi/acpi_bus.h     |  8 ++++----
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 817123c968ba..51caaa73a43c 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -29,33 +29,31 @@ static DECLARE_RWSEM(dev_type_sem);
 #define PHYSICAL_NODE_STRING "physical_node"
 #define PHYSICAL_NODE_NAME_SIZE (sizeof(PHYSICAL_NODE_STRING) + 10)
 
-int register_acpi_dev_type(struct acpi_dev_type *type)
+void register_acpi_dev_type(struct acpi_dev_type *type)
 {
 	if (acpi_disabled)
-		return -ENODEV;
+		return;
+
 	if (type && type->match && type->find_companion) {
 		down_write(&dev_type_sem);
 		list_add_tail(&type->list, &dev_type_list);
 		up_write(&dev_type_sem);
 		pr_info("device type %s registered\n", type->name);
-		return 0;
 	}
-	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(register_acpi_dev_type);
 
-int unregister_acpi_dev_type(struct acpi_dev_type *type)
+void unregister_acpi_dev_type(struct acpi_dev_type *type)
 {
 	if (acpi_disabled)
-		return 0;
+		return;
+
 	if (type) {
 		down_write(&dev_type_sem);
 		list_del_init(&type->list);
 		up_write(&dev_type_sem);
 		pr_info("device type %s unregistered\n", type->name);
-		return 0;
 	}
-	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(unregister_acpi_dev_type);
 
diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 958837e3736e..209419e3844f 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -358,9 +358,9 @@ static struct acpi_dev_type tb_acpi_dev_type = {
 	.setup = tb_acpi_setup,
 };
 
-int tb_acpi_init(void)
+void tb_acpi_init(void)
 {
-	return register_acpi_dev_type(&tb_acpi_dev_type);
+	register_acpi_dev_type(&tb_acpi_dev_type);
 }
 
 void tb_acpi_exit(void)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e86845762e22..ef22cd247104 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1520,7 +1520,7 @@ bool tb_acpi_may_tunnel_dp(void);
 bool tb_acpi_may_tunnel_pcie(void);
 bool tb_acpi_is_xdomain_allowed(void);
 
-int tb_acpi_init(void);
+void tb_acpi_init(void);
 void tb_acpi_exit(void);
 int tb_acpi_power_on_retimers(struct tb_port *port);
 int tb_acpi_power_off_retimers(struct tb_port *port);
@@ -1533,7 +1533,7 @@ static inline bool tb_acpi_may_tunnel_dp(void) { return true; }
 static inline bool tb_acpi_may_tunnel_pcie(void) { return true; }
 static inline bool tb_acpi_is_xdomain_allowed(void) { return true; }
 
-static inline int tb_acpi_init(void) { return 0; }
+static inline void tb_acpi_init(void) { }
 static inline void tb_acpi_exit(void) { }
 static inline int tb_acpi_power_on_retimers(struct tb_port *port) { return 0; }
 static inline int tb_acpi_power_off_retimers(struct tb_port *port) { return 0; }
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index f00e8c72ebe6..05881260a4b7 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -375,9 +375,9 @@ static struct acpi_dev_type usb_acpi_dev_type = {
 	.find_companion = usb_acpi_find_companion,
 };
 
-int usb_acpi_register(void)
+void usb_acpi_register(void)
 {
-	return register_acpi_dev_type(&usb_acpi_dev_type);
+	register_acpi_dev_type(&usb_acpi_dev_type);
 }
 
 void usb_acpi_unregister(void)
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a9b37aeb515b..d025d6d9d346 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -207,11 +207,11 @@ extern void usb_hub_adjust_deviceremovable(struct usb_device *hdev,
 		struct usb_hub_descriptor *desc);
 
 #ifdef CONFIG_ACPI
-extern int usb_acpi_register(void);
+extern void usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
 extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
 	int port1);
 #else
-static inline int usb_acpi_register(void) { return 0; };
+static inline void usb_acpi_register(void) { }
 static inline void usb_acpi_unregister(void) { };
 #endif
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8524ceb52b24..da2262d220e0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -666,8 +666,8 @@ struct acpi_dev_type {
 	struct acpi_device * (*find_companion)(struct device *);
 	void (*setup)(struct device *);
 };
-int register_acpi_dev_type(struct acpi_dev_type *type);
-int unregister_acpi_dev_type(struct acpi_dev_type *type);
+void register_acpi_dev_type(struct acpi_dev_type *type);
+void unregister_acpi_dev_type(struct acpi_dev_type *type);
 int acpi_bind_one(struct device *dev, struct acpi_device *adev);
 void acpi_unbind_one(struct device *dev);
 
@@ -978,8 +978,8 @@ static inline struct device *acpi_bus_get_primary_device(struct acpi_device *ade
 	return NULL;
 }
 
-static inline int register_acpi_dev_type(void *type) { return 0; }
-static inline int unregister_acpi_dev_type(void *type) { return 0; }
+static inline void register_acpi_dev_type(void *type) { }
+static inline void unregister_acpi_dev_type(void *type) { }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
-- 
2.51.0




