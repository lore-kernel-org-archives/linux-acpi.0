Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AC463B69
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545555; cv=none; b=NWJB3qEs2Q+uuEKJuLB4xGFPmppSD7I2NGOvzsqFoRCC6QwjgkVKsAJt/mJb+H8kDE0gvVTv0SpQuGqeqIfwrDXe8XSu7XPLHHVHvGKAoTZl1XeLSgbqPOh2+LwCtLcJv1qqajkIcUM4xECLDexwHpLW0/jwLjKz1OzBL1r1sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545555; c=relaxed/simple;
	bh=/ZoutxQ0ZJmBlGurPpdzCW+RhJfBFL4vY9B17VjHF/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ+Cktalt//1YSxyft3eaWJuFx+ueLw05fc0Qn70Bm2NCX5wnx97ml0Q3WqNpZjZDpWOrojr26ZWu+Rjq8TwPiOkbP5sKUhZzKvCugpQl77OizckiciQzAg4y+T5GgfIqxzKF+9V2cQpaalyYuee1hRLP/cz2NUsW4ZPPlYOk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FBTGVx+X; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBTGVx+X"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso403214a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545534; x=1790150334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWq5hvO3hBRGVn3uOxsC9S/weGAcU55UsXVnM8MhFFA=;
        b=FBTGVx+XreBB0No3JY3I1ljaehiVfYG95okspG0lIcfJ0ts3QzC1LMLHABTdX2yWWp
         9PWU/Ydh3Q+uKRyFcruT0v8o4FC17PT3WMMrKYJgcaRtDafztky3V1p6FKZnq9xp9V6t
         Ospvv7BQNp1T2bA4cyb4AUR/7wmr/dmYv5J8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545534; x=1790150334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWq5hvO3hBRGVn3uOxsC9S/weGAcU55UsXVnM8MhFFA=;
        b=DqGUZnvo3uWv/VQJRemH+zzfW5NOG1FOhRUKt+2p4a2ndeGfGNzacjOrAxXWv/d7Ny
         wje4dER3on7idF/ZU/BOsc0bQPELImbAjhC24eYE8ZMmwnMV9ss9Xfx45R/CPYQ5pQc2
         BXMusGPQmr54lTu3K5SeVNbZjOhkXNcCzTQz/ERecAQ5bks1eFweXXCKBjifm2KKQEDp
         NuecKsE2hr4RuDtYHlOoX0uh7z3Xe7xzPK3wAVIvqlqJ3z8NKf07522NM7V3trTFiROs
         XHBdcJU/Pe4JmGVgh38mvh+5lKt+bIAv4VvHwOCs7AnNNPzim1QoNeghTVDLv13Gzxjw
         b+2w==
X-Forwarded-Encrypted: i=1; AKwUvByrVJOginLqI7py2UNe0RGLm7g/H4meIlj9Lpt1F1SsQwV2ekUCSbEozj2Rf9zftDL/loY55Hw8eoGo@vger.kernel.org
X-Gm-Message-State: AFuF++kl5GRSltDi3glPvaqmSf9nro9lAnDdKakyFMMqDFxgjOaianY0
	g6KDBbeOODRHmL0V6WK6J5gGqHGhBA7av+Os0rXbh2mBxaiwZyUJ6YJzp4dYOKjbyQ==
X-Gm-Gg: AYBFou2TEfrdlIFENzAUv3lo5IzjnHDeqtZl4ebMj9fRMMveOMjpgb8CMYDlevInPqb
	sVAt7VlSrEIdmfydykMHSA5ocHQITVB/56prH4mxli3rF+k40a6A2YnnWpxXcRLa28f15xP+4M5
	lHxitPGWw/jthzeg1emMwomqCj6X9YRNCs0u0E1D9pwiCYJobWMaRCK9lMfgy2U8jyb1mr9qRUi
	f+v2OfOrtBcoUaG6tRQWBP4duq0vWkOFUQuXEQVpyQd2kLAdHLA/IoKvzblIsCjq2tMrUhQb/Lf
	dIR/h8M4wkCe6yToKl0A3TqryeUqcF1Eq6yznD8Rr5D19REGvHXe1zxdFbV2c9N52uQ1zpZqEpB
	g4hKLb9e3XLO7Lxgx/wGUylFXpqN7AWKdyq6MTSHdICjy0Vba5Tv/JGkyMGO2xeZHDOob0tYugD
	IABBRj7vbFdL7cc3jHlNxVW0mD6KZVTJhRZRxpIgalExzrYf3TAK3waF33lc1NyFRKGM3IwWJqE
	mBRjvMHi4L1xd+kdLGdDswTfR8MHg+Mgmc4ffuwgNL6H6hwBHrUmXpZs3OX/7YYb/QY
X-Received: by 2002:a17:90b:2d4f:b0:39e:1b0c:4773 with SMTP id 98e67ed59e1d1-39e1df86c10mr4199444a91.0.1789545534152;
        Wed, 16 Sep 2026 00:58:54 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:53 -0700 (PDT)
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
Subject: [PATCH v9 06/15] usb: hub: Associate port@ fwnode with USB port device
Date: Wed, 16 Sep 2026 15:57:32 +0800
Message-ID: <20260916075745.3549953-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a USB hub port is connected to a connector in a firmware node
graph, the port itself has a node in the graph.

Associate the port's firmware node with the USB port's device,
usb_port::dev. This is used in later changes for the M.2 slot power
sequencing provider to match against the requesting port.

To avoid potential conflicts with ACPI firmware nodes and then causing
power management issues, only assign the firmware node if the hub's
firmware node is not an ACPI firmware node.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added extra |struct fwnode_handle *| local variables to shorten lines
  (Andy)
- Added comment about passing fwnode_graph_get_port_by_id() return value
  directly to device_set_node() (Andy)

Changes since v4:
- Dropped unused |hdev| variable
- Added flags for fwnode_graph_get_port_by_id() with
  FWNODE_GRAPH_DEVICE_DISABLED so that even incomplete
  ports can be connected

Changes since v3:
- Added missing fwnode_handle_put()

Changes since v2:
- Skip assignment if hub firmware node is ACPI node
---
 drivers/usb/core/port.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b4452b665f59..c0a51d9b06a6 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -7,6 +7,7 @@
  * Author: Lan Tianyu <tianyu.lan@intel.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
@@ -358,6 +359,11 @@ static void usb_port_device_release(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
+	/*
+	 * At this point ACPI nodes and swnodes have been removed by
+	 * device_platform_notify_remove() in device_del().
+	 */
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(port_dev->req);
 	kfree(port_dev);
 }
@@ -754,6 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
 	struct usb_device *hdev = hub->hdev;
+	struct fwnode_handle *fwnode = dev_fwnode(&hdev->dev);
 	int retval;
 
 	port_dev = kzalloc_obj(*port_dev);
@@ -782,6 +789,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	port_dev->dev.driver = &usb_port_driver;
 	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
 			port1);
+
+	/*
+	 * ACPI FW nodes are associated later when device_register() happens.
+	 * Skip assigning one here to avoid potential conflicts.
+	 */
+	if (!is_acpi_node(fwnode)) {
+		struct fwnode_handle *port;
+
+		/*
+		 * fwnode_graph_get_port_by_id() returns either a valid fwnode handle
+		 * or NULL. Passing NULL to device_set_node() clears any associated
+		 * fwnode. It is effectively a no-op here, since no fwnode has been
+		 * assigned to the newly created device yet.
+		 */
+		port = fwnode_graph_get_port_by_id(fwnode, port1, FWNODE_GRAPH_DEVICE_DISABLED);
+		device_set_node(&port_dev->dev, port);
+	}
+
 	mutex_init(&port_dev->status_lock);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
-- 
2.55.0.1032.g73a4cd73de-goog

