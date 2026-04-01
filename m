Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EE33F5B4
	for <linux-acpi@vger.kernel.org>; Wed,  1 Apr 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010613; cv=none; b=XCmZOIsmDI8cVy2P48LKMx+3kOyenwWJ9vypcYeM1JMtOb+0oe2VcM51ro+HPFpzmQgOBRgmFGKxKF2iDoBensK02oTuGldc+DsbnCEiMiOTTi7mzSAlXUzUf5HvCnuIKrENbfgJ5s8BNvZbE9/2Pq05VRBWt8mCnuqqvQfzxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010613; c=relaxed/simple;
	bh=zvkcBEqh/jDqQTe9s+XIQDMewdcXVDODI24G6WA9YJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NE+tcdOPSMJrEPPBAjdxBcNFA+cIpzS12WHLzoQ6+kF1kI7Z20EhtbX3mCo9TJ6EaoheU72Fwr+1tNqtYamHWJn4+6y0rw7powZFV2U/Qzde56c+fZDPoTLB9afW4ZYADsGA37Wxj+eOfmifB0tMnNwHMvMAgj4CQMfYq/+Zg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN2kbjD4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN2kbjD4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b23f90f53aso39706215ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775010608; x=1775615408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uU6xSYE0T+TCq9LtlZpBqruvjiamhGaYf3vCeGkc/3w=;
        b=aN2kbjD4tTPE6pErD8jk5mYP1633Ev2IuVe0J0a+Ee3hzn1Nk2eGYlPo3GAA8QNQVr
         7ni8LZsMNYpfoj3L0SUB7A3Agc01a3M8tl//ty8UdOepbZcjsWC5z5qyKo/wo5tqiiCe
         7pbZNqix7bD3MwjaSy/HBzoPsolcam51fAENHfHtoOFKbFJb2bPXGfcj7x4VJ3q29GgM
         Vhy5pbp6IOlqn+bE647zTAgjzmg7Y+YcEfOYXmo13GFN0Tbn6RYx0FT9TbDrgC5oLIjY
         +3T8ody6hlZo7nCx/u/R3wD5YT4WRG+APCw8J86V8fuhPapHCr5exR/aOQ1w0N+bLThb
         8zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775010608; x=1775615408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU6xSYE0T+TCq9LtlZpBqruvjiamhGaYf3vCeGkc/3w=;
        b=rHzyFqhn+Foj9mrsVvf0UJMJgo5X3vy7cHNUr2hiPluG/KZOeJriMA747YXa+nnG6s
         5kNdyayRTGTxW4Nzb3KQUfUwGmBHmcBv77Sy25WPWl5+ZSMv6uoiIkSX3Owt1n6AuZg+
         i6sgHjXyZ8szhVx2ugqJ2ioK2FS6bkAff6Eit7XVqQwbbjrn1E2PRAK0tMYJAUlbmo10
         sjaVxwtLZk5reboaXFc2lNFqu7I0qy+goNJUxaszxHPCm9MX09oD9M72zaL8ksyZ3j5X
         JO5OVK/QsH7eum4jEcX7fec9ma6qNdfiSdi7EoDVePqcAJULLBBGUUgwk0wlK0rLBCLy
         SGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcJCNq9c4RgOEFzCN97S9ScrFIjSAz6m/L9Wocc9ERQ6SB5w4qudXvz0HfWddHLWyolhtc7AQ2fgw9@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWhrUWgQtkPxD5dc7hpd9cQunap7sLo3ZJgSb03tVXYKVglYo
	FIvJe9kjxQFfdo+N+R3lj1uZsG9ONKgKMVyQH8hJDj3KsWpdJFGVOKBeFvRMu+6Y
X-Gm-Gg: ATEYQzxG+efpre4iX8Gbsimv6XvYpcI+2Wgtovqy8XiOwrgVgSKBnJckeinmOHaGfLL
	eGUGcQnpaRlZmSDEabZyqAXmZcB0EmtsiRX0lexU0OnqIsxQmHJLl1oxjsdzzK+LXrDLSDJAVQM
	KnpowyHF7VMRWb2ikPL+2iTXqdncFeuWK/9kqC3j17XqtrXgi94pKQevPwpWi5Jw6Yk2tUmiXFy
	NZIEU8pChg4eUp1duVo5pzmKy87XgJxWu7CNq87fFk8sgJHTNiRSUaEAT3VII88x+2+BMJvyQkv
	rvSKfNmXZuWduMDYq+FGQxe/8AVwCGawoibZ0mSpV8W09/8zjREtdo2SsSAffIlo/TD3fvRtl/x
	b7MqtyCIewsDQnRruo7JJ3vj+1CFmhGP0VHHqhZvNCCKP/8jf9ioSF4XQLkS4Rr9LsXZJBFG+G7
	3u3ZIqthVljN5tT2sXRFcxMADkdt7vOhwIXcfmcuWXu4EkJo84G5E=
X-Received: by 2002:a17:903:2b0c:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2b269cffdefmr15058905ad.23.1775010607797;
        Tue, 31 Mar 2026 19:30:07 -0700 (PDT)
Received: from ZC-202510311500 ([123.139.39.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b25ca51aefsm64331575ad.16.2026.03.31.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:30:07 -0700 (PDT)
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
Subject: [PATCH v2] ACPI: AGDI: fix missing newline in error message
Date: Wed,  1 Apr 2026 10:29:56 +0800
Message-ID: <20260401022957.611-1-hechushiguitu666@gmail.com>
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

Changes in v2:
- Change subject prefix from "acpi: arm64: agdi:" to "ACPI: AGDI:"

Fixes: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
---
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
