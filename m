Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5440DFCE
	for <linux-acpi@vger.kernel.org>; Sun, 22 Mar 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193781; cv=none; b=uTkrPS6V4JwIVQRxYE81Ye4zbuW/cefCEadCoW8U+TXl6MMuN8rhRKYXbdlS/5MiJWu7+tvEyHKY/jmNzXLC2iE1g9/rUiSQWZeM3Cnr+yUqdbE0CP2RJSHAfilAInkiQiU9hndZLfxqSqYFHzADfIm8Onm2iOwBYFd90FwHNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193781; c=relaxed/simple;
	bh=yOhi6aKiUR4eoyYlcX4c+fiyhV6dey/Bi2f/oYdMhDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nz1oIISTxZDsDSlft2g7HGEM86N+wYYx+YCAtK5/5yxT8tAPVe6/+GuMXl4rXDDQoZYrlq5TEaAfvW7v6BBj0msiJbNyOo78IxiMhJFCm5Crtabsq8j51i772ZhL31aZT48ZEOgCgBt3J/VxJZAWJNv5nDyx9gBUuOQrtBmXwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il4smo7F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il4smo7F"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so2440086a91.2
        for <linux-acpi@vger.kernel.org>; Sun, 22 Mar 2026 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193779; x=1774798579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WiiyveVbIeJMUarYCtN7n9x1v7YYVzdYgWfcDHMQmg=;
        b=il4smo7FQR0fX7QULkF8QeclxTjpHELS5FnFcvr8YpOyP1igV2JFrFfskW1hiFUqo7
         hhi5bub8atBx4KwCattad3skcE58qkiFPj6SqGBcy6sU8KOak9xlX7/qaDcSaJmwkTHE
         9caS8iqcmEAVvplaY8fyqug48Xe+acA/XbLdvSFhptGtJMO3wEL5q3codxxkip+lrt9X
         5xZp34KKQV+gXzMHM55nE5mJHVkpigWjDH7kRJHbtzvVKdJmQUDcEIsMgzOzqoOYg5kH
         z//QRWlVFTnvT4qsHVIGFGWaoblAjfX8EjdyNUR1d63L/bDgaL+nZo7o+9UqstiICQfl
         d4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193779; x=1774798579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WiiyveVbIeJMUarYCtN7n9x1v7YYVzdYgWfcDHMQmg=;
        b=WBw4kAVi4bLWEIRE6C/r2VHShHWlP3YeajSR7Zw/OGzoLGhae7n2contDn+acxru/S
         Spk9MYcawX35BEPLMRUEa13XITI8qZ9OdpNM5DREQ6O0sl23BC8j7NYVL/24wfRj7Lvm
         GwIM3vk9ei4D147E/QHa3muLeQQ8UlG6OSQtq+0lR2bJuld6R4vNxwv7Veds5jFFj268
         jo273DN1MhCF7vetCOmy6czHuDurykF/u+2QQYNqjEM8Hbth3SjDuRhej6y1RCkgvi7k
         CYNjOUd+Aw3SOEn9dpACI9ViGvmxBLqs+MhF2WRGeosENTPp0mGpC5sQSaiLHigvGATA
         FJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuoNi7PFrWf9BqfWycSA6ZYdhyZ3eXWltWE1YkmADdG4hljysQ176hHW88QusNWyTlhjOTPFoYv3we@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVlXdLfLfiBg28a8RCPr3d1q7o2VL7edoGCK9QKIags9nett0
	VJGJai8eu5bYImy8w47RFJXMryK/aiool4XhknI77xClsjeHxGVBoTlc
X-Gm-Gg: ATEYQzwes1cG5iOjjPtkR9VmNHb/BgkOWj55Mt1BsD4UuF3q5KzYL6ORnPGKGxbubE7
	mgksBU2Fxw/gjEAeUeMtRy6geVzUMaIxlqnUDKF9fUqAUXdacAnLdgjxxGybgkRLLRCyTtl0zJh
	CZwYS2Xw1DfxiODFWnjRph/VOAfW39sUcIX+d0tmDapcsPwkK/xmW2POBzSMo+6hYLHlY7IHqlR
	sQoz2efFMEAukfymPMSLv8FOIHFj3pF5X+5l2xci4uUEKwLzC0+CnjMrrjbdL4uxqq3F6EzQKFR
	Bj8yDENj8sDMVfS3Lati5QBGxPpUV2Wpyo6JvNtu7VpybMfmTXCVuJ+L/rJ/cw+yHCdMyq3iRpV
	6ZO3q9yNUvE6hJN8vcc7mQabByrEUMzvZgSqKDo5ztwxtF7CZzn4xev73XAewm9zEpwfnv5l1+v
	r47roIu4cfP8bA4MKzFCHxxG2CVrZi71ryW4yQlRcL90MF4lHoLDa7RIKk0r+38hWq7mN0O0O4r
	9OZRuV0kP0=
X-Received: by 2002:a17:90b:380c:b0:35b:b537:b03b with SMTP id 98e67ed59e1d1-35bd2bd57c7mr7961148a91.2.1774193778922;
        Sun, 22 Mar 2026 08:36:18 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd2665e2bsm3166405a91.2.2026.03.22.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 08:36:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] ACPICA: fix NULL pointer dereference in acpi_ns_custom_package()
Date: Sun, 22 Mar 2026 23:35:31 +0800
Message-ID: <20260322153529.3325784-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_ns_custom_package() unconditionally dereferences the first element
of the package to read the _BIX version number, without checking for
NULL:

  if ((*elements)->common.type != ACPI_TYPE_INTEGER)

When firmware returns a _BIX package whose first element is an
unresolvable reference, ACPICA evaluates that entry to NULL.
acpi_ns_remove_null_elements() does not strip NULL entries for
ACPI_PTYPE_CUSTOM packages (fixed-position format would break if
elements were shifted), so acpi_ns_custom_package() sees the NULL
and panics.

 general protection fault, probably for non-canonical address
 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range
 [0x0000000000000008-0x000000000000000f]
 RIP: acpi_ns_check_package
 (drivers/acpi/acpica/nsprepkg.c:634
  drivers/acpi/acpica/nsprepkg.c:110)
 Call Trace:
  <TASK>
  acpi_ns_check_return_value (nspredef.c:136)
  acpi_ns_evaluate (nseval.c:266)
  acpi_evaluate_object (nsxfeval.c:360)
  acpi_battery_get_info (battery.c:537)
  acpi_battery_update (battery.c:1007)
  acpi_battery_add (battery.c:1237)
  acpi_device_probe (bus.c:1076)
  really_probe (dd.c:659)
  </TASK>

Add a NULL check for the first element (version field) before
dereferencing it. The battery probe then fails gracefully with
AE_AML_OPERAND_TYPE instead of crashing the kernel.

Required CONFIG: CONFIG_ACPI_BATTERY=y

Fixes: 7952d40240855932 ("ACPICA: ACPI 6.0: Update _BIX support for new package element")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/acpi/acpica/nsprepkg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index ca137ce5674f..c32770570120 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -631,6 +631,13 @@ acpi_ns_custom_package(struct acpi_evaluate_info *info,
 
 	/* Get version number, must be Integer */
 
+	if (!(*elements)) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package has a NULL version element"));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
 	if ((*elements)->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
-- 
2.43.0

