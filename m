Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89F46C84A
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545578; cv=none; b=sCLILvP01Gox3kR1P6Wfr7qi8nJysYdB+LWOXNkPt+LRxZ40pQLmli8ZZNp/9OL8tIerx7u/meq8B8jhTjft1w8zeVB3l/5b7zOr32o7EGMa845HVxg5t6sHFEBkb3Rn9Ca1X44wpARIFrUnhzSXGbbekWX+k8To++PehG9SAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545578; c=relaxed/simple;
	bh=n5OM2/VFYsx7oj5lWPwm1kxpni3dSJJQk03UQEkKIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8/btI8pBZT6Cqz/WdOqfkxYsx17nl4LMSTX3/OuMb360uS0ME3NPs74Ksv+YbzvFLlsynxPz9qxfAz6PpODSay+Vi4VcRdmc3HalBZfxuzP8mzb4n6mFHogZTaJHNhXpaxqy1uusgvOfxCgqPnz7E6yk7HZ+IzaVqYbKGTyPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ohYqnxUt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohYqnxUt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so453878a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545556; x=1790150356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnPIF04bEgfqnB06sJJ+n/4J6DJ5aXluvuxFl2QwIxQ=;
        b=ohYqnxUtCPXeFU+yDLfm/g1jv2GU38BjR70gPaXT6fZBcN1akUi9BoI/csovFlpLeS
         X8cZbpOkdAT7PpAIHjYLJsNJXHKv2pVqHHFVhp77Ze8Mz8Pjou+T1OuotuigsqHGgzKo
         GTUvC3aWZ47Z7rkhK+0MjnFLYucVqepA4e0UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545556; x=1790150356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnPIF04bEgfqnB06sJJ+n/4J6DJ5aXluvuxFl2QwIxQ=;
        b=THk/nhd5T8D2npDlXJDu/BX6k6Tbo2MIIlui/sq2latOdZLDAM7QdvN7QEwp8msIrR
         VFcmy7wvTIARpq4PiKS56L4paVXuZU262n1yCaq39DrIJ9/Eiur2XaokIZMH4vMqy/4U
         EDAG8JdSuxxzeV10w+jQcdzrarv9MKKXSoz61ILETcrklMtY/FYGneXWmq4wX3BIREjb
         q5+URSCQjVM2VWgL70bRS9NgtWF4uCCRMiWozJRhOA/a7yGmeLevKJ0A7tPBQjp3wwDc
         lcpwhFtaqEcN6M9MWMtdU7n4F388C+najUgF+TECn/m5aquCkkAu64Oz3fQp6aCAboea
         hDFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxacnfOiPT0s1ftDQ0B1f9aDXkUCq8kCsZYxWKbeOFvl81kz9MBY90omHZOQCxaGfLa+iFIUhdXf5QW@vger.kernel.org
X-Gm-Message-State: AFuF++kx/pe8zu2+cPyPdHQIi8OWVxFZEWW3r6XcyjKweEhtDnQIizry
	IPwMFQB8RZXFLrV8V/uInafj8DY2nL4etFzuFki74dqJoZT1dZJ8j0lVdL3qXsuoFg==
X-Gm-Gg: AYBFou1i0aNw4wUM5WM3+QdHQ/kZqW8Deyhp/xoMsPofH9RG9WNLFdmdkPuay7iVYLb
	37KSJMwJZXgXCyBWGKfT5k4ALtLd0vDTFg3gMjUspPJciMvy5FhwGsbGoDgSpZag18VQu8BNgk0
	MxlexLK/vCyVdTlPnW/tc2DTLxjFFSKJmn4SvMm+lA7EPOvKGOXGMcG4EGzo2vC4KaaJ1jkI0BU
	qYtGP95rrbaItpw/0ovFeUXiFq00m5b6hop7JigRb6a0zb+d1ym3lQl8h08IEIRbGl5CLRuX1eS
	kEGU963Lepb7WnUXXfTL6nvTjNVcO6vhVO56CXn8vARWlJ7w2JUqM3yMt89q3K39kh0ZBkT7Sqh
	iArw0f2VphTW16emozGaiPzCiZlOgpdo7AgNleX57vE+8zbNF47akwsSbaLkkflc3jCb1yUeFZF
	LIK1EPZilh3ehMdk9Fun0DzzaDB8GnLWiKVTVXOFC0K6Jx4oI+/wIYmYKZLUwsVD/V78Yw0QAn8
	EoiSpWTojAQ4ivV0K11dcBbSVZv39dXejgBnqSD9FE/hShOMALN6LdDqw==
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39e1e330a2dmr4372580a91.10.1789545556050;
        Wed, 16 Sep 2026 00:59:16 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:15 -0700 (PDT)
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
Subject: [PATCH v9 10/15] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Wed, 16 Sep 2026 15:57:36 +0800
Message-ID: <20260916075745.3549953-11-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

