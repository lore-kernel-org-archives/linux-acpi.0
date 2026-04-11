Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9833BBCD
	for <linux-acpi@vger.kernel.org>; Sat, 11 Apr 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917421; cv=none; b=taU8HJ7BgLEJmFIlE/5nkjx3JwYZQZF80ixPG3oZmkMJKTlVcWhFelbVScJwc5P4cMR1S0gwZB54z1fWsK9FhURJ4AV+0PDtgsS49Kmswln/q+Myf7oD/s8XGIHcCbAWIZ6X9+6Xt+OGby8z3hc3VWL/nM868tFHGnR7ruYd3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917421; c=relaxed/simple;
	bh=zjdX+fDP4DZujxewV7f8h2w2dNgyoukQyBkWuCBGgX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDBuR/BYqWD/mJ2M6EZTRoq0n4sUZLpixSDuhPxLtmViBVyJa/BhT2/pzGDkoDydGgKMtAYvY2ABGs9voCaLulhWxYnuxFuCB5VKNb4u3oAMmSavw89LD/fvLqCCUhgRwY92GM/WzCVYDK2dZEBut5fQePL9EThLwJEd+jfaYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VypOYZ06; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VypOYZ06"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823c56765fdso1833256b3a.1
        for <linux-acpi@vger.kernel.org>; Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775917419; x=1776522219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TremzrygKXcYa02v0/L5LdhZrn3TlivFlrGomrxLn3A=;
        b=VypOYZ06m0rP896JPbDzy7IU5MwemGaESPkzI5g4u63yHjL9wjGkGyLFow9+J/t+6A
         /AQm/5bTAk74LWTxe0hxZJFuq7GQm6kXwBq0uNFjcwykkUROu/ieLhv/8gd2/tPfgNc+
         kVWkbjOh863yWJMjOAsYugTe1iUY8N9tqtDaG1gcVDJ6lpZRReFXu8s0N4Q+hBI54luj
         zfzxjXqIoiosKk9PERbmE58CDO1wYu2/CAKK3tSBfffqWpohxAqr3o6oktjEkJS9uDeb
         90yr0NoO73TD4WpobfbhZztm5bKKuNF4Ha70lTtgELJCXuypHv2RN9INianbcS0n3tgu
         mJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917419; x=1776522219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TremzrygKXcYa02v0/L5LdhZrn3TlivFlrGomrxLn3A=;
        b=Kd4HUDCMyU7324GwIgsJ0Xt2UWH0omul8c2fphQNIR8ops4C57cuyX4nihIcl9Tc4k
         J+G38KcdNxYehcaw7WJpPrjLB9f0BlDbvYdeCvAq2W/2u8AAQdPkwAGq2eBeieWolH3q
         Atl5/hBJpTpo5Z4a7hJDr6GeoAeL6ShYbPI7+31P5wWWV652DlGmrUyqpEaxpMk1vPUu
         qdn3on2ulMTkC/5ZLeDxHBJOPU5QMm87EHk8vS3lsvPsWmeGpzr2+YRpcWJAprhAQEun
         3tFQO6Zt3/PWDZ5mt88leIBYkRNHmm2h1Cn0CdIj5WfaZ+FtIm3xutJsyBeV8ZPJMX+d
         mHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa8mQ1hq2Tb1rJnKI3iGIfogsd6t/OAq0WXsd7jwHQc/M1Wz+ZTuA9GHXohWwzjvKH25n4tdZr9Xwl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7yB7kt5IiNX7E/mVJGp+t8sQbcBdxgbn1A7CDH/hqgvqskay
	gC3uoDonQAN4eW40HkwfvmejkaqtPzOLg+iV8Ps/0TVtrIMt090oOqAZ
X-Gm-Gg: AeBDieu3tXF92MHBxKZkTWKwUiMK/w86gQ6iXMVAwYnVyWYvmb/6LYIMVo11Y5SWQwB
	PP0WlacDndxPMJCMdqUlwU5zg/qnI+5iB6uY09vNlnt0VoaYfhykZiF3PYxulNZkDYmMzU5fLWE
	GVlM8YmCE9IWpeEtwg799keZa0xC3J01JiNSE+6wXJdODC7LJKn5vNyXyhWMGsK545gME0ZKgYh
	9uHgQEsj5wck9HHf88QJQ4iLxoA4qCC/c6OruSqgJ1tDtrvSlq5F5p3CDp/bCrCrwNgNiKGjNf8
	1pwqNA63ttyDUrepSuMTwZAHjGVOyayUPyoKd435RurMW6ALM7RHDG84y51oV9nbuUv/yHrYE+A
	Bh3wPYi1flSIOm3Yky0BNgslJkBIfkdT4qUtRVYQgGzHucq1D0Fc8XSPYCh6YSE2VoniaBKBjsU
	3TGPLNAtZSVFiyyw==
X-Received: by 2002:a05:6a00:aa85:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-82f0c1cc16emr6636314b3a.9.1775917419425;
        Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b6d43sm5250995b3a.31.2026.04.11.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lin Ming <ming.m.lin@intel.com>,
	Hugh Dickins <hugh.dickins@tiscali.co.uk>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Sat, 11 Apr 2026 22:23:30 +0800
Message-ID: <20260411142330.2273618-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After acpi_init_device_object(), the lifetime of struct acpi_device is
managed by the driver core through reference counting.

Both acpi_add_power_resource() and acpi_add_single_object() call
acpi_init_device_object() and then invoke acpi_device_add(). If that
fails, their error paths call the release callback directly instead of
dropping the device reference through acpi_dev_put().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak and potentially a use-after-free.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Use acpi_dev_put() instead of put_device()
  - Fix acpi_add_single_object() together with acpi_add_power_resource()
  - Update the subject and commit message accordingly

 drivers/acpi/power.c | 2 +-
 drivers/acpi/scan.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a8..542e182f94f1 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return NULL;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd10..5124ed02debc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1910,7 +1910,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		result = acpi_device_add(device);
 
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 
-- 
2.43.0

