Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39126F2B0
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532689; cv=none; b=h3Wm6tB9lK9nb94rKeIWdDxZ8xNuTWjS3LwS2s2xbZ1iELA2jgZcpDrWiO2Y13et0WGhqveJXPcrkS+snmD1lrt2rfoJGbJARTfwjMqJH5uuPmP67H9e21QtvgQtU8r6ryAyo3YIenyrgNni/EBNLkuHrvFMDnplLcr4w9yhAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532689; c=relaxed/simple;
	bh=8jia67Is7m3U5EED033sbXjupheEM/ohPoGTWX6yjZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhoH8uDB4/LnvLhmwwuZ3tEBTsVbuRSzDh7Abn9iQfi+sEnKK1d6ivCZcpog0vinhs7A0Jtz4fzu97FUrb5KqS0cKf9daOj7et19j6KJPRfkMijzR4MSoBr4hO5rfWDmNJuEtYYRw0uBoRrAraJtoCtXqT86VzEj23tJwYymuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgNsJvf2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgNsJvf2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0afa0210bso22354355ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2026 20:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775532687; x=1776137487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qitX+bmjkd0T/W6dUmvnjzgJU8do1YCVLzH8yn5LDV4=;
        b=UgNsJvf24N1s98mGIkPAu5Gey6Mr7fj1yYe1E35rB5CKaq8DbBwM1FZgOxRgKG/2ZQ
         ylAAWr4sS5Nho6RHqXZCgtdbMiJk9odFlBVICXXb+oLCduKLSqsDlg73HexclFFbbd4r
         h1BlrCJASO4L1j6e7l3zmGyGGYQjRk24jAudKZLmjV6UEvw+8zd18QcZFOORn0N2YsqH
         0vHPp6tbcDFJqiusawoyLYf6zMKlWkypev4bv6anbPcssuwIKG64QKTIMcw6bhiKRCXo
         RjilMCOZFOHeuekJ1KAyxfU6ZHCZg6PLG7WjKh8JVXfS5sgybyIhQCZ3dMCKaSoK3zTY
         u2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532687; x=1776137487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qitX+bmjkd0T/W6dUmvnjzgJU8do1YCVLzH8yn5LDV4=;
        b=ZxkS1YifRMEjBHqFSlVRkeiPWcngYrLYkGOQhBsRsddPyT70k0CL2r7QeTfY+V2gT6
         eQmuzDbR1tiOfexP+PrObI+6N/NCdfWJOxv9e3RPbSACXfPjGeoQfhObHw9HOdbrZXg9
         0Xq/Oz1EbkUC3kSF1iHh9a++dWtkXUUkuL+M+YAEDSIQ6czls0k55mSSeuFvep/gd4+Q
         V7E12Uj2P7EWqSV2wwSWuBC1UL6IdhAA4DGxPD22j9JAlvwAr8uKGkOPofyQOKhjncCk
         1JmR0XAy8KF+rJgnDeCLpZgsLczvy4Pxg3LaTMkKK0xjXSTyfzenI+4IfCB6o/swlrSu
         lmFA==
X-Forwarded-Encrypted: i=1; AJvYcCUliofr43rNxFjwFEn28XE1I5304coqNsV5Eip2wY64vUwgNjYqU1tndD92otjkUcwFXNj5JqWZIaF5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtzkRlFJLZF0a1L0w/EaztCGu5d26JML4WRUOTAaH7fdyJqSU
	OjeQBQrkfYIY8RiWw8/xD7cr9JqvRqj/B63/wWtAL88y8PMarGzAT2Hs
X-Gm-Gg: AeBDiesI8SHwtLq+MHeNE60cQ7QDTmo1erhMcKaD4O0hMYdjrPczlKCPH42PvOZ1Xnz
	7+eIq3V6JCi2M/MQnsfGIXl1d0md9xJIj+LgNEc+wYcUjY6LIAt1jBVpiUA3CfAX9eihT/LSRiw
	2BZf29nIPMQNPdZYraRfsoZWL07f11eE59A3EZ05XuVkZAuP8eWa3ItW7G4DHZeitgYMQTBnnpK
	j04fkM1YoY5NQokT3nhhMIvf6lRgKmALUGeyPqYY6fGJg7MDHNPEtoNEyu5u32qtA1UYh6Ik+pc
	eN56v4OwA0qqdR3lb15o99PPPQq+ufZ+lYUykuo+Xa0BQSRk51/Mrr8YO9ksSvwQkAZeAhq+yvp
	em1swyBZAkgdB0o4w6PseyqFRIwlHXSO3kj3ShecnVTEM94sxQwpR994+mCvyxP3K/MXExbjlHi
	QObSJ4Ac5GYGwEo6IKqW1M59u1UPG5cxjFNYDV4MlqXv0m7p238y5Npt0NiDdJ5Pea
X-Received: by 2002:a17:903:388f:b0:2b2:4eec:980b with SMTP id d9443c01a7336-2b2817d87e7mr175821175ad.7.1775532687280;
        Mon, 06 Apr 2026 20:31:27 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2adc8c4ecsm9003145ad.5.2026.04.06.20.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:31:26 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoyu Lu <hechushiguitu666@gmail.com>
Subject: [PATCH v3] ACPI: AGDI: fix missing newline in error message
Date: Tue,  7 Apr 2026 11:31:15 +0800
Message-ID: <20260407033117.100-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing trailing newline to the dev_err() message
printed when SDEI event registration fails.

This keeps the error output as a properly terminated log line.

Fixes: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
---
Changes in v2:
- Change subject prefix from "acpi: arm64: agdi:" to "ACPI: AGDI:"

Changes in v3:
- Move version history below the "---" separator as per review feedback

 drivers/acpi/arm64/agdi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index feb4b2cb4618..0c2d9d6c160b 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -36,7 +36,7 @@ static int agdi_sdei_probe(struct platform_device *pdev,

 	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
+		dev_err(&pdev->dev, "Failed to register for SDEI event %d\n",
 			adata->sdei_event);
 		return err;
 	}
--
2.17.1
