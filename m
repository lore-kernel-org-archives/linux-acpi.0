Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF04302F6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616908; cv=none; b=ae5kxzSt5cRIAIry/xSXF13MFUQWRTSdeDaoYY12VC6LHxm+o96j0RWUF9tcRlOAIRBmA4PftitdACL1lOwL5XY3uWAJd6P7cTJ3cm9pZcqirbO0mjyWh1XWOD6TC0m9Ko4ORrfP2vLxhcVtU0kHDrYSe8NU5XwzczYjSGr28jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616908; c=relaxed/simple;
	bh=rDxhkqymr7zNZNO5s5LLG26mVpihgtL4jhXYrXXJ+wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZs9jQJI3Cga9GgxY3LMiZZGcguhoPqMszHGEEy9sHnkBjaLCjxujQ5+Z32FY4PXU0wWSDcF76zKh0BBK30K5qaWsOk1X0NW0tzeifsVyZkkapeAkzr/BtBA60DSqRCbjxE/3VT1aGJLDeiWV99woSVwLX/wuiXru/s6ahyxghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NSKN9p6/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSKN9p6/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so108155785ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616904; x=1785221704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=NSKN9p6/4OKlOUKnluEU5E+bpYA5Gx4ApsZ3d9ivBRylHjrig4TIeZvawbqO/C7H/5
         kR2u4wm1id9hinJq3AxDqU3LDrPqIelLk0Ld9Zqp8LGydswuzyuqk3+4JS3v1CpsnCJL
         QOytZ0ebbuXG4ycgOmMUu/IfMcaQZ3EHCtxAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616904; x=1785221704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=psKygr21H10u2uJcLaPviCE/GfgI1b1mLim+R40AEiFMicmKG13kQXaEvqRGnFwxYs
         DTbb0mXAS+TszP9Eg6CrkFxqpezVAkIT/Bj1J5GuEFNhkYyuq4AyBKreHaPef1X3/wTZ
         brJz4nzXGma2UwEOKcAtGyzbHA+i9dw4HONSCU9Bpzy7f7utewS8Ps9WQlkeS4Ro9kYP
         NLJ5iRf9VOXd0p0/8YXZow0Kw79FgmjK183y+cC6Oc496YyqPFSaHWfoyJ3yEG2aiFfi
         OtCvRqcwZg2p3rfOdBzrTo8kWfP7aCGbyuYesjMKb83coGZk1b+wwnZcbQiCumS1J+da
         wsjg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0YhfkdtWi5mADR5I816eahW2mHkyW3T56N8Gery78XZffzG1Sim13BA71q1M4rJnYJqfHV0tO1aFE@vger.kernel.org
X-Gm-Message-State: AOJu0YwQARART/frMzZapmERwyhYVcDEbOm1QDw0jCqkunnukG/KqGxO
	LqsMW22QqUWfGzT48+FbQvvDgI8OMZrOi7e4kUwEmgn1Umdmrho/zS8cgzjyvucnGw==
X-Gm-Gg: AR+sD12+E5ZbTUB3ET5s4j/AVpA26odKLTHhrjEjDO+ycOqQNWPxcylOX1Oem3tSLg9
	kTXegvBGHv6CMtg4c0JOZHV0ILG0OZn2lEq2f27iqCW+GcWIe09WDbXSsTa1B9UCK/uq+m+ztjG
	vbJc6jjMWRDdl/fY6zXKHiMqKAvhxVYWeYFQnvQCX69nXRfQDmg45SYsQLQWwld/NvSxwnbGTBW
	HqLL6eGnHPDvZ37cf8OiZAjsCV71ThIXckNASjz950TnNxjWOvIC/uzsbCRMfNz4HGJJYCfqOI6
	RHBTHU6pa706s/pprcD4PQJShsyZEj/IPvnrwRtvs5IeDzLUfVFv8PtwA2xDvnvuEUB/DUK5UMM
	mJn7R5BwnfcDoczyrZiEwZCZIT3gbxTXOoaqwIRzNvsjtXRv0LKxux2sCl4mo6GpeENDfL2VaVa
	c4wopgWOv7MeW/H2FH272CxJvcTLoFIiPeEsHCmAzNn/gD6wC9mRf67zPL/mdV+iOOZ5r2pQ==
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr185892145ad.11.1784616904541;
        Mon, 20 Jul 2026 23:55:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:04 -0700 (PDT)
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
Subject: [PATCH v6 06/16] usb: hub: Associate port@ fwnode with USB port device
Date: Tue, 21 Jul 2026 14:54:01 +0800
Message-ID: <20260721065413.2306137-7-wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

