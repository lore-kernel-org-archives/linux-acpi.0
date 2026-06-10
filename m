Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858B3C109F
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080916; cv=none; b=HDN3E9/WxiWunHlkoGK9TxzSkWpaSqeov/mJve07xCuZ5L4+142OGl70zj9URSjAn/V/WOSG/YKdoqSGAPZFeiJWSs2/KVldbz9+iqAfPf+iX9ljDJAmxZHxR7PHUthLM81/kcr5C6MM2LDWfJRWhX5JPOLxNVfTH/nAZOUnZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080916; c=relaxed/simple;
	bh=Pm31+hL6qrgMtRuUHHiRRIlqVHF08y0dXaprDA+L5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JstpVGFqa0RmhmwZqhtSMJcH+I/JiquaH1HUm+ZhPX3KQbsyh2CNmH8KaLcIATjh6ZsEUMKzLEpbH4etB8p1OLPisZbuDphOD/F3XxyHNJ9BqkkQrbEfysIxKK80lBt0gcEddoDJVjIGPoH8/rES1gHGluJGbSK3lhIWpdShxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e0MJTeSt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0MJTeSt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3315c5dso67896645ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080914; x=1781685714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnO3yRdxbnlh4RjwbvilfqRxY8jsmsz+8SVoyh3JZE0=;
        b=e0MJTeStxs1K2v8xXr5iAdoAKYw/aTID2+7aH4ULJdHr+jUKUekXK5kky8CbD6UHi0
         bMz0yD1cO2yESHa1YBfh3dgbhXbqMHo/2nXSoifuqWxOV2YF2eu/6o32l4RWcRMnMDGA
         eLyjaKLHw2StxBFiPS79XDLPHezB2oMVMK3Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080914; x=1781685714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnO3yRdxbnlh4RjwbvilfqRxY8jsmsz+8SVoyh3JZE0=;
        b=DhdUU4kiWvyitPKfooSgwssiKXeelhDWTmQSNtahyCp7SU5AWoBc0te7cEUiZ2ceFk
         6ygziS6Z89Gc2QJrmo/47jquwFaZTFeDV9xNQIFgRzRhtAuj8LbE6o/4Q2vDOhZOqz2U
         lBPsWZ1f4XAtvvgRF6k4cRAnadWZPhsOujm4pMPZ/LxISxom1W39aJmEkO+EDFBCx+1p
         P2j4bFLxo+yR8hUzZB5W/bw7Lo5vS8yzftrHDLhvxospBcMxssabmEFyU0Ek2PufS/dZ
         GNl28PJ5+6OdNcRTcyBDFue0kO31Z1FxM/jcAVyi70QGVKxsHFXiu55aWiKXIv5F3pSO
         vUFA==
X-Forwarded-Encrypted: i=1; AFNElJ8bXNR/gc203zcjP2PAVYtQzhlkiy560YRjd9uhi1R1kdCA/tRwbuO2VBf1cB8c2dxTUeOD1Bgg6jyO@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOCNQZ3mPxTuNp5ZukXLqO6mfL5rNKgB3YgpxdIc/WNEA78id
	Q2htmFVCJwl8J9V+8DAO3GhL5CmmgA7EBssbS9IF+rRKFMok3hHwVSSmK93dJl/idw==
X-Gm-Gg: Acq92OECRQZBzkOihvmbbcfYtpAhPFB968NbgaXS0qBZcAsg+Z+v2jo2LSFOq67lp9H
	gVEB3KzbBh1U9EcdQn+76HiOYl+GJWXHn1yIdxh+ZrCIUepl9jG6e/jSpoIOk7rfWsdpEJM5mgO
	TyhNreWDgNhFMVtY6r5hbA77Ct5lfJYCJ1Luw5XhANM+hMFyNzj5yFJltmrLDhmDvoeEhuqGor3
	opsTV4vVJN2j6sGllrKEYL6TOAAV5B+QJlGGcAUxcP9DmjWBDLKWM6HjEm4sQauFKmAh9lUZA1r
	bTe3XN7Ay9nrpluSn546VhfIIEs8BLQzQZ5yZLSwza/vDvBbYoL83Ncun5qaSSxQXiSppj/fZfu
	VycpAs07vg8BLGRzIQgTuOfbIJNIu8bwM4xWC+9aKMdL9gKeBDUnHrYXcc8G2cZaIudlfo7SkVk
	129Jx1lPoSdqwR/z8uSWqHukDaCesUUZTmQsinZqtsgXckW2zsSfy7Ks9wXyoBZLrE+E0MK5jci
	6xULfcBoH5ae+fYzw==
X-Received: by 2002:a17:902:da8b:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c1e85ac571mr292987545ad.31.1781080914415;
        Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:54 -0700 (PDT)
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
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 08/16] Revert "dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP"
Date: Wed, 10 Jun 2026 16:40:42 +0800
Message-ID: <20260610084053.2059858-9-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.

mtk-xhci handles both USB 2.0 High Speed (HS) and USB 3.x SuperSpeed
(SS) host connections. And there are USB 2.0 only mtk-xhci blocks.
The SSUSB controller handles the device or gadget mode. Saying that
SSUSB handles the HS portion is wrong.

Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..75ecce3bdc7a 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -107,10 +107,6 @@ properties:
       - description: USB3/SS(P) PHY
       - description: USB2/HS PHY
 
-  port:
-    $ref: /schemas/graph.yaml#/properties/port
-    description: Super Speed (SS) Output endpoint to a Type-C connector
-
   vusb33-supply:
     description: Regulator of USB AVDD3.3v
 
-- 
2.54.0.1099.g489fc7bff1-goog

