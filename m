Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE542F71A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616916; cv=none; b=oMkSo+UgROuad5vC1Ay/Xs0t2H8hji7pt6YDn2glZK0ZcZAJ7YwaUg+NS0X0xYjqtCYoRAViwnvzDuYgCVhd7V9aF2KR+YndfQvR65RJz9krp0cvAURSmL8P/e6Bi99leUuMSjcfoB7lttQaQnjJsztFoeh2YbXgL3lexK4wySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616916; c=relaxed/simple;
	bh=uMqpD/0Y+buNT85mCET4vOpwigIs8u3oS1rlx2XlGCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+t8Qvn6oUFJPdPJZz5rBhEUAahPEB1kGNQ+D66Gs1woz68Y2FEejKasSPKdPX0MHQGvZCkGOjZewEowcp7FXHphYLyAdbO18XHE8Y99TALv9tEUA+A4QJroT4FXz8NWAQd6zZ4t6II7UG1x9b+YF4ecNfb+mteW0hKboN0F3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GRN1x4Ch; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GRN1x4Ch"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so68979425ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616914; x=1785221714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rURTZ+6KnrNnBGX3zC7u+30dtH0N63AaHeGxXuU8P7M=;
        b=GRN1x4ChofFLUcUYIDe10xS2fMXvrfvnSH5j0tbyMpRXHyHvonGXC/P1pG64zcdfhO
         jRBACEWVIq7gGCnlevIAsAb8ebAbxTq/4Wf5e81azyTPvhXSLzxRj/lhDshml0lfBgJx
         82rZQ8YB6mbhf8SeZoJkXvzHVBwqrRI1eiIJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616914; x=1785221714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rURTZ+6KnrNnBGX3zC7u+30dtH0N63AaHeGxXuU8P7M=;
        b=dPA6Tz1L89yYWlmnqUC+c9iFsyM8+77syrKF4+TsNm14KbFgrnOXHptlrepT/PPNzw
         6zAOmwpuNW6EKvDqqAdcEHLGuVPrj5o8T5MPjZ3ynvn9UYXiq8vNYFFYQY6BwWtepwDz
         O+FoErS+GBpBQx3DJ/EGMfN7uio+7j5A+8GfaFPf2Pa0EJr7qg5OUYMoAXlNJ2ozFQK2
         1jLaCCtjihHF42XPt2luLFvcTu3gE1ctOoLnoO3D/jhNJl2tSZR/7A4y8Qb+keLl12jS
         0eT5VYAR6kKToPuGKOcU2AbXTBFctb6BRNPGNawFWV/mqHK11/bcS0I3BK8N3mYfpdjr
         CJFg==
X-Forwarded-Encrypted: i=1; AHgh+RqgT2M//FosSeAayXD7NaIcOurK2iRJEKG+Wua2XEAlhpq6A+Kw2LeEbYX5p4N2RzhH3Rz9fRLcFkSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+imdyqNa/n07PgMXbm+VX9WN2Et8R8I78XRoTcDE98odhS1h
	UguEY5DcsRd2yvwVJGITHe84TbnydirCvH9UDvbQv2KuUd+vfadEiqddjv1YFhU9eA==
X-Gm-Gg: AR+sD10kf8435C0wBK3b0jlt8oRb2oqBhShb2f/vW5dhvZknuvKCd21yXdxcYqygytN
	55hmHbdFj10GnyWTWtOJfGanl0+yXo/GJ1w6E62xWT2IDikThkfuBNHektUklPS7QAn79bfeNEM
	ADJiJxXIpfMxInRte8zgVMOYQ9I/LrbWyM0soL8MIJQGnWG88wPN9rJluIA1GEH1DbeOB+VT3K5
	DJiqYyWOZka+fvrq+qrHBJgoLEdv+/O276mk3cmAFHPWHotdtrpPIPjX6aZsIPX4dyYfrxL9sQv
	lNtBZ7qL9kXmYwbpxqhja6HT4MTxkdOHQrklHBt2zldK1e40wX5e2mtdQAnH2P6pkdref4Bs6TM
	hC6loDXhxdCwbBKyf4LlzqUqIeGP4clgRzwU8yzNTZ1qw30qIycGLT9EQdqx/V/2klSSR/aI44M
	EwR2H8JFfVuXHG94vQjrFP+UA6xTPKBn5klHAFo+wPNr7tL8jan7en30Uhx6q2hiIWcd10Mg==
X-Received: by 2002:a17:903:2383:b0:2c9:97a7:f544 with SMTP id d9443c01a7336-2cf34a18cefmr188566915ad.42.1784616913792;
        Mon, 20 Jul 2026 23:55:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:13 -0700 (PDT)
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
Subject: [PATCH v6 08/16] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Tue, 21 Jul 2026 14:54:03 +0800
Message-ID: <20260721065413.2306137-9-wenst@chromium.org>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
index a6c4e4c0368a..6671b5e45191 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3291,7 +3291,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3733,12 +3733,13 @@ static int wait_for_connected(struct usb_device *udev,
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
@@ -5434,7 +5435,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		 * but only if the port isn't owned by someone else.
 		 */
 		if (hub_is_port_power_switchable(hub)
-				&& !usb_port_is_power_on(hub, portstatus)
+				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b2e953f137f8..8d686d43e996 100644
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
index 00f7500af336..2f4349b3ce6b 100644
--- a/drivers/usb/core/port.h
+++ b/drivers/usb/core/port.h
@@ -63,6 +63,4 @@ struct usb_port {
 #define to_usb_port(_dev) \
 	container_of(_dev, struct usb_port, dev)
 
-struct usb_hub;
-
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
+int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus);
-- 
2.55.0.229.g6434b31f56-goog

