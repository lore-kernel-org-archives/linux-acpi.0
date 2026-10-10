Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF24A7CB1
	for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791636586; cv=none; b=gBOwHHwILDPmAkiM0dBMs4N0A/xKsNixNgm+dWxk229UYYnCmi19/qisJPA8aFxzfDYArm31+yt6r+8w9dzahniHDq9MeiR2FoHcArK0xw6aUP0t+VYAG6d2xb6PG7ES9K045BaGXK30o6nw5gp1rOW7NTaha1tBDNSWeTrVATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791636586; c=relaxed/simple;
	bh=1kvBvnU1XqG+LB+Mu/IPw77rDx6+TGEn8znDEATvlDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAKP0PrJF2jaaWTlpEUB7yog2HLLpj5ARr2n8/DVvn8UJYuX5XFajW4VozmUuTTX/QW8NrkDHNShmt7qcYy90IPFcNK9h927f6QToI87I5CSoTTzBMOL8porUAoks76XK3/KM5TbsMtbLxhPAIc+qDvg9KP4luitcXq/XK2ik8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoSbUdH4; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoSbUdH4"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso991452eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2026 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791636582; x=1792241382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mthh0Sv1VUOW5+w7XlTGMrRo8ZjYlLW2iXmgZOV9P4Y=;
        b=RoSbUdH4+RXXvTNxJDmJgROevcokfEtlhB+kRQDpI+mDuR9erirySRkE/TvTdTxvMv
         g6ML8zVCrDcUP3LjLYz3g/8GVhBbeWrdDwrhmLZeUVmrfWiI/BQ7Q26qN+dkHkCPm5d2
         Es4AlUBW4zsjfIkwjDIILA0TeyIWk/o6nKGaq1fu8+/bHVhe09Zzlw8BtP63/SLwbvX2
         sGyx1MatHGVAxMMlYGiQR20QBF++ggBoNoW7jG/XtCXuHa9KgYFoZRW1EaXgCMJD9yKB
         e/Q14BIPpq34wFWkxS+bRiscL9OgrORZHjpikBI93v/wiNFj8zxAYVKRZg1VwIoCyYzK
         eOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791636582; x=1792241382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mthh0Sv1VUOW5+w7XlTGMrRo8ZjYlLW2iXmgZOV9P4Y=;
        b=KnFf+4Pcgs9dtIQ+jYUPFitDM1BR67pGxlweRcBlrtdXfu+k4Ffb172+COKupqD+Xh
         8QXVEUwvc3zB7KwUMR+wwcuIcrY4qEUzZwBWMDUzBP10cvCTh9bPCEE6VNS31xqTV6YZ
         /+YiehMEarjTtmuJT3aagzYkumqKdaIDSY+yx2RXx/wlA9Y4caikUKG2wxTvzuz7LpYc
         TKNS6zSw0w5LlnCTL2XCSPrBGWQMeSf6c5EE+L8/vQOEjYR86qe3Ln+29kY4txRQqRwU
         bpt221TDTqfgZxxs7FQE0PmmpYj5QkSG7kK8NVAvx3phr+XNnu9eDNRP6ydzW1g9WHQ2
         fLCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxFNA4qYZKU4I1zhppz7QfUJW+9I9YNY1GgvfMRznn1n5SxU3LfZUAiQvC3KqsdSU0Z09v/3Y/v3Gu@vger.kernel.org
X-Gm-Message-State: AFq9FYKQCtusxdN+2/RIa2LQPtf3Vd/cHChcW469hBBRMqiv/oFIHYI+
	Xisn9GxdB0Aj5sjyeDNjzqVkFyxiHdzxnBhrxv1dD96/wQL9lo3QDKHn
X-Gm-Gg: AYBFou3/9RpYMUC1Zvhhs2qZ0f8BVOIlAr2AYRJdTKoCYDgFGYpgYd2+dFsbxLooQjE
	kr7Aik56epjWcmAZ5CYdldyTaRtN5hUzh4XOh3xtKORGi4IwMm9WdN/5xvIxKSqzyE3WQU7mlcp
	PbxIlLKIfmSqeWMjq/NLiaYV4Lc40rO2uO/xzAJJRI46ihy6mRiThr6ovRbfseEw4EDpS+mS7y2
	tyafgx9HGhQnMjT5tTopFkQ3Y2UYdUNL7S9RakMq5wKk58XRWZDIJP7C33tOuUCeFaDqM3+8jR7
	C6K+qJ39Qr8aVK4I7bPAcxiDPXvUJw+vvK7cHriOxcYuRS4MR3iLDXgiYtNgbyf0EYvHKORlxz3
	C5OIOTOYC/ZT5f88lSf7+w1/1DouGoSnT4YRex1MVrxobA5HLZ9FDPkJKQi7S2GHpEUXLXmaZCN
	DeizUlmAvUXvNccEWBt5llj11tbH+bSxdnzgDA5FnOEepY8UbPrN5DV+fLAwJ5ZK+VgfYqcU3up
	ga3PXLKeiU7GuEhrgDpUgJIX8U=
X-Received: by 2002:a05:7022:3a81:b0:14c:efa5:ee7 with SMTP id a92af1059eb24-16a5afe51b5mr6320260c88.14.1791636582095;
        Sat, 10 Oct 2026 05:49:42 -0700 (PDT)
Received: from chitransh.. ([2401:4900:c920:95f0:34f7:c1ca:5f91:2fb9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm14204812c88.20.2026.10.10.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:49:41 -0700 (PDT)
From: chitranshmandhaniya@gmail.com
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org
Cc: lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chitransh_Mandhaniya@dell.com
Subject: [PATCH v5] ACPI: video: force native backlight on Dell OptiPlex AIO 7410 35W
Date: Sat, 10 Oct 2026 18:18:30 +0530
Message-ID: <20261010124830.116750-1-chitranshmandhaniya@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009072401.52509-1-chitranshmandhaniya@gmail.com>
References: <20261009072401.52509-1-chitranshmandhaniya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>

The Dell OptiPlex AIO 7410 35W (board 01KP8D) declares DELL0501 in its
ACPI DSDT (status = 0x0F) even though no UART scalar board is physically
present. This causes acpi_video_get_backlight_type() to return
acpi_backlight_dell_uart, which makes i915 skip registering
intel_backlight. The dell-uart-backlight driver then times out talking
to the absent board and the probe fails, leaving the machine with zero
backlight control.

A BIOS update fixes this on some models (e.g. OptiPlex 7420, board
0914RT) by setting DELL0501 _STA to 0, but Dell has not shipped a
corrected BIOS for the 7410 even in the latest release (1.37.0,
2026-05-28).

Add a DMI quirk to force native backlight on this model so that i915
registers intel_backlight and brightness control works out of the box.

Tested on:
  - OptiPlex AIO 7410 35W (01KP8D, BIOS 1.37.0) -- confirmed
    acpi_backlight=native produces working intel_backlight (raw,
    max=96000), DMI quirk has the same effect.
  - OptiPlex AIO 7420 35W (0914RT, BIOS 1.27.0) -- DELL0501 absent in
    updated BIOS, intel_backlight works natively (no regression).

Signed-off-by: Chitransh Mandhaniya <Chitransh_Mandhaniya@dell.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e3b69f876d24..1af14e04e597 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -883,6 +883,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex AIO 7410 35W */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex AIO 7410 35W"),
+		},
+	},
 
 	/*
 	 * Models which have nvidia-ec-wmi support, but should not use it.
-- 
2.43.0

