Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AAE239085
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067865; cv=none; b=imIqzzEY2Cb4u4l8PchlTk6gJgBEGAUTv/jmRfwOlKs72AqLifa083radp+BzbxJ7TrqDN+wO6ZrJSoBepfsCx/3Rfq0aJg6jqVWu6jCHaW8p1OgxL7IERyd64WkPNY4Dyml92YQy+wX56QfH4wff08zHC/0sEDDWRjZZb2gSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067865; c=relaxed/simple;
	bh=PYarvIk4stXWbmENgKi5cQ3zEw7C2KPueXSGbpom3cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fn6++ebWxreZoSD92lFvv5/x8OcnzhRf/4XLBqnte/vSZW31OwMIpjm241wT9nZlBSe4XorIfkmNqd7dn74x6BqhQJs9K8uR6PRYiZvhksUznwWe/g2K/Mb8tYB+CLWswru4yCPbi0IJ09FcvNdxk9777Dv/osgmlboW3/KrlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH0AIKEJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH0AIKEJ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5c9211d2so227817985a.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Aug 2026 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786067863; x=1786672663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daDjSIgh++0EBQy8pk/MlTH43hFTaX8dzx/fJmq3gq0=;
        b=ZH0AIKEJrkpnitdIA5FVi4P5gZED/IisrRx/vZ93+85kyB3xc8LjBN+fwlA6gXACNm
         6JU2wyw1u6HN/Z5+XEV2B95/maQpHnN7iTlhiqcGdifIAMpRUMWdr4QK49H+7VGU/Twy
         ytc2OPF9qwFOosVdBq8YdEF/LQfjuZjw0mozjS/mU9UuOFAPvl7UiNRlf2OB4wVvIgSN
         /rcj4ajYRuF4RyKOMiciJNxmt0DJFRysBx0VaPANp+KCUbGF0/SW0KRrW0cmQCSeItFd
         bN6XR06slzSVokCKGY+xbpzmeBV5ICUBs8LL7i2PMNkLefNKtvxiXHBsao3j/1tsTcNy
         FKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786067863; x=1786672663;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=daDjSIgh++0EBQy8pk/MlTH43hFTaX8dzx/fJmq3gq0=;
        b=jsJFIWi6F3TtLUbeIIfzbH9OftfkhqaRxoPePJVacAJI3uyLjt+mgERyM8WkGCzYGr
         GnZKN0oyQAk+TSwiuAm6qv6J/Sme1iVvADcbXRrgx8Yap1KigJdyODZe1ze1+54NeqaJ
         ekFwz7juKKE4Mer0Et/HHSEOdrNIcFRkoj6HoXAxpslXiUeFi4rYiIEODpP5IWQAzjxl
         tuYGsP8yYoiI0NprZypX5qxHhFK6Xcf7qzu+BJhsZ9iINUv/59+mOvbgwf2uZzZx9rEk
         dzL3cxdTHOr6Gls+Fz3zVI8U6IQmxDuOrnMEA70byuAfNzSTQNX3Mrn+RQPoAbsdNmC6
         lcww==
X-Forwarded-Encrypted: i=1; AHgh+RpXdEz8cOPP91lAmN+PL1lo+H+bZBxuhtIlW16DdxAUyneL42H0yRAyUlxpByQjm500Qfwd+np3dQdK@vger.kernel.org
X-Gm-Message-State: AOJu0YylFTPZLkfB6abOe5bC1Ge7lhMNiZrtjlMcBJlczBQ046yivA6P
	n/85M982/yfPKyQeI8FBLgb6qXFUMGSEKTZ/k/6+rbbL62yb3V1YmEWA
X-Gm-Gg: AR+sD13HTSJPtL3NEeLOsLM2lJNgCLxY1t0PGj5ytLoRrAFk9IUhuMUU+G71q6W0ky+
	a7B88E5J3hx91i1OuqppsLNeN5jgBSb9aqHxPp5Y7i5H+Lb5IGbGInAX6bTsKKVr5dL+M28bO/Z
	c8ZtiT7ftovALNKbiJa4q4E4SU2a1rbtQurSZXU4joz4GjSM+NGVq2QQbXY6NKrw8hoWKGwzmgX
	g9AuzH3UDMk8f0wKVM2vn28HD3FHcvjqv++kn/FjWchJkq+Ev6BWiyeglzOziSbJBDeVk9MnGc6
	ah2G3040t5tMRfy5Cx52CASKZmPy/5cpTTk92rDdd8reqhoP5jYNp+hSgK6/D0nh9tuoJhs25zR
	EtcuAdOr5NsN/LAiJq0wSfEcbUKps+8+1LTjGUkJ5K9QzaFf0C2x0NK66meC9zJzXCgjl7NDc/2
	0yOK4zoRlGYP3v7KsGyopolONxXjqspoKZXVorqRRLdHh+U7Q/apN0Zq1Pk9FiwlRTEFgXOojnF
	T0Qti5Lt1slefCllPPS+o+XikyYdX3ukpybhpYgGX0L32/vhQWZhjL743e0Yvs=
X-Received: by 2002:a05:620a:4d98:b0:934:9fe8:6b54 with SMTP id af79cd13be357-936491651b2mr1383857885a.31.1786067862818;
        Thu, 06 Aug 2026 18:57:42 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22695bsm44311185a.25.2026.08.06.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:57:41 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] ACPI: video: Release PCI device reference after lookup
Date: Thu,  6 Aug 2026 21:57:34 -0400
Message-ID: <20260807015734.913361-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

video_detect_portege_r100() uses pci_get_device() only as a boolean
check for the Trident CyberBlade XP4m32 device. pci_get_device() takes a
reference on a matching PCI device, but the callback returns without
releasing it.

Drop the reference after selecting the vendor backlight quirk so the PCI
device can be released normally.

Fixes: 35a341c9b25d ("ACPI: video: Add acpi_backlight=vendor quirk for Toshiba Portégé R100")
Assisted-by: OpenAI-Codex:GPT-5
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/acpi/video_detect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe9d4..4c1c3b0b5499 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -137,8 +137,10 @@ static int video_detect_portege_r100(const struct dmi_system_id *d)
 	struct pci_dev *dev;
 	/* Search for Trident CyberBlade XP4m32 to confirm Portégé R100 */
 	dev = pci_get_device(PCI_VENDOR_ID_TRIDENT, 0x2100, NULL);
-	if (dev)
+	if (dev) {
 		acpi_backlight_dmi = acpi_backlight_vendor;
+		pci_dev_put(dev);
+	}
 	return 0;
 }
 
-- 
2.43.0

