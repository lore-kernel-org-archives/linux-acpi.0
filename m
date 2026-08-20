Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67544065F
	for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787197749; cv=none; b=Tq3mJfhAMGLXLAsuJngetUtDl02kEGB2L43kPkX59tjkOgv73HsaOzO5pslaKyiXL6jKhqpB0VBaocBn+PDvbr9gihwaDiXhqbhDfzmJCwMWD60Ism7+jf0tkTXXu06y3WMIknPm7Zv6otoog1CnN2EQze9yPnLGJhUQQdmAosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787197749; c=relaxed/simple;
	bh=gwl2K2qi0+QHOxwi7ejH9gI928jpGhRvGjrKq4JHIYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEk9MUcil6kytdPzo7QUacCdg8U/dhxb+xBmpjP07PraPFBSrM+67ULY9YwVDYpK+ooarQwQE6sM34VZstLGnBw2QrdPANjy6uj58OY/E/9IwTknc1k5EvIzNqnMAiGzuFdVrGXbQuaHof07Wxt/NpBI8nW2EBBhAx7sGK3mhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aujxyajj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aujxyajj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caed617615so18683085ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787197748; x=1787802548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKTsWDPLPqyEKmAz0VQAquog83aYLQqUOwynHs/aX2A=;
        b=aujxyajjDvneVtO2+U0jy6PWgxuBJAh8LUmOzcZZ66NUg5DADIuvQWpBCc5fReu/Tb
         AZxfpubyjXDuq+fd6d7IkhbVeFNVOR4D63oYcM+wVPmAjTLGUcRJSlcB9VB43BmA6jQs
         KgIZO6Jj2iwdaCgWmPK3DH3KOaS324nCnE8AvhFOMsQdP1ribKcj2ng7w6TVGWsi+tgs
         xSnyJRh9XfQDqUcdJdsuARR6egeE0r+f9GzeC3ZMjJ84WEUXrdzXrh0PuNni26Ro9jkp
         jHeYxjWqJSdtGSUBVh1lkhrYMVzwC2U+iGvLrh5r6qsDne9tZMLX4Z1YGixI/P85lcR7
         acuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787197748; x=1787802548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKTsWDPLPqyEKmAz0VQAquog83aYLQqUOwynHs/aX2A=;
        b=IjfmG1Jj4y1ELRVbyK5y/Nll1m+2FnDCOvqQU238IGH18CsL26fzibLIKEyij6eG90
         MDa/nlqauYxKzjNmM7ZBMdvoY5vKTD56MrfIshD276OrpibUozwT5OwsYNxVJfG2gmw0
         u/X0iRwCxStFflTS4MlxPlUNdLKOWfQPe4Rc5n/q4CFqEh4BSsJwMdSCP+OgZDTC5B/+
         yXJBqOVB/uFam4f27i/St9R/zrYkywS2+kloGTMNSyN3jGkGr8/41F9RzJK6FtLLqfzM
         1XO4AknLk8cWWinpirQhff6hX7TwG5ypq1x+Phb5JolJazFJwZTtK00SQUBKL/TLpHQB
         DTYg==
X-Forwarded-Encrypted: i=1; AHgh+RrvUflSpA7op6Rl65Z9aDRCRyzk9QVDQNEXDrLq+e+XZfIK1GxFLa0BJTZg4aEO2ydRgFyovXmPMdmx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4d5iWgs1onYTsiu76Vq0g1Gzm9tXpM0Ux3onU1JgFZ+vX8iUb
	kBqX69ZGvRT8h5RhF/tld3taeqNbvfGEZUdH9y3rQNtUixXNlZIBvOU=
X-Gm-Gg: AR+sD12Byy+4gtarPTa9wFz0LHuD9aYgodsP0//lxwlwVqtvt92Jwq9hmWAWrYcVdYf
	JA1t2VLBHgv+z1b1At9xF1yVLq2Zk4NwayPxdjBOMRTON7QXwosKaUJlwh8MfKXk97me7neYbkH
	ooCZoN6xfRBp79+Zq2ZQmylTOENG8fIYZhPKBWMJ2sEaxLYwG3D68I7yfmPeKRs4J4FI/CUEKeZ
	ah3moowxMr68AGqe5D7Is/eNcWiUifsgA6I27mhJi+2jg5eIuD8HvAyvZLTPlLg4VOmRiw0sAST
	TTnYUjcU8qmdiWAIr0H4FPf71BlCdzm8czdI+3dX0e9/oxWw+g42jFvZcJhE8A2+O/DWlSMCyUA
	5JP+wKzeAlDkxwf5M82HKObRKQRPgTvnbKZv9umVIKr3xXUqBoJ8hwnIxmLOwE2n88Eo6oqMRn4
	vBBpx6PoECzPlwxKdmaMcMwMgNXiNX5vPeGY6HpNkPy7S5AhW8YqmUtDios9o7F3RFjt9BT2aRh
	9YxJ0yP99c=
X-Received: by 2002:a05:6a21:4d18:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3cd01733ff0mr17450675637.7.1787197747784;
        Wed, 19 Aug 2026 20:49:07 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523489fsm1279229a12.5.2026.08.19.20.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:49:07 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] ACPI: SBS: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Thu, 20 Aug 2026 10:48:48 +0700
Message-ID: <20260820034848.1693724-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS

Also use pm_sleep_ptr() when assigning the ops to the driver.
This allows the removal of the ifdef CONFIG_PM_SLEEP.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/acpi/sbs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 86b7c7975852..543ca5f0defa 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -692,17 +692,13 @@ static void acpi_sbs_remove(struct platform_device *pdev)
 	kfree(sbs);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int acpi_sbs_resume(struct device *dev)
 {
 	acpi_sbs_callback(dev_get_drvdata(dev));
 	return 0;
 }
-#else
-#define acpi_sbs_resume NULL
-#endif
 
-static SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
 
 static struct platform_driver acpi_sbs_driver = {
 	.probe = acpi_sbs_probe,
@@ -710,7 +706,7 @@ static struct platform_driver acpi_sbs_driver = {
 	.driver = {
 		.name = "acpi-sbs",
 		.acpi_match_table = sbs_device_ids,
-		.pm = &acpi_sbs_pm,
+		.pm = pm_sleep_ptr(&acpi_sbs_pm),
 	},
 };
 
-- 
2.53.0

