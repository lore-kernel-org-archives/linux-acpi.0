Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07903FBEAF
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154263; cv=none; b=ak+tS7viw7Ua0ByQhtr95dGGQGAR+Jy8YGkRHM9hgt1QhJT9dolSIdng4GdCWEz1WfkWV8WBjSASKr1u07/Jaq0X9Ii4APvbAEQdWQlBZ0PbPlGOQ5diDjcHQ8AnoN2zs2cin/bh7Kd/BJoD6dLxkzXNxRb1VCvzeU42uFitY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154263; c=relaxed/simple;
	bh=P0xjQiLQXAgoqUkWLKYp5IthAsIDgkug16mJm0ZMeDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSDJ1D7l50TlAWccuGJPGJ4VF5NCK4rVN6sapoqyegO9kZjiICF/5/frsaRHKy3wEDMTT0S66sCmUmuNAgP5JfJxU1mLGobTvhvL0VVpaVQzH3MPrh7hlReSN5hu6bXZNJJJvTOEkj0QTtpQRlc15d2kTibucuCg9iWsnyTbI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=RxT8Uq8l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="RxT8Uq8l"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f904e80eeso2138582f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154259; x=1785759059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDrB+Cex1z4J7gYLaCt9VWCfPXHJCTTUZUhkbLnsi7U=;
        b=RxT8Uq8lDpGdyQuVgdNPLPNmkAToF/0rlfeebmVDzCzKCnKfJwblTSdxDwDU3Sf2Li
         ukcLkMEjnc8W+JzVG+HcRdTt5WtN7/VrsfbfRpmP/Lj1zRjguuF+3fi9Y9P7w3TYJibJ
         8guxzQSukDxbvTT/uLquo9O5HlJj+fcmzmb/APpHiH9Rq84ZGrFP8NLeuBORmzLhFBNf
         6qxg2M12HQQ9lxaQmZ5yNQNlh61PzEOfo3VQiXQt0A1Lq+A73OgcZawpjUbLHNOd+fMU
         bOafvXVUikhjiu+xjnz3Q0RWNJntjLUpYxT+1BBM3ZRolxKayy74qWh16emTsA8FrKdQ
         vobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154259; x=1785759059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDrB+Cex1z4J7gYLaCt9VWCfPXHJCTTUZUhkbLnsi7U=;
        b=nWQGdVzCaxrjcatNUyiy4pQUQZWePEBk3+Py4PoR7xjVztnKKJrOBw/fCrIHdCZj8t
         +Wo9qnEzU+BQmVmYwxMmmrNmAH3fKWg6UtjYBjpLHzzYNkCLRkme4T/wuoKIAhoJNKMW
         gW26Tt1UfYDIBJmiWIF2k4q8/byrldBTy/bacs2LToqa27By1q6SuDoPyUS2IhLg170L
         lpmStdZdu7mZUIkSZQsMqiBeh3hKIDAVXyrEmLm8FFqZqFTNaQOsFVSQePlyJQSJB8Jw
         wxVabcPAfMJFWfsl1hf6KGrtqal8FBjSdqrRQR7vldXP7upvdsUFG8gHBa6oPZRLaRMd
         mc6Q==
X-Gm-Message-State: AOJu0YwpHZr20I8aK5aPeDWxFuLfHJ5CWuMF0fF+MtXhg4+TnudXzyhL
	4N62Ua2k74q9MKJo6PG7qR1mzfD5neh5b40K34WKROK3AAlJr4LI1O8JQtl1FNKNi0I=
X-Gm-Gg: AR+sD13gOxIHlItAr0TKSUS3ru1Hdj1pzxiaV9q1XrAhweUY9e0h0INoOGRcpHTrb/g
	+ChRXDQhsefKoRmWH0tPEhsrqFIkiHSXAcC2Pb8khb6tFbQFl6hO9VQa9FLEckOSnHfJGCBvfD6
	/eI8i/pI8aHEKbSGCpy4ZX31XDFnCBIPbTqYpBVgPJYr8XwQgIBNBO5Nq6vtY/wfx9FI7MsEh5b
	O4lg9OQR700FGKus4wBn+c6ocPsMupGM22SDEfNcGCnSOwCrPrRVG1ezURVnAgi6h9eGbSIdbH+
	bR7AP1SzyrpSgVPeM9H1bt3wOvTAG5cWu2tSDuawHp264/CgLZ1YMAyCRSXJ0Ffy0uWyTuEpZzt
	/+vrVwUwW8kUMz9Wfufkr2REdB6hNcbzBBSv8T3IFKFqF5Nb99osuT1rBg8fOF7B+0yo+08ZXyF
	Vp1h0V8dhcM4pBntYicQk=
X-Received: by 2002:a05:600c:8b4c:b0:495:67b8:d97e with SMTP id 5b1f17b1804b1-496b57081c7mr107464815e9.30.1785154258767;
        Mon, 27 Jul 2026 05:10:58 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:10:58 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:41 +0100
Subject: [PATCH 3/9] ACPI: pci: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-3-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=1501;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=P0xjQiLQXAgoqUkWLKYp5IthAsIDgkug16mJm0ZMeDg=;
 b=PNFz3+JEcuHTQLycUVytg5ZW5oWUuiIlRW2Ta2z8sj1QeOuxPAHaLQUtnCCOg9lGVoNYFi7nQ
 NZeOOGrRDxRBKbRpZ1rCkozuEsM743rRRDZUOoTKiqtbhh9ZdcPagk0
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

These modules set the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - used a named initializer for the
acpi_device_id::id field to increase readability and
drop explicitly setting the list terminator fields.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/pci_link.c | 4 ++--
 drivers/acpi/pci_root.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index e6ed13aee48d..276dd36aaf23 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -36,8 +36,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 static void acpi_pci_link_remove(struct acpi_device *device);
 
 static const struct acpi_device_id link_device_ids[] = {
-	{"PNP0C0F", 0},
-	{"", 0},
+	{ .id = "PNP0C0F" },
+	{ }
 };
 
 static struct acpi_scan_handler pci_link_handler = {
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..a129cb0c0a36 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -40,8 +40,8 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 				| OSC_PCI_MSI_SUPPORT)
 
 static const struct acpi_device_id root_device_ids[] = {
-	{"PNP0A03", 0},
-	{"", 0},
+	{ .id = "PNP0A03" },
+	{ }
 };
 
 static struct acpi_scan_handler pci_root_handler = {

-- 
2.43.0

