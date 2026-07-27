Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7240B0ED
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154274; cv=none; b=pz5HSiTWAhSHfmOqA+B2hoBhRf935e57ndFL8KmZdwUPv9Reks7+8sv4RLMPL+P2XO18w7WtgTcboAm2JyZ9rfgoHCcIBK0NiNzhF41lEhqhbxRMKfGmr+8WbjvvYu7Q0eADzVmQn/DYzAQr8Rkd+aS4I8qTGNsYQ52e8uUs2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154274; c=relaxed/simple;
	bh=e3kFwrE54qrR7j9hf08X7x7yaGkc04oEEErLkv2k6T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFqF96mN+tGQaBMFq1XjrzlLoVCUrtdbs0ELHuNF6w0r5fJ3ptvejbS7htFnxtyj7OqKL6OE0v7TcDkaDlgl6yynnhdTNn2rhSw78DVdwY++h3GYwiYTghZZMTB2K7h2Je7wOARGA2IhPoZMcwe5vU2Z65SpA6lFp7grg4WuE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=NRwo8yqz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="NRwo8yqz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f6de72faso22580955e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154270; x=1785759070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYfNO8HaF8EPi01gt07T8qMMcubFMIJKbbLH4YUzSjU=;
        b=NRwo8yqzNQuu5kW4UhsvJ5FPerztukUJxRy6xG43Fog4unve2p7NDncCHc4PJ+Nwnb
         XN1DmIP70uCTanpVw45qOOctDV5caEgEdRdOYK6PtZ2UzGklNRXBQ+Tw79qIwORh7SNV
         smr0NhGDHyYR0xUG21as6cB/KYvKUZVnzmSdf6ELWZQxgSKUnjDMj4xc9F6ibyhTzCfh
         bfp4DY3h6w9NnVc+iWQj+zLK4OVZINDcGnNYGebtwUeAqPEGprLyUukXPORMdyBRBKOB
         8X+z5ko6cOGKsiIS51T6WUCm9o+IQL41DeWlI16zDSyZeAAExYLeoRftv+qsf8F2Ua16
         1s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154270; x=1785759070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYfNO8HaF8EPi01gt07T8qMMcubFMIJKbbLH4YUzSjU=;
        b=hnHbdJUq17s6UOmCAr35cHrrWKqxbcqj6op81xX7cJC0308ovSM2PBiUxHKn7Ssxmk
         QjuTapkx6GLpsRiPwwOPggIgP1WFn4+5/gFycLVogYHxWYBvzEqlUQ1YNvg7uNFlnh9s
         ugEepfnBVf7aOr7nhvwtVv2my4NqHYT8hIOywYUsxRRp1pLt7uOSPSPYy3AeVF/2CrbF
         eOSKQimWXKlNi5qqHbcNVe0GqXwiI4pd+bjkteW/W9yXvb9SzLSXviBrbQzFYHLgrw8F
         CeXixozhyJcEp2FBsJd9M5ABMCTwKFFgpVAkxfvAclP1jGG6SBc5hVDotoDKFFmCAkBn
         iFkg==
X-Gm-Message-State: AOJu0YwqpFfDZxTau2nyOu/N9iMhUgjYru1Yu5oyEJbnU8QvePGs6g7u
	dY2hY0MwrLT4Plj4wAV0G8H46cJLZ3G8YcUI2691bQ8mHiFQ4IkbQpI5rQTHF3aCXOU=
X-Gm-Gg: AR+sD10xIVs82yj1elq0yy6w3EHzCZU1tUWad43LwTy8rcj5ty5tKMxV7VBpXSiHsHC
	cO1BYmc5ZkslhpEeGSr+ky8IRCFlyNOvvmOKgysVQaqBKnMwm+FXe5ASQl/8xaXrmz02RLjgJpn
	xnpzjnLTiXttOHAJZjd0pHQK9l+AQeh7sap+v3YhgQdXmCdzSUGQpkC2g3D3y95dVgdtMVXOr8n
	Bmt4ALE8R4tjLTLeCtsFDsFHMi0kIIsA076vPOpNat6tRDlMwK0BShraRE6NNk0V8pWKREQkA14
	RX0x9dOK42oUyfEu0ZNlJyVaKu9wxRJnsd24hH/mbqaraWIeirrpl3+BWrvyCCS5jP3Hmz8ezqa
	0APy9WzOKg9vjQE6TLJoWDbv8uIMzPnndKfQWuEaYbM9fOfu8phdhfpmRmvTsAFzXyN09swCpMR
	FbEOHD0LPC3ilkYD6wC4q0lPospAKvBQ==
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id 5b1f17b1804b1-496b5c7182amr98814975e9.10.1785154269911;
        Mon, 27 Jul 2026 05:11:09 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:09 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:47 +0100
Subject: [PATCH 9/9] ACPI: use a named initializer for acpi_device_id::id
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-9-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=858;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=e3kFwrE54qrR7j9hf08X7x7yaGkc04oEEErLkv2k6T8=;
 b=wsRNozjg+w8drnieAF7pPxdPTk2dePtttYSw8fmP3QMndGXJ0o823SOn3yUNPQaqnRoaKa8AK
 Jq83mLuCTQUCT2D3wimXdXs1iPMiRgklDO0pAf9DdxAeyLqrdnv2PyD
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id::id field for
readability and drop setting the list terminator fields
explicitly as well to be consistent with the rest of the kernel
code.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 include/linux/acpi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 60ab50cb8930..b34b483d99f5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -805,10 +805,10 @@ int acpi_mrrm_max_mem_region(void);
 #endif
 
 #define ACPI_CMOS_RTC_IDS	\
-	{ "PNP0B00", },		\
-	{ "PNP0B01", },		\
-	{ "PNP0B02", },		\
-	{ "", }
+	{ .id = "PNP0B00" },		\
+	{ .id = "PNP0B01" },		\
+	{ .id = "PNP0B02" },		\
+	{ }
 
 extern bool cmos_rtc_platform_device_present;
 

-- 
2.43.0

