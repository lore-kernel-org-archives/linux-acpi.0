Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF063955D2
	for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2026 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549982; cv=pass; b=CoIPtRdLF4vEKFffDv9TLVor9NZfLRB4eypTTyAOe1SxIedbxnZYfNVub9iC19kQIqTvglzjeIZuzQwUKxh08RebDHkK7kNcc/IAObBp6a1TvDh32v1XlBQYPYREP9MXVtP7YGuQRaln+/0MUtDJOj1sVUJ6ggLU8EO+ORPyLc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549982; c=relaxed/simple;
	bh=XYY5aHfKaVdbGbNj+y2tPfJIcR2z+VDczl/yLY5xZko=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g/LUcDsy3CNLRROg3Bf5VhlwlK0cCpu5oAxtRmcf6ONMHu3zkRJPhOk6RhAubAfIheDS04gFSvuTubZ0NhyOxVNBiNtOIyVSpl2/infBOKZ3REhajbYY1LVS/vQeV86VWcLPQN7z9R2Nxjil4jhDEx4M4h42QiqLYUN6DhuqFQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHMg2XLq; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHMg2XLq"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13721dfd471so4120203c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2026 11:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549980; cv=none;
        d=google.com; s=arc-20240605;
        b=Mn735UtDe1s3YG7RdfNpmkRqCk6qiTSDX9vHUgwfNvYMxLIt00Bo+Zi5jegnAng7JR
         raZevgFsbwwm8xy0mNQb1CDqQsk1naMCzbIP/10k5lDsami/kaQO32TEJZ+gcvxP8wKL
         eZYMpGw9xpBpRGHbPb8s8zGi909rcHoostySC/a243AK5zCumIRA9qCyt0m8TVMM4ONx
         lAu79Tf3qCOZU6fzGQ8wGGRbkeuRn2R1xBefGvpYGUK0JBLGisLaA3ei/MlLKzKbq/7A
         sVxFy9FP1Eq6JXwWC0mCHhiXh/UcYYwY0va7aDqnnqW/85jlkrtVYzY8OoEqCxsODa2y
         dIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nOVpPB2xMg7CQEH07CQqXRjU4JdVuqmbWwBzqGfwaDA=;
        fh=AL5RI3dc8BfHEEp4N+bTR7xPir+JDjH4+MWzFMbbKG8=;
        b=DvdUdMEjmc4FzvhnT88TxummoCstG6M8urKZIMb1oZxHPdfd6/pu0VQ48/mUIUIeri
         V+xBeVBFeBDEzymiVXJPiaB9S0eZOGvEhNhcrM+pMzhUNkpROiqvXfOFCgAhumoWLFeB
         mB4MFewwmMxjHtUXAIu9EwYAoRQ6y6Txuwa0A+CKEfxjGm3231nzSKnB/FBq/saerDgC
         bLrt7tW3rpiFe/N2kvbaCqJScPGFp7JxcVGtlSFeDU6+e//5qK1M34v6sDFJZp34VH2c
         QMI/F/7xNshAQgF6l9CkP9E6BnUdUbgeQ816EAspCXMccbA7uOJ6YetiIqSF6KqclKav
         S2yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781549980; x=1782154780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nOVpPB2xMg7CQEH07CQqXRjU4JdVuqmbWwBzqGfwaDA=;
        b=UHMg2XLqW4fF2ljkmOPit+dIIHEahCKgbmeeZuHadsKxtUs04Nf5e+Et3gQT2URaBf
         0jzBgYItTWEvAXEMM3mF2Z/hnKqY/lJ6R0UorxtUJJOfPAvH+JNxNt/zQtbWHulUIjsG
         tW7iimlde2t2FWtk6paQegPlSEWGbSTSz9LvWiCyqsYvmUU+6Zr9x2KIOxh+LIhZv9qY
         y+qCWUDNVMn7YjYJ3x2t9p73ymS0nexAGRMbgHHsqwgT4LpS7fyC5FCPU1pfYZMRvxtX
         KYOvrZoFsBdagwYQi8/SexO65RMFaPAtKqpIySb95LhP2Mf9UwZHFFHYl0f8vJEx2FLN
         8F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549980; x=1782154780;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOVpPB2xMg7CQEH07CQqXRjU4JdVuqmbWwBzqGfwaDA=;
        b=RdavtA1KYjNMTQCOfyWbWqYLarzvYa6wSQQF8HtPZLNrs6C1QDRiWae0j//Sz1KKJD
         zf7v0xzIs7ihjfA0OITmgN652ip+jFDqN53ehFBFjPxU+ltJhDzknFVV37We3D5wTi4W
         k9ROTYB6AqWislHfwpH2ujA5nvlO0dq9Z87oDu9UA8ezFRRF6OWMfM0QPedZYDoutkpw
         Bz2sWVpRFfHPAbhPAOX9tyTTfxB+r5UXIqxWxrg/h4lYQvguif4UKaHFUypOKxqtP4kO
         FLrwFTEP14lCKxaNuggzo30tLfw7w3/zRlYMY78XjAzCManw8aHggcx3hmH314dq6lGU
         d35w==
X-Gm-Message-State: AOJu0YwF/HGbNdjKXDDlyLRd7yTWIq81wV3LL1a5dye7bykBzuw6uv/1
	1CgxG7BVSnawC3C9dZNiqLyIcOPMgdrqKPedyzuZ4ivxA58bpn++VgqIRIpvq5OwoaD7vgC8Um5
	JbNdTxJSkSJz2Y3J2KUeUVs52yo9aD80=
X-Gm-Gg: Acq92OGVb3Vs+clwr61B1ee0tWd+rHD/q7e3GxTGJjpaHkL/S/P/3LWLaIPvLMMO9mk
	Rt04jzcEbsBJSOZQhbkCRACRtd023vYe36M00aA/KPBdOPYfrMxuF7Zq32EHd5l5uYLSI4B2LPa
	QrORrQu9PuElA9d+upxvJsOPQP08QvKxY5J/xkP/eb0b7tvVOF5gfFt5WVSMmyR2BGDm1Rhl6fL
	C/vWIJ053+OzfpuTQ/kfz094pY7MBQ81EW0aIfuczCLVvw57hfbgHVQ6ItADxSC/mURtgGkLBPN
	omKyFHn8pGuST18VYDgq
X-Received: by 2002:a05:7022:6082:b0:137:ecef:c935 with SMTP id
 a92af1059eb24-1386f24a584mr5033257c88.5.1781549980449; Mon, 15 Jun 2026
 11:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Keshwani <keshwani.anup@gmail.com>
Date: Tue, 16 Jun 2026 00:29:29 +0530
X-Gm-Features: AVVi8CdA3RvyR4R1kbfDzmxfsp6r5S5X262QbH-IpwBPi5OBUd_MBVHXidkI8FI
Message-ID: <CABD5TJy-sp0knXTpaBhJ4+zvc42jaDFggX7jKpqUvz6tTVhoTA@mail.gmail.com>
Subject: Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell
 OptiPlex AIO 7410 35W
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From b289e63d7f44500517dc94b7028b707616fd1dd1 Mon Sep 17 00:00:00 2001
From: Anup Keshwani <anup.keshwani@dell.com>
Date: Tue, 16 Jun 2026 02:57:11 +0530
Subject: [PATCH] ACPI: video: Add backlight=native quirk for Dell OptiPlex AIO
 7410 35W

Dell All In One (AIO) models released after 2017 may use a backlight
controller board connected to a UART.

In DSDT this uart port will be defined as:

Name (_HID, "DELL0501")
Name (_CID, EisaId ("PNP0501")

Signed-off-by: Anup Keshwani <anup.keshwani@dell.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe..10e3c1657 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -886,6 +886,14 @@ static const struct dmi_system_id
video_detect_dmi_table[] = {
  DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
  },
  },
+ {
+ .callback = video_detect_force_native,
+ /* Dell OptiPlex AIO 7410 35W */
+ .matches = {
+ DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+ DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
+ },
+ },

  /*
  * Models which have nvidia-ec-wmi support, but should not use it.
-- 
2.43.0
