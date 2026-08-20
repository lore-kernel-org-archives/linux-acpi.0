Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905432D2394
	for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787195579; cv=none; b=hKGoeJzewdp+HUiHDsw/JorB6h54akRoFgBZFvZeMKhzOCNBRZOY+vkxX2s3c2eWc7g8Jmx6JPt7VJoPDxudqaf6IsBJGwmL05xflagjrlnJ3DUFlQr0W0j4y+PMpC0LZoVICGsn9+7p9GrZY7bYBwFS0IA4wlDY8jMJ9wZrzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787195579; c=relaxed/simple;
	bh=tY2r4cZfzqGkUWbFCIooDXOZXg+/9YYIyUxW614c8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZTwwbjjqGU4KbsbEV+eg22hMyWZJtkIKeSBjyoj2sYhQtWHcCylosqXI0j/0ELD4Y0tiYmUM0M0XpwUrPBc4ZvOKuRjt1PwFM7s+0E09hrJ9Qi+Dc+O63u5xNWDai75xBl8V3w8XFKMvG+Y42PRMCNRt0M+AKR8CYojMMynwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKzWhjrk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKzWhjrk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so17203105ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 20:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787195578; x=1787800378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0FTkG9CYhIlgFIGlCi/E6RQNAoU6z/RvhBai548Bg8=;
        b=YKzWhjrkudeorkjmj62phQhkFzpTBYaCCfJV3LqKj8/i31Otgh7eYh3hAHS+yt/dMb
         4SHL+LnfB5KACdJ6ZJLXfB8WWq7COBEl41iS4jMhXnADe0tWOi2iLvNN/neLTfVLNzTX
         Z7sWme3/m/6Yl5qLOCW4fj0jw/27vx/5j5wXrH29mWoBfNrnAB5oFq9QiNLNMz3Eb3fX
         1g6ydE0kVGPNIq0YyMOwi7oBgXOo5Bx4BWOFwtv3UWAJcXS/cb3NbCyEQg9gNyLl2xB0
         wuCPMt5sZmBOyVsqOzegBymJEpcE4iw5kR/Lfn/AKndUfd4HYmmBX5N0Q4nVfUPH7Fhp
         aqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787195578; x=1787800378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0FTkG9CYhIlgFIGlCi/E6RQNAoU6z/RvhBai548Bg8=;
        b=WFvHsBHloinYJupGBg6xKR+snb08HzQu7KylfIY6NGJCjLGdN8sTgSp78Knph6frq6
         uqS4mK1tmtG2xAUAM70JtVs/qb9uxGbA0V5yzdGsv6phSUiK1svKcFEZEf/96AFX2S81
         PCjXQGkmhONv3JoQ0UaY/q1C+H/rOfzTDYQMRtF1fE0bmbXpXCxdjGzKEsZLxHMPMyCn
         xSBj46xmxlgDu4F6hiyhFZIRkNG3pQy0wqzAOlb63kZG99TZGyNf6dh0dXVLZJpQcBX6
         8vHW9jBgrbzNJpekpZHCzdKeXoqHUpVOdOMIdYWpi8rYny6Iy5taAdnoqlBfWMqCvgcl
         dYVA==
X-Forwarded-Encrypted: i=1; AHgh+RrNlAYAtfBehqgH4LKzMvk94qp2eJE05/zBDZ6bp2w942VU0RXwv5KIqqKcjuBfBkzUXL/hxtximkFx@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoR+GQ6l36WbdJ6+IpDGT+fE3Y4DCdMo+ikX8RrEOwcIedc8N
	QHAqqL4fKgkay3ZXUMjGxkXYxRj6Mp4isM/RRaOz4rZ6M0GJSum52FA=
X-Gm-Gg: AR+sD13x54QBXBP/TB8HAI5QHy8gtlF374SUq3hIMQYkGRXAOF0idCpg8VMAXbc6HgH
	joBvwWx+Lcw5DuwbOYcYVGTM6dhmx3rJvYN2thcyuLIYhOdQ5pNHIIO6277zP3f27B1YZ/BmDdQ
	c23wBpRMVISF7qsOat00vz3iYdH/xqNws/KQeFK9ZO6DwKXgPSKwdlC/OTLeqzeFb+mWI5aT5JR
	nuTifdRX5gf+FGTR7TurD7jebI96vJjYS1+3eTZTdWlfKuyXCZhNOtwHt/DTHY8HPoNpR/BYDtY
	0b4nIj3lUsd0vqNeyZ4ycevd3UuVGAdrmIBgL2+gvY0DpKEuNI8dxdohnk85CUv+6ZIBk+G9ZIE
	6YEDEBDAigRFmnZbAmSn8tDTQfyAvGDxw4cg3vvPVqkK0An+wHKxIWx3h20wxVuBXfesnhTDkh/
	IdgaYOQ2qRU3Za5nPWHd5L1HbA8OAd/n5wM7RhPhXBj7yzTW6l8LDX0Yz4wD2keRlWb5R5LPkC3
	Q==
X-Received: by 2002:a17:902:ef43:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d5fd5ff363mr180029815ad.1.1787195577864;
        Wed, 19 Aug 2026 20:12:57 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1c9sm1289065ad.38.2026.08.19.20.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:12:57 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	triet.hoang.dev@gmail.com
Subject: [PATCH] ACPI: AC: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Thu, 20 Aug 2026 10:12:53 +0700
Message-ID: <20260820031253.1636952-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS

Also use pm_sleep_ptr() when assigning the ops to the driver.
This allows the removal of the ifdef CONFIG_PM_SLEEP.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/acpi/ac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f19d6dd43473..eef0c8e32d73 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -239,7 +239,6 @@ static int acpi_ac_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev)
 {
 	struct acpi_ac *ac = dev_get_drvdata(dev);
@@ -253,9 +252,8 @@ static int acpi_ac_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 
 static void acpi_ac_remove(struct platform_device *pdev)
 {
@@ -270,7 +268,7 @@ static struct platform_driver acpi_ac_driver = {
 	.driver = {
 		.name = "ac",
 		.acpi_match_table = ac_device_ids,
-		.pm = &acpi_ac_pm,
+		.pm = pm_sleep_ptr(&acpi_ac_pm),
 	},
 };
 
-- 
2.53.0

