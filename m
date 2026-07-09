Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3B404BCB
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591100; cv=none; b=LyR0KpaV8I051ynKGGLR35H8iJX9mvWSxj1KB20Af75PlZFADcIJDxxWMY8tWh8Xi+vnb50y9aVNz/BXdd7qW4uafJlkeC3LajyZihNVQpEk8v3iqNs36CI5nsQ0OqTRAiYON/RIIuXBr2orGR1PJwYSUH49ti/wTK3LcukgXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591100; c=relaxed/simple;
	bh=o5T0PAKC4bhdWYNkYeRDccEnX6iTBQ7LIFU0ggYfB28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+wv7CdVPRi4GDLvt9SIniQLlGWBmjeFoLmuXbWv3jeJWa2ycWTbOWphCiKFd6zOi9933lgKpGHfdUBr7118YRmMKYMKnt1IbhJKbnYiGANMVZG38yq86EWWN1jhARQWZ3J2MINTvtv0P8M4ugYdD1g7Swx0cWHWM4MQilSc/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NdpJWF/1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdpJWF/1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad4170e8eso8244475ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591093; x=1784195893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/jD944UIyuOWk9l7jvwFyLAi8etvWVpl+Q1R2YAPVM=;
        b=NdpJWF/1/nSMwEktGBf2nUBSNCGNGB6vJ56QJAT4MyPLt1PzFFF56+7QxVUqcUW4bn
         T2B2wT1YjYxIkjeT3YTmdyOvxOrozEMNNo8Xf1PRHiOuGmJ/mXWQ/42ET3sV4C74oree
         FlbcSsfSj6CLgIeb7xS8jpauzhxAt6nj3BFWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591093; x=1784195893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/jD944UIyuOWk9l7jvwFyLAi8etvWVpl+Q1R2YAPVM=;
        b=sewIE9KavTwrUudKaFfbOzYnF1FVyF5I6Ec2HfPG8rOkjBxGyURoH336gRdvDFZ0hh
         9FIS9wVDDbQ2RXxNi8LIxHtETY1Bma7ln0sAjSZQ0xu7Q2t3wvb5XK25icTPW9dRhQki
         wUer9OaVPe9G0LEARrulXM2DkmfuGVzxOhpuUT2bVJ1YoRe6wgRdI5ybgFnEw+uH+1wN
         OqrhJlOc+JrQTgQ9Twz4GfzqXI/CLGRlYlG/jYohIOWpsMCV7Qj0PNEl9K/hWlm1zYL6
         VlwBQMfhCvjXiwJDElD3wiSp14U5vhKpOi401DdQfrdphdYtknELiVFt3jWim+poCq6m
         Jpqw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6uotcJn9NHO18r+aJjhFY0gRdszDCgDDqI2fx+owvrqvFSWLBdvK2tqIA7+HWxgtu2B0Fuyju8lkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhy/07GO8qnkfs+ozPAlJV0j/ZgP/W8CdXbqOjostDZhTUgw3Y
	f4fWQIKKdpKhWR6irVdRAN2NBYuXiybQmGm4oviQ0Yk4G7s4ZRUKlRCoZWRyNRrY2A==
X-Gm-Gg: AfdE7cnq505T49RwX9nfi49wZLhRYOTpt3gFwoohxlcz/uzIFZPPLE9JKORD3vE7JsF
	kqV9KA/y8iG+Tk3gNYOh64vgL6A9/rKU7EYL9i7tja3MxUEJrYLlKwjEOwh7t7PifEHSYM2GlCl
	GwyhBA60fVU2Lu+EQw+3wDscLDWZzGkY0wLWliyV93aDE+JHRDzGLBt58xs2Ywl0GRv5NsGTCD4
	Fndn2WzKs/C+bg1qGE7LzvmSB0i1cCZ12Sp67PqkwdmPNAHJGD0/VIh62UhP3yLArIsp9uCMdik
	bS8B4MCXp6tI5YYXPP8ThoTuSuPAQuDv/n1zQDe3JRuJE20H7y/pQHlfi2bNU7uWLUUnQxm+16N
	X0c5PZBvpas2CAVlWmMN2HwiP2+5LbVMXAzHyO+OIXk1LzgseJ2bJmnIxd7dFD8M8wSKDwgaR6k
	l+lBQXwP4d7Gy5pSQWJTv3CpOevNOUqEybYo6SiosM4sbTtnTDWkcLiWXLIIyuJ5L+rRaZEap+H
	aigGawA
X-Received: by 2002:a17:903:644:b0:2ca:cef2:dea8 with SMTP id d9443c01a7336-2ccea46aea4mr43506135ad.35.1783591093550;
        Thu, 09 Jul 2026 02:58:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:13 -0700 (PDT)
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
Subject: [PATCH v4 07/14] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Thu,  9 Jul 2026 17:57:12 +0800
Message-ID: <20260709095726.704448-8-wenst@chromium.org>
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

usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
it to tell if the hub/port is SuperSpeed or not.

In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
state tracking field in |struct usb_port|. Either structure can be used
to identify whether a port/hub is SuperSpeed or not, as the field in
|struct usb_port| is inherited from the hub:

    port->is_superspeed = hub_is_superspeed(hub)

Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
|struct usb_port*| so a subsequent change can use it.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Adapted to move of usb_port_is_power_on() to port.c and port.h
---
 drivers/usb/core/hub.c  | 7 ++++---
 drivers/usb/core/port.c | 6 +++---
 drivers/usb/core/port.h | 4 +---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6f576efa37b1..c7fa73673582 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3290,7 +3290,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3732,12 +3732,13 @@ static int wait_for_connected(struct usb_device *udev,
 		struct usb_hub *hub, int port1,
 		u16 *portchange, u16 *portstatus)
 {
+	struct usb_port *port_dev = hub->ports[port1 - 1];
 	int status = 0, delay_ms = 0;
 
 	while (delay_ms < 2000) {
 		if (status || *portstatus & USB_PORT_STAT_CONNECTION)
 			break;
-		if (!usb_port_is_power_on(hub, *portstatus)) {
+		if (!usb_port_is_power_on(port_dev, *portstatus)) {
 			status = -ENODEV;
 			break;
 		}
@@ -5433,7 +5434,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		 * but only if the port isn't owned by someone else.
 		 */
 		if (hub_is_port_power_switchable(hub)
-				&& !usb_port_is_power_on(hub, portstatus)
+				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 206b9f9a5807..f3e4d6a31798 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -23,11 +23,11 @@ static int usb_port_block_power_off;
 static const struct attribute_group *port_dev_group[];
 
 /* Check if a port is power on */
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
+int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 {
 	int ret = 0;
 
-	if (hub_is_superspeed(hub->hdev)) {
+	if (port->is_superspeed) {
 		if (portstatus & USB_SS_PORT_STAT_POWER)
 			ret = 1;
 	} else {
@@ -114,7 +114,7 @@ static ssize_t disable_show(struct device *dev,
 	}
 
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
-	disabled = !usb_port_is_power_on(hub, portstatus);
+	disabled = !usb_port_is_power_on(port_dev, portstatus);
 
  out_hdev_lock:
 	usb_unlock_device(hdev);
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
index f43f6b3b6b1f..22f9973638d7 100644
--- a/drivers/usb/core/port.h
+++ b/drivers/usb/core/port.h
@@ -63,6 +63,4 @@ struct usb_port {
 #define to_usb_port(_dev) \
 	container_of(_dev, struct usb_port, dev)
 
-struct usb_hub;
-
-extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
+extern int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus);
-- 
2.55.0.795.g602f6c329a-goog

