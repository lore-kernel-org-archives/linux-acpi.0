Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B03C10A1
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080920; cv=none; b=EXhO62xi4ZCkM8Peliy+RD2Os0LlApzP+WJh17/72UUK9vLiohFfiUkU0sMc2wnQJnSpUT/1YjGMagnL4Xuuy7OECjFXuEFPAy726QHdqbNvIvE7bCYcDxSeq+QECV4RmYcgpPlBednHbx/3J0Qr+N6In1Vvhrzyvm4g6dsx1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080920; c=relaxed/simple;
	bh=K4CbRZICEvXlvZnsotKBa841gnqFgA+6O9aKcbgn718=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrVv7VWKlaTYq3/qY6hAQ9pGKxIejsARJHaQYsbVS0nTq3tqYQo8C+ihBaz5ySq6OeyZnNoKS4ye7JhcW+lIYiRcrpGNRqO2Xr+8mfgfw2RyD5zx0gM/IChkPQEED9dUUtwN+/APtetTMCsi07cRznSSy6S9JP6yLCnB7Ni05Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oU9OHa4q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oU9OHa4q"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf36a6905cso46297505ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080919; x=1781685719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ie5n/VZ8V7UrahMrX/rnRRNTfb3tFqqez2pnqYi7Q4=;
        b=oU9OHa4qwepub7JawaNuseJsLw8+JEKpBAUataCn6hqsatICp9JYzO1zwduBlLWBoF
         JLG4dIiQ1ER2t0IRzTq4VoAJJCDAtHujaHIzL7U+Jxi+8mYIbWyzwBOtPDy2Zaabv5HN
         3183s6JrqtLAsmqy/UQB826fjUCfbOz/DZi8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080919; x=1781685719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ie5n/VZ8V7UrahMrX/rnRRNTfb3tFqqez2pnqYi7Q4=;
        b=SF4m8sZP+HS24WkyMmKuDejh8VyxGw/ChIdaed3BdvGrHwEzHi/VO3H1cXTUjONHQi
         jOiJ8BcqykWEDnw5bYPjZ11vEw7UXpsj7ElJY2MDQsDzmSbP+pj7ophp8RFJGsgkW+vH
         yJilkR383RXFPDUUibvOnn/WqJcJeV0CZ716fMA0fAHT0wFR/PR+CrPiYeKZ6i4ldQI5
         tZP6Q6IJZn6GIUEo1lj9jGUQVOhVNkBlZhh60BRlOUAUR5lBQqNX97RBRvmrI171IfQ7
         MhnXg6M625AJaO7u9ck3ABWSr9uTura7qs8Rkmmp87PPoccwR3DGh+cq1KO9Blc9hc8J
         4DEA==
X-Forwarded-Encrypted: i=1; AFNElJ+jhdFj1TQiJ2L8wsq4Od5jggK5HCepzIMc8XkR/tqvT7j3++kbosPeoaFxi6RRCWlSp8EGf0y4Sttf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy54fHLU6xWEfm3mTfnmiLzCsVJHNk289P7m3bx8xyrrgifHWJ
	RWVorcLgm/0fSqItE/SjJKIuss/my+IRNRL6hLA0bJImhR+vz56XcnBu8qFpB6nN3A==
X-Gm-Gg: Acq92OF4W0/8KbCeGQgpzQsXDMADU/AJPUrQ2MbDRcFY9kUcI4QxKZ90dnK3C6xNmZE
	FotZLmHZg20za5dAOS89Kr4V0FfYFbUzF5gVZOf5pgOqmZP8q0E/cI/YvddSj7vG6kR/UIXKRWe
	H2Q4WhnclPE1k696UJ+AIR9tBncfXeu1Lr02h0Hn3YRfCxnhbF0TvGH9XX1aF52Oq3jF8wu49oi
	sqLIiRxCLaxDekBhJeDC834kV7SYR6Fwgg/M/8PLWoDtGMyzxgGVMFrvyAiNYQcCiMx6tJfNbYO
	g0SvAbEtXVZ8FEg9AwLe3Wc7keIcob7y98emG8VRUj+tyHhU8oqZ9WbjsEVi4FmxEmoCo6q/7wd
	5qfZbIYSuqRUor2+xD5SrqOv2n0PnHlO2WOVC5VV+qkWnnkmJ+aLa32Gr0PQmmSZtlk//P9/zU/
	5G19FH4H99jvvEWfw5JwkPiiTE6JBRZpru3EUnVTXXv8VjIaxo5sm2buyrx3bO3c1W/QEufMGD9
	tbC3BOK6x8iLCcC0sb2v+HqdLl0
X-Received: by 2002:a17:903:3bc5:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2c2a1bafec0mr80534305ad.3.1781080918758;
        Wed, 10 Jun 2026 01:41:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:58 -0700 (PDT)
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
Subject: [PATCH v2 09/16] dt-bindings: usb: mediatek,mtk-xhci: Allow ports for USB connections
Date: Wed, 10 Jun 2026 16:40:43 +0800
Message-ID: <20260610084053.2059858-10-wenst@chromium.org>
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

MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
and USB 3.x Super Speed (SS). The block can also be synthesized with
either HS-only capability or HS+SS capability.

For example, on the MT8195, the first two instances support both HS and
SS, while the latter two instances support only HS.

Allow a ports sub-node for describing USB connections. Port 1 is Super
Speed if the controller is SS-capable, otherwise it is High Speed. Port
2 is High Speed if SS-capable. This port mapping scheme directly matches
what the hardware returns in its capability registers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 75ecce3bdc7a..d6c75bd20b78 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -184,6 +184,19 @@ properties:
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
2.54.0.1099.g489fc7bff1-goog

