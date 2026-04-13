Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC553469F4
	for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088439; cv=none; b=YVCgBrXPyZSPpqLP38OtErR2Fj46mIfpaLKwehhyblFAvPlssqDvzVUULhWHdWcZFwXi12/PTuqN7CxWpXqCZTMAGDZBrRocDIQpwKhdh1uxmCy723UdMApvpjf0U7k/tCTmwcKo5s9FmTXZzP35FiVTOSLdkccK5n8Q6aSv5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088439; c=relaxed/simple;
	bh=tF5k1wSfQV9qRpEm/c2ecKsgNZoxB0cUfLMGDbVIRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQT4ZqXXICQ/6xH7stW/QYJzPsI6Vd7qGeqLker6CI7m3MOAS0io+IMGgygQGkHa0tU+DDIe4m4UvnYegevB6oSfcrtVyPaHFNyw3uTJTOdPivNh9ol5sJ/1gA4al7woRwZtdcJNkuiCv2oa9BnavmztlOP7Lfr0CQn4qwfaAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEs6WYMN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEs6WYMN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbfab4501so18413835ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776088438; x=1776693238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OD3lGF5l5459705Ws9WBdEwFaekZ5NwpESLmPDJ+v0=;
        b=KEs6WYMNmOy2PUhRSA1obOPNCt6UdxRxqQNU5ZOkT72KH66tJ0XntdyzV/Z8V7Zi5z
         gU8K0XqQeUFsWWdFrzMTJWDTLEGSiUcZ40fmJN8yL+LfbFLpD13amcoXJQ8FAq07daP7
         D3P2o9BVlAcryokQ0wdJ7K87dhMCdENFV8JflCsI9og0yye1wq1NpYt46UF9Nw1dofMG
         zSB8OMpWlKxA4XDR6iDaG6VUcSW1IcMTsiy7iqEdLG1MWxXJgCNfI38OiO+KgeMeSTtt
         mDwFbuaHJo4TkcsZ8dEgWVY/Og2XDMCdgDrApDnfdKZgbwCaEhA2+Py/aYsZVRIH02Tf
         fywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776088438; x=1776693238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OD3lGF5l5459705Ws9WBdEwFaekZ5NwpESLmPDJ+v0=;
        b=RIJ/nJlVQ3VucKs82Ga9ZI4LvLoprooBr8b3KPjp/IskUR/b/oXpiGCL/0YaaZPXrl
         7JTQA63ay5+k5+dSK1MGZyfVRIZuDgiE58saSvk8rhRmfQCssJXDcUEyTxYXr6IrGCS+
         PfDT5YNM8px8Uv9C6u+Cn5KOeZeA11yhgG4UNEIDRTovUI4plLKw6qlzmmYaO8+81gTl
         XGDoZ7E04KXhppcWQCL1y2bStfKBqzr3FJ4rKUU9xK2aP60xT59V1yHl+XX/61g+Eg+7
         y+hTP8UvvoNBb9WijxfIlatMlTyX+PtYAxm+pTRdehvHU14CvT34vlrjVFnyGysCDo81
         wUOg==
X-Forwarded-Encrypted: i=1; AFNElJ8xzye26i8cmEMu8+GGyQdN7mjLnbu/VG6G1Rqj8qb0CUAbFOVDYxpHRzVaCWdzNDVN2FKsO3QIdPsN@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwo/Sfsd2SIJnRDf9H6wLie2y3Pbk7IDKFgkdm8uFUJ6hs+Wd
	SV+7P4AHDFVn5T8bcXi+xQ9J/5lsHKkCZ2leRG20+f7EAdbBaLAohAfr
X-Gm-Gg: AeBDiev5tMOMnccGDeypc1b6BFHHRifH4SdypZQFCMfIYP95ji0m7Ru/xjh+yjJX1ro
	3pMBNNG5Po0TUAKu6ogvhVOOLuUQ+lHUbae8fE0ZodWD5cJTbs56VEoO1tLJRRSCECHSmS4eCeB
	CW6spo4Qcdmot4+0WSPQIQ0YzA8N2cVrIl5JJZ0NLevmWGIetsbxop/ErxwFGuD+tVKiV1Mj5IW
	JT9D+LvQVt9ZDk15c/4LF+LNuimGcSy8ipqoMV7hKitRAGjQLJvGSoA7EFGPpO5Xk8ST7ceWQLR
	MxeQr/d//iVducuWdmF8Nn/Vf++b2/NIEzcLXE0gNmj0ZHY5APvBt1HrqkohV6oEENdtVSv4cDz
	wwcbgawYdM54czWC5BB1xAGjvNiG2dik3s5Dc0xMFCOtxJ9jiJXddVwUY1DF1B2cv+wMgM8oql5
	5Ix/Bn+fW/7ccnkrkZ5txY61jTvy27l/I=
X-Received: by 2002:a17:903:2286:b0:2b2:dca5:101b with SMTP id d9443c01a7336-2b2dca51487mr114332635ad.12.1776088438092;
        Mon, 13 Apr 2026 06:53:58 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm119174855ad.71.2026.04.13.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:53:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lin Ming <ming.m.lin@intel.com>,
	Hugh Dickins <hugh.dickins@tiscali.co.uk>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Mon, 13 Apr 2026 21:53:43 +0800
Message-ID: <20260413135343.2884481-1-lgs201920130244@gmail.com>
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
may lead to a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Note that the issue was identified by my static analysis tool
  - and confirmed by manual review

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

