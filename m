Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697B42B327
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616920; cv=none; b=UAqrgVrLF0SJYdPLVvzQJeRimbRlOreklchJebhVhMvHmS+xHVN9pqBqL2W4kYLflGdsUrMLjD5xBXoP0RjN7PgACG/YXJLeiq08PkpdKJTubdel1jP52PzXVrDKW819HpXRd4ZJRieBDccZISU/6mUnDM565i+io4zniW4gTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616920; c=relaxed/simple;
	bh=DyEec2Z7+FSSh+lvskH9h+/zSvQpOnJC1n/aL86DbdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8VUz2xY0HfIGPv62CIwN0IJrhRobBMs7Wo9JBR3kA/2i4SLX5Im9ce/FdHX31bdLAHDJXWXUcaaCvRymMb6l6wRImZV68ABsQpii7mUMCHd5DS2A5ZiI7Y+Sp4TMKYaTwX+UGdPStymbqCMLVAgWY1OC35djd1/yvrJI7KKa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kr70JVPy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kr70JVPy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cae1a3a744so82748025ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616918; x=1785221718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0rgL0VJ5kE0g1GPB7mxKos5pVHLgytmLF2hovXGdFw=;
        b=Kr70JVPyDvE4ZOMszTxjcVJZp2HTNwUDsDpuPnUHjPcmunxwvoTzW49334Pv99zn8i
         rjuIX5eODThjRRmnpbyXCZSnpiBrBL7ZX5oB2Wa8bbRVo9xyD4IPleUwA5U8L0EzGAcb
         eA5nHpKqcuOilQyZX9MWvmPxkjSeV/m3wkYRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616918; x=1785221718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0rgL0VJ5kE0g1GPB7mxKos5pVHLgytmLF2hovXGdFw=;
        b=pNZpc+Cct7YiGS/G6cwnQCFTt037hCoWcYGCfocO3cTR+STeDdfvDNAQKwWStIORNL
         Skz3WUdoqu4euDZKb9IFY2oXBlk71dZaiGK4WPmStDOJAQjwFgLJZdbDlfftIhAjTtxq
         BI78vLpgc+4JkeeQWUpG3OJOdgpWRQn9Ao5p3QKbrYPjSgrrJahtJJKYCRtqMDoGVbXF
         ENxLhWMo5FPkAzSTPtN+mwoa7UwbKcB4fEpSGYR2FEnOst2ghKNFjnfNr68aVAQ1QaAt
         LvLmDdOdKBjt/F0DRQROsreCitknqySm9JzyEOa0A+kLZ4a/fMV23TZEKRBR3JlyTlmU
         q8VA==
X-Forwarded-Encrypted: i=1; AHgh+RoffJcXh1F/I5YlyXRHQBGe6pF4xQHvi9UlEI+MEc/eIPR4VrEBPbrM137xxLeao1Mc5wegb0krJeT3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0FfvTxe4GiHf/z3QvVUgM1lN0l9upJ6DA2nKkZb5ciZz7aoS
	NkH/FZ8eeNGtLc9AdnAXbmm7G3iF+YOnDOzkSaSb1jGeBrSeUDnZGHfs9N17MW5FSA==
X-Gm-Gg: AR+sD10kICIAUSEW2vViDUjfajTpmtMXhTwWPDKS/dU0vifZe0Pp2a3soomEwm5rv/X
	/mALVseKk7W1hBRz65hAm0ctnUCyb1QdQBRLjfWEvuiuwMDH2xqVWdsFz9NWCF6n04EGjRD7P0A
	4prf66wHxiETfhr/pak5a1pZQrChCqhYptpw2Tdu6xNjte0bz5zRbA7+6IF5BIsN77TklGHXdFi
	pxO9wctDZK8y/ICYMGpiyc0H6liW+cPwH+RJAMULmQOGyx4cv6JMOUNOksOwjeLCuomyJbWO1ai
	jRIdsALEPmfrIgpxE/e3culoHLSaJ4xbzJLNjcTmTaoQfZrkb7mkb9g5a13c9tMlR3SS0yeqt8T
	SIeXHgwASoOwZJhNhUNWyZ3gWfbVKuwIA5y7Sv/6IYhU1P4PmpGQKRNo7ExfJZ5k+gPmd/bMXzf
	AFpaJD/IFEU6jAVbCueQ9bpLzGIDknlgiJ4HX/3qW7ofM1IO+G+NIQ8ohPvws2mY+tbO1OTQ==
X-Received: by 2002:a17:902:f64d:b0:2cc:df15:91de with SMTP id d9443c01a7336-2cf349d30b8mr204344825ad.42.1784616918417;
        Mon, 20 Jul 2026 23:55:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:18 -0700 (PDT)
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
Subject: [PATCH v6 09/16] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Tue, 21 Jul 2026 14:54:04 +0800
Message-ID: <20260721065413.2306137-10-wenst@chromium.org>
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

There are still some instances in the USB hub driver where port power is
directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.

Switch these instances over to usb_hub_set_port_power() so that only one
unified function to do this exists. This makes adding external power
control with the power sequencing API easier and consistently applied.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6671b5e45191..a5c5038e1604 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -976,11 +976,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
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
@@ -5437,7 +5434,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.229.g6434b31f56-goog

