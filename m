Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F6408032
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154269; cv=none; b=sbbbbsr53XCHOF8966pxroWrQt0mAFcVBAxhF7ErmIf5hDeONA9F/XLbxAYDpSnaVK0Kdog4g25J5Vxiy2jmYk8MwLzfXI7rPnIvT+iGq4Gzi8JrrzbEiADXWBK8SoewuCd8vY/aLJCNr39WLPJ3SVixrX+Eh40H32spcXXKNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154269; c=relaxed/simple;
	bh=f5yWEycCLmhwNgNs+7yltFCigM8U2L0qmiC75nRPZPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/odQylw9IKO27BhLDnvl5GmG5D82g7EDuIoEjcAiSTlNPt1JMv0zCmE2ANwZ851K8/D7LnJH1r5x6LzDaI1XMXDokVeszU1MKvlX00erfkDUsedAg8qpffuJEixNLdtI6yflpztmu/ABnbARXwypUNQ8rUeG/g8/Carc1kkqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=0DM/6X0U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="0DM/6X0U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955de8797cso16109265e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154266; x=1785759066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yngGEtXt8XdvhkSci47p7H95S2e1zfXfAmsSjMJsNNY=;
        b=0DM/6X0UeAHvgmATILO7CjqVWXyRUWmZqNQtvA57/21VIrbr+Rw6jB7daOu+gWwDwR
         zbSPGj8qRxW9TAW3TBCZEm7Bmhn/KQJObYX7825fEJMxp4sbNwlpUt06DebRk53PyQMu
         0brf4fhCMP2gnXSY2T5j9SyzjQpnKHI81waHUZy46qSrQvosgQ5rh4jY/UMx9fz5duGQ
         gRJ4gK0z4nNS+v+941blcej5Dp1rBC0o9GJ1D3IhSrAJFPvoolTVF963MJev9cA2H9Jy
         2iVWHIx9lE6uebjBqNpHk5NXqhd1oPBwm5Xi6XnoLdevlk5M8rGFmsE5BbtvVqK2xi8/
         aXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154266; x=1785759066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yngGEtXt8XdvhkSci47p7H95S2e1zfXfAmsSjMJsNNY=;
        b=MpofI7vfd6NwKIos0ZGI/7WF2o+LZGg/5tPeOCfodK1uDIr0OtTD/qSbZ8QfPMll7v
         gvDsb+utRWmru6xd9Xae9+K6WkUtHpDsP6VB5l7YJd7siaqZ5oqvW+0Q79TXx0rwYLaL
         eEGHJLB8xZMYlCHUwB1Oihn9U7W3WzNBY0UayPQCk6vELIkSuaBV6QJXLX7YaJ2Xpa2n
         tSwMQBqgqXQM0MfC6MlVwPJk+XLI/rqJ8Ehfuo0Sr9YV6tcf05meG0Y1poQ2rPOOXuC8
         UfBYXNouXKbCgwmZS21LCI6lC16wG2gfd2bpBqlXzsyda+PEpbbdDNCGolFWpIam8S1i
         WhOw==
X-Gm-Message-State: AOJu0YyUA9/S/cYiiT03jNGtXC6P1uPtNqCqgnXvCrGaRY7UUEwfZADO
	kGyBNclS3VYS/14gIfzwWG27yfmM9zusdzvbc1Rwues192DflqGHrHCe22qCbU4uCl0=
X-Gm-Gg: AR+sD100yENmg34ru6+AIv+UZTRDiksH1Yszu+osYz1lMnx8Az/3uKKU/5KfuOY7heJ
	na3bNqkcRztoltsAFuEQ0vPpB+RpFHK+RVosZ1mrPVp0dWXlv1Il0MfRNZLWa1NnXhQMhzCrwBg
	78v1bt5ujezZ/D+HA1qKoO+2FagBizdHcGepplILIKnIy9S1bEYwuDnFPxDtR1n6OZaG4rC0cLh
	gn/UQxW8F1jvVpQ0CHdAyBm9+UVmv6HUdon1Vc9DoWJczVGgjN7n0Qk0iNWm01jhlcBh7j8dseE
	Mvd07jX44Pk8t3rOPIfc/E4rudBgGdRRKABEcotsGPjkihmQb9qD9etBMFlgkZh9H0wCB5fLrWQ
	T+u8qHPAoZiTHHwehmtBiX+KRr+MiDEgIcTo+BNEF9oliWP0YjLalCjeRQXcZn4D8NT4FXwESwc
	9U5rnECC7ww+tVrSdfBV0=
X-Received: by 2002:a05:600c:5492:b0:495:7eab:3abd with SMTP id 5b1f17b1804b1-496b5736f4fmr117417715e9.33.1785154265733;
        Mon, 27 Jul 2026 05:11:05 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:05 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:45 +0100
Subject: [PATCH 7/9] ACPI: nfit: core: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-7-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=993;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=f5yWEycCLmhwNgNs+7yltFCigM8U2L0qmiC75nRPZPg=;
 b=FPBuwEoNc0FwTPiW1OLmoke/+L0vL95t8jlgufvJHvdNH2cU9i9jhCZ2SIOLvvfU3dElEbK4X
 ffdwTvMsuVIB49CLJL8HnAYzDHIg3Q2vmuDwUv6QV0kEAdHSx50UKZC
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module sets the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - used a named initializer for the
acpi_device_id::id field to increase readability and
drop explicitly setting the list terminator fields.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/nfit/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index cb771d9cadb2..5732df5d53f0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3515,8 +3515,8 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
 static const struct acpi_device_id acpi_nfit_ids[] = {
-	{ "ACPI0012", 0 },
-	{ "", 0 },
+	{ .id = "ACPI0012" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 

-- 
2.43.0

