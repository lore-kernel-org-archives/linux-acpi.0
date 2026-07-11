Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9E2264C0
	for <linux-acpi@vger.kernel.org>; Sat, 11 Jul 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783751034; cv=none; b=n6oGHMLH4Q7lSCkUoo3hmE8/Ae+uD3lGUgrIrS01bkOSEhOskzNTOL5wfbWXTwOVtz4SQDMnw6lR4OWhj/3QmfRKNa/ysEXmgMbkXeQBowUA7yJUDkDJ18VDKOiE7MXBNKc40SpQ2wZzmaOQQk/tD6hJhB+8yI8HdPOuZ2m+nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783751034; c=relaxed/simple;
	bh=S1/0jwBMfcPVFdbh/v4avu7b0dUuZhaQPjurjiCKQkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpvigsihrhMKPMvvrCCs/jz4hSK9Yd1MjH4Ieq/iRY6IUc2Q/j/7D9qqgVaRJkrodBeoSLpmmTKhid3zcXqja542LqCjelOMwfDIGQW/kZnvLPDhB4yFaZ4NFfZJQYvYgjF1L4gMHW3hdZi1ap3wHk0FCdHKBYs4WOMu95pqKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lalTUBvC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lalTUBvC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so20527745ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783751032; x=1784355832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkRstM7R8Vg66nTgVC4msTuOth2Fa5G6vugexDMuMcA=;
        b=lalTUBvCpgJXpjePq6VrYiX4K7GeSyr5xJrnLcyrftAaoxj4o4snesDObypzSN4zB+
         6Ad0dTJ4z/cKf9bWp43rSIu7yyRnFlsxIbCTV+7i/fQoNWuHrDomimb+2kOvjaT1rNJE
         /U54QYHyIvLeowSE559oSSUi9ZReCVVLyVC/n0R+nWnUdqAVch0VRqWhQNv9RXvRq6tT
         jr3jLIsgNaTi/S9obogJtSyo751uvUfI0QYtE8wVn5sKlJmko7qfcYK38S4a5gErEEdj
         CwiyfTIJO/K0xugMDVVHIkn/rUD++JJWJu9TsLYS8EIf9hSKp6hvXWVw8BaE8hToEYFD
         GPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783751032; x=1784355832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkRstM7R8Vg66nTgVC4msTuOth2Fa5G6vugexDMuMcA=;
        b=B0Cf1EgnjhMTI+u/pc+D+eIzyR1SCc/K9tPARmC+JVtjY2HHVogmM7wp+nEpS9WtgT
         wOdflaqL/WmMASurMdkA+PgG4eFmmO3Ajjaxb3xP282i8XnrNmwdc6nYe4TFRrqCNaIL
         mTOBBYjQZpMRa7N7AVTvTHs5LUEcsIX0PeP7HaoQpUvoOtcdZ4Cyg7rXDAGJRQZy3mF1
         fJqgwA5y0dcTHJKxVeASVu49np5wKxylm6sP/EBanyuQylhYLp6DYbeHOqsMYXYFsdcR
         bzP4SyI+q/XkEbgaS9myuOeaxvCt9iHrgacg2vQcWVVolR+LbLmVFB6am4dSfcl3h8qJ
         4Q9w==
X-Forwarded-Encrypted: i=1; AHgh+RqMTgUXhOMjBZiSIFq5clPIS3ewDj4fUJsL6dqbSxRGrdFughNLTBs6weP4+LKW0L0maVoA2zZJo6KF@vger.kernel.org
X-Gm-Message-State: AOJu0YydaF1SkXc9LUTiC8++aujb8JZoLqGpyBvOHOS+jWhIdOfG743v
	AMcodPTyMsNFh5WQJARQ3SAPfV2qec80x88Bo/W5EhU00+yPOZqXtbfX
X-Gm-Gg: AfdE7cnwFvpoVQnmgPvDS5rwn/Z4KPdQkQrDOg54Nc8w3cujCy6ut8kQNb4eAIdDZHL
	3GImbxdh4aLodLxao1oT+foqv4ks9g0R6FksKvb5tYCnDhaAlaWLTgAUznAiwqldpjpIrKArVG6
	tkA9yCMVYljy93nSFGELpdXgW1igRbac/4PtApzDWP2Lj+MnIbDXJQZ9rZLFCKZDhljggjLcyRO
	1weeGTsfsPniGgwkj62RRL661R/wnEXOWdXDy7/WVWKTrcQHw+MN3QXARSepjYmENwRat79pPQJ
	vMFt8IiGsS2hm4XL08kvBeqEkdjW96f8FFagd6XHI0SXqWClLgGjkvCTVvhAx6dJWlGD/VfiHSG
	hcbQoZz+gVpBJe9M0Z6Il1M5mCVajwfe5+T9BYk+ORQxm1gGJqJluETEbjDVJqAb7C19l7PstWa
	wB2Gw45HC/wytz41Ql7oKvQOZEaP2u4ca/LVGh9Jg=
X-Received: by 2002:a05:6a21:d83:b0:3c1:fbf:1e2e with SMTP id adf61e73a8af0-3c110a12318mr1877132637.10.1783751032179;
        Fri, 10 Jul 2026 23:23:52 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:a02c:24ed:3127:342c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79aff904dsm4103117a12.6.2026.07.10.23.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:23:51 -0700 (PDT)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	oliver@email.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on unsupported platforms
Date: Sat, 11 Jul 2026 15:22:49 +0900
Message-ID: <20260711062249.503264-1-vishnuocv@gmail.com>
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
Reported-by: Oliver Lin <oliver@email.com>
Closes: https://lore.kernel.org/platform-driver-x86/239c8162-e1e6-4b49-8292-35547c5a525c@liuxiaozhen.dev/
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
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

