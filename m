Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204163;
	b=uaTqA7Mhrkr/17jFCHusj7XmEN0k1mqu8nIE++v3f13KVTItFWocZR2iouH84r7vN/kq
	 UtWUKCsvfAeWHpClmpYKb7j0VUCFabtUy7rFNg+UxZcUrj/6DK5rNlJMEhutOflgrlEFt
	 wsxmKHBkpaioEdhhF+yDaeAP9az5qZSuYuyNof3NWuYjFExVylM7lml9ONm/nFRSEJXqr
	 pMJZZUIv7oozlN531TiQLgP8PZ/6ITsMG1L6TortDEiHZ6sRR6+GHZA5KLVGGY7a34ixd
	 lgSKCOZ78e6JZ2OutwCFzBSR09TLah7LQghVgLN3kB1eapN8MXlVud+hkFE9v/svOJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204163;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xbWRnn6RNjBklw3X9Nkee9wTnt8ta4yhANwXs66hsPs=;
	b=JAeucs283Q1o/JoSCrZii8JhgdYE/5P/uBTg+67KEdz3fubEEZH3hsiPMSWFOXa8nm6d
	 ysBcU90QnqA/IdYlb3QCn+vcZFGt8lhbcLCVXFNVOh84/vYk76we4kKGxJifmp0uN9+es
	 yUBcfcpaL8Rdwcq+sTBIxu9GyItfbcARJOHAd5DMPeTSupp00EDy2pvSFD8fo/F7MA7qm
	 O5GGsZj4SdqvtEkcNw/+FbwMQQJCTalk0JcdjApaVwbUx53eSCg9B1YkHiVFoENRN7A8l
	 ns6FWhuX/R8Y+1Jb4rv0pZe3gmTWP2ZyIYRBnVasgCxHUXjMzbXtZeLqt6AITtFnweg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyD1+iWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C2606A31A;
	Wed, 28 Oct 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyD1+iWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64791F01825;
	Wed, 28 Oct 2026 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204162;
	bh=xbWRnn6RNjBklw3X9Nkee9wTnt8ta4yhANwXs66hsPs=;
	h=From:To:Cc:Subject:Date;
	b=dyD1+iWbCFgR+Q/kV0YX/ajhyUxlTMv8PhTe6NYWPiKm0C1mt0Eb63oTHThKYtBHQ
	 qZkrrvFXDkwiYI2M0cgsDbs4Ubj0l6S7RMHAqy2dSY8upj3c/7U9gWn1AjDEAn7MH0
	 X+DRH0BvSoOa/aXj5kFePKaLcHWf050hSmJSspaNMBrlmeQcBxidd7zUhFKzDGnwgs
	 Cf7XMP5SpW/CamicfkL0FQ/3hJ54jZ+P3WY60PuPhcNEhGzK2MW9EbjwJcyGSQHNEm
	 RMgVSQC88/3hG3zhohFHlN3xxuFhVRrSY74M3B3gN0E77sEsyQ+RaiEdasSkQX/0uG
	 Qj/HJzggfVGRg==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com,
	syzbot+a265816368571f78ab88@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ACPI: scan: Do not hold physical_node_lock across device_offline() and device_online()
Date: Wed, 28 Oct 2026 12:16:00 -0400
Message-ID: <20261028161600.1524682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

acpi_bus_offline() and acpi_bus_online() hold the physical_node_lock of
the ACPI device being hot-removed while they call device_offline() and
device_online() for its physical nodes.  Offlining a CPU this way takes
cpu_add_remove_lock and the CPU hotplug lock under physical_node_lock,
and lockdep connects that to the uevent attribute of platform devices,
whose store method takes physical_node_lock in
acpi_primary_dev_companion():

  physical_node_lock (acpi_bus_offline())
    -> cpu_add_remove_lock -> cpu_hotplug_lock
    -> cpuhp_state-down (mce_cpu_pre_down() unregistering a device)
    -> device_links_lock (device_links_purge())
    -> kn->active of a uevent attribute (device link unregistration)
    -> physical_node_lock (uevent_store() -> acpi_companion_match())

syzbot has reported this cycle twice.  The uevent attribute waited for in
the link unregistration is the device link's, not a platform device's,
and the physical_node_lock taken at the end is that of the platform
device's ACPI companion, not of the processor being ejected, so lockdep
only connects them because they share lock classes and this is unlikely
to deadlock.  However, lockdep turns itself off after reporting it.

It can be reproduced in a QEMU guest by writing to the uevent attribute
of an ACPI-enumerated platform device, reading the uevent attribute of a
device link while the link is removed, offlining a CPU and ejecting one
through sysfs.

physical_node_lock only needs to protect the list of physical nodes, so
drop it around device_offline() and device_online().  Mark the nodes to
offline with a new offline_pending flag, hold a reference to each device
while the lock is dropped, and look its node up again afterwards to
record whether it needs to be put back online, because it may have been
unbound in the meantime.  Physical nodes added while the lock is not
held are not offlined by the current pass, which is no different from
adding them right after it.

Since acpi_container_offline() no longer runs under the container's
physical_node_lock, the nesting annotation added to
acpi_scan_is_offline() by commit 4c533c801d1c ("ACPI / scan: Annotate
physical_node_lock in acpi_scan_is_offline()") is not needed anymore, so
drop it.

Fixes: 683058e315f0 ("ACPI / hotplug: Use device offline/online for graceful hot-removal")
Reported-by: syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6ae18ed0.6200f071.51519.0f60.GAE@google.com
Reported-by: syzbot+a265816368571f78ab88@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6adf293a.67317f00.38c4bc.00af.GAE@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/scan.c     | 112 ++++++++++++++++++++++++++++++++--------
 include/acpi/acpi_bus.h |   1 +
 2 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0b17a7e519569..3a6420872651f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -114,11 +114,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	bool offline = true;
 	char *envp[] = { "EVENT=offline", NULL };
 
-	/*
-	 * acpi_container_offline() calls this for all of the container's
-	 * children under the container's physical_node_lock lock.
-	 */
-	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
+	mutex_lock(&adev->physical_node_lock);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !dev_offline(pn->dev)) {
@@ -133,6 +129,59 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	return offline;
 }
 
+static struct acpi_device_physical_node *
+acpi_find_physical_node(struct acpi_device *adev, struct device *dev)
+{
+	struct acpi_device_physical_node *pn;
+
+	lockdep_assert_held(&adev->physical_node_lock);
+
+	list_for_each_entry(pn, &adev->physical_node_list, node)
+		if (pn->dev == dev)
+			return pn;
+
+	return NULL;
+}
+
+/*
+ * Find the first physical node of @adev that is still to be offlined, clear its
+ * offline_pending flag and return its device with a reference held.
+ */
+static struct device *acpi_next_offline_pending(struct acpi_device *adev)
+{
+	struct acpi_device_physical_node *pn;
+
+	lockdep_assert_held(&adev->physical_node_lock);
+
+	list_for_each_entry(pn, &adev->physical_node_list, node)
+		if (pn->offline_pending) {
+			pn->offline_pending = false;
+			return get_device(pn->dev);
+		}
+
+	return NULL;
+}
+
+/*
+ * Find the first physical node of @adev that has been offlined by
+ * acpi_bus_offline(), clear its put_online flag and return its device with a
+ * reference held.
+ */
+static struct device *acpi_next_put_online(struct acpi_device *adev)
+{
+	struct acpi_device_physical_node *pn;
+
+	lockdep_assert_held(&adev->physical_node_lock);
+
+	list_for_each_entry(pn, &adev->physical_node_list, node)
+		if (pn->put_online) {
+			pn->put_online = false;
+			return get_device(pn->dev);
+		}
+
+	return NULL;
+}
+
 static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 				    void **ret_p)
 {
@@ -140,6 +189,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 	struct acpi_device_physical_node *pn;
 	bool second_pass = (bool)data;
 	acpi_status status = AE_OK;
+	struct device *dev;
 
 	if (!device)
 		return AE_OK;
@@ -152,25 +202,44 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 	mutex_lock(&device->physical_node_lock);
 
 	list_for_each_entry(pn, &device->physical_node_list, node) {
-		int ret;
-
 		if (second_pass) {
 			/* Skip devices offlined by the first pass. */
-			if (pn->put_online)
-				continue;
+			pn->offline_pending = !pn->put_online;
 		} else {
+			pn->offline_pending = true;
 			pn->put_online = false;
 		}
-		ret = device_offline(pn->dev);
+	}
+
+	/*
+	 * Drop physical_node_lock around device_offline(), because the latter
+	 * acquires locks, like the CPU hotplug ones, that must not nest under
+	 * it.
+	 */
+	while ((dev = acpi_next_offline_pending(device))) {
+		int ret;
+
+		mutex_unlock(&device->physical_node_lock);
+		ret = device_offline(dev);
+		mutex_lock(&device->physical_node_lock);
+
+		/* The device may have been unbound in the meantime. */
+		pn = acpi_find_physical_node(device, dev);
 		if (ret >= 0) {
-			pn->put_online = !ret;
+			if (pn)
+				pn->put_online = !ret;
 		} else {
-			*ret_p = pn->dev;
-			if (second_pass) {
+			*ret_p = pn ? pn->dev : &device->dev;
+			if (second_pass)
 				status = AE_ERROR;
-				break;
-			}
 		}
+
+		mutex_unlock(&device->physical_node_lock);
+		put_device(dev);
+		if (ACPI_FAILURE(status))
+			return status;
+
+		mutex_lock(&device->physical_node_lock);
 	}
 
 	mutex_unlock(&device->physical_node_lock);
@@ -182,18 +251,19 @@ static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
 				   void **ret_p)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
-	struct acpi_device_physical_node *pn;
+	struct device *dev;
 
 	if (!device)
 		return AE_OK;
 
 	mutex_lock(&device->physical_node_lock);
 
-	list_for_each_entry(pn, &device->physical_node_list, node)
-		if (pn->put_online) {
-			device_online(pn->dev);
-			pn->put_online = false;
-		}
+	while ((dev = acpi_next_put_online(device))) {
+		mutex_unlock(&device->physical_node_lock);
+		device_online(dev);
+		put_device(dev);
+		mutex_lock(&device->physical_node_lock);
+	}
 
 	mutex_unlock(&device->physical_node_lock);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a755b15af9db9..29c59ea1e3e48 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -320,6 +320,7 @@ struct acpi_device_physical_node {
 	struct device *dev;
 	unsigned int node_id;
 	bool put_online:1;
+	bool offline_pending:1;
 };
 
 struct acpi_device_properties {
-- 
2.53.0

