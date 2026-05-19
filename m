Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CF3A1A56
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174050; cv=none; b=tKXsL5t6B++pxksbyg1nkB0UxVKxbRgMpaSXIZYInLltetqXA2EcrVgrCFL1MSnPul0nQMxFSyndOgYhs8B+YKl3aso++IZh8P797L+qwOcqcPUvILm/ycPLbV7BNdPPua+5pDAqxlnS1yzLk8XpHTLuDeCpgoDt7xL0ql4fRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174050; c=relaxed/simple;
	bh=ZO+sueJVrR69Zhx9fYyKQVNvrfhpta1Aq5px2+ybHl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSc9dVmpLoJL7omjnkMyJ6MrHlUNoLg6jXkpYp+C271i9rG4e90BJB9x3QhWCltni5XgFnHEUuK4iz4jxlzc5BslyZGhNfg5TTP+63jqlaxibeTtGx/YnPF7AxQ7HwDGMe7CQc8tC4fr+b3dHIHmy8WvqcTUdGdKl/X+s7BLNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYqobdPY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYqobdPY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso24705335e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174047; x=1779778847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaZKCHeIzJcYq9VGQ5atd5s4RbOR0sd+cuGJOBOqccs=;
        b=SYqobdPYf3U9cm+blOFuda9VMItNavprmCoFhDxJRbqEaLZj+OArQ4CaywgKRotCd9
         0CV9Rm5rAEDR8uY1S/bW2sqM07of+hXOmwZ81thO5mLoGJr0a26rTqgY5wsRX1Wx5dYg
         LBADCVhzel30E1gU94rEp/PrzhLKcmDdLPbKZL3b+gTYe/1zBPJBuFG+zidQPuKo0y3O
         ywz4zKvjDaNA0JsdpdGuVmJVWRVZL+rekhpK63hV9RZmSSnbOj5646mvpbKMHF0+tq7L
         P7MiGQ17qiJcDG17U0kDcSkroDq+skGF2WDFz9F+khKN54epcAe2dU/jpUV76bpOTcty
         rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174047; x=1779778847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZaZKCHeIzJcYq9VGQ5atd5s4RbOR0sd+cuGJOBOqccs=;
        b=XwYDCZESAR6ctG87QvYHMBbFag91DnK/RvL2PtSmL9qSu+I47vnvDI67PRUUpo5eDM
         ovqYM54wDKCPQLkfuElR6XIXPIo5RvhcxKHjZpooPt4iihUTbTVQJpAokBxrQJWkFuVU
         7zL4S6KhSxWcp/Ts51OcZqWWT5KaHB9zbpuv2wk6ZO59q/5zYZYa/XVnR1igNXz29GBV
         H/4nor+NGAnRDLx4qL/jGJ70IpODHYNoJr95YxnwdoPSYUA72foNvc9lFQ8yu51d00ir
         AFaKRxQfV/euldayx5EbV4cIAHY35/ATahVuH6Z+8yPFxbFCIvdW/5GqRhikZFJhc9/0
         2QVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+c9nCPhlzXqueaFXU3a1TnKwu9F7ZAFUotv7xlLEXWoNUW7RnlQHxwg5XafxgPaopx47+xlhVwMY6E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WTHhW/HTmWh6HMYysDNDpvG9LwzrYjM3CJ3Pb4SFIAZ3ruK4
	5WVfTgnMBBgTXN0J4ja9/rJBL5h1+6hAsp+zJ17Xc4YtKRWW3K5JNIo3
X-Gm-Gg: Acq92OE4YH8pTiK/YbySeNYFAebzGP0FB6sX6sjEkKIaO42HvQWyiyv4/F5bNpJrWIg
	Z/HhTQb+jXv/O9Tx95ySV087TiEkWE7QSTvEr8FsnK6fZiW0+dux+xLH255VbeMhJkDYPGRZgK5
	mZgBbzGDlUPgu28aBloGPi2cUK0TpluQKh1Ybe8WzhASbeHvaHsoopkwwSHh+O3eWCx5WxyM/+r
	U5kHGCWDX/AoS7Mln7KI1kyvYQbSUvHJtoXfO91lhb31KUomX0kheWzd/oHzVe2TzcQQRpy/xc4
	8g2UN+QWPA+28JorvnpK96xgO6GQ+VxXm03F2DFWFr+AwxF7rvat5WABv0ejR6xnCemS/d+Er2b
	CGmwsg49cGPpqqe8OUp83MP5BGycyW6sOv25DRfnaoLs5zpoPZFM1qzP3eqK1fxdE/LB9aUd+Bu
	l0z3xB8MltYAybWaKObHg=
X-Received: by 2002:a05:600c:a406:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-48fe632a02fmr239198495e9.22.1779174046426;
        Tue, 19 May 2026 00:00:46 -0700 (PDT)
Received: from G614PR ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm149177055e9.4.2026.05.19.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:00:45 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mscardovi95@gmail.com,
	westeri@kernel.org
Subject: [PATCH 2/2] gpiolib: acpi: Fix resource leak in OpRegion cleanup path
Date: Tue, 19 May 2026 09:00:31 +0200
Message-ID: <20260519070039.9280-3-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070039.9280-1-mscardovi95@gmail.com>
References: <20260518103302.GO84797@black.igk.intel.com>
 <20260519070039.9280-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If acpi_remove_address_space_handler() fails, the cleanup function
acpi_gpiochip_free_regions() previously returned early. This leaks
the connections list and all requested GPIO descriptors.

Remove the early return statement so that connection cleanup and freeing
of descriptors are always executed, preventing memory leaks in teardown
failure paths.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index d381631ba6f0..b6f2af23b204 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1239,7 +1239,6 @@ static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
 	if (ACPI_FAILURE(status)) {
 		dev_err(chip->parent,
 			"Failed to remove GPIO OpRegion handler\n");
-		return;
 	}
 
 	list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) {
-- 
2.54.0

