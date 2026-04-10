Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6635B632
	for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817308; cv=none; b=nS+CMDsTAVqrEYN9FvktvOA6N7Gutm5c0ZxG5sOtl1JrqYbN6Eb9WvQVGJ8Hnbtqt8Lk32harEgVvfmH09UWgyizGsXI4Bkx9qP9oEhlrKkgQ7JzFjgbw+MKEw054LLUI4f9+8pbEYw8LVyYtym3qQscpzpL1QXcy7Wd0B+UcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817308; c=relaxed/simple;
	bh=/2nU6DwGYrB+jeV22Tu6KgLsWFcZFrLNZ+WCDr3H/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBQxYntFjSU6vVBUSBAwt1u8PLRT6Cv8zxSlZcOzPB6wmUKPNwMgo8AZHWyN08/ghbrP7YnxiIhJE6nieeZkGDWySxKtZ60FlAWR80H9gmw3I2lmVnlghDynrppC1qKz2HqXbalpf4esPWANuh14slMaApBAADFTM6AMztTe4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsHiNQCa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsHiNQCa"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so1780667b3a.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2026 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775817305; x=1776422105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9CrhvcxM7cDtB9lpTmog91+MN/asbSvWwrp/YtXbmI=;
        b=UsHiNQCapg8iULk7EptHrHrvd+IhlwCXSh4mG+eK4okgDR0B+jJ3i4UJpvG1Kz6UBk
         egn5vkgJoQjv4S5LuMZS63+oO1qkvr+fO62IpfUgwggbShefWCMg5y6QIxXQ735o7Rw1
         s75J365nL9bqC9GoatK7uAV7zzsbNXaF0f2rnL5oAJ9NMtYnh1953+booqbHvZ+wLzyZ
         jLEGZ3+8hCyeQN6l4BNaf5abwt8SljLvs2QEHTN6dDYZIa4nIF/wJ72FZiRK1Y6g6NtQ
         WxFDz0UlXDSn9JgzYG+wH6A3bRcD5bH06iPnjJEB8knoq3Xw1nyP8iqLGo7Hg5AiKnHL
         tHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817305; x=1776422105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9CrhvcxM7cDtB9lpTmog91+MN/asbSvWwrp/YtXbmI=;
        b=WmK3+pNaeXY0q1zo3+kHWtSEoqlxDWbKs2OCF5pkUv87tNRxsXfo0e9C7Sa4JxsmxM
         duG7cFAhiMrg+h5j4NPwF86NL8Wy0BwCHBiF1KmZcEo+i4OeC+VDdijp7Sl0keJCPGKJ
         kXMS9HhG9+aSbLOLQkyUWWPLAagAL+XGsB8zXFsn4cH8a1ePWHcYbeosT2BDREL+BE6j
         eij2oMMrN/Ff5i/eCfKJDSqKY46CHVndK3DhwIerV3Jhu/WHn0dvf00LAgMEXbluEZpH
         gkqwpGxbhoWRdzW4HMnglir2TnSNf9beX0RpZCkJuLIiqKUrg9j4OmKJNKMhVxKK2WxP
         BrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqaA6LageACRlKnhZm+SoZykdkS++V5iqvYUEfBTiavaFIykVxjPFc3zVyroLAqv4DD6OsmUhqBEf2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXS7IRa2Vq7H8vUyEfo977s817V8U94M4wlktbl4GX2KLNUhc1
	eUpO9KRyukp5G41XeQSdp4sJrYHkAdN5vA3AP2pMi63ba4zHuzO9K1gF
X-Gm-Gg: AeBDievoxBQs+dqC8o95CQrUXXWI7ehM5zgAmgw5iTAZ4oWcPIp9UANyiovMxj5dPVc
	imnTK1k0RvQaGigsOfe3EBver/elf2Go2lar1tlX6OkyEcqCf4mFHSh2sNNKxLhpTAb3Nh6ho8B
	WNI1Dn8irWmZXhxLKCsZYPaubWKHHtp0p+ahbZsdjmirb85xWnZvJxlKiU0R+WE3ouzIp3B6jU2
	/TQg9Q4LIU+Be5pUYRNCidzKwxnDkqe/bYA76ar5pTjukz97kTBflHCAPyLSqXaHlenP0omXwV2
	LBbZR9cbCA6PvtvdgxK3LXBLBpal4nrz/ooalUT1ryws9oswvclMTYsksMCVPPhheO7xFL4yC4P
	aPM2KFjbXmQkRqLo3WEPD9R5Nu6OGNEGQrwe/rcy9vGIgJqXf6Il/TQwTr/0ychHGEJEaXRlZYA
	FBxYw2Yusf1xaKgJ4=
X-Received: by 2002:a05:6a00:32ce:b0:82d:24f:2510 with SMTP id d2e1a72fcca58-82f0c384a66mr3113052b3a.50.1775817305356;
        Fri, 10 Apr 2026 03:35:05 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm2503600b3a.45.2026.04.10.03.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:35:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: power: Use put_device() in power resource add error path
Date: Fri, 10 Apr 2026 18:34:51 +0800
Message-ID: <20260410103451.2014607-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the lifetime of struct device is managed by
the driver core through reference counting.

acpi_add_power_resource() initializes device->dev via
acpi_init_device_object(), which installs acpi_release_power_resource()
as the release callback. If acpi_device_add() fails, however, the error
path calls acpi_release_power_resource() directly instead of dropping
the device reference with put_device().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak and potentially a use-after-free. Fix it by
calling put_device(&device->dev) and let the release callback handle
the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a8..f96f954876a7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	put_device(&device->dev);
 	return NULL;
 }
 
-- 
2.43.0

