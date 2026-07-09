Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B3408604
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591101; cv=none; b=e+QIqU+ImeQ2cpDV+DoLgwALAZP7roLcChTrfuaHd96LItPQQyT7VUuGEXOz714sv70Lckp80w2gkHDNPtRpZdYvZlc7KH63kWnu1ViQmpZLikgVeEucerk65unuadyPdD0xsSmnUiIWz5yiB2ryHZRDaxTgdw7WuafKMdknPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591101; c=relaxed/simple;
	bh=7Id8aIDDawUTH+Vp/qv7geyMCxiyF2kG5OxwY8VhiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3g4svsxztglpAj6R3I8GvdIIOmXtisSv3sIHuU/pgNJF3ulA817TrSCkS5A/O6AWCqHvwtgrDD1TIZJVRTnyIw1bOi5aDJ/AzdROaOuy9PDCV0kzW6uYNs3xADRbwIr/MfBnq7KaEKvd5RbC2GTjXTI1yNsYF2cSWhPUc229wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KSX4DIYv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSX4DIYv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso16600505ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591099; x=1784195899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3NOayELjm3/+NeKg/MUGc6Z0GBz34hjktNSI4aLdsWw=;
        b=KSX4DIYvdXr0E4Hiuh5F79zRFeAR+8NErThzozoUr22068snis6HRCLT0GkSRMEdSv
         u7TLDsPKJAVGYxCtAQJAAx2LRt6OUzyKOTw2uIJQmiOvSPubkRH57HIJgXfHHBH9II+O
         wkaYX5FT6YksniRTKUH6JdHhT2Yma3yGWcqIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591099; x=1784195899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3NOayELjm3/+NeKg/MUGc6Z0GBz34hjktNSI4aLdsWw=;
        b=XtEmAHbE85Tlu5Nu5lka8ZW5/6WqQuO19TG/a8dciz8JZUQhie5pTXfY2QnQkcT0mM
         M2Zw8Qcy1gVkztX2L4/is2YN3YfcE2VPucxfe7RUwl+MXrH/BmTf0TtsU6r9ATgmV9tE
         6k7zVqKayqJq6E586UdCjMwCmlWGftCum8TU0kC55YMVXmGtlr+JSUO48xWwHSUYg9XQ
         qJcsNtl3iPeU1AWnDFxE2QPlfCzNqk3HUmab1/2qsj4O940gfS6+VS499sILcsk06nA3
         5rfimOY9PP6VuX5F+myltm1YU1ikeZIKnrQPh4xjqurewk1LMYPZF4oCNz3BfdROCU79
         Mi4g==
X-Forwarded-Encrypted: i=1; AHgh+RpVyr7WzEhEXZQzhJwIuczip11sjHTBy6MV4rO7AueW9jlZPCxpMN7SUPIOBWuenDJoI8fqV0wIZqZG@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUOsM6X7Ouy9k9qIvIezLgF4KPhfrCUqkXdpKTFK/nVZFuX/s
	kuftC/VgZHuigT2eDjlv+8IceVh2RWO9RuJ3fZAY9eDGbYcTylnQX7HgnVBhq2xQyw==
X-Gm-Gg: AfdE7cmLGkbz6DMIfoD9fncVIUbDtdgFUxxy+vcaOx1SMIPm/C0zSzbA2I17fY4/1ZH
	PupQRlzyCJKrRt7SaErTYSPxd0E+v46X9IptcCVjXN1pR3gOzRS1McPCN9LgzEY7c5+k7uWbUx6
	CET/k1GkuNLNl+azarXPmdtGC/m8K1OBkJwgVErdLZ5by0zviNXEKmp/xOiP8WUbqz49xBSppb3
	Mbsr8ecYRRjixDPatEQhsPEI8xk/wAFLuBZKakSeoCiPWrF8GiDu4iDUnOOz+/wr2G/fsZ793/h
	WuhVQIeK4DjWrZ9W01qhmcBG+luknHfvdot8XvW5qssk2WVfIWXV4x/yRDuFfclKESA3Nvm5sVN
	LNKd8mF+1npVjQ2cFT1WRtoJs4bXh9oDb1otyEM5OB0eglDzjYAjc2I2TjxeCLNttYuxsRU9uQu
	OwzDrzm9RqGA6U85vtKTDco4QSkwRIrw9f649QvonbBRrKlmoxXjuCqxtyJRbM/b7yg4pHDRMhM
	7X59hx5
X-Received: by 2002:a17:903:1247:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ccea373170mr66966485ad.18.1783591098706;
        Thu, 09 Jul 2026 02:58:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:18 -0700 (PDT)
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
Subject: [PATCH v4 08/14] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Thu,  9 Jul 2026 17:57:13 +0800
Message-ID: <20260709095726.704448-9-wenst@chromium.org>
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

There are still some instances in the USB hub driver where port power is
directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.

Switch these instances over to usb_hub_set_port_power() so that only one
unified function to do this exists. This makes adding external power
control with the power sequencing API easier and consistently applied.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c7fa73673582..369280a217cc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -975,11 +975,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->hdev->maxchild; port1++)
-		if (test_bit(port1, hub->power_bits))
-			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
-		else
-			usb_clear_port_feature(hub->hdev, port1,
-						USB_PORT_FEAT_POWER);
+		usb_hub_set_port_power(hub->hdev, hub, port1,
+				       test_bit(port1, hub->power_bits));
 	if (do_delay)
 		msleep(hub_power_on_good_delay(hub));
 }
@@ -5436,7 +5433,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.795.g602f6c329a-goog

