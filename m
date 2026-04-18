Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774D341062
	for <linux-acpi@vger.kernel.org>; Sat, 18 Apr 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490670; cv=none; b=myUhsjKy4JUlfN6KDRbq/z9tdN9lZOZR5CjBvajoPTAyslout90QrtXq3RU56nlgdh3Jg9pvYVW6A1J+Aw7GNar8F2cUtv+WSQ+6CyMh15UsFHJqqe8199vqEqYOpuXrh9zf/eGuwJcfxjWPelrS5CYicVtK1q4bdWDNGPD2zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490670; c=relaxed/simple;
	bh=prW9Ym1vKl2hLBI+UbuMXxxNt2Sy1yJhvMrFoNFpczQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dm7nhUphHzRnoS1ZbARpaYCCygJtWdaN/SwXaG9+2pUHdsROn1nrKMCaesmMepVvgBpfWp0cjYE+xT2qUAcIpPAXbbP65Qd78oY5P9IJ+rJWQd9PETqNZW0dGlAopXyApNbaKNsa0H3eDAr9cymZe3KesP7dcDXYl/GTydGwxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKu7uAtK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKu7uAtK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488c1f446f3so2768405e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Apr 2026 22:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490667; x=1777095467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IohdsypP3r+7DTKppzdm/+A74a+kqBF/x1lFwg/446s=;
        b=dKu7uAtKFFytQssDpzNJhgHxbwTUeDoBN34lwDqpd9U00+S+q9Tvl2PwcNqqmVk3dh
         4U3wdLOpet8OBsFJSfW6aRFlSb7LzdpfTM3J/zPJ3n0xCx5cn60WbTS+U8F9orKNQe9a
         t9z4CdsGNQgPTNrbugsIr7SIZ2qDad6yr1e4r7S6sN18ZkvfrkS//IMSb4m6AobLW+0o
         2LaijCyGDQX0PailV36tcH10dnN4WPeAGMvMw541Co90nqE59R6KiMM5yEclLNzI4N3E
         ft37dDX41Avmvql5XyqJi2wE5eq5a68oP63zKTi5OEt4t5PlAgUvb39vC2Yhi087ukm9
         mCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490667; x=1777095467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IohdsypP3r+7DTKppzdm/+A74a+kqBF/x1lFwg/446s=;
        b=l8+gt3YzNYm0WOM9u5cMy8JitwxWh+fvVrTOb+TnicMQmGdYRP3vU4Jmy902Ry/BG7
         nc1xaPMASnJvRffyIn9TDx20g2JQsgqUbGkVJwrRgjd8hOb/fAoQBLdTw+e9g9tcg/e6
         EHZom3nM5o2mKe2w9ZeAUPnPaTHRSPcfn4ehikfF/nYCHRSWrlQXJ0dtYYmsrjPzEkQN
         Kg8JSPgXpo9liLpbbtc5rT3XIUOyQLvBiK4JxU8otZZHp93q8JYFn18wTd1FJqOFAVAJ
         JGdUaskU2pDwGExTuyrBvaotN0foD9GeMDqcblgIKho6IbuFfbEAvkmwN49saSc+wLPf
         xxrA==
X-Forwarded-Encrypted: i=1; AFNElJ9U9IrCyNPKPgXXNxxN8s+zajbtWCgqb3sZZqLArevFyiFa7cY7GMlF1HMu7cjpK++KyMS0kRsBfG7e@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiEeaA5ibGH6kvxplrSHXnwtwHqSefV9ZATtpKya6kq8z1NbF
	4dlwd/ZoMuhT0YwY3hBnfMQG2ZfgrDFRaUsrvKzp9OHrKYRz1t4niIgI
X-Gm-Gg: AeBDietid+UPOYeVxU+OYCpudC7ok1bO+oqpXZWmjErc8fsgWMmpVV97djgCF0DW3b1
	J8nSjmn+zwDuYC3N4xsdbGVP68rX9lhG8QOfne40ruH5vsAUDnkGz7Mqugk9QNR5RDopFVy9c2G
	l5ZT0olQ7dfsM/IsgXp8gN7ryHXudw1yVOccadrl0nU0BcKylSQQ795JP7fd1MCBKlTRWGqI1zx
	pCNahPpPmC3sID6GmkSiFUONSDzPm5O6KpzdL88St4wigvLUelNgCwPQHULp50Vga/eTVYxz4zB
	UZ7QVc9utfjGRlqmNpPXlAVQWcnVgjZarjeARR0jEJCfkEZtVvtsIxE8ypNBiMmIlw0/F0FZ+Ee
	0l1ejYJxA73oacqKAK4WApOV5WygYpIzmdnMhZ6jkwTJb0dYfTNUPjlKFAFmUpHZwnUNqQQ64mY
	9ceGwA1m8cf3TxemqWbdkYz/hHF/5YoiEPCjyHeeZrZ4FJDRR0Tt4kGEjZjgn1qSeRRRnyBbLj4
	g==
X-Received: by 2002:a05:600c:3b85:b0:488:a39a:24c2 with SMTP id 5b1f17b1804b1-488fb73e120mr45995315e9.1.1776490666619;
        Fri, 17 Apr 2026 22:37:46 -0700 (PDT)
Received: from thinkpad-cachy (adsl-178-39-113-125.adslplus.ch. [178.39.113.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c7a2sm33871755e9.1.2026.04.17.22.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:37:46 -0700 (PDT)
From: Niels Franke <nielsfranke@gmail.com>
To: westeri@kernel.org
Cc: wsa+renesas@sang-engineering.com,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niels Franke <nielsfranke@gmail.com>
Subject: [PATCH] i2c: acpi: Add ELAN0678 to i2c_acpi_force_100khz_device_ids
Date: Sat, 18 Apr 2026 07:37:19 +0200
Message-ID: <20260418053719.15766-1-nielsfranke@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN0678 touchpad (04F3:3195) found in the Lenovo ThinkPad X13
exhibits excessive smoothing when the I2C bus runs at 400KHz, making
the touchpad feel sluggish when plugged into AC power. This is the
same issue previously fixed for ELAN06FA.

The device's ACPI table (Lenovo TP-R22) specifies 0x00061A80 (400KHz)
for the I2cSerialBusV2 descriptor. Forcing the bus to 100KHz eliminates
the sluggish behavior.

Signed-off-by: Niels Franke <nielsfranke@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 2cbd31f77..96d339df0 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -372,6 +372,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 */
 	{ "DLL0945", 0 },
 	{ "ELAN06FA", 0 },
+	{ "ELAN0678", 0 },
 	{}
 };
 
-- 
2.53.0

