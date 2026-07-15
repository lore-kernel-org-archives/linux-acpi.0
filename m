Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A435979
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077446; cv=none; b=eqwVKIkWwfyOFuzMpmzsDBlfis06bD5fhXWb3se0hWxUwuisUMNyoADYId8GOIgjEqCnVmzLjzkLWwJdJoyUc3/GqH08u2uNv9icnIL2kmGAIliXXODMvUeqZNwbDCiSF1rvG/rV7z0XcQLmMtLSA6nHpHg+/zyCFyG67gjQizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077446; c=relaxed/simple;
	bh=odsHPKGRkXpnbVJrCXqgvkItzFXDUdiBxoNTUL5323Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D19FFp/s4swgOXnTbEBY4QThPwMFpSinkTmRL037x/279WsiwfizhEcrK2gD0g/q0lnm7ffMIwIRtDg3e+FSJMZ924Xd9Ej1mpDmbmgzeYRiLKLVB1Adog0HSPoYJKWrQDA7OdKk+6OJJHgEjZBnns6oIf9gK8BTAsVBdw3say4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqDGo7wB; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqDGo7wB"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664db84f074so7468697d50.0
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 18:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784077440; x=1784682240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T92TVFn6rhO6HmCv2F8f/L0PpErBRmmCEWcKmmWl3MY=;
        b=OqDGo7wBNlHBZFvfh5AoXJbhq86Ke1h0h2Md1W26ibZiZ2tuAZZd/3hq5kjBXEMMwW
         kkvXUo76NCBpdk7F12eSWpIfvNM+wc6A8k2DPhncy/twSXb4XF9XUVtAO7ZsDi0DcAS2
         Qr2idux/+0K5jJPFyEuPgN6I5xK+U9ajpgZ1BW68AIa0btKFQOri3XW1zqXDF8OZ4VpO
         KelqnKGEm2aQpAWS8ubPtNqwKrRsqJwS7xjDcrJn/2yjDlonpiVKWhe2mSNk9QPfbGRl
         EAw7q/EmH1L2B70xPZ3pksyM4oxdKQ1OpGh2mNMYKAPce5m+EL8yHSJK9gje1XUxStnR
         gkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077440; x=1784682240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T92TVFn6rhO6HmCv2F8f/L0PpErBRmmCEWcKmmWl3MY=;
        b=jGknhM7MfluWe/rqVkoBMqjwdvEFnEjwPmGlwfuvT83cTbfoF1YS4HY2RiD3Wr0Dgi
         znrE5SmaZNpQzA6UOlyGFST8aHFnvlKLk2KBAgyBlHjnO2KdEYaAAakOududnzjEDnMi
         RU1CCgnPSnOpvs4FlvJYuxPP6Nmd80iCkcAqlZKAyjoqyjLFDlU3KTGQRRrT2Y9gzYjl
         kXjDYHiDOCiMX5ljtDxrNO9xaDNSXYK9lFNjNuR4AY6XvOAfRIr8eAIYFQhzLE7OBHML
         tzmVG73npmLFJ4frz0WfvszjuNJA8kpDJ0jh9dB+NOhrNT2hFoDtqLXC7A7yfKKof3so
         xcmg==
X-Forwarded-Encrypted: i=1; AHgh+RobS1ijclEMHklwEbP55FMojATcpRkeVBbxigSin5GM5piZohHjSeQGFUMchBtwhYH57w0RNCv/DF+k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+n/UrY75oP1yrMtyeRk6DgZYdlYGVZKfhCRT90O1726iugtau
	JAf02TFvRGe6HTIX3z4GT+OYBIRjnjm95jrK6ZRVqAM0qi7JlnTzcwx3
X-Gm-Gg: AfdE7cnh15CAS0udkuDe6eKwRrF/CKsXX+Y5trXcq0hREJFC1tqxVxI3ZtqdFXJ/sdQ
	0UYiiYq4DPj2hB7Hg/jvhawYmxT9XH3BtR3FAPT6jhg7Q2sOm99DiHimHwggel2C5GduLHKSJAK
	dG6M6UvdSn0x6127AT0p0qRzdMwJ9nk+ocX9tpNSICpSVqTNfYFTNIhsfagNcf7iLlQ6pce6QB0
	stm2v+bNu6Kj2GAUf/H6U1KCSH+eZy/4yItJdc8Pc778b0klbLdew10GuI9wd0HbsRT1Rz/0I3K
	M0VvyI0qoQ/ds9ooZpMSUUoN5UJONNVrQVHqalqVsLv8N+USZS0uxm9rc/kcfITUJboGIKYyuDU
	Xxh1GtpXlya8jED4q8yBxzzAqkzKVV3xw8ffn3khB7/LuDqDnHtpXkvX7O/TMUEawdLggKdYvCZ
	I2bvgYi2fS9mQFSdClwWJvJoBbMkBBmsECdV75aOWOCtll422a
X-Received: by 2002:a05:690e:488a:b0:667:d3e3:170f with SMTP id 956f58d0204a3-66813398a5amr609793d50.67.1784077439997;
        Tue, 14 Jul 2026 18:03:59 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([103.161.144.215])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667874c2d15sm17602863d50.0.2026.07.14.18.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:03:59 -0700 (PDT)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	oliver@liuxiaozhen.dev
Cc: platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on unsupported platforms
Date: Wed, 15 Jul 2026 10:02:05 +0900
Message-ID: <20260715010205.514132-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems where the USCS ACPI method is absent, acpi_evalf() returns
AE_NOT_FOUND which maps to -EIO. This caused tpacpi_usbc_security_init()
to propagate the error and thinkpad_acpi failed to probe entirely on
unsupported platforms.

Fix this by checking for USCS method presence with acpi_has_method() before
attempting to call it, returning -ENODEV immediately if absent.
This follows the same pattern used by other subdrivers in thinkpad_acpi.c.

Fixes: 67e8d1e9cacd ("platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support")
Reported-by: Oliver Lin <oliver@liuxiaozhen.dev>
Closes: https://lore.kernel.org/platform-driver-x86/239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev/
Tested-by: Oliver Lin <oliver@liuxiaozhen.dev>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes since v1:
- Fix incorrect email address for Oliver Lin
- Add Tested-by from Oliver Lin confirming fix works on ThinkPad P15 Gen 1
  and ThinkPad P50s
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 91db4c8eeac2..85ed506516f0 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -11368,6 +11368,9 @@ static int tpacpi_usbc_security_init(struct ibm_init_struct *iibm)
 {
 	int err;
 
+	if (!acpi_has_method(hkey_handle, "USCS"))
+		return -ENODEV;
+
 	err = usbc_security_query(&tp_features.usbc_security_enabled);
 	if (err == -ENODEV)
 		return 0;
-- 
2.51.0

