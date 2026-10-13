Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8433B993A
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886490; cv=none; b=Ko16p3iPse95c4LVMZqlVpmLfJSuxxJ3PBZH/sN+UYGQjBXVdJLnjK7HBQ7h4R0lJbcY4V5nxqGeQm42slnJt2JnC9MyQf8zw1WEwshiQlqIRGOCcJhYzO3d/8P2+p7u1i6Y0X/PrmC0Co2OAmXaL0hrf4v/7lGuL5SxJbg732M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886490; c=relaxed/simple;
	bh=oDmYbs9ld2ED1TV9AIIfvBhHDWWoC40K7g2n0kUxjfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBj7iPZ2ozj1TPFDVRoeT8GdY552iXzOgkW9xNzeEFIiuIDGooWz/v+ykdVHS/Gk5tU5eVahQnS2kzcNCx1q1r7BeRQj7DpNXEJNNTv5Sv/vnIWIKTlWqiLGcwymhc80Z5wkxIudH0wrrQYo5qfm5N5oaYHiHW3to75nyIjmDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miwRqZlx; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miwRqZlx"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33c2520ad38so6391443eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791886487; x=1792491287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vk1RYHI0RSh76ko1CjG27QOrqWrkV0BB5GGJ+bVwEJI=;
        b=miwRqZlxo97t4AsE3jbIVru73SRrQVTId5nBToO8pgZB3X7BfP8FAnc4gj9zVWX4q+
         2fN9mB8LS7KEmrSM2/V6HrhTBd7AFh7TEP/4REbOQLLxcS/XT/GQIcawxTAdsY6Q00go
         M3KtOnD+EtpSZJluWsFrrjjYj9PWS8ggyebCI0X5vfPPzNBG3DTi7w2bGtEgCSz42dPp
         yeU7htlmLjBRtn/bj+QyLHLZpwemaQcncMynGDiOqYjNGCS9ZpAxRDrK8srEyKH8y/ia
         FT+ae8OcYrB6FddWu2Sw5JD1IkBDJ+FMaqPQCOdft2SH0fZa8bl334H/ZVDMUURq8XeX
         Mypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886487; x=1792491287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk1RYHI0RSh76ko1CjG27QOrqWrkV0BB5GGJ+bVwEJI=;
        b=Q71Rpc5dEH0lJfXVmhv/rb8izouZpbtIh3BfBGf7AaCTfHtlEXApvLhHdiFtbh1t5h
         0VbYvQTRe5emr8KBpQVSFm9OZ2BTcWive5cQ096EWPpsuwyjihJIt5Ex95ADro7Rw5hU
         77PNTnOqsq30mg3Z0lOZWlamifcCNad9Fs3Wiv28TrUOyS7wCntFsa4++QaTQ+rynh5a
         PudQyLAJq6eg+Q9mt52+eXISZ9t5IcQKk2ZtZbHqYhTWjPjsLBbk0K1ReCgDJS2z2s1D
         3MngHvcR1GB2X1/+zHGp7UHXO2LOsdwKJDRln0KRhW5raLgQULgRoooRr6a/IBKM3yZS
         P9Xg==
X-Forwarded-Encrypted: i=1; AKwUvByleuEejDUwPFmEdf98MdyKPn8E0g08EBTDCi677FOWbUX30rmYZYhmgtqDpVD2DrrqzEfoTpNYmDVR@vger.kernel.org
X-Gm-Message-State: AFq9FYIfn8rZwipYyh+DCg090ygvHT8OP5AJl91Wlv1BfdRhUsdY0hie
	WHXjzP41RembNEkCHjh1GF8Y8mIyxFDj+8UgoIy74+UlpS7n9wv6PXQ=
X-Gm-Gg: AYBFou2zXpJWl1GyYvxsU2PJvlh47zr5yP9IUk21NlbgKQCGp7LsWNW7rtuzMlsixgQ
	KmH4tXC5wv6J136LBKDnutS5rhQfGprfvoX51rDwuSgBv+oE73gYCpGsRWOorN+tDVFzzziS1gO
	r+QaCa73+How+mVAc51Cq33XF9YHRP8ZV/JgjeOH5cvKEI9OCuOiNOmaO4xSuUhDBGro4nLhKSi
	/K16vn0v3+sirTTlNgRgiWJQJ99F8/vzpOGHYFGXEq7QyigFovfUCKUoYV5BkjOKSJtNQYAKTiu
	B4+4kA6i0afcpK+NTm/DN/WHpvET7qiKnyiUtCO8J8r+uKeSPhVjtg6y9qjxuEeJNyCk/csBQie
	ddpoIJ6Ar48nh2FhULqcQ/YLqzzrjjipLPUxqSnckWi7V1MyNlVfT66KW6YcQzuvAXs1VKu/BA5
	GDLGxicjojLkFoQDzgZ/gvt24BuLOSJkgC8Q3OlBo9G2JAnhFHSrCfS3KyHjfOLnazjl1VSzqA/
	bK28EoSsBFZmR22zWywsZqB74h5yoVAg9I=
X-Received: by 2002:a05:7301:470e:b0:35c:73ca:a1e0 with SMTP id 5a478bee46e88-35c73caae65mr2099669eec.15.1791886486576;
        Tue, 13 Oct 2026 03:14:46 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([223.228.14.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b690af3easm13650379eec.1.2026.10.13.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:14:45 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Tue, 13 Oct 2026 06:14:30 -0400
Message-ID: <20261013101432.9712-1-atharvatiwarilinuxdev@gmail.com>
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
index 00775b91b..37beb1a2e 100644
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
index fdf55c285..4b9e17d65 100644
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
@@ -323,11 +324,20 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
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

