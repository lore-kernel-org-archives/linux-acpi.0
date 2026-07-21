Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88998432E9B
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616930; cv=none; b=mGvdh/RyRVMr/F7ELEO2+RuJPwKQ9cM4BwuqtBeiz9kJAsPbjTVHGzS6oBnV1nKEw3bD5EBSVqsP4i0MK/u+L+3mr5pp3PHANaDUem/3tXlWiNDHr0a5yZImL8kcJii6qVD98bO/SriYiaBi/kT+ZshtiD/DJvN2NLiA6uK6RnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616930; c=relaxed/simple;
	bh=Weo+Ui8E43MHQNrKTqB+K8VGg2TvPBPQ6D1g4YfmF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3/nA6/+fkhasOOm/nUVoSoR+K41YL1gKjXhNyZBRZg+vp8dNRXoK5VcQLuEdie14GtuIK9TbtNqq2DNw+qhGlDFIi5p8oGalehTphVfRUPfvU5+JuMDrM09xSS3gqOm/+o+Y4QawBJGFWoy1rnaU1synwB9aCVZNR3e6ncEiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1JubqtR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1JubqtR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacf197759so124515655ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616928; x=1785221728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=Y1JubqtRZwAsb43vVoeSY5JJjyZlmldO9NC9MH8KBHAhdY+eCt+yF8EQwu8oYh76DT
         MBzdt6DuPei4vUVl2ymrABNtz181vEHdUNn4eP8cU5iDmbLVB79E9XIfWUWJ0jIS9bYR
         9i+IVVezSOdycmXwyGUG5mDeD+rH5aFyIXTEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616928; x=1785221728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=VZ+x6rbBm+CcFbpMHsLFo8ri0vTp1msksEqDgV0L2oAXRES6Bxrhw8U90pf2FAyVeB
         hLL90VT4/wOolrHXPMdPUksD92Pm2S5P0aerye8/L8WKZ7Nk5RbVVh/98EJmGNR0bgOo
         GzdSKLH+rBb+HbCuSceFNdZ9ltYYJzklGdVAL2VmB+owUP8VYnZjV8xzbqzoc7Y22R4j
         hN/u5nVjjR/quiOjF1RJmU7wZ4lbUXJztddZUGEZkHKMfhMWpd+mqwUy6iaW43MTnCdi
         a7La1rrTajd/4SGFS75Mz74hFoE+oQy1FMEWRGQR17E7sCcYnPH9b47YULIwRdEZoekj
         KXPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVZsePszC25GYko2fUU8mRezYYFJAq9DB94H6sURu1nuVgWi45UamoEL74tCJPQdorm3s0ZRBkhfXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s/xj/0xruDp9fWdDxuOWg5dGFYRHeN1HNz86OP8dhejstqKx
	DOmZj0eACvBWfk+yradBB9p0Q+96PdXvsI/FNxaNNGNj7avITnr2SoRjZgYwBnpsaQ==
X-Gm-Gg: AR+sD118PeJmG0W8/un3suVE0bSAo5oYKYtKoVPnse5RkG+piWRBopgslUIQj0zHWLD
	6SMfjUQZD3MdZ4gfi0AgJZKHQkrIGBiFOPjHDEpinE7zvAAmmeZwMX6Jb9OIp2SjRvURmXj7cLz
	0hjiGt6ILXBvT2oDZa9uD83k+hcCseZF21LibzoGoRzC2A0gmBtBQZk1NbUgWCQQtLNzjvZGwTS
	ny4KMYQVlu49j57ucd0P5vAD0+YU5oINrvA8HyBinl4WYFp8HXVj7wN4OVLjT8bkA+KoJtLEro+
	qVxEsjj++CznK/BTJAMFrHOYPa9qohvCrFIJhSDUUk25CYYcCBYSmu7aEAzntmMRLJJPp+GIESq
	aj2GgHHZVrFQH+6U2Awxp7nmTafgdShdycD8aV+2IeoLZ+L16Gm/t9hztlRchlysT45w7AYmNOG
	+ptjIu/cl6BtGorBeC4QVd5rZEXcpHA8YkzxdoE4PN3wOG8ODEXv1IdFod8lo=
X-Received: by 2002:a17:902:ef49:b0:2cc:ee78:3236 with SMTP id d9443c01a7336-2cf34997125mr195766485ad.33.1784616927898;
        Mon, 20 Jul 2026 23:55:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:27 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Tue, 21 Jul 2026 14:54:06 +0800
Message-ID: <20260721065413.2306137-12-wenst@chromium.org>
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

