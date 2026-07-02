Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAF3191CE
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034763; cv=none; b=bBkBvaJ0Rk+pV7Lmq4GcGMLldc4CIgLN0L2vCLlSa+aXt7Cjb6HQvwsP2S9NquhJChTlxDnn3xjM4Iw50RaOucrlHgePTYWez8mp/3wUB4m5dvcYvEEq5iJAyhH5rDMTFfo0g0zYGEUkICCz7PPFGfuIvEiKxp8jLB/QDP1Qxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034763; c=relaxed/simple;
	bh=2fBn9uQ13xUI3bkdLW+iPy5SLta9Dh1FDmBU6YUf75g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsd8VvGXLjavla+u289gzluzvR/eylMNOXgkGaJ8MNyM/3MwFmJ7TP+4k+744Kl/fQo6y8Ck8XL+o5N9hp2QjfEYEatUqzXKR8Jxk6GDMq4vIWC8Vt9g1fwT9aLJswtduPU8DCFBcRH7KWcTp/h32JejmDJux5h4UgiM/1j+y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cADm+N4s; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cADm+N4s"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f23e851626so19255786d6.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783034761; x=1783639561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVks+nr0O6BL6qphy8ec4fsdEnx8+iHy3YuzoqMy53U=;
        b=cADm+N4sssv/Iv+unF0C0cVHNqFXlkC/62RK5LGXmpGBCj7aM2aHjfbpInkFmmEBLF
         lyadreuWs5iTBYZ6EzHhnlYMsYrNaoHP/LAB1qxCL1H71mwE7UwMsMg9DiFI/XWf63vT
         innchTSr8wnUZMxpz9NKLFAcBa3J8OsvAN8ihEl8fieoUe08ARkgo+ejwOt56EN7PnEa
         x9+zAz/izTGzbItJ21myw2Xzbp7SQgjNvhAkI84VwIXNpxvGVQZ4E96jYtndF3SFgams
         7rqAO6SdhrPcQSy2kowbav2CerdLRsndsmKw57/GthF+j3Au8KXvCmTCuy4ltveGVyWw
         1vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783034761; x=1783639561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVks+nr0O6BL6qphy8ec4fsdEnx8+iHy3YuzoqMy53U=;
        b=bgVKyU5IAxrF+FhwPZD+Nv7Vw+o4HkpPt7l7pUh9LonzQmOHUDRdFlhDLQ4pVq7e3j
         nEqJxKNTHfFXGxtPI8jC1ze6UY7kZrI3cA7Din1/rVY1hK6q4xB1APTl6gxvWuujh+lz
         xHq6AP6wdGVuDSOpiXFTr5VYN1Gj8YorppcHkpl6fLjRxIPyo0mfFmUdt9XaxxsN/hX8
         0sa2fd2WdcOl7ZW+gU3q4oZ4TjMc5JZMx9gBPIWHWokU5E39uxlKLidA3rPhRhhEV3P6
         zhAMNRLmRpaE3ZlxECwO5zghJycTra6E27IecD5QM0Q1qY8Snzmv2HOzKaS8P3cM460H
         7sig==
X-Forwarded-Encrypted: i=1; AHgh+RpkzQJFx5UR7MpgNsEJqm4g9U6ug4R1eFLq2U5IohFgR+qcC8FdHRvvyCebcxOJMJ+0JittbZGQpfBC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91QwgdA+xJ4xygTO8KX0t9jI6xCWgcJtzs1a2xGVFZS0nR8g8
	7IX6uphITgzsmd0FeYGl7LwgXhCtM6C8ny3VbSpEqAR7KJqdoVqisqRf
X-Gm-Gg: AfdE7clOf5bB+6g7AlXN5Hf8G3ttzGm0NnGfeW2NixDSu1Hgr1GocH5asvpzm2LZ3ro
	kCTkKFW86mCQPNH4rjlFasrvGg3FUiozLoYlMVeDd4fbx+CITOWmgtebgprVUjjfo29W0DKchbT
	lsEf4mg+I8ggmFlg8V7Eb4R7cTKCthG+icemCg4/Mbpr6DfvXhJvJYjtelzKpDeumpE6CmAkh7y
	T+CVA6O/IwxBeg5NnyAUtcsB9d3Z9JGDhq4j3BljqZuzPcYH0MztPfHfb2RjMNeCK+nNFGo/oDr
	FQ0DM5tCyOyGk+Y2h+Xq5GOb3UV2utAg/bsJN0UmweVnUF4zleiCThNHp3/k1sYTpRGhw2yGyzo
	qBAmaK3x6kgy0jxwU4Ye3KAQbxi6gjTUiuYlWMotzIU6jHtveqdrjyanPicgxrjmATL5mOtLtJu
	2tKyhq7n+yMsqpqIWafAcRrrMUlGnWwmFqdHUKmnrrheAuh6NXb6tqsP/zn80Qunsg8AOzkhDPk
	q88eHxa8PZ0WBefkRTRBaz9IQ==
X-Received: by 2002:ad4:448a:0:b0:8f0:f35c:23ae with SMTP id 6a1803df08f44-8f3c90f3805mr79103196d6.29.1783034759655;
        Thu, 02 Jul 2026 16:25:59 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471815818sm39392936d6.31.2026.07.02.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:25:59 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] ACPI: sysfs: Fix hotplug kobject cleanup on failure
Date: Thu,  2 Jul 2026 19:25:55 -0400
Message-ID: <20260702232555.96539-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_sysfs_init() creates the ACPI hotplug kobject and the force_remove
sysfs file before creating the pm_profile file. If force_remove creation
fails, the hotplug kobject is left behind. If pm_profile creation fails,
both force_remove and the hotplug kobject are left behind.

Add the missing unwind paths so the partial hotplug sysfs state is
removed before returning an error.

Fixes: 683058e315f0 ("ACPI / hotplug: Use device offline/online for graceful hot-removal")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/acpi/sysfs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 908cc5c7e643..0b642ba1a526 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -1037,8 +1037,18 @@ int __init acpi_sysfs_init(void)
 
 	result = sysfs_create_file(hotplug_kobj, &force_remove_attr.attr);
 	if (result)
-		return result;
+		goto err_hotplug;
 
 	result = sysfs_create_file(acpi_kobj, &pm_profile_attr.attr);
+	if (result)
+		goto err_force_remove;
+
+	return 0;
+
+err_force_remove:
+	sysfs_remove_file(hotplug_kobj, &force_remove_attr.attr);
+err_hotplug:
+	kobject_put(hotplug_kobj);
+	hotplug_kobj = NULL;
 	return result;
 }
-- 
2.43.0

