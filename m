Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E72367F5D
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774925588; cv=none; b=OrWeCLgmyT9LmU7cwuY5tMcRN4FfWePHf/8sbihY+NVcJguCe077gUqqppy5BTsDtZtZX5Xn84FmQyqlF/PsPbxbPtQ9ykHdbRNKdrP7pfjEdA78NbeMgKXgTvf/ZnC7Qc/oxUNvSjoAjx37xdOYtO6paGL17QPfOJMuf8/kzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774925588; c=relaxed/simple;
	bh=R40Juy3+Owhh9EBAGYTFKsMNK1+iwfY9nEhDApPpyJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOeMC9IwMp9SpvsZjKh0UQzoix0t7NBe1gp96ESX+PDGJBofelr+W8QXNKi8vDQkZP3SJbWT+ETNpk/ua9KcMYD1Up6bqOb5BhsDGGjo2DN2i81Ic3lLBf9HnSY3rO1OuhY0LiCBPcH2SLSrkmHOWLOr2ccxG49BKSLHVhfsjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKv8l7le; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKv8l7le"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so3237862a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774925587; x=1775530387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilhcaIS/tbQmsg6PWjrfVpOQh4yyfAhJzLT1EMbVKSo=;
        b=KKv8l7lefb66OzxZbb8uVgAyD0k/EfOci0F89WcoEANQtMSWGN2B6p0UlF5rPG7VS1
         DPdOfgSggo6FYnxeh88LQieGZlz/AwpvLMsBlGcM70D7DYTiwR+YQkZzerzQWb9QDybU
         NK1Xdz8xwxNfk5HtqxnzI1h+FQf6fBUFnuRMciwOeWhlV/CiTUH1xNXgO+VtFwt/fyPX
         wC1tz0fmpZmRrrr68Tk6p1PUrICEy0HJd9NC9Wf2l+3EeRCGniB+ChkqvA0kdwokY5xf
         ogONPxt1Cs66xOVMCwLvygY2izM6gPaisJKa/DwaOpGixY9f4lq3Q7OmYo4hfvWV+7M7
         wtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774925587; x=1775530387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilhcaIS/tbQmsg6PWjrfVpOQh4yyfAhJzLT1EMbVKSo=;
        b=jz2CXYDuRNwMsmNY0ODz1AslO4ksHBt5a5lmVpyrwqSd8UVQZvtDErZWfd1GvrbUOd
         eO6gqVeFg1K3OYzYHCehYv0OWFdWIsn3zYcrDH6wh/45q/V+URH8Vjv32XYcJUr6b2kJ
         PrBbnds1LzmEzCVU4HO8zLQN9ZdUPRrT+HXygv0pnEqgTwDxEElwoyUGEL5NjdVTmiUe
         E3pl+3SpC5Ra6w8nfLMSNDpvk26PWAaWyCx4M73w3LVfsGJ38mMboJ5M65KnmMxDTVWO
         n+i3qR1B/PbKiIm06ZREKz9ok2hpuySMDQZM9dwuVYstUdBSVRjJR8vTZaYJxIM4DUB/
         WnUA==
X-Forwarded-Encrypted: i=1; AJvYcCWm+UZWr3u46C5vRHNrhRBq92Vr23nRUCnKE1Dm6ecMsAwGgnDp9j9zgODMC/RuKg7fHrcHEOv4tnU6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FXLF4AWHPKN35B/t+H/QW9SPbm/tAGkRlK4cmz111MRHoriO
	sf/Hkg6Sl5O0UcR44Qqsab+jZiVAMpmgJkPGmjvwoV9LZt4BiulIlqPDM5kM+YgX
X-Gm-Gg: ATEYQzzFDi0YgsA9QFAkIHVMIJRLRFK1/gAAkfgmIkM+Q72n7aWZx+2w4v1u5z7wjmv
	EfySComRDQkUzKTIUtX7fiL3iUUQ2gLGyoyem8pdqoecDbLq7NVhyMs+dxyVj6AiWFq6Pxy9eBA
	7A3esfuOjDXZtoteAxMe2GTaUiQyNsju1Fqt/T+bhnczASC5TIza4fqpSPYjXlLDA9yH7bhfXMa
	56QLg88Pk91K/BV0t9aCc5HGltCCFX5rEihVmwd0tT1SPTvVRhA33PO6zYFbEPL8ZA457dcbHC6
	naXKzf24yVBYnl+SzsewjJ92WNXdRFOj7bSbMI/9YJKwBfesIsQtf3ndxWA3PiHr0lVe6rBaJZH
	+PRgUJayzSJTVSBBAEXd28NaEVhoH+p1UCq4gkKVAOAynUr4xLAxSIc7+W7sKwePxc3f+c9g6Rc
	Fe0LilWCMBdDg9nN1uY178wQ6baHS0jqHIp/8JPIwGOKV7pRA83NLD3A==
X-Received: by 2002:a17:90a:710:b0:35d:95eb:879a with SMTP id 98e67ed59e1d1-35d95eb8b32mr6542247a91.13.1774925586915;
        Mon, 30 Mar 2026 19:53:06 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe66fb67sm4887a91.9.2026.03.30.19.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 19:53:06 -0700 (PDT)
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
Subject: [PATCH 1/2] acpi: arm64: agdi: fix missing newline in error message
Date: Tue, 31 Mar 2026 10:52:56 +0800
Message-ID: <20260331025257.463-1-hechushiguitu666@gmail.com>
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

