Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E983C9888
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076659; cv=none; b=Q9NVmL5IwwrnkK3CaQABrfAyukhxogjqzuqo631hUt8KSrN/zAagrw8EBBsrYhKuqf1proQsYpKi03svQgJk7P2WYyYFSzVmcR9cgzSY4XLu4qKx2vqzEZTKbsoFng+3opXo+9cqrG4EVKIMQYgARcSi3OQPEyUoFsonQMgUKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076659; c=relaxed/simple;
	bh=StLYhAjRY3Tk0UVrkWuO2kk43YeFTxpvsEJRpOxBLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkIm1RuBG4+0AMS5qYQ0x2s1tXdYEIldmUzuOqx8BUhsKyf0UlWpzga9JkZboO9xFOrfLVEirt3/xd9Pn523k+T5RCiENSIcgPcrsFFtX2O0sCvdQz+iCy1VopTwZzy9cxo9nBMIXwrUTnlYr6a3RXfm5Z3TtzUQ8s7QyNod8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T4Ombv5i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T4Ombv5i"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace7da66eso3963645ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076655; x=1783681455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4WWH0bleuNmTAqXa1RwaMnEajgDvtrfpYNFP62ibWI=;
        b=T4Ombv5iv8fxAxhPaQs5Oy89RIe2pPAShePk0y3q6bRkaOO+maflECFvlRd98RY75E
         HgdAr008Nkfv8SoaMAwnWay3PHJo5+kMKfBuZWxb7GCbA7zrrmCeRKuB3t84jBwzSkeA
         1f3GW0Dk5KRt2AifE3MLYyXOUqx/hYJk6WVPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076655; x=1783681455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4WWH0bleuNmTAqXa1RwaMnEajgDvtrfpYNFP62ibWI=;
        b=A0NV738+45+JVVtDhKhofGATufYX8XJnlcHB6tz3K5MwDLK5wLjiEGf2D8l+aLKNdY
         ruY9zxwZYxNkSKPoV77dO//wSIYtZdmcbbhGjCVMNVL0w8dIA88UtSUW10Lc3U5ons8U
         uhoWQGW8n5Fn7Mck+Zjxn0eipnI4BZDmVGre+4VifdolGhWDvzmzdHrvwvYMlzxu41rZ
         UasdXHOe3u/po1oiuRKbwc7U5uNebZnuICbx3eI9XzzrWbgau+bRWrXTWoDI5U5kppeT
         bQAP/kI4fP9MZ8qWbASrIdW+Z5DKufPVFcSo+NFFEmna4nYVYMT6FuGaH6KakWmWiDz7
         n5eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMuYV+SERR1/1bVMY8osuAtWAWVywP6fZYQzXte246a0gnuO58/jZLXKE+UNiQBenlQOAsAeaTM8qw@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJDNfEFPUzn/h6c8el48YjUClxOcojBhHua/c1NvCwlKhxGQr
	tbxrZedq9GMuMd2O4SLdNs/M0V98H/8af+1lznO6vq4LyqOBYn7pypwazxxk0YD2LA==
X-Gm-Gg: AfdE7cna92WLUMvOXbC9dym7hbkLuQF+sUaTTsZbIyRp5LUGxH1YZANr2psEljkjfLb
	EsXIP9FYdTrNGKC9vyjZlH+HQS4buUMVAjHtHo40Vxpz8CaVgWOi8nQaW+prIlMPARkFUfvnf6W
	nipGHtDSdZsfkWdu/HXFHtCeuFrZe0arcELr4YG3lc74ABDF1vumyCLkPwrHqcsPVBikSpDIU4B
	8c/ZH5dQHw7hl+lFe75EQ5Zice1Lf9bihtLinNOAXnNMK6Iv3Fyo8+wPqMs1WTZbnNZlrWPoqgD
	EKpWrhZBhCziDFJPVyAdZNE6fIUb+Lm9w8cRSuvN0JG9VQKENim7H4QMdLHKb1dgGzlOwMU+4US
	N5MWGOlHWsCRNS+G6GNUP6/L+RjKNeSoi7bfaX/vqcfULUFD8PQ7k+A1efHBuT4xhus9rJ2ERGk
	mJzhu9rngI4x6/PJ9t6ZM6m9rPoDBSzKyWQWZgpHhrWlsXTgYYzLBsNGHEbWwCdVI1Es8+Sw==
X-Received: by 2002:a17:902:d58d:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2cad7a013f5mr21135815ad.25.1783076655443;
        Fri, 03 Jul 2026 04:04:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:14 -0700 (PDT)
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
Subject: [PATCH v3 09/13] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Fri,  3 Jul 2026 19:03:10 +0800
Message-ID: <20260703110317.1283411-10-wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

