Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B403C2BB3
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076650; cv=none; b=m2HBasM8pGThf0fMHTEwSrLFMvIoVc4B3UT34qZnE63wSEOc3WsnX5lWamUsTy+8cnRGyUyG6N4ZVLBeVAO+IQA+Uj5/GT2fMpA83GVwLWSpKvfcf2hSINrcY8rxPkwLMLcj1MnD6tTTRh7HhNLDRt2c6AU6Uy5shnKDyxsgp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076650; c=relaxed/simple;
	bh=kfKxqCT0AnFtztM5LFloMbjAp374Nxm9lZYgvpDSr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKTi23sAEiPQINihUkNPqSXk2RrVH09eEflYPKyPGvCmNoAjP/vt6wSqrPK9LVpayv1zPIdZlQUN9BQRtuunW5UywOSnELYUEfDRVuBqYjfxPHlObS9tAZ/5DpeyURknF0VUBLkf+smVmRShWd+OHdnLpT8qUYB8125De9xFx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O+y53hif; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+y53hif"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so16664905ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076647; x=1783681447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWC74RHfH35yZoE+4T5JHX8GhXugEkV5aHendXMIUrQ=;
        b=O+y53hifkvRjzCdB1Ewt4af9ZOm9SggDwvEJcCMPVVHKv1yp8Gbw+cRAFQico/sdvB
         hNaBm97fEzqrTz3tgnzTaz88hYMd3i0/OXT6/quW1A71tbzXOy7TiyxZx934zPiQhWHA
         mGEHwld6RTwBIzuxi4JDKIsosRAdGgEZg21LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076647; x=1783681447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWC74RHfH35yZoE+4T5JHX8GhXugEkV5aHendXMIUrQ=;
        b=P08E9uQ7IyG5mSYYm/X9jbrSudc5xxTXJyTls6FyPeMjGmcn56MBObZn9PmFJ2g8aq
         X1fcQT7k7nX/3yoWikXXZY5YFjLTyYtknI0BARw9e1HDUosl9U3wc+QQp0vvf9W1SP6R
         AzLALnXdPJ/AgzufO8kSfVKAYaG86NYZ6+Da8+U7Nj2IDe2/JmIUuAP97U89IoOj2kTE
         FhzroXpCYPqIgLvTe45Nc0AH/Hcv2ffhG5WbsD2q4X9SS6S0srBiVfCLtAslcVg4Q379
         F+IM3/O/DpDiSglNXEWXdrtFW73dkcGwfkvr8YyNI0OpXkYukBdCYV+h7SeJN7E5Qy4E
         T2OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFRFjc7m0iFJ0VCR9Pnl1k+3yFqg50LFyD5iCmytR8dS+t7+VB4ymdZWa6p0ixIa4gErDI7tmIzZDw@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKSvVPVod+HNd276XWtsL/6nekVcQshZoGc/MtXUKEyEjxIpF
	HxdjeJCs3h3OtoUHK8RYfDrgVyOnoe9qgSXFPxJN9iZJlvcT5LHX282MkHJFk0cv6Q==
X-Gm-Gg: AfdE7ckyAPOLIaCF0NOS2OcZs9R8UCFrU2s8o2H0VCLUjc/p6TZIe2T/0cwNFWx3EQ4
	ZGzf8g58c2gO2i+Q0kPUzcPhwtwaeB1D3qnqSsQ0btQNbkRk+4Z9KjJvUWl6YEsnqImoa0sXJKA
	QC5WQGAfx5jDt/JTmL0Aj8Q7Ubu6VDx1Zy53pORpyOEcF47s1tVz+lojz2e2QMbbzdhop4tLFNn
	/q0uT528uwfknk/U+rLrHwzVzFOTE7myEL9opbWLTnDaR/hZbxlmW+KtLmhcv/05laJsbb6hHQR
	lJ32q1kBMSBLchAPb4qfViNsSIxeoGiuVCqvrHitpG2Yx/4ef4OqpdD7IKfyU0t/ERBIb4vP/Jx
	C255J+ctJeE+0qPMLe/LwEejsIAVLGJf1sw8ZrUbCkwezuwteePj2lPFMyuWRv6ssLQRei8Ah1l
	WmkGu1DcSY+7QaENEBjfrB7o7ov//RRHHhnSM1iQMpE3XhCr3fCrlctP4fhJVIf/EordM8pQ==
X-Received: by 2002:a17:903:3b88:b0:2c9:d27b:af11 with SMTP id d9443c01a7336-2cacacc3ccamr39740205ad.11.1783076647262;
        Fri, 03 Jul 2026 04:04:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:06 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 07/13] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Fri,  3 Jul 2026 19:03:08 +0800
Message-ID: <20260703110317.1283411-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index da0a4cc8e15a..8ae97e8c26aa 100644
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
@@ -5452,7 +5449,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

