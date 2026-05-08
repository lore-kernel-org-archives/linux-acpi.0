Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158A349AEA
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221082; cv=none; b=khQzSvIA90UpStxRU91AYdRAuN6jODGiYWCMeBztJV6Z3I4pyKvhNjOZLcPgikRXdamdxwrh+iEm56w8pldrbCDgopL9ISyf0p3O8XHDsKr4wYoBmrlE+6PQh4H/WmzcbUxikatql5mHt0M9AS1WCgGiWG8s4beHs6NKSR/sx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221082; c=relaxed/simple;
	bh=du9luptkF1RMPunIoS83NkddF0URQJLyQE4jUAhjG3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rleFj73h8aCJ/mIEqGZF4YGsUdHQYHzgieXb1zEyr6NR6NZkEzlPSAN80c4W0dllO+hJzURFmSqAMOCyVoNUQws00Z9mHQ4bImG7Q5KPpGrTxGEofKzAmetBhCaE41MLLRYAQqTNS3FEzu8JwH6tuLOmoicooQ/2ap03u0ZAxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecBLSQ9c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecBLSQ9c"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso12324565e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221071; x=1778825871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uJNehFBwWP73FrSYeNJ0QcPue1v1GrVxPAkYJ7F8Go=;
        b=ecBLSQ9c9E9LN5q0HiJE5FftLfU/1lntaTDOdkzOiKTsuWPre3qo1BVdPbGq7RlGnB
         fC4FUUZTXVfN+hMfwKHA5DfOB+30tegtvSS3l9AtfBsnN/GPRw69t7adUNa+pwRmGvmJ
         QIZdN95WWH+NMa0JcYHmMWWSRY6O3vvgYIICWUEJYOhNmZxfy3mPdPSNyhzatDDPAuzC
         ljBpLXCS8YgmTM7wfj0LQbDU7YHftaQ8jUCfiO+IGGBGz7aPZsLuPYQXhNfrHjQvd5I0
         r67EZ3Mqk/UFhbPBzwTUB/sQvtOyZtITzXCBYE3dDe3+CUgBPa6GHzrkJ19x9xWOe45G
         jC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221071; x=1778825871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uJNehFBwWP73FrSYeNJ0QcPue1v1GrVxPAkYJ7F8Go=;
        b=HFQ1QcvAE9KItCoi7D3xbrsZRmKPtx6aKKnVp7t0bLZPevCwFipagBUrPy0iCWPTgW
         K55qQeCwqoCpx1E0iSyvAPaoUiy//tbifATcQIMRvmXW4ffLU+35SuWDSF9mv26i21Mz
         Vf1B6hN2tqHpGjf7rnhBNIbX6pU/3gdItOO8nnT3KhBocRA/pFHtWIdm+f7pgcV8sRmm
         WcvxRMglnQULXstqrkrfnSqKdIQRLYN/r1uOtL1LaU+recbfDPYTJg1jvCDLg3dMm5F9
         2EDxE0Vlf8I1DY9vPi66GHwEjlsZmNYE1aoZgY9jbq+VL90e5Ryd4qCeqtKxWZ5TuvA1
         coQQ==
X-Gm-Message-State: AOJu0YxCPWTZuywi18lOTASqMTQpYQ5/TfjZmN9aRbuCnM24PxIcPolY
	lx1UMZoR6EJ0UuJmBuhrVxx9Dig+FHmpQf3HJ94a7ABYBunLDhuKgVCZh+yOejjyG4M=
X-Gm-Gg: AeBDies9dP9RN0F5bgfZiTYQZAmlVqVRxYCdrXIqzq9OMVfgFAp0MtFrAKoFZ27LjfV
	rqOBDqsc4FHCo4qfRaaUAd8CDhwyointrpXD28Zi3m6eO6dfAwCzg5ESu2mYI/RAyMUWGf+KVsW
	9wVeah6r+XLAJ8TKET1R7ELn1UL3qbIrylhHYN7yeO+uiE/I+JCW0Jj20XRWgf+55603LaIKq8z
	F8YodiOp573qIl9e2Zo1xtG8KwWcB7v/sfbd+s+E2kcMEoPiQX2OAhQqLQZpF+QqQ8M8zEJDKvz
	0r+TzES7Wjqnn/mG24Ew0He5vw5ZWgPr+U7QlGTM7E9nuObEKjclITjo6Hwqlt88UmZIUU836Jb
	xSoNk5dPGFzknu8FG2lPIaM8GvS07iChYJfIibanIuANhu8Z2VDNMbm9fl09hetZNuCdSeD15zc
	Jm/FpxjAJp9cJiJG4=
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48e52bd5035mr196450835e9.14.1778221071083;
        Thu, 07 May 2026 23:17:51 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:50 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 1/6] ACPI: Move DEFINE_FREE(acpi_free) to global header
Date: Fri,  8 May 2026 08:17:24 +0200
Message-ID: <20260508061729.9530-2-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508061729.9530-1-mscardovi95@gmail.com>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
 <20260508061729.9530-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce DEFINE_FREE(acpi_free) in include/linux/acpi.h to provide
a standard way to perform automated memory deallocation for ACPI
objects. This enables the use of the __free(acpi_free) attribute
wherever ACPI_FREE() is required.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 include/linux/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..f58e704ee850 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -234,6 +234,8 @@ static inline struct acpi_table_header *acpi_get_table_pointer(char *signature,
 }
 DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_NULL(_T)) acpi_put_table(_T))
 
+DEFINE_FREE(acpi_free, void *, if (_T) ACPI_FREE(_T))
+
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init_or_acpilib acpi_table_parse_entries(char *id,
 		unsigned long table_size, int entry_id,
-- 
2.54.0

