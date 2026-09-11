Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A83603E0
	for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137303; cv=none; b=oz+W0kqulUaeEMGafo/b7gFcWgZLYtUM3HrW5lqhUMwG5Iijy1k8R1GwMH+8mqINiVrQU/vUZlk7oh6OKywLqLqW3nOaaZBaL1/Fw81Y+Xc5oitI/L89RBuDGjBaS858gfnR+G9bKTsiz1GaUbwWtU88SDqTxr49UXL+qTjvpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137303; c=relaxed/simple;
	bh=dvAk2dqkAlXIm6SK8bigWlZEwAOCZpfJJcV/gP5wTlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iH25r1UAzOajvtPMb7jlracm4MFUhqiG0Y/2PwXmX2qh2OsOJPSCZ4JuQiz01r5E3Hnk5WJdvBdivFUccJTIQe8pYHDmRP1vf51lP6AQBsOXtqHtDvKqcsHz6tiXZp9my1k58ofkzRyRigb1WUDSsjyGHpZdAIwEl8FAVKpvCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2onzNNB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2onzNNB"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-869ce628b69so128779b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2026 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137302; x=1789742102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1sNp6qYMSh2Pxp2iS5mOkD4cGCz9UgtwUXiF4heieqw=;
        b=C2onzNNB1vVggh5UpvDc2zZx3GFRRhzOQScXIs6qT6acqdDtcIiQZmV/0KfVJXKYjs
         qcWOE2l8b/AgKx++5GcDc2eC3KOF++Pt/6qdabs6Pm4hDYOgDSugFc+HasYt0Uv2Tra9
         Pn2P28Jb2Leyd/ADtsYnJ5XJc1ysBc4S9Xkkn81DT8z9STktpj/ULkK1UP3GXXrBCtST
         qbQwOYuoz5UVlvQe53+9y/em5zTvJQWsDsHdBCwhfZL5DV/QbKVjwp2ZT6p+dnsbnB7+
         JTNt14cHWWRyU1EPEmaBsKCbQDQ1nFFLl8EYO9qMBv11nJaj0gOPOFp+QGJgSd/1Ovfs
         3cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137302; x=1789742102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sNp6qYMSh2Pxp2iS5mOkD4cGCz9UgtwUXiF4heieqw=;
        b=l4fjZeUAZZN/E1UCmI1p2EfUQmoqatyaCy0ADLESU5jm5WJLDhBuDrC5V6RyJzrSPg
         Eowh6Nzliu1Ub/OdKbcCILH5mBxiEZxwI0xA/Iuc1KAVQWwzTqRaQka0x4iaHlmEWUiK
         j7lGHL/tkDszkJYm2QEyA7436tQVVHAxtwJ1ANGlqItI9O4squliDKcCNObKrLnHGEhf
         JeaSJ4vwABCxQ/7qA74pD5v2kjNb/oOm7Pr0bllcGuukPRah08uGhNXBl49uc+LcgELK
         YsAOM9DxqBeCj/eIxGcDprhFrjX4pJGNXFIzYvLtwP/tWN85Nfm+TWqlDNLkZqLz0Azg
         vqRQ==
X-Gm-Message-State: AFuF++kBiVtHYTcbUZHAb1vGQ8+pWSzYS6RRvrwvjnse8nB+/94IyXll
	Zwx/QcJBawJb6+w0jB9NghT/CfLkZrdcTSFZGz+fv8KcjUb2XLkWuYiE
X-Gm-Gg: AYBFou0Z+AJ6372g1vuwC5SwtjHnFQqZJjtqMX36WPO2vo/inp6Qj680TTry+cWFuQ8
	2nFy90I5AVMpVn77h9uuS6XeYJaNGT4xk/LuaBTRpVcXcJfjNyID4kdTkwOACTBgSnp4lqzSQ1h
	yyfAQPRT7Uy8EdvBRYg37UOAy2jUs5CFSaK9DTRwG5/2Gc8vKXiK7bl93c+1Pz/fjQoEHjSEVOz
	wb59xwmRGHhlsaj7spqkQGTskonCPNR3V/ofF3lzTwKjg9D6Xv7KwbpMwaR/+51X/1OXQF17NCh
	lXaNS6qSLaIw3oxCGvBuiWdFsErFGPyZO1sd119etODM2+Uk+gdnebnSAzRDKkXQmyen9BONz+3
	dsPrHSeuJaNfmaiAW7+f/sGUE+edUj38PG6D23w7xF67q0z/mrSTl+YQETbo8L5OLdNXruH53Tw
	Se+LTMGXFDoujEht2/c7qFvOT1vLJFTaN25oCpGQX7qlt8IgBHuxNCB0B3AtknOsH6VeeqgQ==
X-Received: by 2002:a05:6a20:ad90:b0:3d1:56e6:daad with SMTP id adf61e73a8af0-3daecade5d3mr4625729637.0.1789137301981;
        Fri, 11 Sep 2026 07:35:01 -0700 (PDT)
Received: from yuzaya ([182.253.152.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a5c052csm1209838b3a.58.2026.09.11.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:35:01 -0700 (PDT)
From: Dirga Yuza <dirgayuza123@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dirga Yuza <dirgayuza123@gmail.com>
Subject: [PATCH] ACPI: video: add backlight=native DMI quirk on Acer Nitro AN515-58
Date: Fri, 11 Sep 2026 21:33:06 +0700
Message-ID: <20260911143306.49015-1-dirgayuza123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer Nitro AN515-58 requires the same quirk entry as AN515-46, since
its firmware also advertises the NVIDIA WMI EC backlight GUID. However,
on this hybrid graphics setup, the internal display is wired to the
Integrated GPU (Intel Iris Xe Graphics).

As a result, the nvidia_wmi_ec_backlight driver fails to probe, leaving
no backlight device registered and rendering the brightness keys and
desktop brightness slider non-functional.

Setting acpi_backlight=native allows intel_backlight to register its
backlight interface and restoring brightness control. Add a DMI
quirk entry so this model uses the native backlight by default.

Signed-off-by: Dirga Yuza <dirgayuza123@gmail.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e3b69f876..3037fd18d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -929,6 +929,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN515-46"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Acer Nitro AN515-58 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN515-58"),
+		},
+	},
 
 	/*
 	 * x86 android tablets which directly control the backlight through
-- 
2.55.0

