Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836273;
	b=p+GN5rz5WPmp+sQyW9W8LNSrV9+Uz9Oyit0YptJaCRvLxPGyxGTM9UXuMHVMQOLWwJYD
	 JV5rtKgZauqxcSp0pQgISBIRMY/C9MgIztIDc8kfgR8qgGpyNgy71Tk8TeN+c6+C4uldS
	 kgZCugo5ypbhukC0lHSblc8dbGj+XxM6GRb0Fs59l6lZFiegfONc46Azz5pE98SbZbsWf
	 3m88BPGK251/PHhlGBQGRu98uFSrOM7bcwI5dYMApA83UoptoYAEuw/rzuShzhv1GOl/K
	 AxpMXhgQTAkVaHc9G3vsF9bvI76WtKnA5PoX6cmQfDsCGYKKdT0RAgdu6VeMjB5MbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
	b=tirc6oL/1Lb0P/6YHge41gwERGvcM8fm/RjimZSLgFVVoDApVwk0AKl6eVLlLo5hmuhV
	 EJ1hOYK3oojpB+kLteZZTbSWAyp7C2suag7mWCZn53jGhId781/n5XfzhFYYoNCm/qsFe
	 qHDLmxvnMIdRO3bRsXJ6CjE6X/o4NzjH/G4mugmzsGRH+t7Z1qq25m09OzoimWCbtv+aK
	 ybAqqbN5ce6xuetUbfjsi1EyGQpfmzeJv0OvWBkBHJqTSWhvDCIj/xoFcq72NTwpIEe/9
	 TmCFlqwQHs9VCtzosEr6XeKU2nrBIxc4KmdKdvVQNbwAaz9Gfz77+OkKcD+REPhrffw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNmQF1kE;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A4606A329
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 23:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C09A4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNmQF1kE
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06454116eso719479b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836272; x=1794441072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
        b=bNmQF1kE3aFKPO1ntIRZIaBAjUZbGWG4hp0SzTcG4Hn96N8bGgPVm8D6NGrsZijfSK
         aVxtTZnycYxlNxHKrALH/SYEIQqTOg8+8ijbx2UGsi4ONuMf8TcxbUM/v+Tzn8ALjMpw
         92jbLGo0IdTNKi9hpKdIGinD4visJcg7A3BM+SBAx5x6esVjGoJorvso0uvE+7Z5MDVJ
         vjqrYVTF9sbn4lv8F0xW0tkrrEAAi7jF8OSI5sVK1+RqrLsysNKIEiUqjCvmD6vFwmam
         UFGTT4xro/GLVbj9/sY8jYBUp6a/ZPCgXNpJ2kEEPVHnkstDwT4Nauy+VEpL43GrY1ep
         zexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836272; x=1794441072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
        b=KfQzf+rTy+mU/648jiSXNsjocklm6QQwMeI45YUOM344TwMrqK9We8RGUDHQ7VJ0Os
         KFUpU2UYlnOc5zeOGRmoq0AGOdgc8mdu0gp+ej0cSCuSaOOMoHzg9PosUOhw7B9vfdIy
         LziBD7lTt43gfQZDRkbjhEY25ouOdwCy8TVlIIPXhEnlL2b2duMtVg/xkOXtSko+DnXn
         XkkTBxj5YVdslMIuHpUvwGIB+4guPUPPuwiBd2DibJK+kkeggI2OKnFOz21vdZl35ozn
         Ds2XOPQ16pQBNWdI+wFC/KH+qVmf6kPosJa/6X/M+2DTNyU48gnTtYgRs4+WR+n3bIoS
         FAvQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1wy6WpditS20KMITmFIJv1/O+S7+tsV0WPsaL2gDjhbnXuC7E+IXSRpLaCmiMB+/NY69pOtIDv45E@vger.kernel.org
X-Gm-Message-State: APuU4Z+IqJ7v5VfkmHqYrXiwJ7DyeCTObgER2c0Rn6uy1raWFKnvdHFY
	lBipAMk5EtTnmYnfM+ew5d1m8hO/I1i4VQfelcZWboqf+WBwbDojH94QNRbuOQ==
X-Gm-Gg: AYBFou0Rpiu1cgMAYUT455xjI4QhQd9HppdfNggWRPfSfY6DPyXdN4W0nHzZtLkf0gO
	ajDqp/O3ub/D5FNI2fAikn/UFkBMKctKSrdvNUYOWWB5f2M6gROVYYA/gFyijxmEUMN59Fphkdc
	XbcbgSTPKp3EG/4Xe1w22FY3fP509F5qezUdiyxQyekL08wpIfPctQSooJ/DJWexpRv+3v81wV1
	J5tmEvD2JmEblZ+I1yjz/37X8xRLguSYrk1Es8iOeQP8xCHNuTFA1yQyPxsUmGOuYHVFdD1hwFG
	Vq7yIFCvp3u+YVFCoABEQaHKE5qjKvdWfmE7VvlzUBWK7OY3aiD0mMNyVKk0qOCB/MhgAekEV6A
	AoahlgfkNwglenv37EnV5ecDJTidflDM/XFwsCy0oRgvdwhOUXBx74MB+RfAdczUAOas5Glrrf/
	g4xvQMHXdvaVBLdBaCmwLNka7SLMCyymvp3J9vCKCsU7Tx5gJd3EOkNhpv7mQJG2mhJ+a88u8tU
	Vq8XkxU6+Sk1XcRdKbjetK6uxncu3SwszTXXMU4/qlMjwi7esryB/B+7111XJHfPLL80Ghh5wG8
	NENbItbo5L2O/MQyNx/z3WOjPXVQqQY07RzBr/OJOnJiki9ej4aFurJkGW4+V2PBvnDdK22XNkv
	2bBl01TQmnrtiw59HinAad3oytmXWfC8RBWjy57BMeb3FwH2PoL0RyxSLKNcpqkNvsF4XQcvuEC
	soyaHNwaIUmZ4RULJ9xvKr+FXeqqxJX7JADE2nBImIrimrYryhGoIn5FhKnBdTAA==
X-Received: by 2002:a05:6a21:6a0d:b0:3e2:47cf:17ec with SMTP id adf61e73a8af0-3e928d28b6cmr14923917637.34.1793836272084;
        Wed, 04 Nov 2026 15:51:12 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm1608170a12.8.2026.11.04.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:51:11 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jarred White <jarredwhite@microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006 for Microsoft Cobalt SoCs
Date: Wed,  4 Nov 2026 23:49:28 +0000
Message-ID: <20261104234928.86458-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
in acpi_apd.c.

Without an explicit MSFT0006 entry, ACPI device matching falls back to
its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
the controller's actual 300 MHz clock.

Cc: Jarred White <jarredwhite@microsoft.com>
Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/acpi/acpi_apd.c                     | 6 ++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 9fc667d6776c8..a1baa056931c4 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
 };
 
+static const struct apd_device_desc msft_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 300 * HZ_PER_MHZ,
+};
+
 #endif /* CONFIG_ARM64 */
 
 #endif
@@ -272,6 +277,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
 	{ "LECA0002", APD_ADDR(leca_spi_desc) },
 	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
+	{ "MSFT0006", APD_ADDR(msft_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 1da6b0314b6a0..f359d38cc63c7 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -280,6 +280,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ .id = "INT3433" },
 	{ .id = "INTC10EF" },
 	{ .id = "LECA0003" },
+	{ .id = "MSFT0006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
2.45.4

