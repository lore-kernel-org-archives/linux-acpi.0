Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3F4189D7
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158543; cv=none; b=svNK6LmeX8/TMjsiMdZMeHRd//b7cpsHM9z2JoxuznHmI7I5cE3vYhaHffo1Pg0LBlnDBM6N74L4endYurIHX2fkryhOvAMnU1USjrJtuUPfA4EakQZhT7y8/hCl21ifbMEx8v9pwlaJxQJAMNaf6X1WqQLnzhRqtSQzCBCK+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158543; c=relaxed/simple;
	bh=QcMiEMYwdCjlpEZ+6OgWUcYhyD7ZgPtRvz1hKGZrJ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCNQRNERYgYD1bPH4KqGQR1ycwGnvE/aNz02R10EhXUMJLlTyInR6CHFwinPEsRCc9f0ALTivyMr1aKZf4YA7lDOzWQkaL6BUvgs+65v+MgSkGkCIDKVECvAzQsF1uEeqhRxCnSbIvtjT4ADg6Mn5FMC/w6+DZh/IIn9dQsCR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5smmIAU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5smmIAU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383fff6e8b6so135591a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785158540; x=1785763340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9jQTmsQCn4AYRUZfs4Oss5+mTDISaXLcnv2LYG3fsw=;
        b=V5smmIAUUz14ikrBpOYy2fY0DlbH+sXhNq9OPlrG4Szw2w8y5FSWi4j4XxKx5kHKfZ
         B8VgnbQVbpVEmxMpoWY5WHyuIHglSc3cX0+EvjDLpYdGFo8nyBR5eExG/q9th3FYESIn
         mA/SKP9q+1cxNW63hkemRl1yWLKIhh0+wCPdBrT+eaypIqZWa1y5Y9MGVmjjiuaDE+oo
         f6TXeE/YPl3YZuW0dVojtvKGOb8V7HKkx7h+R4159HXD4eY/+K+aGWCY+skEAje/y216
         M4Yr1L9eJyE1arYTYqo5YNPr+g8D1mpZ9YLBgK5GXtAkv26wSkGLMBC7Ja+YJ+nGc7mE
         adOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785158540; x=1785763340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9jQTmsQCn4AYRUZfs4Oss5+mTDISaXLcnv2LYG3fsw=;
        b=lQKqzsH5QVW8UwSKUNsLhw0ma2TbKQepg5pHU4boFT0v1loDp84sfZbmAIBeEIqPuW
         ADOQH6Enl4ZBtiWuEIBWZVlIgbYUFsNVNNPE5ITMvjAVeK8q1u67JFwaJYgCHiQjoe//
         dKSPxKEXX9PcrYTyluJa4RKct/aFmhUpcUF1WaiUSFiT9+DbHAVLl28sOtoQ4Hl7Pwcg
         ZBMGpjOxO3KwvWYQzAbw3JlWHwdUgXOJTKfMIzpqm52w4r50BcUfRl5ZvK9VPIMBV37B
         tm8xbgGDjmWG/e5y/GlMT4xNT5nimd2wXq0zu7BneP0X4Kyt0Q3mTL6doUCGrftSBF4z
         wmHA==
X-Forwarded-Encrypted: i=1; AHgh+Rpa8Bj7vN28+46DBEv3W1rlh7wyHSCG5OppDuxzxnWWxIXmdAtimq8zPgc+bfO7+9fEfV4qelwKMQqP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzic/HuxUk3FfI6YFZxOztweqKiDO6D/P5uLSjgqktnN6a6U2QA
	OEA1eOoKimeQGTe+eXy6nrBRZzSXnsf+uQm5XUi7nR9z53wMTqcNx3Bd
X-Gm-Gg: AR+sD10bjE8ejcG1OnO2slKMRtmLtYqNE2c3ml0svqZ2MN723X224uPzyJw2Oae1T3u
	8cb1ewOmzG7XqVffIejQ85/4ACtZyQ8a+VoU7vSeKdjL0L7EmLOwa+SMwt9ZbxoDRNYeQxQyZeD
	C8olJ5U1AQ6mhJJH5GHtFwaAbbvl9l5KsEZ6sGlCQ8pdUF/gAEyTu0NPp/jGrGd5lxEYipDtQoG
	dics3/k+nQgF9UPItKqs9xw3WkRyx7IfqExYlZxscNwT/WiNx8W8I237D49nSVC8wILPslMUlRB
	Ky+jqPVgt15CoLWWyBJ0kNZZ7kI0gFmDgr/jgCWqlz28PuFZd2lNQBGqalzf1hwu9+OqjYLB0Kc
	OjLgHzpFqeVRJjOqLTrZhNhfRpLI0kgjGC4sKX6hpdeRa3YSNOjXlbgntTNa4NdWMVQj4Wj1N1n
	BWG7rRMD6BNbA=
X-Received: by 2002:a17:90b:4c0e:b0:381:6cf0:d5f5 with SMTP id 98e67ed59e1d1-38f6289b462mr168227a91.5.1785158539807;
        Mon, 27 Jul 2026 06:22:19 -0700 (PDT)
Received: from marcos-linux ([2804:3d04:a1ae:f400:ecc:47ff:fee4:ed75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e53094d65sm25117076c88.13.2026.07.27.06.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 06:22:19 -0700 (PDT)
From: Marcos Paulo Medeiros <maarcospm1996@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	Marcos Paulo Medeiros <maarcospm1996@gmail.com>
Subject: [PATCH] ACPI: video: force native backlight on Acer Nitro AN515-46
Date: Mon, 27 Jul 2026 10:21:51 -0300
Message-ID: <20260727132151.12792-1-maarcospm1996@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer Nitro AN515-46 is a hybrid graphics laptop whose internal
panel is driven by the AMD GPU (Radeon 680M); the discrete NVIDIA GPU
only drives external outputs. The firmware nevertheless advertises the
NVIDIA WMI EC backlight GUID, so the backlight type resolves to
nvidia_wmi_ec. The nvidia-wmi-ec-backlight driver however fails to
probe ("EC backlight control failed: AE_NOT_FOUND") and, since the
backlight type is still nvidia_wmi_ec, amdgpu skips registering its
own backlight device. The result is no backlight device at all,
leaving the brightness keys and the desktop brightness slider
non-functional.

Booting with acpi_backlight=native makes amdgpu register its backlight
interface and brightness control works. Add a DMI quirk to use the
native backlight on this model by default.

Signed-off-by: Marcos Paulo Medeiros <maarcospm1996@gmail.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 5b0dc679e..07755b856 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -919,6 +919,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-n0xxx"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Acer Nitro AN515-46 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN515-46"),
+		},
+	},
 
 	/*
 	 * x86 android tablets which directly control the backlight through
-- 
2.53.0

