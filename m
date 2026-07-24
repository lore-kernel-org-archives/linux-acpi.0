Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5C3F928E
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882703; cv=none; b=S+uCy1LFfQl9+/23PBdFRJyfQRc52DC9nmmNge2yf7EURPxStO+MtvkGcL1uSK2QT0vJ1GTaQfLRDAm5mNZGGIOfQg3Fav5vUvcpguvj6T8Z1rD+B0qFStgexYxO2Mz4xzajXuWwlwdS/ia/AEFS0l7tOvOnZg4bFiTnVwlwMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882703; c=relaxed/simple;
	bh=Weo+Ui8E43MHQNrKTqB+K8VGg2TvPBPQ6D1g4YfmF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi2nST6xsdXzSnDwXQFlM+6gqgn08UZw0W7sLhMg9c8vr95iNeoJxXZ6bkauPqc3vnnAIYrl734NgZq6Qbe22x4fvuUDDsZr/hrl0EbQEOvy0v6X2cnWUQtNuCXnsGc9RmAcItzn66BrgUatrUDYD2Xv84k6LhtGIXEEIerrZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eEH8NjHx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEH8NjHx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso164570a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882701; x=1785487501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=eEH8NjHxdbQ4AzHsBEZRYGZUyiY8pMiQTx3ef7+ZNkeVWAJMFIpp55gIpBVDIyDTTm
         7x37H6Q80oqvnFsqIuhMdkihsXSqLb31/ML/PxJuDa6h67Z5SK2+efCvC30Qz0W73IKF
         ASLrFJziTRsKXt0YJFXXcXXlFA7kRGE/jGvk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882701; x=1785487501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=ekPkOl27Rd9UwrsX691JEgfH/kIqOFK3XvOFW6N3JLDEE0d/Ov1151vMOQSlbzSOca
         EmT6Y1gaOhR1CHNeYjdtRa8etM2C8h3hy8/hwkYzXi5mK6S9Ik1TH9utrd2425aSSPZR
         xeJVkeU5qTd9D7+VVgLe8A/1L/PlB790GxKo/suF1ZDz9UNXPCUoa1l1ab89g7Exso8J
         +YUBFKowPxeRUVqaI/AAEY6PkW+y7x2xXaiaiEJ6tmQ+Px2px3+q1LlSAHTbirq1Qyb+
         Zs9JFYAx0eLkEIZ7+ocKRWFTw0tfK+CPfB/0XoACWkR6CHRMaCtS+YcZOqSDd5CyEpiU
         35Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrPtWlPNDxMnufHLgadbWbH3+zkbBXTjGparIvCjKxIcQ/0rUyj3Jo9tJiHk7P91WST89SFZ57wt6sR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fssbgZL34GvnyhY28XxLksFN60wwmkhF+s2aUoj++QFogboU
	CRWaem+zmVKCNAI8nKguP1GBr1ZCSsZnG/5tIpCmGU5JYc0bkRhUuEHLHDO6diTFGQ==
X-Gm-Gg: AR+sD11z+YjZFarY846xfv4sBuAAQ+Tfr/UtkMqIURmdP/LtCKhkEZiuYEag4CMRjI8
	v4/Ln0dusIPigclGclwbA9SzHUeon6USHNMi9HK79WcqyBvtztg6kDVA58+84KfK0hh0wv4YCa+
	SkskHoI72jhEA21y+/zdhRXmU7vvtUWn+T6VlSgi4wuDpzsYe+myoolje0RpzuSMsUwGA3oL3D5
	mNfSq/uNQHE3pIcmnLyiA6DKbz48Xh4j/auj/JS/De6o8kXAVAkXZVS8ehBdzQ7uxNwHqwYYPLy
	dflkUmFopV9WNUCXCz+GOw7IzgfO99GAs39IJwePa0jOqSShhfucidUYnHC4qOy+GKGflop3RAf
	aEyDyF738o8Zq3svOWyTnGuPoGnJYTiVFe253c603PsoWMdpZ9IfyyL1czL4grub9k8SDrJSzdw
	ybzoI2uzI73wrBGDslTlDi3Qxee/KBNZVKJ5awcR4ImL5fwGb+Yzue31LQLC4=
X-Received: by 2002:a17:90b:4d08:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-38ec85cb1b9mr5733586a91.20.1784882700981;
        Fri, 24 Jul 2026 01:45:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:45:00 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Fri, 24 Jul 2026 16:43:20 +0800
Message-ID: <20260724084328.3943997-12-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.

MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
and USB 3.x Super Speed (SS). The block can also be synthesized with
either HS-only capability or HS+SS capability. The SSUSB controller
handles the device or gadget mode. Saying that SSUSB handles the HS
portion is wrong.

For example, on the MT8195, the first two instances support both HS and
SS, while the latter two instances support only HS.

Switch to a "ports" sub-node for describing USB connections. Port 1 is
Super Speed if the controller is SS-capable, otherwise it is High Speed.
Port 2 is High Speed if SS-capable. This port mapping scheme directly
matches what the hardware returns in its capability registers.

Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Squashed DT binding revert and addition together
- Dropped reviewed-by from Bartosz
---
 .../bindings/usb/mediatek,mtk-xhci.yaml         | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..d6c75bd20b78 100644
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
 
@@ -188,6 +184,19 @@ properties:
   "#size-cells":
     const: 0
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Super Speed (SS) data bus if SS-capable;
+          otherwise High Speed (HS) data bus.
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: High Speed (HS) data bus if controller is SS-capable.
+
 patternProperties:
   "@[0-9a-f]{1}$":
     type: object
-- 
2.55.0.229.g6434b31f56-goog

