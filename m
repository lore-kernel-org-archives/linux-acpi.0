Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E0400968
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154266; cv=none; b=PHOiO92JyWbSu7d8tJUl0g2wpyY+SgjO+UYUZY+D/YDGfrt9Xt+F5Ou8h3UDZyCaGMLAxEIRW+KVMsxOC9jfnoptc1WIXo9TmVO/cadNxnpgFiPj+6Q3OBJjBFn+gshNGI3oQA8HSUamlOoKCDW5zfOOHAIZ1nEoSYrOvMLBmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154266; c=relaxed/simple;
	bh=Lbvh7ljIparNEO5uJ2mabx3TClqFF5XzLm3/VRCVAl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkcTDjx10nzUvgH6AFTMx8T8RzM5rgDjCnPQCmRx56JO7eZ0lRhVdM0C0tc96d74F8aNI3gyzG5yJKBZZaPffSLvrajkUMqp5aQ8QprFtQ+Sohr444LyuxPvzb8nvLQWmVYJ26Hwx4uaAHWDcKa6h4Z8DJKc955vw1D6H1Qn3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=ootkLIzG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="ootkLIzG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so29353445e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154262; x=1785759062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34/3xpWJfuscYnym0h0qM9v01c2NqgtLDv6AlT7mmYc=;
        b=ootkLIzGvpZ8hTFTys130cRlvEuK0emcLXpFSVv4kLwJl9OvX2wNfwP7Rh2iMuaa/F
         kKSjgvyifM07ssZ4w0PppcQLhWJlq1tXdMAsqKSAkZL9ElbdzyNhBF9JAcZy66d3eLLc
         FTml5vA5+t3mZ+t36kkA1FXrxUE/DTG3+1hy9bgcyFcFuTywToYiIkcmv5MQMIv/4Ber
         xNMHR/YTDaNhGge99hs9UWrvWCGmxzuI1vhpRrU49Y28P/H9JyZQXjHW9FT5cxUTcBNq
         HLVuLTMU0P7k3h+BmJ5GUV2xcy9FN1V1N/0Qk7oif9Sr8Mnn5jFAUixGgMs5k4POPUOe
         Tg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154262; x=1785759062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34/3xpWJfuscYnym0h0qM9v01c2NqgtLDv6AlT7mmYc=;
        b=Mh6Tb1pxPj8/iSrBiFIhQ9pjZNtXzVl4c8lPZb8YepeD84IELfXq4AnWq84J+hokCo
         AJV+Xn8KUMwdcql8QP/N1riLgccFKl4zplkVAp2LfpKR1ct5BIK9uHOThqAMzyuADjIy
         l2rHYG2IJaWmQiEl8GYiuo1JH5WWbw8yxeWHu7gSsUQsYGFzFLpaZHZs22snqb4V33eE
         mjQGwTfKsKvTN0tcAYUxJ6qUr4Pwaj/nekIhTO+IyMFzxxWN0yihC6cBuUjk4GWICMzQ
         bpDrgQ2t07ICuWpEdj9VaswiZg9vxFICzsFEMoII9IY7+7Ubf4k6KpTtsxTPX7nUO2Lq
         1Njg==
X-Gm-Message-State: AOJu0YwuT/EOhXABHUDBXTMBTb+eEROGsAf2PiKGc7X7xghqzxuRb0hC
	hqlfvk0ivf0l5kBaJxnal5n1rleX+qJa1gWq4sHHmuvEnD5EXUHiM/Ud/Ogb3Ule/vQ=
X-Gm-Gg: AR+sD13wp1s0dCLtApDC03G42Qm3YZm953slgWkoV17qcBrVFecWUo1C/x1kWzsRHuU
	js4v7RpcZ832KCUT9PuVIVCErYK4oLRCQ2FuVO4pZUyTpNTQlb+Dulsz73jXrycwzgzLaH5uI/5
	lHM3mCm1K1rcDSt8+HA3HN9s8fK+H6esek3bE2qYwYVj/ueZZzS5wp7XlfTPuR4jD/3Sdra6XA8
	pP6ogHFftVCPoxczdCU040lYme15TOv1GMWwhZTM7nFxp9bYX8etGMq1ulBYsq6Nb0C4CAcUTlP
	X9KeQF0sVdRb1PLBesm/XWfpd/gkvC41ZO5XtH0PmCxXn4mXF/4u6VhxPbyj+Ta8qLRVq9ZkOg/
	BIulH9+DE2oI9NZG9m3lLQsJ3YIhvAR9Gb9NOBmACD050nkRWj6KPe5Yk8GdtUlJTrBjxe9cog7
	I29fetxYkb5SYGQ/ns9BZ+O5jlKcO7GOt7UtxOybT4blZT9WrFdk2zKzBYebIIfHyDHGOKHODd0
	T1Q3Z0Pnwk42sV4
X-Received: by 2002:a05:600c:3ba0:b0:496:bba5:33a9 with SMTP id 5b1f17b1804b1-496bba535fdmr82232185e9.34.1785154262149;
        Mon, 27 Jul 2026 05:11:02 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:01 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:43 +0100
Subject: [PATCH 5/9] ACPI: amba: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-5-ff900aa326ee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=1054;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=Lbvh7ljIparNEO5uJ2mabx3TClqFF5XzLm3/VRCVAl8=;
 b=judU8sVVfRgrI+5ADeNtDthotqk9x8BTWf+Syrfpzb+YAyTvlO80HNFr3Ji8L5bsisVb/rkxu
 cQqASkV+g7XBfSqQvy8iMLH8daT2jimlaAqGe1JXLVIWuI6rYuSAZe+
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
 drivers/acpi/arm64/amba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 1350083bce5f..e32b37a2126d 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -20,9 +20,9 @@
 #include "init.h"
 
 static const struct acpi_device_id amba_id_list[] = {
-	{"ARMH0061", 0}, /* PL061 GPIO Device */
-	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
-	{"", 0},
+	{ .id = "ARMH0061" }, /* PL061 GPIO Device */
+	{ .id = "ARMH0330" }, /* ARM DMA Controller DMA-330 */
+	{ }
 };
 
 static void amba_register_dummy_clk(void)

-- 
2.43.0

