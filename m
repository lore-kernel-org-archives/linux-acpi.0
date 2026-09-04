Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89D3C3F66
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511437; cv=none; b=ARwByjbiW+pvQf1tFgvV36W41gHDL8E7Up88TC0Bf4/l2NHscIhuq1ptnVh5OcfUOr18Pja/RGY4p/IXBleNhmguRR/e4rS8yy0Z1SfbafjPUXjlo2zHCYKoUEP61RpP2l1Pbh1gIPZEIxDJx9wh2TNn0bJp+Uo/qOza9OaIKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511437; c=relaxed/simple;
	bh=iO3DF4u+63xTtKP4FxOejaFf7KwQ2Ou9YoxBchLW4e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6pOyCvqIgAvk905uZpFRPAeG1tv7nn+pwZFp8iJHawQMj3EEV0+QGlQtRUqIRDumaLtLB66j0zq5oiZmgp/iCNhDU+9kQVeMQlqriRpfC/5IiSeZIJhLa+os267TS5CtZc0KwPtGtV3NvXlXb2yB8yZyWGerxXNYSN1mKmwZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dYjq7UOt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYjq7UOt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d944747d41so8850375ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511431; x=1789116231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FkHDnS01ZrIUIFEZvu4Ez5qiW1Xnkoau5FbL5ZwNaU=;
        b=dYjq7UOtAqLocf3FOvhgglj1glz1QpzT+8NmUIjHKDL4o6bznah3F3Mk8Ewh3I4OVU
         CK5SfApSRvz/kDQILfkZEKqIhoMGNyT8MWsmRnnc4Xit0tFZlnI/O5JT1hk6R/HecQ4G
         hTa1DZ834h4gkzwAGuYleNwW7+MoqXk0F47t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511431; x=1789116231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7FkHDnS01ZrIUIFEZvu4Ez5qiW1Xnkoau5FbL5ZwNaU=;
        b=ijhlnrKOFQKyow80V6yyxObqAmWaKo2WcIH6ZEp5cQCPYvoBZ2K29fMuif4J3w4g1m
         S+immmhKap0Q8ps2Yzr8akPRNWc/Zjix8x8LwCBxbIJHjvxnjyVD3UoRmjcKtWr5g2us
         Sp3231Vpy/dpWr3eIwExqpNnU0PKdYGW5W/a0m23Y1qqG4Qzyn0mzaYN4pzNWzYDI+q/
         WPHpl0QHe7xHPYiILwk88aBQmDd/nV8MeUZ8b7YfFnlCxgqKup/96F9O0Ecd5MqA+XbD
         NeZH9YJQPijKO99d4j7sjihmt3+g4jLtwNK3J/yJenDGPHArHdf2Q0fN/58dwHGN/I3L
         tp7A==
X-Forwarded-Encrypted: i=1; AKwUvByVRBhwpWM7edp3W4X//Q8XdC0QqQ/uq7zmbk+WiJ3ahveNeGVF3eEv55jI3ypE3X4fQwdlum2eE2F2@vger.kernel.org
X-Gm-Message-State: AFuF++l5n3AR0LGdTZe91WvIfzfuECgrA+zWqoRLpkwr3CwzLN69hsQh
	LJf5icF6rz1WNVdlV1ubB3O5Km/vSVmBgPoHcMqbRg/TSWjWF5WOKHDDyq+ndGSLFw==
X-Gm-Gg: AYBFou0dv+rGMSu6x7oLdEkDvdBaLC58W789D67UIKFjKvYauOvF4UUxong/jLOc58y
	uQPOmVMfToNR5IzznATrYQ9UY9UkJ4wq/K3AkHjvmCD+VENqyaouu8rhq2rciKoKRLZNn+oD9N4
	OEyS0ZSWaELcjwHFp1p6SCpUCWMyy2jmk28WRwCPeYcwpkQfuMXoTLpbKNXlpyk77DlkxuDf5Jr
	JxE5Oy4hPPVNDay5wH0g3FEnjX/IigeAtd9BBt5DmpFqCsemliZh6DkClwtuzGXB0Z67Dy08gkE
	Y25OYS/6l/kevz4YuzI6XosXG546Wiw/4wHjecn1MAU2LhSV3OSwEP0lre1D8GIkYp1KBE9GQa2
	k8DkWFNoFtPTMWII+SYhg5SWfmV+Oo25SqCLdIMfFXfdqqNiP1Z80PKEsW5WfA/Rk/21OXr8+xM
	ODHkT3+FZK7IXTDyYqCEjO9SC+GHXiOoA7aL6bs4ve7g3i3bi35XmzOlLLVGax+F5m4GmJ8tyEu
	nrUsYvoYauHH72DZrHVdd6J3YVy8eNt//D/M0MGI2ZsQKWAQ6twSaU=
X-Received: by 2002:a17:90b:264c:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-39b2612f7dbmr7487531a91.10.1788511431512;
        Fri, 04 Sep 2026 01:43:51 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:11 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 06/16] usb: hub: Associate port@ fwnode with USB port device
Date: Fri,  4 Sep 2026 16:41:45 +0800
Message-ID: <20260904084158.1341550-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
2.55.0.979.g7e5102b832-goog

