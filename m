Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602017;
	b=YXpRLD29KyfGCv+k3e9Dj/5JNUKYXPxCl8aD1p+BQxIxHGmS4KzMr6Tq6pEjfeZx+Oky
	 TQNz+6F8zK6HeZH6w709Quvii3El3jYCm9jDRB6C/xj/mPgySsSMIamZ6lbjijfD+4M7v
	 w+GQNTh7l5LROcLfDIJVyl3LUplkLf2n3l5f7Q9fIAVpB3LTXb8AZixoqugFa6P4fe+RT
	 RoT7cSpBRC0LyWFflYtrMm6957MIdSPjwou5iCmUGWZcWTVdyoOgd+d2KloiG0hHXLkkv
	 TThUysyC+OwyfEEFKrJnQq3XhcEZuxEXO7f0HiGePmoXSEPEWD2jsepZr2T8GMMC7mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602017;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3GqzT7SXZUXUviYJRJR+eWJ2kJqwUKNfSUL8dK6KjqY=;
	b=cgH+W8Qk3lHk4PCa3Z46kIDwKJFvIhUuOJSLIcChpeBTPdg8wYxrAgfxbSAs3KdsC+z+
	 Vvv/z2zEHRAHDTt6dewSSZ13Fq4uj3llP3cANdB2WLprCz+WzUuIsVfpI6MIb6cIWi1LU
	 1rSHAC2wl22cGHizBXqVplQ6f8qBYQp6E9CB1HBrnX2u5VYtdsDsTBplQIIHWEq+k6mQ6
	 u8qn40ffz6lL+YKgMHTKwOErJeCi+bqwtkBtnHRfqM9BID4n3L7J5sZg9Eb9SPXRmc3bN
	 ouVfrC1ml2khKcowPMGWrCKoIuZyQ23BNrG2shLcAnrThQ9Ii2tRY30i8g6W9rb0aPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIvEojkY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CC606A326;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIvEojkY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602017;
	b=ihjBBHNsxzoDl42jotCiE6uXPOdlaEMZ3JaFok+3Ni9EV9iEzY8SSRTIkR1pguAiukxl
	 VEyO4YE02pqVYNJ/SzIffUtVFurmGaTESQdFV7kqRcwgDiS7W27ykpZ76xTBQnQBIMKyI
	 IYT1K91fSuENPVW+QD67dygru17kIvWidwI1OoPiOmjxBhaEkd7rA2IGFF13+JayA5wdW
	 YRm7m46WyeB9Wh2L9cQIGTP5JEvkZrr4iFR6bdgIKjckmGhcnudoyc7fqOe5wPWvsQxxH
	 ta+1vKCq9MoifVd68lMzh5m9oWHxcEBNfXbDWBnVh8rXUX1dhbmBgzGCxTHqTyQ1lLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602017;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3GqzT7SXZUXUviYJRJR+eWJ2kJqwUKNfSUL8dK6KjqY=;
	b=spj4tDmlo+vaQMwziX6F/oVHIU0kKp0RozqkeESs3n86CHP0cukT1KQuAuJDs/UNOrKX
	 G7DISn2uXY21GGvpph+CWiQPntZ7Obp9CKRdCjQvpRAcdj6MaswMA5sKD5nWj2xb7Y5WP
	 U719BagSVCRS5uTkc4Ml64re4E84oIvlGvWGb4E8RaKKRX/9+8JLVMy6ohdA7+M5jigSw
	 raf/XOKIDLvkjmG6chnShzcaqNod40Lb+7To3i3xEgnCyB32EcONApv7hjAHssOpMBasv
	 TMJWuCHdXRvXQAimWQFlNXhfOQYGr0/x6ryIqW2AXILyegF4IisiIlzu02IJBs1XWLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17B321F00A02;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602017;
	bh=3GqzT7SXZUXUviYJRJR+eWJ2kJqwUKNfSUL8dK6KjqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FIvEojkYRDVTANxGdJJ0NJBI+wvSYf82QViPYfDShixH+D1gG2hBS+TXSFWUueMVI
	 IPukfTkuvHoQ+L2G6aHK0AhvOABAls1ISBtV6j1DnZ/w/NnMwr1RMZbOrMHth2Hh37
	 O4uClLT9hpsiynE+Q3iy5WHEI64fvVnxFgrL8r0gTq/5Ais2rJLnanoSZ/ipA1ePGE
	 oLBKPPX9+g8TilVY2wCm/QDLhsVA02m1EKj1yFX1yRyFlW6g20EnkxYpeoCHsfw06t
	 a0KWiZNlxC6eo/lIXmbSsFA7ZN6BRBKOCznuhKTMVGBPYlA2i9OttJPedk/9Ye84mT
	 iwEthhBKtW9nQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 804C74638E;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:54 +0800
Subject: [PATCH v13 01/13] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-cv75-gpio-v13-1-4f93114ea204@ambarella.com>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=2175;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=ecrzSAMMaNZiFiJHNHyvnNwBNYVIUrMbREC+e46Wpqs=;
 b=aK45sE7xMsnVeUkJVEYGNztWds5bR4QSt+NBrfZ1irIoqSH/N4oPJ438vdEhKbnLDYnPFiP5L
 nJIfQd9zIWLC5joFcwOJbdjBu2gqDxn8xQNuHmwJsEdoxXGomUrSmuZ
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

The CV75 GPIO is a modified PL061. The basic registers have the same
names and roles (DAT/DIR/IS/IBE/IEV/IE/MIS/IC). Each bank is 32-bit
and 32 lines and adds MASK and ENABLE, so it is not
register-compatible with the ARM PL061 and arm,pl061 must not be
used as a fallback.

The AMBA core matches the PL061 driver by PrimeCell ID, not by the DT
compatible string. These blocks do not implement the standard PL061 ID
(0x00041061) in the ID registers, so arm,primecell-periphid is required
and is fixed to 0x000e8061; the driver uses that ID to select the
Ambarella layout. gpio-ranges is required because each bank is a slice
of the SoC pinctrl pin space.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/gpio/pl061-gpio.yaml       | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
index 4d970e55104b..c22dd8a1d2c1 100644
--- a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
@@ -15,7 +15,9 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,pl061
+        enum:
+          - arm,pl061
+          - ambarella,cv75-gpio
   required:
     - compatible
 
@@ -25,7 +27,9 @@ properties:
 
   compatible:
     items:
-      - const: arm,pl061
+      - enum:
+          - ambarella,cv75-gpio
+          - arm,pl061
       - const: arm,primecell
 
   reg:
@@ -64,6 +68,21 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ambarella,cv75-gpio
+    then:
+      properties:
+        arm,primecell-periphid:
+          const: 0x000e8061
+      required:
+        - arm,primecell-periphid
+        - gpio-ranges
+
+unevaluatedProperties: false
 
 ...

-- 
2.34.1


