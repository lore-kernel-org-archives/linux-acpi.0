Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286D379991
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036360; cv=none; b=fHkJFp81WYHI9VjMdRbn6MaXw5jUk00GAelUdn691AFCI0ZNTm04oDu9/57bYw+za/NeK+UJazsvTf86BgZB8JgS3DIGS10uj3dqTi7CyotJu2yKVrtvQJW+ANYUlwXMWKB7cUvY6tzZviez2o2XIdKpkPSfVxRU8hX8eQ079WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036360; c=relaxed/simple;
	bh=5UTXMSeom7sDfDEZoJPtYwokhZBlKzujVMWMmQn+fGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/IcBdbufsRhwh3GGBKGHvrNdYAik+pUUs431NFckOsdllb38zzuzE4homrsyVlIWNIcGWw1E2Yyrf3uvUw5b/jh0qkYYKNuBjfY+CB54wgm+mVtMKzwZXgTM/BYnRy4RtjXfuTg4H9zpdV+TkPP0u+v7k2PPrPDfccchYlo3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWRtPmjH; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWRtPmjH"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f3f52143cdso2207916a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036347; x=1787641147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mtj+dt5p7fIyuo0qayJwRGBo24B4b+4gdSbjpBywKdw=;
        b=ZWRtPmjHdFPiSYkTsiHNaPeyNUYoXjPx1wa3DB5zT1JSyV27bryCSNtNX6OaHbkSFd
         gFdgeErl26uZezsK6APzD6P1ghFP1dGrlABqY6gkknanzn5kPgjxWWiYwSwwkgkpW07j
         lOZFpVG+Hpowe4S+ORngnAx7cR24y+pGTA1pNJ/jXDfKOAVN8SMmTmc+Qh5vYawLSa82
         w9UZZP2Ooem1UxReaIe8QRKjPz+CNxHOeadTXW2d4LRSogr1upUhIUzfG+oa9mjaNnZb
         LheeVgTHX7SfvCb7OgChWZ68Vxx43sas2LKamZ3RaIteY0lsyMrG7ZO+/whZekVXpJDH
         UvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036347; x=1787641147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mtj+dt5p7fIyuo0qayJwRGBo24B4b+4gdSbjpBywKdw=;
        b=ZQXXlHA9BZ80O2/xIW2ZEQ6w/Kf4E+cS3igLvKnh5WWwhUxgPp1iT0qh/95h7oqiYB
         3w0O3aM75mPd7TFQjeqb1l3dYBs7Tm3Au9OXRgzw6fLMF0TdbwA47NFnSX+9ZNI57gu8
         x6mHbU/unJ63GjxR1L8gZOm+6mporXzvFrbxLqR5f+dUKPyq44Ltg7ND1xrHlCei/8gF
         +1AzdvWRta2KIb9PXeqSBUCAcr3aRR2xdnBdbL25stvczqMOqk/MT2hJue/1hMQfad6Q
         2Sxg1pB8lFIm/q7iVvVExQFRyRiabkEGU/UtHvtzuaJ5BYNaiUhFwC1eYkD7hKVzrJDp
         qVOA==
X-Forwarded-Encrypted: i=1; AHgh+Roq7Ao5nlFA/5Ge+q2Ol6q9VIFPSlCG+UH+omjIZi8m0Dozjz6jipON6QX9R+P4mMXXhmLAD/p34A5c@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPZWqtdII+CeHhAWJaPTJc2lizmVrUjoyUhk4zfDd5Xtf3Kip
	hbKCMDNyqGxBnoAIrcgqqs/+7XGHB0BfQvLMy4sXOM75QZAZtOoyc/Wo
X-Gm-Gg: AR+sD12/bCA7kVi21svJ/0TpsET5ewF0MK90TAhsc/9q+VLSyqlatjEv2XDbNsa/TB5
	ysAhnoJQbeDEt3BnwgqHO/oEEBsKDfBxZ9chFlKFkQwrTOEvVs/46c4hoRBHjFEUfK/B/krc1KS
	zPIfwVy3DQ/o9P55hIhDHz7Ft6fwHEoWlHJy0RKn7vQALY673Y6sA02nTB9qKHMegrBhwy7Fwpk
	23r2XSA+hwzwePjKnNibntOX8OKFe4jfmvT3OnWLSZ1+cDVsTNEcx5SmLOGAwwFD4MVwQkBk8KO
	lw+ljbkOmgb7zsjtobKFFAZAQVrk7envpDmZMRhazoF/ECbiXf6R60KVacDkIXSLsZOZ4h+mcUE
	YO1hOUh8YOKNCin0dGfPrRRzTESgc5bXSIHbwcK6fiwXYZiz/MD5Q4LF5jbrF3pp5DoL87k0GIk
	EU69UQ+htPlTuvjpZ4lrlGD+BW+DrCnnbemcopeamGvsv76FJf4uRGbf/LozlbBIb72HLZ6UmRH
	qzB505IFi/vVeujQ0ockweHvmeHjfptoVSU6eljfdUIs14lPcqObjqrCnQDzSGHj2E6rQvtYT6v
	2ptgiWgdHwo/LQ7azO2wfUnmFyl862rr+d5eF31trejKNGe1BWtGYUu/u9sup1tt7O0ZHrEr+hP
	MahSfq1o1nLIcuR/r
X-Received: by 2002:a05:6830:4c01:b0:7e9:d4b5:8004 with SMTP id 46e09a7af769-7f3de4d731fmr32472603a34.5.1787036347210;
        Mon, 17 Aug 2026 23:59:07 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41beef430sm3599463a34.5.2026.08.17.23.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:59:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 18 Aug 2026 00:59:00 -0600
Subject: [PATCH net-next v3 4/4] driver core: handle managed links for
 class devices
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-submit-phy-package-fwdevlink-v1-v3-4-40a905ea16b6@gmail.com>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

fw_devlink deliberately lets the nearest device pick up dependencies below
class-backed firmware nodes because driverless class devices do not
currently progress through managed device-link states. This can leave
consumers of class suppliers dormant, while sync-state-only links from
class consumers never reach the successful-probe cleanup.

Track class-only devices through equivalent registration and removal
transitions. Mark them probing before device_add() publishes them, complete
their incoming and outgoing links after class interfaces run, and enter the
unbind and no-driver states during device_del(). Preserve firmware links
below class-backed nodes so later-created descendants can acquire their own
links.

Include class registration in wait_for_device_probe() so supplier unbind
cannot race a class consumer that is still being published. Transition
managed links which existed before device_add(), remove stale
waiting_for_supplier attributes and do not revive a link whose supplier has
already started unbinding.

During supplier teardown, wait for class registration to finish, but move
an already registered class consumer directly to the unbinding link state
because it has no driver to release. Keep consumer-autoremove links valid
until class consumer removal without triggering driver-only cleanup
warnings.

Factor the supplier-bound, consumer-bound and cleanup transitions shared
with driver-backed devices. Activate late links involving an already
functional class endpoint instead of trying to reprobe it, and let
sync-state-only links retire without forcing consumer unbind. Ordinary
supplier links cannot defer class registration, so they must not be the
only mechanism on which a class consumer relies for functionality.

Class devices do not match drivers, so distinguish a genuinely unavailable
supplier from a probing or registered class endpoint before relaxing
inferred links. Preserve normal probe and runtime-PM ordering for those
links. Also recognize class-backed nodes when refreshing dependencies after
firmware-tree overlays.

Exclude the internal device-link class because device-link objects are
registered while the device-links lock is held. Document the class-device
state transitions and add KUnit coverage for supplier and consumer links,
pre-existing links, inferred-link preservation, registration waiters and a
concurrent supplier unbind.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v2 -> v3:
  - Replace the framework-specific proxy cleanup API with generic
    class-device managed-link lifecycle handling, as suggested by
    Saravana Kannan
  - Preserve inferred links to probing and registered class suppliers in
    no-driver fallback paths and include class nodes in overlay refresh
  - Cover pre-existing and inferred links, wait_for_device_probe()
    integration, waiting_for_supplier cleanup and supplier-unbind races
  - Document the limits of ordinary supplier links for driverless class
    consumers
  - Handle registered class consumers during supplier teardown without a
    no-op driver release or driver-only cleanup warning
  - Derive class handling inside the shared bound helpers and clarify the
    lifecycle documentation
---
 Documentation/driver-api/device_link.rst   |  47 ++-
 drivers/base/base.h                        |   2 +
 drivers/base/core.c                        | 270 +++++++++++-----
 drivers/base/dd.c                          |  21 +-
 drivers/base/test/Makefile                 |   1 +
 drivers/base/test/device-link-class-test.c | 479 +++++++++++++++++++++++++++++
 include/linux/device.h                     |   9 +-
 7 files changed, 739 insertions(+), 90 deletions(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index ee913ae16371..c248ec9fa9f8 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -253,6 +253,18 @@ child one.
 State machine
 =============
 
+Driverless class devices participate in the managed-link state machine as
+supplier and consumer endpoints, including as consumers of sync-state-only
+proxy links.  Their registration is treated like a successful driver probe:
+links are completed after :c:func:`device_add()` has finished running class
+interfaces.  During removal, driver-backed consumers are unbound before the
+class device is deleted and its links return to the no-driver state.
+
+Class devices are not probed, so an ordinary supplier link cannot defer their
+registration in the way that it defers a driver probe.  Frameworks must not use
+such a link as the only mechanism guaranteeing that a class consumer's
+supplier is functional.
+
 .. kernel-doc:: include/linux/device.h
    :functions: device_link_state
 
@@ -271,10 +283,13 @@ State machine
   and consumer.  If the link is created before any devices are probed, it
   is set to ``DL_STATE_DORMANT``.
 
-* When a supplier device is bound to a driver, links to its consumers
-  progress to ``DL_STATE_AVAILABLE``.
-  (Call to :c:func:`device_links_driver_bound()` from
-  :c:func:`driver_bound()`.)
+* When a supplier device is bound to a driver, links to its consumers progress
+  to ``DL_STATE_AVAILABLE``.  Registering a driverless class supplier performs
+  the equivalent transition, or activates a late link whose consumer is
+  already functional.
+  The driver-backed path calls :c:func:`device_links_driver_bound()` from
+  :c:func:`driver_bound()`, while the class-device completion path performs
+  the equivalent transition from :c:func:`device_add()`.
 
 * Before a consumer device is probed, presence of supplier drivers is
   verified by checking the consumer device is not in the wait_for_suppliers
@@ -286,17 +301,28 @@ State machine
   (Call to :c:func:`wait_for_device_probe()` from
   :c:func:`device_links_unbind_consumers()`.)
 
+  Registering a driverless class consumer similarly moves existing available
+  links to ``DL_STATE_CONSUMER_PROBE`` before publishing the device, and its
+  registration participates in :c:func:`wait_for_device_probe()`.  Unlike a
+  driver probe, class registration is not deferred for unavailable suppliers.
+
 * If the probe fails, links to suppliers revert back to ``DL_STATE_AVAILABLE``.
   (Call to :c:func:`device_links_no_driver()` from :c:func:`really_probe()`.)
 
 * If the probe succeeds, links to suppliers progress to ``DL_STATE_ACTIVE``.
-  (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_bound()`.)
+  A driverless class consumer activates usable incoming links when its
+  registration completes, drops sync-state-only proxy links and preserves
+  links whose suppliers are dormant or unbinding.  The driver-backed path
+  calls :c:func:`device_links_driver_bound()` from :c:func:`driver_bound()`,
+  while :c:func:`device_add()` performs the equivalent class-device
+  transition.
 
 * When the consumer's driver is later on removed, links to suppliers revert
   back to ``DL_STATE_AVAILABLE``.
   (Call to :c:func:`__device_links_no_driver()` from
   :c:func:`device_links_driver_cleanup()`, which in turn is called from
-  :c:func:`__device_release_driver()`.)
+  :c:func:`__device_release_driver()`.)  Removing a driverless class consumer
+  performs the equivalent cleanup from :c:func:`device_del()`.
 
 * Before a supplier's driver is removed, links to consumers that are not
   bound to a driver are updated to ``DL_STATE_SUPPLIER_UNBIND``.
@@ -305,14 +331,17 @@ State machine
   This prevents the consumers from binding.
   (Call to :c:func:`device_links_check_suppliers()` from
   :c:func:`really_probe()`.)
-  Consumers that are bound are freed from their driver; consumers that are
-  probing are waited for until they are done.
+  Driver-backed consumers that are bound are freed from their driver;
+  driverless class consumers remain registered and their links move directly
+  to ``DL_STATE_SUPPLIER_UNBIND``.  Consumers that are probing or being
+  registered as class devices are waited for until they are done.
   (Call to :c:func:`device_links_unbind_consumers()` from
   :c:func:`__device_release_driver()`.)
   Once all links to consumers are in ``DL_STATE_SUPPLIER_UNBIND`` state,
   the supplier driver is released and the links revert to ``DL_STATE_DORMANT``.
   (Call to :c:func:`device_links_driver_cleanup()` from
-  :c:func:`__device_release_driver()`.)
+  :c:func:`__device_release_driver()`.)  Removing a driverless class supplier
+  follows the same sequence from :c:func:`device_del()`.
 
 API
 ===
diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..8bdf0a709401 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -166,6 +166,8 @@ void device_release_driver_internal(struct device *dev, const struct device_driv
 void driver_detach(const struct device_driver *drv);
 void driver_deferred_probe_del(struct device *dev);
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
+void device_probe_begin(void);
+void device_probe_end(void);
 static inline int driver_match_device(const struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d2f9ff65138c..0c26ba38e6cf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -213,10 +213,10 @@ static void __fwnode_links_move_consumers(struct fwnode_handle *from,
  * @fwnode: fwnode from which to pick up dangling consumers
  * @new_sup: fwnode of new supplier
  *
- * If the @fwnode has a corresponding struct device and the device supports
- * probing (that is, added to a bus), then we want to let fw_devlink create
- * MANAGED device links to this device, so leave @fwnode and its descendant's
- * fwnode links alone.
+ * If the @fwnode has a corresponding struct device whose device-link state is
+ * managed by the driver core (that is, a bus or class device), then we want to
+ * let fw_devlink create MANAGED device links to this device, so leave @fwnode
+ * and its descendants' fwnode links alone.
  *
  * Otherwise, move its consumers to the new supplier @new_sup.
  */
@@ -225,7 +225,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 {
 	struct fwnode_handle *child;
 
-	if (fwnode->dev && fwnode->dev->bus)
+	if (fwnode->dev && (fwnode->dev->bus || fwnode->dev->class))
 		return;
 
 	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
@@ -259,7 +259,7 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
 
 	/*
 	 * Find the closest ancestor fwnode that has been converted to a device
-	 * that can bind to a driver (bus device).
+	 * whose managed-link lifecycle is handled by the driver core.
 	 */
 	fwnode_handle_get(fwnode);
 	do {
@@ -270,15 +270,15 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
 		if (!dev)
 			continue;
 
-		if (dev->bus)
+		if (dev->bus || dev->class)
 			break;
 
 		put_device(dev);
 	} while ((fwnode = fwnode_get_next_parent(fwnode)));
 
 	/*
-	 * If none of the ancestor fwnodes have (yet) been converted to a device
-	 * that can bind to a driver, there's nothing to fix up.
+	 * If none of the ancestor fwnodes have (yet) been converted to such a
+	 * device, there's nothing to fix up.
 	 */
 	if (!fwnode)
 		return;
@@ -287,10 +287,9 @@ void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
 	     "Don't multithread overlaying and probing the same device!\n");
 
 	/*
-	 * If the device has already bound to a driver, then we need to redo
-	 * some of the work that was done after the device was bound to a
-	 * driver. If the device hasn't bound to a driver, running things too
-	 * soon would incorrectly pick up consumers that it shouldn't.
+	 * If the device's managed links are available, redo some of the work
+	 * performed when it reached that state. Running this too soon would
+	 * incorrectly pick up consumers that it shouldn't.
 	 */
 	if (dev->links.status == DL_DEV_DRIVER_BOUND) {
 		fw_devlink_pickup_dangling_consumers(dev);
@@ -1088,6 +1087,12 @@ static bool dev_is_best_effort(struct device *dev)
 		(dev->fwnode && fwnode_test_flag(dev->fwnode, FWNODE_FLAG_BEST_EFFORT));
 }
 
+static bool dev_is_unmatchable(const struct device *dev)
+{
+	return READ_ONCE(dev->links.status) == DL_DEV_NO_DRIVER &&
+	       !dev_can_match(dev);
+}
+
 static struct fwnode_handle *fwnode_links_check_suppliers(
 						struct fwnode_handle *fwnode)
 {
@@ -1152,7 +1157,7 @@ int device_links_check_suppliers(struct device *dev)
 
 			if (dev_is_best_effort(dev) &&
 			    device_link_test(link, DL_FLAG_INFERRED) &&
-			    !dev_can_match(link->supplier)) {
+			    dev_is_unmatchable(link->supplier)) {
 				ret = -EAGAIN;
 				continue;
 			}
@@ -1307,6 +1312,33 @@ static void device_link_drop_managed(struct device_link *link)
 	kref_put(&link->kref, __device_link_del);
 }
 
+static bool device_links_track_class(const struct device *dev)
+{
+	/* Device-link objects are class devices registered with the lock held. */
+	return dev->class && !dev->bus && dev->class != &devlink_class;
+}
+
+static void device_links_class_start(struct device *dev)
+{
+	struct device_link *link;
+
+	device_probe_begin();
+	device_links_write_lock();
+	WARN_ON(dev->links.status != DL_DEV_NO_DRIVER);
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (!device_link_test(link, DL_FLAG_MANAGED))
+			continue;
+
+		/* Do not revive a link whose supplier is already unbinding. */
+		if (link->status == DL_STATE_AVAILABLE ||
+		    (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY) &&
+		     link->status != DL_STATE_SUPPLIER_UNBIND))
+			WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+	}
+	dev->links.status = DL_DEV_PROBING;
+	device_links_write_unlock();
+}
+
 static ssize_t waiting_for_supplier_show(struct device *dev,
 					 const struct device_attribute *attr,
 					 char *buf)
@@ -1356,43 +1388,11 @@ void device_links_force_bind(struct device *dev)
 	device_links_write_unlock();
 }
 
-/**
- * device_links_driver_bound - Update device links after probing its driver.
- * @dev: Device to update the links for.
- *
- * The probe has been successful, so update links from this device to any
- * consumers by changing their status to "available".
- *
- * Also change the status of @dev's links to suppliers to "active".
- *
- * Links without the DL_FLAG_MANAGED flag set are ignored.
- */
-void device_links_driver_bound(struct device *dev)
+static void __device_links_supplier_bound(struct device *dev,
+					  struct list_head *sync_list)
 {
-	struct device_link *link, *ln;
-	LIST_HEAD(sync_list);
-
-	/*
-	 * If a device binds successfully, it's expected to have created all
-	 * the device links it needs to or make new device links as it needs
-	 * them. So, fw_devlink no longer needs to create device links to any
-	 * of the device's suppliers.
-	 *
-	 * Also, if a child firmware node of this bound device is not added as a
-	 * device by now, assume it is never going to be added. Make this bound
-	 * device the fallback supplier to the dangling consumers of the child
-	 * firmware node because this bound device is probably implementing the
-	 * child firmware node functionality and we don't want the dangling
-	 * consumers to defer probe indefinitely waiting for a device for the
-	 * child firmware node.
-	 */
-	if (dev->fwnode && dev->fwnode->dev == dev) {
-		fwnode_links_purge_suppliers(dev->fwnode);
-		fw_devlink_pickup_dangling_consumers(dev);
-	}
-	device_remove_file(dev, &dev_attr_waiting_for_supplier);
-
-	device_links_write_lock();
+	struct device_link *link;
+	bool class_device = device_links_track_class(dev);
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		if (!device_link_test(link, DL_FLAG_MANAGED))
@@ -1409,16 +1409,35 @@ void device_links_driver_bound(struct device *dev)
 			continue;
 
 		WARN_ON(link->status != DL_STATE_DORMANT);
-		WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+		/*
+		 * A class interface can add a link from an already-bound consumer
+		 * while the class supplier is being registered.  Likewise, a class
+		 * consumer has no driver probe to retry when a late supplier binds.
+		 * Those consumers are already functional, so activate their links.
+		 */
+		if ((class_device ||
+		     device_links_track_class(link->consumer)) &&
+		    link->consumer->links.status == DL_DEV_DRIVER_BOUND) {
+			WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+		} else {
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 
-		if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
-			driver_deferred_probe_add(link->consumer);
+			if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
+				driver_deferred_probe_add(link->consumer);
+		}
 	}
 
 	if (defer_sync_state_count)
 		__device_links_supplier_defer_sync(dev);
 	else
-		__device_links_queue_sync_state(dev, &sync_list);
+		__device_links_queue_sync_state(dev, sync_list);
+}
+
+static void __device_links_consumer_bound(struct device *dev,
+					  struct list_head *sync_list)
+{
+	struct device_link *link, *ln;
+	bool class_device = device_links_track_class(dev);
 
 	list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node) {
 		struct device *supplier;
@@ -1431,13 +1450,13 @@ void device_links_driver_bound(struct device *dev)
 			/*
 			 * When DL_FLAG_SYNC_STATE_ONLY is set, it means no
 			 * other DL_MANAGED_LINK_FLAGS have been set. So, it's
-			 * save to drop the managed link completely.
+			 * safe to drop the managed link completely.
 			 */
 			device_link_drop_managed(link);
-		} else if (dev_is_best_effort(dev) &&
+		} else if (!class_device && dev_is_best_effort(dev) &&
 			   device_link_test(link, DL_FLAG_INFERRED) &&
 			   link->status != DL_STATE_CONSUMER_PROBE &&
-			   !dev_can_match(link->supplier)) {
+			   dev_is_unmatchable(link->supplier)) {
 			/*
 			 * When dev_is_best_effort() is true, we ignore device
 			 * links to suppliers that don't have a driver.  If the
@@ -1446,9 +1465,17 @@ void device_links_driver_bound(struct device *dev)
 			 * (consumer probed before supplier). So delete it.
 			 */
 			device_link_drop_managed(link);
-		} else {
+		} else if (!class_device) {
 			WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 			WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+		} else if (link->status == DL_STATE_CONSUMER_PROBE ||
+			   link->status == DL_STATE_AVAILABLE) {
+			WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+		} else {
+			WARN_ON(link->status != DL_STATE_ACTIVE &&
+				link->status != DL_STATE_DORMANT &&
+				link->status != DL_STATE_SUPPLIER_UNBIND);
+			continue;
 		}
 
 		/*
@@ -1460,10 +1487,67 @@ void device_links_driver_bound(struct device *dev)
 		if (defer_sync_state_count)
 			__device_links_supplier_defer_sync(supplier);
 		else
-			__device_links_queue_sync_state(supplier, &sync_list);
+			__device_links_queue_sync_state(supplier, sync_list);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
+}
+
+static void device_links_class_bound(struct device *dev)
+{
+	LIST_HEAD(sync_list);
+
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
+
+	device_links_write_lock();
+	__device_links_supplier_bound(dev, &sync_list);
+	__device_links_consumer_bound(dev, &sync_list);
+	device_links_write_unlock();
+
+	device_links_flush_sync_list(&sync_list, NULL);
+	driver_deferred_probe_trigger();
+	device_probe_end();
+}
+
+/**
+ * device_links_driver_bound - Update device links after probing its driver.
+ * @dev: Device to update the links for.
+ *
+ * The probe has been successful, so update links from this device to any
+ * consumers by changing their status to "available".
+ *
+ * Also change the status of @dev's links to suppliers to "active".
+ *
+ * Links without the DL_FLAG_MANAGED flag set are ignored.
+ */
+void device_links_driver_bound(struct device *dev)
+{
+	LIST_HEAD(sync_list);
+
+	/*
+	 * If a device binds successfully, it's expected to have created all
+	 * the device links it needs to or make new device links as it needs
+	 * them. So, fw_devlink no longer needs to create device links to any
+	 * of the device's suppliers.
+	 *
+	 * Also, if a child firmware node of this bound device is not added as a
+	 * device by now, assume it is never going to be added. Make this bound
+	 * device the fallback supplier to the dangling consumers of the child
+	 * firmware node because this bound device is probably implementing the
+	 * child firmware node functionality and we don't want the dangling
+	 * consumers to defer probe indefinitely waiting for a device for the
+	 * child firmware node.
+	 */
+	if (dev->fwnode && dev->fwnode->dev == dev) {
+		fwnode_links_purge_suppliers(dev->fwnode);
+		fw_devlink_pickup_dangling_consumers(dev);
+	}
+
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
+
+	device_links_write_lock();
+	__device_links_supplier_bound(dev, &sync_list);
+	__device_links_consumer_bound(dev, &sync_list);
 
 	device_links_write_unlock();
 
@@ -1548,17 +1632,7 @@ void device_links_no_driver(struct device *dev)
 	device_links_write_unlock();
 }
 
-/**
- * device_links_driver_cleanup - Update links after driver removal.
- * @dev: Device whose driver has just gone away.
- *
- * Update links to consumers for @dev by changing their status to "dormant" and
- * invoke %__device_links_no_driver() to update links to suppliers for it as
- * appropriate.
- *
- * Links without the DL_FLAG_MANAGED flag set are ignored.
- */
-void device_links_driver_cleanup(struct device *dev)
+static void device_links_cleanup(struct device *dev)
 {
 	struct device_link *link, *ln;
 
@@ -1568,7 +1642,8 @@ void device_links_driver_cleanup(struct device *dev)
 		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
-		WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER));
+		WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER) &&
+			!device_links_track_class(link->consumer));
 		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
 
 		/*
@@ -1589,6 +1664,21 @@ void device_links_driver_cleanup(struct device *dev)
 	device_links_write_unlock();
 }
 
+/**
+ * device_links_driver_cleanup - Update links after driver removal.
+ * @dev: Device whose driver has just gone away.
+ *
+ * Update links to consumers for @dev by changing their status to "dormant" and
+ * invoke %__device_links_no_driver() to update links to suppliers for it as
+ * appropriate.
+ *
+ * Links without the DL_FLAG_MANAGED flag set are ignored.
+ */
+void device_links_driver_cleanup(struct device *dev)
+{
+	device_links_cleanup(dev);
+}
+
 /**
  * device_links_busy - Check if there are any busy links to consumers.
  * @dev: Device to check.
@@ -1599,7 +1689,9 @@ void device_links_driver_cleanup(struct device *dev)
  * state to "supplier unbind" to prevent the consumer from being probed
  * successfully going forward.
  *
- * Return 'false' if there are no probing or active consumers.
+ * Sync-state-only links are moved to "supplier unbind" without making the
+ * supplier busy, since they do not require the consumer to be unbound.
+ * Return 'false' if there are no other probing or active consumers.
  *
  * Links without the DL_FLAG_MANAGED flag set are ignored.
  */
@@ -1613,6 +1705,11 @@ bool device_links_busy(struct device *dev)
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
+		/* Sync-state-only links do not require consumer unbinding. */
+		if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
+			WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
+			continue;
+		}
 
 		if (link->status == DL_STATE_CONSUMER_PROBE
 		    || link->status == DL_STATE_ACTIVE) {
@@ -1668,6 +1765,10 @@ void device_links_unbind_consumers(struct device *dev)
 		if (status == DL_STATE_ACTIVE) {
 			struct device *consumer = link->consumer;
 
+			/* Class consumers have no driver to release. */
+			if (device_links_track_class(consumer))
+				continue;
+
 			get_device(consumer);
 
 			device_links_write_unlock();
@@ -1826,7 +1927,7 @@ static int fw_devlink_no_driver(struct device *dev, void *data)
 {
 	struct device_link *link = to_devlink(dev);
 
-	if (!dev_can_match(link->supplier))
+	if (dev_is_unmatchable(link->supplier))
 		fw_devlink_relax_link(link);
 
 	return 0;
@@ -3704,6 +3805,7 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
+	bool track_class_links = false;
 	int error = -EINVAL;
 	struct kobject *glue_dir = NULL;
 
@@ -3737,6 +3839,10 @@ int device_add(struct device *dev)
 	if (error)
 		goto name_error;
 
+	track_class_links = device_links_track_class(dev);
+	if (track_class_links)
+		device_links_class_start(dev);
+
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
 	parent = get_device(dev->parent);
@@ -3838,7 +3944,7 @@ int device_add(struct device *dev)
 	 * match with any driver, don't block its consumers from probing in
 	 * case the consumer device is able to operate without this supplier.
 	 */
-	if (dev->fwnode && fw_devlink_drv_reg_done && !dev_can_match(dev))
+	if (dev->fwnode && fw_devlink_drv_reg_done && dev_is_unmatchable(dev))
 		fw_devlink_unblock_consumers(dev);
 
 	if (parent)
@@ -3858,6 +3964,8 @@ int device_add(struct device *dev)
 		mutex_unlock(&sp->mutex);
 		subsys_put(sp);
 	}
+	if (track_class_links)
+		device_links_class_bound(dev);
 done:
 	put_device(dev);
 	return error;
@@ -3886,6 +3994,10 @@ int device_add(struct device *dev)
 parent_error:
 	put_device(parent);
 name_error:
+	if (track_class_links) {
+		device_links_no_driver(dev);
+		device_probe_end();
+	}
 	kfree(dev->p);
 	dev->p = NULL;
 	goto done;
@@ -3980,9 +4092,17 @@ void device_del(struct device *dev)
 	struct device *parent = dev->parent;
 	struct kobject *glue_dir = NULL;
 	struct class_interface *class_intf;
+	bool track_class_links = device_links_track_class(dev);
 	unsigned int noio_flag;
 
 	device_lock(dev);
+	if (track_class_links) {
+		while (device_links_busy(dev)) {
+			device_unlock(dev);
+			device_links_unbind_consumers(dev);
+			device_lock(dev);
+		}
+	}
 	kill_device(dev);
 	device_unlock(dev);
 
@@ -4024,6 +4144,8 @@ void device_del(struct device *dev)
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 	device_platform_notify_remove(dev);
+	if (track_class_links)
+		device_links_cleanup(dev);
 	device_links_purge(dev);
 
 	/*
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 60c005223844..61288fcceb5b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -555,9 +555,21 @@ int device_bind_driver(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
 
+/* Driver probes and driverless class-device registrations in progress. */
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
+void device_probe_begin(void)
+{
+	atomic_inc(&probe_count);
+}
+
+void device_probe_end(void)
+{
+	atomic_dec(&probe_count);
+	wake_up_all(&probe_waitqueue);
+}
+
 static ssize_t state_synced_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
@@ -797,7 +809,7 @@ static int really_probe_debug(struct device *dev, const struct device_driver *dr
 
 /**
  * driver_probe_done
- * Determine if the probe sequence is finished or not.
+ * Determine if the probe and class-device registration sequence is finished.
  *
  * Should somehow figure out how to use a semaphore, not an atomic variable...
  */
@@ -811,7 +823,7 @@ bool __init driver_probe_done(void)
 
 /**
  * wait_for_device_probe
- * Wait for device probing to be completed.
+ * Wait for device probing and driverless class registration to be completed.
  */
 void wait_for_device_probe(void)
 {
@@ -894,7 +906,7 @@ static int driver_probe_device(const struct device_driver *drv, struct device *d
 	int trigger_count = atomic_read(&deferred_trigger_count);
 	int ret;
 
-	atomic_inc(&probe_count);
+	device_probe_begin();
 	ret = __driver_probe_device(drv, dev);
 	if (ret == -EPROBE_DEFER || ret == EPROBE_DEFER) {
 		driver_deferred_probe_add(dev);
@@ -906,8 +918,7 @@ static int driver_probe_device(const struct device_driver *drv, struct device *d
 		    !defer_all_probes)
 			driver_deferred_probe_trigger();
 	}
-	atomic_dec(&probe_count);
-	wake_up_all(&probe_waitqueue);
+	device_probe_end();
 	return ret;
 }
 
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index d871a71dbbaa..c33c615eaabf 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
 obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
+obj-$(CONFIG_DM_KUNIT_TEST)	+= device-link-class-test.o
 obj-$(CONFIG_DM_KUNIT_TEST)	+= fwnode-link-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
diff --git a/drivers/base/test/device-link-class-test.c b/drivers/base/test/device-link-class-test.c
new file mode 100644
index 000000000000..7d52efb55aa5
--- /dev/null
+++ b/drivers/base/test/device-link-class-test.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/platform_device.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/device/driver.h>
+#include <linux/fwnode.h>
+#include <linux/jiffies.h>
+#include <linux/kernfs.h>
+#include <linux/kthread.h>
+#include <linux/platform_device.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#define TEST_CLASS_NAME		"device-link-test"
+#define TEST_DRIVER_NAME	"device-link-test-consumer"
+
+enum test_class_action {
+	TEST_CLASS_NONE,
+	TEST_CLASS_SUPPLIER,
+	TEST_CLASS_SYNC_CONSUMER,
+	TEST_CLASS_OBSERVE,
+	TEST_CLASS_WAIT,
+	TEST_CLASS_UNBIND_RACE,
+};
+
+struct device_link_class_context {
+	enum test_class_action action;
+	struct device *endpoint;
+	struct device_link *link;
+	struct completion waiter_started;
+	struct completion waiter_done;
+	struct task_struct *waiter;
+	struct completion unbind_started;
+	struct completion unbind_done;
+	struct task_struct *unbinder;
+	bool waiter_completed_during_add;
+	bool unbind_completed_during_add;
+	bool waiting_for_supplier_seen;
+};
+
+struct test_class_device {
+	struct device dev;
+	struct fwnode_handle fwnode;
+	struct fwnode_handle missing_supplier;
+	bool added;
+};
+
+static struct class *test_class;
+static struct device_link_class_context *test_context;
+static atomic_t remove_count;
+static atomic_t sync_count;
+
+static int test_driver_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static void test_driver_remove(struct platform_device *pdev)
+{
+	atomic_inc(&remove_count);
+}
+
+static void test_driver_sync_state(struct device *dev)
+{
+	atomic_inc(&sync_count);
+}
+
+static struct platform_driver test_driver = {
+	.probe = test_driver_probe,
+	.remove = test_driver_remove,
+	.driver = {
+		.name = TEST_DRIVER_NAME,
+		.sync_state = test_driver_sync_state,
+	},
+};
+
+static bool test_has_waiting_for_supplier(struct device *dev)
+{
+	struct kernfs_node *kn;
+
+	kn = sysfs_get_dirent(dev->kobj.sd, "waiting_for_supplier");
+	if (kn)
+		kernfs_put(kn);
+
+	return !!kn;
+}
+
+static int test_wait_for_probe(void *data)
+{
+	struct device_link_class_context *context = data;
+
+	complete(&context->waiter_started);
+	wait_for_device_probe();
+	complete(&context->waiter_done);
+
+	return 0;
+}
+
+static int test_unbind_supplier(void *data)
+{
+	struct device_link_class_context *context = data;
+
+	complete(&context->unbind_started);
+	device_release_driver(context->endpoint);
+	complete(&context->unbind_done);
+
+	return 0;
+}
+
+static int test_class_add(struct device *dev)
+{
+	struct device_link_class_context *context = test_context;
+
+	if (!context)
+		return 0;
+
+	switch (context->action) {
+	case TEST_CLASS_SUPPLIER:
+		context->link = device_link_add(context->endpoint, dev,
+						DL_FLAG_INFERRED |
+						DL_FLAG_AUTOPROBE_CONSUMER);
+		return context->link ? 0 : -ENOMEM;
+	case TEST_CLASS_SYNC_CONSUMER:
+		context->link = device_link_add(dev, context->endpoint,
+						DL_FLAG_INFERRED |
+						DL_FLAG_SYNC_STATE_ONLY);
+		return context->link ? 0 : -ENOMEM;
+	case TEST_CLASS_OBSERVE:
+		context->waiting_for_supplier_seen =
+			test_has_waiting_for_supplier(dev);
+		return 0;
+	case TEST_CLASS_WAIT:
+		context->waiter = kthread_create(test_wait_for_probe, context,
+						 "device-link-wait");
+		if (IS_ERR(context->waiter))
+			return PTR_ERR(context->waiter);
+		get_task_struct(context->waiter);
+		wake_up_process(context->waiter);
+		wait_for_completion(&context->waiter_started);
+		context->waiter_completed_during_add =
+			wait_for_completion_timeout(&context->waiter_done,
+						    msecs_to_jiffies(50));
+		return 0;
+	case TEST_CLASS_UNBIND_RACE:
+		context->link = device_link_add(dev, context->endpoint, 0);
+		if (!context->link)
+			return -ENOMEM;
+		context->unbinder = kthread_create(test_unbind_supplier, context,
+						   "device-link-unbind");
+		if (IS_ERR(context->unbinder))
+			return PTR_ERR(context->unbinder);
+		get_task_struct(context->unbinder);
+		wake_up_process(context->unbinder);
+		wait_for_completion(&context->unbind_started);
+		context->unbind_completed_during_add =
+			wait_for_completion_timeout(&context->unbind_done,
+						    msecs_to_jiffies(50));
+		return 0;
+	case TEST_CLASS_NONE:
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static struct class_interface test_class_interface = {
+	.add_dev = test_class_add,
+};
+
+static void test_unregister_device(void *data)
+{
+	device_unregister(data);
+}
+
+static void test_resume_sync_state(void *data)
+{
+	device_links_supplier_sync_state_resume();
+}
+
+static struct platform_device *
+test_register_platform_device(struct kunit *test)
+{
+	struct platform_device_info info = {
+		.name = TEST_DRIVER_NAME,
+		.id = PLATFORM_DEVID_AUTO,
+	};
+	struct platform_device *pdev;
+
+	pdev = kunit_platform_device_register_full(test, &info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, pdev->dev.links.status, DL_DEV_DRIVER_BOUND);
+
+	return pdev;
+}
+
+static void test_class_device_release(struct device *dev)
+{
+	struct test_class_device *tdev =
+		container_of(dev, struct test_class_device, dev);
+
+	fwnode_links_purge(&tdev->fwnode);
+	fwnode_links_purge(&tdev->missing_supplier);
+	kfree(tdev);
+}
+
+static void test_class_device_cleanup(void *data)
+{
+	struct test_class_device *tdev = data;
+
+	if (tdev->added)
+		device_unregister(&tdev->dev);
+	else
+		put_device(&tdev->dev);
+}
+
+static struct test_class_device *
+test_class_device_alloc(struct kunit *test, const char *name)
+{
+	struct test_class_device *tdev;
+	int ret;
+
+	tdev = kzalloc_obj(*tdev);
+	KUNIT_ASSERT_NOT_NULL(test, tdev);
+
+	device_initialize(&tdev->dev);
+	fwnode_init(&tdev->fwnode, NULL);
+	fwnode_init(&tdev->missing_supplier, NULL);
+	tdev->dev.class = test_class;
+	tdev->dev.release = test_class_device_release;
+	device_set_node(&tdev->dev, &tdev->fwnode);
+	ret = dev_set_name(&tdev->dev, "%s", name);
+	if (ret) {
+		put_device(&tdev->dev);
+		KUNIT_FAIL(test, "failed to name class device: %d", ret);
+		return NULL;
+	}
+
+	ret = kunit_add_action_or_reset(test, test_class_device_cleanup, tdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return tdev;
+}
+
+static void device_link_class_supplier_test(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+	struct platform_device *consumer;
+	struct device *supplier;
+	int ret;
+
+	consumer = test_register_platform_device(test);
+	context->action = TEST_CLASS_SUPPLIER;
+	context->endpoint = &consumer->dev;
+
+	supplier = device_create(test_class, NULL, 0, NULL,
+				 TEST_CLASS_NAME "-supplier");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);
+	ret = kunit_add_action_or_reset(test, test_unregister_device, supplier);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, context->link);
+	KUNIT_EXPECT_EQ(test, supplier->links.status, DL_DEV_DRIVER_BOUND);
+	KUNIT_EXPECT_EQ(test, READ_ONCE(context->link->status), DL_STATE_ACTIVE);
+	KUNIT_EXPECT_TRUE(test, device_link_test(context->link,
+						 DL_FLAG_AUTOPROBE_CONSUMER));
+	KUNIT_EXPECT_FALSE(test, device_link_test(context->link,
+						  DL_FLAG_SYNC_STATE_ONLY));
+
+	kunit_release_action(test, test_unregister_device, supplier);
+	device_link_wait_removal();
+
+	KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
+	KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_NO_DRIVER);
+}
+
+static void device_link_class_consumer_sync_test(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+	struct platform_device *supplier;
+	struct device *consumer;
+	int ret;
+
+	device_links_supplier_sync_state_pause();
+	ret = kunit_add_action_or_reset(test, test_resume_sync_state, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	supplier = test_register_platform_device(test);
+	context->action = TEST_CLASS_SYNC_CONSUMER;
+	context->endpoint = &supplier->dev;
+
+	consumer = device_create(test_class, NULL, 0, NULL,
+				 TEST_CLASS_NAME "-consumer");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
+	ret = kunit_add_action_or_reset(test, test_unregister_device, consumer);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, context->link);
+	KUNIT_EXPECT_EQ(test, consumer->links.status, DL_DEV_DRIVER_BOUND);
+	KUNIT_EXPECT_TRUE(test, list_empty(&consumer->links.suppliers));
+	kunit_release_action(test, test_resume_sync_state, NULL);
+	KUNIT_EXPECT_EQ(test, atomic_read(&sync_count), 1);
+}
+
+static void device_link_class_existing_consumer_link_test(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+	struct test_class_device *consumer;
+	struct platform_device *supplier;
+	struct device_link *link;
+	int ret;
+
+	supplier = test_register_platform_device(test);
+	consumer = test_class_device_alloc(test,
+					   TEST_CLASS_NAME "-existing-link");
+	KUNIT_ASSERT_NOT_NULL(test, consumer);
+
+	link = device_link_add(&consumer->dev, &supplier->dev,
+			       DL_FLAG_AUTOREMOVE_CONSUMER);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_EQ(test, READ_ONCE(link->status), DL_STATE_AVAILABLE);
+	ret = fwnode_link_add(&consumer->fwnode,
+			      &consumer->missing_supplier, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	context->action = TEST_CLASS_OBSERVE;
+	ret = device_add(&consumer->dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	consumer->added = true;
+
+	KUNIT_EXPECT_EQ(test, consumer->dev.links.status, DL_DEV_DRIVER_BOUND);
+	KUNIT_EXPECT_EQ(test, READ_ONCE(link->status), DL_STATE_ACTIVE);
+	KUNIT_EXPECT_TRUE(test, context->waiting_for_supplier_seen);
+	KUNIT_EXPECT_FALSE(test, test_has_waiting_for_supplier(&consumer->dev));
+}
+
+static void device_link_class_registration_wait_test(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+	struct device *dev;
+	unsigned long timeout;
+	int ret;
+
+	wait_for_device_probe();
+	context->action = TEST_CLASS_WAIT;
+	dev = device_create(test_class, NULL, 0, NULL,
+			    TEST_CLASS_NAME "-wait");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ret = kunit_add_action_or_reset(test, test_unregister_device, dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, context->waiter_completed_during_add);
+	timeout = wait_for_completion_timeout(&context->waiter_done,
+					      msecs_to_jiffies(1000));
+	KUNIT_EXPECT_GT(test, timeout, 0UL);
+}
+
+static void device_link_class_supplier_unbind_race_test(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+	struct platform_device *supplier;
+	struct device *consumer;
+	unsigned long timeout;
+	int ret;
+
+	supplier = test_register_platform_device(test);
+	context->action = TEST_CLASS_UNBIND_RACE;
+	context->endpoint = &supplier->dev;
+	consumer = device_create(test_class, NULL, 0, NULL,
+				 TEST_CLASS_NAME "-unbind-race");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
+	ret = kunit_add_action_or_reset(test, test_unregister_device, consumer);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, context->link);
+	KUNIT_EXPECT_FALSE(test, context->unbind_completed_during_add);
+	timeout = wait_for_completion_timeout(&context->unbind_done,
+					      msecs_to_jiffies(1000));
+	KUNIT_EXPECT_GT(test, timeout, 0UL);
+	KUNIT_EXPECT_EQ(test, atomic_read(&remove_count), 1);
+	KUNIT_EXPECT_EQ(test, supplier->dev.links.status, DL_DEV_NO_DRIVER);
+}
+
+static int device_link_class_test_init(struct kunit *test)
+{
+	struct device_link_class_context *context;
+
+	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	init_completion(&context->waiter_started);
+	init_completion(&context->waiter_done);
+	init_completion(&context->unbind_started);
+	init_completion(&context->unbind_done);
+	test->priv = context;
+	test_context = context;
+	atomic_set(&remove_count, 0);
+	atomic_set(&sync_count, 0);
+
+	return 0;
+}
+
+static void device_link_class_test_exit(struct kunit *test)
+{
+	struct device_link_class_context *context = test->priv;
+
+	if (context->waiter && !IS_ERR(context->waiter)) {
+		kthread_stop(context->waiter);
+		put_task_struct(context->waiter);
+	}
+	if (context->unbinder && !IS_ERR(context->unbinder)) {
+		kthread_stop(context->unbinder);
+		put_task_struct(context->unbinder);
+	}
+	test_context = NULL;
+}
+
+static int device_link_class_suite_init(struct kunit_suite *suite)
+{
+	int ret;
+
+	test_class = class_create(TEST_CLASS_NAME);
+	if (IS_ERR(test_class))
+		return PTR_ERR(test_class);
+
+	ret = platform_driver_register(&test_driver);
+	if (ret)
+		goto destroy_class;
+
+	test_class_interface.class = test_class;
+	ret = class_interface_register(&test_class_interface);
+	if (ret)
+		goto unregister_driver;
+
+	return 0;
+
+unregister_driver:
+	platform_driver_unregister(&test_driver);
+destroy_class:
+	class_destroy(test_class);
+
+	return ret;
+}
+
+static void device_link_class_suite_exit(struct kunit_suite *suite)
+{
+	class_interface_unregister(&test_class_interface);
+	platform_driver_unregister(&test_driver);
+	class_destroy(test_class);
+	device_link_wait_removal();
+}
+
+static struct kunit_case device_link_class_test_cases[] = {
+	KUNIT_CASE(device_link_class_supplier_test),
+	KUNIT_CASE(device_link_class_consumer_sync_test),
+	KUNIT_CASE(device_link_class_existing_consumer_link_test),
+	KUNIT_CASE(device_link_class_registration_wait_test),
+	KUNIT_CASE(device_link_class_supplier_unbind_race_test),
+	{}
+};
+
+static struct kunit_suite device_link_class_test_suite = {
+	.name = "device-link-class",
+	.suite_init = device_link_class_suite_init,
+	.suite_exit = device_link_class_suite_exit,
+	.init = device_link_class_test_init,
+	.exit = device_link_class_test_exit,
+	.test_cases = device_link_class_test_cases,
+};
+
+kunit_test_suite(device_link_class_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for class device links");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..3783744df86e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -446,11 +446,16 @@ enum device_link_state {
 #define DL_FLAG_CYCLE			BIT(9)
 
 /**
- * enum dl_dev_state - Device driver presence tracking information.
+ * enum dl_dev_state - Device availability tracking information.
  * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
  * @DL_DEV_PROBING: A driver is probing.
  * @DL_DEV_DRIVER_BOUND: The driver has been bound to the device.
  * @DL_DEV_UNBINDING: The driver is unbinding from the device.
+ *
+ * Class devices which are not on a bus use the same states for their
+ * registration lifecycle.  In that case, PROBING and DRIVER_BOUND mean that
+ * device_add() is in progress or has completed, respectively, and UNBINDING
+ * means that device_del() is in progress.
  */
 enum dl_dev_state {
 	DL_DEV_NO_DRIVER = 0,
@@ -480,7 +485,7 @@ enum device_removable {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @defer_sync: Hook to global list of devices that have deferred sync_state.
- * @status: Driver status information.
+ * @status: Driver or class-device availability status.
  */
 struct dev_links_info {
 	struct list_head suppliers;

-- 
2.53.0

