Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F342D592C
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168274; cv=none; b=p2PMZg0lR4JOpDRHY/CFtUFl5i63k5ysJyuNpQsZfn0JOJNDwv6J79ijui4sHzS5RZC5wAAicRtwPf9WDOMV3iOcKg/J95G59Kn0QXRjXM8Z67tNlR2x17xujKFZf6IuIAJPd3zaUZwGb7+vDy85VGlxcn0TZ+4hekoRxZ7uHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168274; c=relaxed/simple;
	bh=lhtTz6r9h3gam08PpROtwyqAJ6lm3HQYUI3xZrXDqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbxdbExTZ3UivLmzhUPkhMND3V5FXt+1QT5+3MR+XqvFhOgfNXKJKGk0TtLJSvTZKf6fk2iLTQrykpxTSR3FRwACq4sCIPmDTtMyK5hbSP4BKsvQCe+ywIhbo6eZFZNrsExcsCcZjSrs+Ko7DEt2JSkXjGyAPNO/zxD8Y3EGhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuMpEM/J; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuMpEM/J"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e97863425so36159991cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779168272; x=1779773072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=BuMpEM/Ji2NNQGRz9lcBiY5cu2OvBHGUvoaTdvSDLh2jbEgmPq5rfW3GKrtFVirNIm
         HgPJ0QJfKDj7E3WA1KwXSGFNrC1kXnXUB55rfhxDVLkWalXbGZ58l9tenghUPz9tsJ1M
         Fhhsn1Bp1B+UsxotnVevlJiqAsp7ynQLlo90VD/P7DxQr+j1LjiBDW48AVXwjd90WimX
         PhB89HlGv+GcDwUPXadODJMpeV+WMSTTIyVMXqU6HZPGD7BOilHc05S8nAxvqP/ZWGK4
         d4zam+PCP90O8BMmzdWcTWHxu1t2dlDj4g+vPdz8xCUutLT0YCLW4DBMidsYU+2HL1XI
         jRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779168272; x=1779773072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=S1Oc7vmuchFBny50EnfI5FjVhrIs3q00BG6+j3pfKsv0H9i1wvTkiY75dH5eAk/2aF
         37CHmpNQKjx739FXfKwxm1njBSAs2TUzmlx14PKwAj6cfQKfZZiexI/DyRb4hYZz09ex
         TaD2P0LvFAAG+8fSHR2U5747AHIyD6f1KVqNxzMSFbYpanFSPEfYVDoLKgGDhato9814
         EzV+y7eJWK4752SB/M+acXQfL1h7PDKARLqkx66J+yzGYGuG+XmRwaZ1bwgBuqw5tz8S
         baxji1g8SqWn0QPtvc3nhTr4jBhYBEXOSGnCnagDcKj+n1XZcGKbCbq0k5PeiagO6Uw6
         v3dA==
X-Forwarded-Encrypted: i=1; AFNElJ+YwA+4eXPPbA7HzkBYCSf2d6P0x8MoPghXEMwd2meUfqQbjTk+HyA9eHa0+/f3kvvQbP3/zsf4sgNR@vger.kernel.org
X-Gm-Message-State: AOJu0YzACKNaJ5azQIhyJB7JgQgp0rLcd3CPoDdLCcO0FCeY5bgpA55V
	eqVGhVNHAxPBvGRrAX8GzYPqMWnwIFN6UmoHltTTgJNS9EjuF8ht7A0q
X-Gm-Gg: Acq92OFldFX7uxpxxSxUy5sMIby8tendw1cCCJS9VGrvuW1RynYhvDvDuSa0Dsy52Dv
	xCQnDUonUIKDIggW8H2+nDjn3HP7fAkzmAss+DYVYAOPIcRe+La/pZYZ93iwdvc5/KbWvJl1jQi
	dHrTo7k2HdJ6NOf5c5xdqzDsHh2l5bLrNT2Vggol8SNPNMAm7IsnWZFhGlcXTXBPF02Jxhy9R2J
	I6nv0IKv6i7f2ePjc5FEHgBEBGeqiDk4V5QidW8g34XPR9cAiL/yjYZBz6jdAHtiaMtGkmWYliW
	/v91UMkEo2Jt/TpJzc1+RQTcgzJQQlG5J+tECWrv7C32km5YCVO+em+Cg2Og3H5QAGSKhKmbFS9
	GDuFZXHZ3rllZs2z4zPNxfR0L/9qsPUTN8EGkzwijbEWEVq8rb1P6ROIQ/moNz1NT/z8SfywSyQ
	ZZhaPYnG+y6R7QlU12sDQW5idcps/AjUrtHqrdBYfbZjUBdoVG732MSLzgRw==
X-Received: by 2002:ac8:588a:0:b0:50e:defb:77d9 with SMTP id d75a77b69052e-5165a22032fmr243600281cf.46.1779168272348;
        Mon, 18 May 2026 22:24:32 -0700 (PDT)
Received: from xps (ool-45718bcd.dyn.optonline.net. [69.113.139.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086ac6sm81286726d6.7.2026.05.18.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:24:31 -0700 (PDT)
From: Jacob Bazata <jacobbazata@gmail.com>
To: wsa+renesas@sang-engineering.com,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacob Bazata <jacobbazata@gmail.com>
Subject: [PATCH] i2c: acpi: Add VEN_04F3 to i2c_acpi_force_100khz_device_ids
Date: Tue, 19 May 2026 01:24:24 -0400
Message-ID: <20260519052424.7591-1-jacobbazata@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This model trackpad (04F3:32AA), found on various Dell XPS models
from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
at random, exhibit excessive smoothing with no obvious cause, similar
to other trackpad devices listed in the i2c_acpi_force_100khz_device
_ids struct.

Forcing the bus to 100KHz eliminates this behavior.

Signed-off-by: Jacob Bazata <jacobbazata@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884..512ebdfcc 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
+	{ "VEN_04F3", 0 },
 	{}
 };
 
-- 
2.54.0

