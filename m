Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636537AA97
	for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789293079; cv=none; b=BSvVAj6qwuc3vxrlJtmTk1S07Abolj36bHhF68IzpdLvukcD2wMgPVq5E/35V35YvETCC7dGoRgg5BP2lOUr+YLWjhq6HzL4DrGespemb9Vokw/DgJWOL2XFmUsw2g+ojslX6mkUi4jdlh5YpiZkbuucDi+o2iM+28kEeXqE9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789293079; c=relaxed/simple;
	bh=jbVm0RLVeDlU9P10OCDpld57tDHcD90z/kytGFhXC6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4cOJZCvoDUs5h517WuRS2I7HJBJucIJ4A87lkZ5/nB7t3G1qLo3ZMk5LDgaV6H5EBr5CYV1Ij/5jv9lPpi5UUe9//7v5SidaAsfvUXIlYLgpJ+dBvNcyigD96pI1w0+GoxRO+cyb/e9DIj6T2VhSUHkRmD4lgUbC/XJDgNtSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw/4EyLQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw/4EyLQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484399babcaso145698f8f.0
        for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2026 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789293076; x=1789897876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcs5SoEwbG5DjCJj0LVT0Z2R1O7xtBNzbwteyqKUk8E=;
        b=nw/4EyLQCkwYfTO5vXLsjIHg8oWDopE6qgjNyiU6hL/cLbwFTeFG9MnCSG5O7SwpKV
         9CCwIUoSa7pd2xxsDWHj3ezcRfrxb+uBrdV6woLkRplgmGkfnti9BrSlRinXQTZBXyG4
         G+c1z43+41VOop36KotSePgGb/2pIf4pim847+TvN8m88HXPmB0RvpuDitYX0U2xkUKs
         7HILPXEC1B/aYpFATI98vCdoXVXLf0ElQPt964bdt8Y2jq3qaprVAFeHNNDzNff4a6SX
         tg4+mJn/auZWVfAPSkSlS0lI4J+qBhh0RTGGbEkwwBuotxN0zNL7s5iHYWinOy6xp7gh
         SlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789293076; x=1789897876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcs5SoEwbG5DjCJj0LVT0Z2R1O7xtBNzbwteyqKUk8E=;
        b=TiQxCB7xcAMBhhbKohJA5c01O3jq6sJVpjpRiESEJon77E0GlKH/8wnrjOzeelL0ce
         3IrSPtnNLAmtARc1MjTFp/2vzT6TMBm3taqIDfjlRkOpcPKmNf6GfMMxBa2/H5kXNe8j
         2DeQk+KQp1HGagRlRtAhqeP3f2DW3uHeKHx+/ZNqPXiVzlQjMziQzeAscm0+Cr/rmzCt
         f/UWFvrf+Pw0gKdlDeYZlOUxfC9bYfndFY92nq7P0kyFyFS58x7yrDfGe+XX0YZTCFVr
         u7kK7M+kH8tJ2Xup1GErMmRBeBG9gTcvB9Z13HJIjNDtk07LF3orvIz4yvxEENNeh4ht
         zrrA==
X-Forwarded-Encrypted: i=1; AKwUvBxv+dNhO/CF2iHMgllqdyHkKJn1i56UvDlBvSCA04e1t2SDyctRxkzzaK9eXXjxWMRyXalxy1UD1Gn9@vger.kernel.org
X-Gm-Message-State: AFuF++mL5oG2zntZQdR27sYAPK4E8zivBIKN5+gLFIM6p1sVUnGGSqAc
	niPurgUhHCX2UpN176FuOh289RXy3irka+9WfB0mYXheNd8q4/k1JrSs
X-Gm-Gg: AYBFou3ZsAHR6LkjY8WkaOSeJyDAzOZYGJ2iTpsNlSRnu0p6M5OzlaeXx+M/LnUka7G
	EaZZBrj5kBkBDBC9CL0qwHeU9208Sw3E06RPLe5VmhUD1XDVEALFOVzqSxKwTcIsfa1WVzcgj5T
	cXQ1X+s9uE7xj9dpr9ByRjNeaOTbIe6BLRtxeVDPkU2GRP4JzF+bWm7b0xMo7zPWcwRaHExvDHw
	kh5EpAV6WLjCfIoP2dPioD7MAEQwxvd9YQ8mF16JLd58qYuVwC4g819Ivp5bLghaPeqoPcPwtv2
	GSFvfX4FeoA6S2XLOJpzv5R9mxXnsy7+sMy2Tq9jhdRiy04DDFDRbC90NHpvJdSAOlZ6ck9b/Zl
	qM98AMFCzg1ugujUdaWcq+ZK1OmFR0VgcKh/OTwBjllGPYDCt3bMOPQEq16XzO1hQ5jtSDZo6Wn
	23tW0FMK+boiamv+60oKLSomgDEZhQXH+pwj3eAlkULVC/rY7er9tCT9oXRufH0hzMk3/4V2CBb
	doO3w7XVLEom1KcC2CClM0Ot0+yMcqxpU+j6GNocoL4xfeQZ3tb5N7AKnHurnxSnLxe5GAL5AQU
	nvRHt3fqRyLUy+rifEakP0xM
X-Received: by 2002:a5d:5d0b:0:b0:486:f768:395b with SMTP id ffacd0b85a97d-486f768400emr6172871f8f.0.1789293075665;
        Sun, 13 Sep 2026 02:51:15 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb3602eesm17401532f8f.34.2026.09.13.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:51:15 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: rafael@kernel.org,
	u.kleine-koenig@baylibre.com
Cc: kmehltretter@gmail.com,
	andriy.shevchenko@linux.intel.com,
	corbet@lwn.net,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Garcia <miguelgarciaroman8@gmail.com>
Subject: [PATCH] ACPI: device-id: document struct acpi_device_id
Date: Sun, 13 Sep 2026 11:51:05 +0200
Message-ID: <20260913095111.2543502-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct acpi_device_id lacks kernel-doc, so extracting documentation from
its header describes ACPI_DEVICE_CLASS but not the matching table entry.

Document the four members, ID and class-code matching, and the table
terminator. This complements the pending documentation header-split
update without changing its include directives.

An LLM drafted this comment and changelog after being asked to address
the missing documentation noted in the header-split discussion. The
field descriptions were checked against the ACPI matching code. The
extracted documentation passes kernel-doc and a focused Sphinx HTML
build with warnings treated as errors; checkpatch reports no warnings.

Link: https://lore.kernel.org/all/aqEWUBf1pewPP_K2@monoceros/
Assisted-by: LLM
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 include/linux/device-id/acpi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/device-id/acpi.h b/include/linux/device-id/acpi.h
index 65800cefd..8c3b30ebf 100644
--- a/include/linux/device-id/acpi.h
+++ b/include/linux/device-id/acpi.h
@@ -9,6 +9,16 @@ typedef unsigned long kernel_ulong_t;
 
 #define ACPI_ID_LEN	16
 
+/**
+ * struct acpi_device_id - ACPI device matching table entry
+ * @id: NUL-terminated hardware ID (_HID) or compatible ID (_CID) to match.
+ * @driver_data: Data private to the driver.
+ * @cls: PCI-defined class, subclass and programming interface code (_CLS).
+ * @cls_msk: Mask selecting the class-code fields to match.
+ *
+ * Use @id for ID matching or ACPI_DEVICE_CLASS() for class-code matching.
+ * Terminate the table with an entry whose @id is empty and @cls is zero.
+ */
 struct acpi_device_id {
 	__u8 id[ACPI_ID_LEN];
 	kernel_ulong_t driver_data;
-- 
2.43.0

