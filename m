Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF893D3D1B
	for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488403; cv=none; b=C5DM3wegz5+U2UhvYX0hfFcggET8EOOEBiCica222VGiaIGjnfZnkPoKVGlgnriPrQcWLGkiigXboRKx1W0mu5oate24pDwH5IEPb5srbd+LneaeQVEDFuDiLEqm9GbYwwj+AtCD8hyn26zdxMTg/fdB5ieFJpwiRVUgx+gzPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488403; c=relaxed/simple;
	bh=eFAek2fTRzS73NfCoH4RA0rIRDbPRNXEUtq0xg+7oQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq6NuD1VdY/XXwYA4S6X2At8l43FN2pWB8JlZ47qJZ6X/k3ZQ2t97Cq5ltSmDcSftfe8bGZNRax+8/JUJ+5twoDssuvrQ4Cs8TNs/5KpOzLJe3vlQR13bHrMaPNlUJcEni3OPCj9JuJ7sroR8rTKi+exLC09/7nkGxFqrcDtHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeTMD2ta; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeTMD2ta"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso3410311b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 23 Aug 2026 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787488401; x=1788093201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3c/+w0gY/yiLxrAX3Ag3KOv3d/87sKGQ7Sm7A1q70M0=;
        b=TeTMD2taCpTw2tSrAZBuy90DHEA3NxLI/BHi4kVj5sEs0Q62CdMYCuIZ3Wo3PW+HiI
         MJPaTXhgV3SZIJ6sy5Re4g8vnZReXP/RBA73Ycx6b8GHy+hmkuYblowFDdMKuI6eFELc
         hLam8TpB04+31oWPavHJzr033KeJuG0YyoSgoncEmLFLisuNOwThfQQ4FgwSIcTCpOP1
         PqFlg9iVGuaXJ6lZr3/kxGq/Kql/1pBm/fGI+rZV6olfVHzUSsE9GnITKMB54EIbFiwL
         hXqMyefjj3omaLPBGIcDn8CD/+KQ24nmE3hUsPkKurIoE3JmJCo0VPcMXlfT979fNaZ7
         XI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787488401; x=1788093201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3c/+w0gY/yiLxrAX3Ag3KOv3d/87sKGQ7Sm7A1q70M0=;
        b=l+20xr8umOXdz+XoiDJXy2j+L1A0/RjJ7I+zONbcCltPGIFuhZKjFUT2/iPM9oTEJk
         HBPPsyWLa+W5UhJyrcFb8LyOrX1ItvsPbqIYZcWM4M0M8orN2+lvSOomh8kl2AdHdpXj
         007OGA/ca+GEtWa6NUJNwg7F6H+13L0imgIxO+SjSGPlbdqnU8XuhdTX4oOoQLIb0n4g
         AJA3pcIQSNlHD55BYG3w2OIcfRJxuxw5Iod98huAtOjr0T5yP7ad9qMd7bgDFOWhsVjs
         GIlwSIn7As7WSHC089sdhDsBHTX+fIFZIZ0hO1UvbvfKtU9NOd8R18wSx3wRYmca10+m
         E/sg==
X-Forwarded-Encrypted: i=1; AHgh+RoiOEd+akknu8dWwSp0SN6yM8mqMd4cDAlf2i1Azazb8FZ3ym7vrHdjLWoPQqnTaqe6BJZOe1FQUlsk@vger.kernel.org
X-Gm-Message-State: AFuF++lUGK8E4j9ZXTr26ChAoOzsGxbfWZqnXY/qlqW/KdrhgkOVLSQu
	fjvmT3kvJDzRHKgTlkUDp7SIKXxoRnSzHol8R0499kg9ZODbdGgEXGgn
X-Gm-Gg: AR+sD10hEj4y7JEX9rTeQXiTaVYozb/MrJZ1DUbXrYFC7/gsc6PzrdL6eDMRzeaEmRo
	OX6b4BmQI8LdgvZxFApIOP4vjKoBFlk+fYG9s8iCqyC/93lksuesbHwsIG3f/14MpsjjTNgK1Zw
	fq/Rn/RCsoMeEF8N90P/mfi+WU2PVjhldXK/0patCL91OA9P8bM3IEVLXOny0Is3CNM9L242d87
	om3duoZGxgikUY47DznsU3hKSrhMdxWR2VgWHn9KU3nRQ3KVu6RGPZqolqeEX9ah/q+AuN+D0RI
	cTNjFpkmU2okthFZRN2u2rWL+jA4tJG4h/DKe+twKvNWogOPs3IQj1Z/sZnl23X+NwExtzCqsEH
	z5nVyuwScSaWKVjERoizvcfPfGTbqBcdYV6p2Y8jgCQRW07HEtpXvxTl/QVixbnrt9DqX1VlwoS
	v7zcnwvzCLYR+XjHmcZmDIo6+0uNCp+QLswBy6oDtyg//FKZdd6SY/AIzjlBa+BaBIDh4=
X-Received: by 2002:a05:6300:220c:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cd2fdd9b4cmr38342943637.7.1787488401490;
        Sun, 23 Aug 2026 05:33:21 -0700 (PDT)
Received: from InspironBook ([117.182.103.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b1e1sm261058a12.21.2026.08.23.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 05:33:21 -0700 (PDT)
From: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Sun, 23 Aug 2026 20:33:10 +0800
Message-ID: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

Assisted-by: Codex:ChatGPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
---
Changes in v2:
- Resend as non-flowed plain text; Thunderbird mangled whitespace in v1.
- No code changes.

 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
-- 
2.53.0
