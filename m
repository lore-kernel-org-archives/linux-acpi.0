Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678644D014
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169419; cv=none; b=aOv/E/KBEmWKBegyYvFVeywXQxVQ5i82bFEKkwDg+3s6keAvVVryNgi/qvw/qCpWaMLYfGvYKA8j2pf4ZONs/GILjWb+Qu+Giz/s2ZT3bDyMGk2anM9z9I+Lrs1ci5z1c5u3/laksmFzGsJxNs3zEMLTCx5Pd4SRtxUpABBNe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169419; c=relaxed/simple;
	bh=kCWj/tihXQyj2JmnfTQXy+jrNeLIqAeRIffTZPiuv4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr6ISl88B6+6JZ5AtqfZpSrvDkwfiQbYwZkG7AsyJdWfMykcOfdz+lYZhtfG66Hn3+JS+x4LFkYyiP9nlnl1Fuuix5idfcCN2EF5NqMmyzHoQ+zlS5nA636jYhM7CALeFaZ4b1ib8ZDNIxtIfcRnWtTr5lQKFYXWkjym3uKJoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=px4K6q4V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="px4K6q4V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4526a8170ceso610074f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169416; x=1778774216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjkaLOp1lKw94U0v3DXhZH965s0rAW5C1WAv92gzk9U=;
        b=px4K6q4Vz3ZsCk6NibOYvrQfC107fLNOwzU1iqTUlB+TdfHo3UJVdU+rutdw977ahI
         tS35CgPqhaZVz8jhY1JuIuX2xBtmN9BM2nx4GvHQSgtNQFdxP0Db0dxp+m8/iiPeI7HL
         8Bkvp4NSGHAystoI/8ouPSJdQVR32mMkU/Yksi9mOXepbey+x6TAGEl/xnZL+5GS65yB
         bkyvrSLePrKsFZl2VKZlqvBMV1zw37TOyKx8i/YXsq9Mlg57lyMO/ZeX3aoe/IHzI3wr
         b4kICpjsjrpo2wAwMRHFKjUGOrHCkVcdSBqhIZLITgliM81yPmTxBgHxi4QMFY8JZwjR
         B/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169416; x=1778774216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjkaLOp1lKw94U0v3DXhZH965s0rAW5C1WAv92gzk9U=;
        b=FVPuq7SdQevsxVqc5PanHgdlAAErcqC8mzrpduiBme+bHkp3PSptSWYBppew7NM+93
         PsfP5+T9j7wfIslP7AaIYwCPv2DSknpMFDfVtDdv+QLkRTxL4MAnnRFuBnVSUc7UwlTM
         2+Rnr4ed5+K1rOLSFkYwgMfKBTTMUzxZOH34892e3YlSstzCJGcGvTrndHSqH1em4J6b
         f5eGnnkBcVLBF1xcjT2MiSAR5+h29jZ9QvfYDPfF5yUZMm4X2wnkJUPatSKqKhMZHHi4
         S06hdw7AvlqM0C7PmE73QWXvycmFlQixQg/i8ZSzJ4s2V2RbTQ9eMCdjg+y6fWOOZEg0
         SSog==
X-Forwarded-Encrypted: i=1; AFNElJ8iipxHwXQ9pNEdOiTmPqZbXePodhC5RjbzUPoXjLqsfxt3LFtDkULSMkb4wHsFRxmaYQEPNfwxuUUD@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyi4bMfcVgVAjJ5kfmiKK6mKUpgznyeh9CNGRNbQeE8c+sMK0
	70vCRFDDXixiOyQ6WOGb5BY1P9MyQyyNVxSPR0k1mPAmZQs/IZZC4xRDqCOBZqDevu+u8w==
X-Gm-Gg: AeBDiesLzcPJbL/GmqqDI2wRBBI8uu3eiTAs57w0nd2SY2DTy1quTrmlx3xT8wrJJEy
	bXBbBC3/gViEqDDcGgAP7pDPYBDJ+dYNmXicKtUrnAT8/QxkF8AI45LiY2XN4STei97cbQ3/XMh
	rmu26Yf0bW66nbT7Jk6B3KA4pyI96pU7wkV34tSru/7iwPvyLwroSQSGjaZB6QgbB9Ivd2xzLQ3
	V71HQwGbqc3T6ZQ/eJniM87S2G8vgw2o0ROlMDDDWkbmaiortfppT1x9qnU0KNGPO4fXkk5OlD8
	aUurSCawjDDDeEtczuLjwMf5SBlXonRO++WX2f1q5I23Z6e+bOY2msdpUs0fS+PePPxC47JVnCW
	MrNx3s0pj8ygBYF6M0Ln1jEMsILEscb2Ij1C3OpGJAKLTgn6m/DYx/mNIku1+Asiz2jLJGIrP30
	MRAtPdMDvg2QMyFDc=
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4515da967c3mr13748901f8f.37.1778169415965;
        Thu, 07 May 2026 08:56:55 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:55 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 3/6] gpio: acpi: ignore out-of-range pins in acpi_gpiochip_alloc_event()
Date: Thu,  7 May 2026 17:56:44 +0200
Message-ID: <20260507155647.403964-4-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpio/gpiolib-acpi-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..e53d68578024 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -370,6 +370,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	handle = ACPI_HANDLE(chip->parent);
 	pin = agpio->pin_table[0];
 
+	if (pin >= chip->ngpio) {
+		dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, out of range\n", pin);
+		return AE_OK;
+	}
+
 	if (pin <= 255) {
 		char ev_name[8];
 		sprintf(ev_name, "_%c%02X",
-- 
2.54.0

