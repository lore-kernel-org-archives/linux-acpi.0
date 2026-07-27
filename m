Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B313F4DF8
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154265; cv=none; b=QLjsDpGyDByWWbkd6aXaCG2LYYB1RonzzgeGbh2Ww7qnFz3mU4qpK1fG+qglXA0XHc1I+bqe+a1M3agVoNCelJC3rJY8HcM5Xq9wG4oveTXGYVhrXTMAj0GEPhZJHw1OvJ8HQDR6uh420G6pmNiFp6/OKAGVP+R369r3SkBAPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154265; c=relaxed/simple;
	bh=zrA6C2Wn6O6irBjX1A7U6/j0mruV7VakTyxcAWQ/gzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO3t6lorjZhs2DWHcC7AlL+ydivQMSTUG4mip8L45rBtodPjThoEDfvw+9r3aGqlyM0bc1DQJLThYigf2wdAkBQZu+VHH1rWClAaUg2OQXSg5etrCEby4BkFerIJjAvvTRVtAH9HJgbis/ncM7JMfm85IACbu0j9SHG1Lw3Px5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=oEBuiUli; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="oEBuiUli"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so25964655e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154260; x=1785759060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1gHEnus99pEhhk1X+Z0rEei8S8+ToTCVA6TNsBFI+8=;
        b=oEBuiUlitaPuWDqFDtpvUpIh+HMwiOT0NK1GwTnsfR0B6FUM7rMjY2868DJKvyPBvQ
         WcUCWTOZbrsXg4HYjhhmoZQDvat0XqwmCDxZ03ZASKgClzanhoPMKpwG3UB0aIiBz1ey
         CFk2pfkNe9/sioaWPszX8HbLcQqFMIPBs0Grk+yreTmGBDuA2qxck3jL26jg3gsWcmd1
         bG6FTz9jnLmspoJC/XaVuxTPuDV2qzRK4MN8uDNaKpjM0pF599B776b6ebSf3JZ0BGTU
         t2cqSC6cCtyG5B37MNBDGK8helxBqa38Qo+eWhWPLrGhijmBMKzli5S0lw5pqCEHyBo1
         +aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154260; x=1785759060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1gHEnus99pEhhk1X+Z0rEei8S8+ToTCVA6TNsBFI+8=;
        b=J0HQ6FsD4d1S7bnYQL89xFF1FUK+J/pRbqLh1hgR+mpCkpra6McpkW5w7LXbpSxwfX
         tMl/3zhqTSh8xP8ZOJCS7IexgHDheO1MKW+8Hx2yrngAKrvbNHHt1oOhhVY1QPH8Kv1Q
         bTRsT6NVjQayifWmGecXq16la2NTIeNSy+uP+HjxN5HyQaeedqdvLBDElVyC/Q4lJlRe
         wNUYIH1hbmc39tnLv9OhZtpFJKnmDgNgJfWU6GGVgAfWEejS5TY3IbgPbYZsLi3t34+5
         eSuCPAg2GUiQTtFP6kEUzr2l9yVTWOJCgsC8wArJ0pjTWiHpEJBzYP7K7D+9z3X6YWXI
         ugaQ==
X-Gm-Message-State: AOJu0Yw0s5GsI1B3dMuGrubatEYsKLD6yTPo5raDQFRDWxlBXdbD0Aew
	Wo6sgiywk19w9Z7/hrMDSupnLlrbf7HYPVMvQBgUtkm3VJkB6gh86M0RzhoG9tALPuU=
X-Gm-Gg: AR+sD13YqKHBn6rI2gvzDD2u5JHnj+Q5us0yLhHO823774D0c6kRIxVPzXpGGvRQWiF
	ZUQUjAPfyp/QYzcorQOXykU3YwaIgsZSVI8cCygl8gf+v1B9nQAhUe2HKVtosbeed1yVl3CHc7X
	OD1RcthMlclKGqX+4vFPn1cJ/g7SlBOiD476bpPruXVpwPYSmKGQGQHGbNW6D2I7kghFO8HwfXe
	nDk6khDfIaa5BSS2rDsgac5MVXFqB3XwuJ4KPlFBnQHbKUQ3qPBc0fVQwuky+tGQ4xD3NhJxXNA
	AIx90mR+diKJkaKRGcUij31mSuCIKoQdYwBPofExJDyr0Fu8rmg8bCrMLhi/E7FAFmjD0a385pt
	5pLrgjFoJvJeQtd9f57WGRtwnBfMUiPYjEwb/7VfEMMQP0jza0ptJkEkJWCHPyyv7e/tEtNGrFe
	xxpByyJnXq2As25euyWdpH0cCJu6xF2A==
X-Received: by 2002:a05:600c:1906:b0:495:6b8a:5227 with SMTP id 5b1f17b1804b1-496b56ff17cmr116342545e9.23.1785154260529;
        Mon, 27 Jul 2026 05:11:00 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:00 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:42 +0100
Subject: [PATCH 4/9] ACPI: ghes-nvidia: use a named initializer for
 acpi_device_id::id
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-4-ff900aa326ee@thegoodpenguin.co.uk>
References: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
 Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 nvdimm@lists.linux.dev, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=732;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=zrA6C2Wn6O6irBjX1A7U6/j0mruV7VakTyxcAWQ/gzY=;
 b=S6PIbfdwzeRS6uAnwlEAg/bFB4cywsN5K95TfQqHoJbODLCpFQlWBQM/pWKmzNszJMLADygl2
 HXSTp5kuGaRAoubKt8FGxqKuHW3tvNk9iqIksjW5VI4dh0qwHh6QbLA
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id::id field for
readability.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/apei/ghes-nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index 597275d81de8..1d3a6997a019 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -130,7 +130,7 @@ static int nvidia_ghes_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
-	{ "NVDA2012" },
+	{ .id = "NVDA2012" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);

-- 
2.43.0

