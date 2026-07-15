Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850903DFC82
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105705; cv=none; b=RoDukWjhd9Svt7tdujCzgEUOvx3FD9ql07VI92/VHoru6nxOt4LpJ1MdE8vAvUN4xx6JhdeVOzjzF0xiMj5tuwKcckpUUc5RPMxuUDf64AcEpFP2QvcdU3splWjBoFmR3CsjkY8SqYyzdKf3KVetRPnA9GmqNq9ZaSMsx329Hio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105705; c=relaxed/simple;
	bh=y3WhF+SuyleAojl6FwQNCSw5fjhd9v1zDhHyaW9zvKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBH5ER2fTGUU5aAUQuW/8K/gvYj4FvMQ/6OmE7lddVaBtI7yM6qINDFKsgMwPIlRtgkdcxYp3OkujSBux4aoPRubFA6y1tVokjbj27/tinZc9XyQn8W5VsZNiCh4SGteXbEBsAFf0JQSIQRCEwuJvnHhejKazY/wk7wRTw0JyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U4KiaC8Z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4KiaC8Z"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2c90e383so303872b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105700; x=1784710500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jC877lcIipbzPO12i6mSRmQx7EEzSrLJZiMLFWRppMI=;
        b=U4KiaC8ZHcotD1jLJItMvlRs1LXy3siwlGpuWwcVjaYsH2uPgbxhrljMsmmnnTdrr1
         7RfAyNcwK2WRn6W4J6jlrEh23rCKQsvuExVUc6LwyJLCH9L3hkelsyQsM7v+GW89vtSy
         VOPwlU3gDFh+6S1Id18vmddoN/2FGNbbNfknI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105700; x=1784710500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jC877lcIipbzPO12i6mSRmQx7EEzSrLJZiMLFWRppMI=;
        b=IrGXmzULL0cAFgMSSz5mYRbNqtSJmVB8sQ2htrOsdbWz+nk2J6MUC7l+Ym26hOX6KK
         62Fgc+EeSPBJmuJvkzHeAYoTo0zEhpMM8vX8i6/b0KS9ZLN2qWVoL2AlIlPFwLfZ7nuc
         zOO8fb7tJPXA1U+/q/JTHf/vfCcP7xmUIz/uEZGZSlua5AhA7u2ETiM9asNt9zBibqGY
         YP5SURd3ZU9ttkaDpLcpo3f69UeWwBTtt2ZeGKiCiYbIAuP4AhXz9U2rHWfjmBsOYCoM
         yhRHdMoQO/Mot0nz75ytYNJyjlKCqVKfYIa5M/bJVwWzaioZL2YgxOQkg9SIkVtuoYem
         w35g==
X-Forwarded-Encrypted: i=1; AHgh+Rrnk/PKt65QfYRLk+JCvR7y4aeRjbBiE264SLmVicWR0jMq/vOGGu96VhtY7Tc1ez/OLAJmn3EsKEKi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Qe8FSqH/eaVndG+5efbTo/pLD8byna7wHWwiJekYgOgTgnlt
	3ocF4vEviafAwwozQclzVqWcxdjGvjcdDZEm6XAsrmwavdvsVsSIXPg67flvbRP7BQ==
X-Gm-Gg: AfdE7ckTYUCxWXe+vrW68cWpH+Qun8IaI2b0wG33m02/NRn1nfTomh6oEUW0LAD1CWB
	9/tiMYb47XU6EcKHwyJi9UYkxNVXzq/+AavP7jCysEFeTlH/BLPtZP3BZCa8X6AwmUIDtpthNWt
	hpFZQvWZnI0vplfpPLAkeYjb4Fiwn1yPRyFAFIJA5CiRA22qn1p89vdWbKWxEzTCWvXK12Zyuex
	9HK8lCbCZeOLKCqdfJMdjjmLKI8Bdx5KqysboB1tZPFuJg7AycnHZKO7RYHeZX8PXiXuYAGudGL
	0Wu0Bb08v/ioO1+rPLHOFg9xD3v8vMV/ME/8K+aQdEGrzMH4SDurPnP7qA3giMNlZjkgU7MaNLn
	k4OdxQJxdk+AKTLhlQc814wwPMzbOkvZSrPxZL8zwN47Qrs78I3K1jiYNbEVMjLJthGM95znptf
	L3x0EoTwFmnybetoz3n4KlmbvpBEft6Cj19alpGcTRw0/BgBZMQFgaopVTqK8qjoqr29uRYA==
X-Received: by 2002:a05:6a00:3928:b0:848:2f58:e1e9 with SMTP id d2e1a72fcca58-84870790b80mr18374319b3a.36.1784105700341;
        Wed, 15 Jul 2026 01:55:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:00 -0700 (PDT)
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
Subject: [PATCH v5 09/16] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Wed, 15 Jul 2026 16:53:39 +0800
Message-ID: <20260715085348.3457359-10-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
index 40cdb63b5333..47010090d3b6 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -973,11 +973,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
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
@@ -5434,7 +5431,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.795.g602f6c329a-goog

