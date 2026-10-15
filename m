Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942358B6B2
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097103; cv=none; b=Kvzvl2quJX6mer190YxzxJtxBUjXLqLZq53mV0eTBwbdS3vgcJ9Upar8Jl3bWzCWe82fO6A7EhVizlaysybLJxu4JDIPj+U111wfhClde9MwprrtGdKkRuWDFCpC7Y2Q8oRfEPbCshl6vCAk3VdCnbqqWiWzUZLZs7+h+K4yzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097103; c=relaxed/simple;
	bh=YUrSrx3nORZjCfUb1kowBqtj+wacaINHUxJG3uHwC28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAcI8WvrqHgiX6FT9hDNFsw1fbD+jWXeF/4pe5yFSMbfmvHbYRoXbDfG7YEqCx74SARMGVloSusA5lGjP26tXjEbZC87UYTlYn3TnBVotiq0zUlWktNwAUwJv9KjaZSkg4Ro1nlo/6zWVuvhcB12/BeqQnY2/nMutXagGYjPmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3lJ8A6C; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3lJ8A6C"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15354aa70e8so1150600c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792097100; x=1792701900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2O5F6+HI/RIGbJQtd9sQGMunBjZHyF+3elLXX+sKSI=;
        b=S3lJ8A6CCiWhEgOLkEBjEvvdXGaU3FM2LOGF/Mj/VLAmbPOHevyUNvCbSOYZFmPH4K
         QwAsHyEoxHd32o/cCP8x4Qr59JmStan7Sv0zqOeiEyxQbhn6c1fx8RSZkmFOyhGjoeyH
         NEBeFLaxax09izCC9NJ+cAl1zU5YyrCnTLbPZvwuTtjtRK8WQSACbzF4WAZeofQIOgPi
         ZRjGHQGJ0hOOO4zdYQGSeUaoIYzsHLlkuTOcP6exmN5QzW6Epie3IfFdTpv2pIwfIUKo
         1PZme+7CfB6lhzbv8qBcPaR0xYNaBgEKouJdjgnpa4tPLpPl5c31opAEWSsChqgSzjuf
         z3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097100; x=1792701900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2O5F6+HI/RIGbJQtd9sQGMunBjZHyF+3elLXX+sKSI=;
        b=Bv0byxB7BLc1h8sKQg2vd3b0E1OVjEOOwcDNCZBH69AvOPiEEhROIIkEBkpHioTcWa
         LXdnWeTkm/ZZJ/0Gaej8rmGvpW/swDZufbmOH9Cxr2UrqAQKkb2DTUxdvJNGl5fqnk+j
         KmjK7qAfQ4r2k6lE2YfcSKWMDF7r0DTpxCZKr7NMzgohx9PkXTXVnD0cIR56FG0DLDP1
         D+GmTA3FFWc69ykraSl/JrDkTYtj1rH+LvQyo3kiddoYvBoR++FUtmpjs1eIgdl3IKGF
         RBbYExwJxVsK2z1MhbQw2LvSXitO1V2yzfOp3gt04thQrr2H2C/hV19t/EP8cJ4BNU1D
         bvrA==
X-Forwarded-Encrypted: i=1; AKwUvBwHXV3f5exVdgoWkvgI+RA4/g1GUWxg4nU0WgO7KC5FrsQDnB+g1I77yE8MXsOeX2cfKrvzKbdDahdV@vger.kernel.org
X-Gm-Message-State: AFq9FYIXhv+/mGiiKKrKXh8kD+nXU8i0DWWLFMY5bPXpaHtoSSGfTgea
	FInLM8UFBc3Vqa0GYiHPZRcA953I0CyOLQGDAn52kLADP+GC/2lbe54=
X-Gm-Gg: AYBFou3P1VxbMdMzwfBgQQsi+fF2u7zBCRXIDfpRTi1FdM4WwFdBKWwMSdiaSpPtOB3
	koTiaMB6IEgkb9flVnhNodJ9fAqeUnrF/6CAmW3ApTeFJCVb7gRLIJTRGHLprgsGFID2Xg4GFml
	0OyzjK3WFuCW1wkKh07xqIDY5kQD9EQY1Rmh2DdoYMAg/j5/0IlpmaMmJ1gSjZpwUHdi761IMvz
	6/x9k/Eo68JWZOKApyhdjKYtlJy2qjI6aE0XdzyChR+bXh94rFxp216dLdoshlgQBjlitQIRrXI
	qwZOHL0SuscgQvkZSnC/4lZSImqpQJlSAwFXlJc8EOQ1im1/X5jzmNOodnclj8QSY71r9Mh52Vv
	6BXoSBLFjAict8S8J99hRzxOR0RzNeZTuSP5R3yAkJrvnegXlqIKh41cHX7bdmy2OZucLLv2RVm
	SNhhsa/2uVoGkkOBW8LUwRliyALkcY2uAmRt+Fs4tqQ7hSyQVSdJ/ebYo5y3blFeijPOPbAkIWO
	GJ73HB3p9jll38fNaKtpQKsQi86grU=
X-Received: by 2002:a05:701b:280d:b0:16b:fdbf:4a9d with SMTP id a92af1059eb24-16bfdbf4ff5mr28145542c88.27.1792097099604;
        Thu, 15 Oct 2026 13:44:59 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.25.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm130114c88.16.2026.10.15.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:44:58 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Thu, 15 Oct 2026 16:44:47 -0400
Message-ID: <20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use APSS and ACST instead of _PSS and _CST when available on Intel Macs.
These methods are used in X86PlatformPlugin.kext, and when not found we
fallback to generic _PSS and _CST methods.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/acpi_processor.c    | 22 +++++++++++++++++-----
 drivers/acpi/processor_perflib.c | 10 ++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5fbab5417..782676ef7 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 
 #include <acpi/processor.h>
@@ -837,27 +838,38 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 	acpi_status status;
 	u64 count;
 	int last_index = 0;
-	int i, ret = 0;
+	int i, ret = 0, base = 0;
 
+	if (x86_apple_machine) {
+		status = acpi_evaluate_object(handle, "ACST", NULL, &buffer);
+		if (ACPI_SUCCESS(status)) {
+			base = 1; /* ACST is a 4 field variable we need to skip the first field */
+			goto success;
+		}
+
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+	}
 	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_debug(handle, "No _CST\n");
 		return -ENODEV;
 	}
+success:
 
 	cst = buffer.pointer;
 
 	/* There must be at least 2 elements. */
-	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
+	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < base + 2) {
 		acpi_handle_warn(handle, "Invalid _CST output\n");
 		ret = -EFAULT;
 		goto end;
 	}
 
-	count = cst->package.elements[0].integer.value;
+	count = cst->package.elements[base].integer.value;
 
 	/* Validate the number of C-states. */
-	if (count < 1 || count != cst->package.count - 1) {
+	if (count < 1 || count != cst->package.count - 1 - base) {
 		acpi_handle_warn(handle, "Inconsistent _CST data\n");
 		ret = -EFAULT;
 		goto end;
@@ -882,7 +894,7 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 
 		memset(&cx, 0, sizeof(cx));
 
-		element = &cst->package.elements[i];
+		element = &cst->package.elements[base + i];
 		if (element->type != ACPI_TYPE_PACKAGE) {
 			acpi_handle_info(handle, "_CST C%d type(%x) is not package, skip...\n",
 					 i, element->type);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 9e25d6124..b4b36e60d 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/platform_data/x86/apple.h>
 #include <acpi/processor.h>
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>
@@ -324,11 +325,20 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	int i;
 	int last_invalid = -1;
 
+	if (x86_apple_machine) {
+		status = acpi_evaluate_object(pr->handle, "APSS", NULL, &buffer);
+		if (ACPI_SUCCESS(status))
+			goto success;
+
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+	}
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
 		return -ENODEV;
 	}
+success:
 
 	pss = buffer.pointer;
 	if (!pss || pss->type != ACPI_TYPE_PACKAGE) {
-- 
2.55.0

