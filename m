Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568475;
	b=WRVb+FLGygLbZfgsynMgwAPkaaOBvC6Da1/dnK3kcHWlW8Q+INCT/7l+joj1adILUsBu
	 Y5BawUKu1ZWSlNEZPb727fzFNDwGExHQhxaTxkpDc0osoDq7IY3RcJ+fabFdUBY4ci55O
	 D2Fq1A+X8X/wgUW+L/XTTXysmGko8bD0fuVN10uzCGDIzVsVu/+zI1k3cWBTyZYvacg9W
	 rbqnp3s+gqLWtEqCeJv31kiqtVqhVgPGY/heB1EclLfAx4h5XbcRpmDX7oisdUEuThGFg
	 hJG78z0JR5rApszSRn9MF7te7Lt5EONosTZot6kNIduASBjIRUMLh270tRHBxv5aycw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=k6T+kUrBS45iigoe1LEtqjopIjVrHfrGfCCOaWL4OrQ=;
	b=gw6YOkU7LQJpMpH1kDiSlLgqZziHIJcGpY2IHo6Y3nLQ9O4aVeLIOsGkTWUxb9wSGDa9
	 AIEGLYXe4eDCGpI1XKvvczGoXymVGFc71HkFWjRWNS+rU/uKxcLvCCedsE3WIVIx/r/zx
	 cNHJ1mD172U0x1IC2wB6YSe5W5ne/jiikYTVNrfNetxveulokemdmRPoUlerQJS5APhoU
	 dKaq4MkbLvufiAgO0gaG0Y53Dzs+/KqdXDKkWKMrDw7xlGB5Q0nMtDJmRvwCxOWT9dE0r
	 5CDtuQ/OBuDb7Dt2Y1oKUIvzXTDVe5YwFIB61WvaCrTLm6N1OSz5kYX8a0xmwJUlSnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MbZnWhCp;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAEB606A321
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 11:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAEB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MbZnWhCp
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so4829685e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794568472; x=1795173272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6T+kUrBS45iigoe1LEtqjopIjVrHfrGfCCOaWL4OrQ=;
        b=MbZnWhCptH+hbsqb/9OhqAZmJFMmXWTuiO8EgvD1nH8jadNvi9Pb3kV/tAWCSULNcJ
         0QSaAAbBA6hcRyu408ggHdvmxF7MDOIQr8uOhUqUKiPoYwNeihuZnlJLW1dvkoU5I5c+
         UqAP6p3ipIjBsNnnGBMgN7LRzTR555G1vqlCJffYzDKr3CqINYLZBrsc5qK1LPPuYdDp
         J5cnI+EA+I8frMZ/4LiDSqhd7px9dqVXMXulbOkcuO8mX7+o3BjV6rhBx9yHAMwL7Cw1
         S7+Y06BTu35Y17mj8VNUlf1oGA42lMqp3M4nTUh0jGg02bWV8UBlM1AcGD1HPPyOLmmZ
         bENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568472; x=1795173272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6T+kUrBS45iigoe1LEtqjopIjVrHfrGfCCOaWL4OrQ=;
        b=NNH+dq2BkWxy/GXr34wS4sB7ZNqsNghqTd9SEWELfJ5y+uilFueJ6mFNt0XX6SV8Pu
         KzCi4+pqrF3RtYYEWnVW0Bfjx7C4CSclFvJwVKENoK9N6Fyza9++lHlXz8ZvR8ESn6Hs
         cYiBkQoAIo/jOX/P2MzHoQ6Ob/zwSI1qbW58ncnqRauRR0FXSnzh78ZGhiRftmbjIm7n
         D7ITQGTS6KEf1Ru5HUGeRttWC34D9IJnzIx/HVEF5Z2J+qls7vhRO1Q5El3uICTIz/n0
         mofNTQa4jRMvJkicd6wEJMejrTf/nUygKno/atMTr8yS4ASQZrv3mww5HgOhFwMv2Jq0
         jDqA==
X-Forwarded-Encrypted: i=1; AL+hErG3eZWWJBSk3Vr269FiZ8umvh8GyabKkPSmejThmqyEwsma3825NkJrJxB+MmBxHmfW/dOUEch0eTY3@vger.kernel.org
X-Gm-Message-State: APuU4Z/9/uv03h2wCD4iZ6Z4dZRTMwLD8RmnTyNweOvPqgfwASiyCexq
	CaX77HX/kbQcn31pq/cvDmTKUbi4lkkeGFaOytrtzv9CTFbAxJGqiISTNL8kURwftYo=
X-Gm-Gg: AYBFou2SGBWhAJX+moQXlnHJsjP+aRA4OD7aLUhwCqSfSUY3ePhD50/DC2uLNs5y1HD
	KROF47HAub47b/pMk3OeRCUEk1vo4fukKxOk/j7U8sIBqUVt2MyuIx/aPPcw16oEvPI7yAdOGxO
	MT5BHRUAVEs/Eq8mFoIgNjcEKl29c85cQNqM8Y0CFhqc3ZcJoxqVO5/iqVF+2mbppCZAZic33JA
	KPR7iqVn5VUo9drDUYt+4/CikRjT4u/f8PpSfZjS/Z22RSEWB/8/zYJQZrxwniE90nRC3A58hek
	eXWU+CwmOPq243O1NPT//6A4dQqDR+Ny/DN2QRwNYo+91lIcOnZgPHEq2XkIA4nikFmr4g5lYFF
	doME8UBEomD46GpLL8dUq5M2V0SJtsUU4688vSHNgx8Ap++wGeDR2JZeZWU2+oF7bB+lJF/7ZYe
	u/g/kU7E+vlGcdk6KdbcuMKfV8qpSLcey0zgCslrNrmYxLxPHH6oSUV9aCek30SNvFWI0L91IHC
	oUGtI5w+tpWktPp0iUDHjC72MYwAL7Zf5rMRyGkP8ZCjSMy4bYFfOdccAP8XktXm3ngkU9GaiIu
	tyei/j/5ulpM3AlR7XgmlzQ/mnF6LUObnWAOaz5gmw3G4X1Zu5OLnrGqUnlXDr7bSiWWcSbv4KL
	F0yxlztFqm7gMNFWJtg==
X-Received: by 2002:a05:600c:1f90:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4bb55a57b96mr41725385e9.9.1794568472217;
        Fri, 13 Nov 2026 03:14:32 -0800 (PST)
Received: from localhost (p200300f65f19a904278f3f81ea855105.dip0.t-ipconnect.de. [2003:f6:5f19:a904:278f:3f81:ea85:5105])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb4e29d24dsm150251465e9.11.2026.11.13.03.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:14:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Chu Guangqing <chuguangqing@inspur.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Jakob Riemenschneider <riemenschneiderjakob@gmail.com>,
	Gergo Koteles <soyer@irl.hu>,
	Yauhen Kharuzhy <jekhor@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] ACPI: Use named initializers for acpi_device_id arrays
Date: Fri, 13 Nov 2026 12:13:59 +0100
Message-ID:  <78dc04789c71a0e0b43c52f7814121b9a763851a.1794567577.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1794567577.git.ukleinek@kernel.org>
References: <cover.1794567577.git.ukleinek@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=42693; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=idIkLMifW96yRmOGypTU8IiwK0VZIbzA2+3kGJ3yxTA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9vD99Fc1x7BoVk/bqVyLTmExYRCFKU5XdBC0V jni/rI5Vz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavbw/QAKCRCPgPtYfRL+ TvW3B/0XCAWncp9HjSyZ4Pgbm8XrmazV0xGM4mVqGIuV6hzpbnA7mEfnFyKllO2rwNqdo00xMuz zT/51z3vPcdKSz8KpPUxMrHiFxPjiVuZFMpbYewPZcckaMLnfTUt6r2bvBMb2vyK3pgt2P5urrp 7cRdjO8AjQOakKmHlUIV7nJQD1xUtcHQtfLG8BMKOh5rrlTo/Bq8ScsEKbvoZ6LJXmyfh6d1XF8 kzym24XEXRl4n3LGjQOAr1lrGuIpHf0JIHLZ9pUsKT9yAPeVK7IvPpVsS2Ykt8fsGz+234PH6kz FqXt4/5lxBRyNAvt75yel3c+EhmoO8pWmWGMlkAWYKALJZXG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only its representation in
source form benefits.

Co-Authored-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/acpi/acpi_apd.c         |  46 +--
 drivers/acpi/acpi_platform.c    |  12 +-
 drivers/acpi/acpi_pnp.c         | 512 ++++++++++++++++----------------
 drivers/acpi/acpi_processor.c   |   6 +-
 drivers/acpi/apei/ghes-nvidia.c |   2 +-
 drivers/acpi/button.c           |  10 +-
 drivers/acpi/evged.c            |   2 +-
 drivers/acpi/pfr_telemetry.c    |   2 +-
 drivers/acpi/pfr_update.c       |   2 +-
 drivers/acpi/scan.c             |  34 +--
 drivers/acpi/x86/cmos_rtc.c     |   2 +-
 drivers/acpi/x86/lpss.c         |  54 ++--
 drivers/acpi/x86/s2idle.c       |  10 +-
 drivers/acpi/x86/utils.c        |   2 +-
 include/linux/acpi.h            |   6 +-
 15 files changed, 351 insertions(+), 351 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ea226fd98756..14a19846ba91 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -248,31 +248,31 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 static const struct acpi_device_id acpi_apd_device_ids[] = {
 	/* Generic apd devices */
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
-	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
-	{ "AMD0020", APD_ADDR(cz_uart_desc) },
-	{ "AMD0030", },
-	{ "AMD0040", APD_ADDR(fch_misc_desc)},
-	{ "AMDI0010", APD_ADDR(wt_i2c_desc) },
-	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },
-	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
-	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
-	{ "AMDI0021", APD_ADDR(cz_uart_desc) },
-	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
-	{ "HYGO0010", APD_ADDR(wt_i2c_desc) },
+	{ .id = "AMD0010",  .driver_data = APD_ADDR(cz_i2c_desc) },
+	{ .id = "AMD0020",  .driver_data = APD_ADDR(cz_uart_desc) },
+	{ .id = "AMD0030",  .driver_data = (unsigned long)NULL },
+	{ .id = "AMD0040",  .driver_data = APD_ADDR(fch_misc_desc)},
+	{ .id = "AMDI0010", .driver_data = APD_ADDR(wt_i2c_desc) },
+	{ .id = "AMDI0015", .driver_data = APD_ADDR(wt_i3c_desc) },
+	{ .id = "AMDI0019", .driver_data = APD_ADDR(wt_i2c_desc) },
+	{ .id = "AMDI0020", .driver_data = APD_ADDR(cz_uart_desc) },
+	{ .id = "AMDI0021", .driver_data = APD_ADDR(cz_uart_desc) },
+	{ .id = "AMDI0022", .driver_data = APD_ADDR(cz_uart_desc) },
+	{ .id = "HYGO0010", .driver_data = APD_ADDR(wt_i2c_desc) },
 #endif
 #ifdef CONFIG_ARM64
-	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
-	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
-	{ "CAV9007",  APD_ADDR(thunderx2_i2c_desc) },
-	{ "HISI02A1", APD_ADDR(hip07_i2c_desc) },
-	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
-	{ "HISI02A3", APD_ADDR(hip08_lite_i2c_desc) },
-	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
-	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
-	{ "LECA0002", APD_ADDR(leca_spi_desc) },
-	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
-	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
+	{ .id = "APMC0D0F", .driver_data = APD_ADDR(xgene_i2c_desc) },
+	{ .id = "BRCM900D", .driver_data = APD_ADDR(vulcan_spi_desc) },
+	{ .id = "CAV900D",  .driver_data = APD_ADDR(vulcan_spi_desc) },
+	{ .id = "CAV9007",  .driver_data = APD_ADDR(thunderx2_i2c_desc) },
+	{ .id = "HISI02A1", .driver_data = APD_ADDR(hip07_i2c_desc) },
+	{ .id = "HISI02A2", .driver_data = APD_ADDR(hip08_i2c_desc) },
+	{ .id = "HISI02A3", .driver_data = APD_ADDR(hip08_lite_i2c_desc) },
+	{ .id = "HISI0173", .driver_data = APD_ADDR(hip08_spi_desc) },
+	{ .id = "HJMC3001", .driver_data = APD_ADDR(hjmc_i2c_desc) },
+	{ .id = "LECA0002", .driver_data = APD_ADDR(leca_spi_desc) },
+	{ .id = "LECA0003", .driver_data = APD_ADDR(leca_i2c_desc) },
+	{ .id = "NXP0001",  .driver_data = APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
 };
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 80ea7121744d..aafba11434b4 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -25,12 +25,12 @@
 #define ACPI_ALLOW_WO_RESOURCES		BIT(0)
 
 static const struct acpi_device_id forbidden_id_list[] = {
-	{"ACPI0009", 0},	/* IOxAPIC */
-	{"ACPI000A", 0},	/* IOAPIC */
-	{"PNP0000",  0},	/* PIC */
-	{"PNP0100",  0},	/* Timer */
-	{"PNP0200",  0},	/* AT DMA Controller */
-	{ACPI_SMBUS_MS_HID,  ACPI_ALLOW_WO_RESOURCES},	/* ACPI SMBUS virtual device */
+	{ .id = "ACPI0009", .driver_data = 0 },	/* IOxAPIC */
+	{ .id = "ACPI000A", .driver_data = 0 },	/* IOAPIC */
+	{ .id = "PNP0000", .driver_data = 0 },	/* PIC */
+	{ .id = "PNP0100", .driver_data = 0 },	/* Timer */
+	{ .id = "PNP0200", .driver_data = 0 },	/* AT DMA Controller */
+	{ .id = ACPI_SMBUS_MS_HID, .driver_data = ACPI_ALLOW_WO_RESOURCES },	/* ACPI SMBUS virtual device */
 	{ }
 };
 
diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index ea9858e00238..fec894467425 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -15,292 +15,292 @@
 
 static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	/* pata_isapnp */
-	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
+	{ .id = "PNP0600" },		/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	/* floppy */
-	{"PNP0700"},
+	{ .id = "PNP0700" },
 	/* tpm_inf_pnp */
-	{"IFX0101"},		/* Infineon TPMs */
-	{"IFX0102"},		/* Infineon TPMs */
+	{ .id = "IFX0101" },		/* Infineon TPMs */
+	{ .id = "IFX0102" },		/* Infineon TPMs */
 	/*tpm_tis */
-	{"PNP0C31"},		/* TPM */
-	{"ATM1200"},		/* Atmel */
-	{"IFX0102"},		/* Infineon */
-	{"BCM0101"},		/* Broadcom */
-	{"BCM0102"},		/* Broadcom */
-	{"NSC1200"},		/* National */
-	{"ICO0102"},		/* Intel */
+	{ .id = "PNP0C31" },		/* TPM */
+	{ .id = "ATM1200" },		/* Atmel */
+	{ .id = "IFX0102" },		/* Infineon */
+	{ .id = "BCM0101" },		/* Broadcom */
+	{ .id = "BCM0102" },		/* Broadcom */
+	{ .id = "NSC1200" },		/* National */
+	{ .id = "ICO0102" },		/* Intel */
 	/* ide   */
-	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
+	{ .id = "PNP0600" },		/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	/* ns558 */
-	{"ASB16fd"},		/* AdLib NSC16 */
-	{"AZT3001"},		/* AZT1008 */
-	{"CDC0001"},		/* Opl3-SAx */
-	{"CSC0001"},		/* CS4232 */
-	{"CSC000f"},		/* CS4236 */
-	{"CSC0101"},		/* CS4327 */
-	{"CTL7001"},		/* SB16 */
-	{"CTL7002"},		/* AWE64 */
-	{"CTL7005"},		/* Vibra16 */
-	{"ENS2020"},		/* SoundscapeVIVO */
-	{"ESS0001"},		/* ES1869 */
-	{"ESS0005"},		/* ES1878 */
-	{"ESS6880"},		/* ES688 */
-	{"IBM0012"},		/* CS4232 */
-	{"OPT0001"},		/* OPTi Audio16 */
-	{"YMH0006"},		/* Opl3-SA */
-	{"YMH0022"},		/* Opl3-SAx */
-	{"PNPb02f"},		/* Generic */
+	{ .id = "ASB16fd" },		/* AdLib NSC16 */
+	{ .id = "AZT3001" },		/* AZT1008 */
+	{ .id = "CDC0001" },		/* Opl3-SAx */
+	{ .id = "CSC0001" },		/* CS4232 */
+	{ .id = "CSC000f" },		/* CS4236 */
+	{ .id = "CSC0101" },		/* CS4327 */
+	{ .id = "CTL7001" },		/* SB16 */
+	{ .id = "CTL7002" },		/* AWE64 */
+	{ .id = "CTL7005" },		/* Vibra16 */
+	{ .id = "ENS2020" },		/* SoundscapeVIVO */
+	{ .id = "ESS0001" },		/* ES1869 */
+	{ .id = "ESS0005" },		/* ES1878 */
+	{ .id = "ESS6880" },		/* ES688 */
+	{ .id = "IBM0012" },		/* CS4232 */
+	{ .id = "OPT0001" },		/* OPTi Audio16 */
+	{ .id = "YMH0006" },		/* Opl3-SA */
+	{ .id = "YMH0022" },		/* Opl3-SAx */
+	{ .id = "PNPb02f" },		/* Generic */
 	/* i8042 kbd */
-	{"PNP0300"},
-	{"PNP0301"},
-	{"PNP0302"},
-	{"PNP0303"},
-	{"PNP0304"},
-	{"PNP0305"},
-	{"PNP0306"},
-	{"PNP0309"},
-	{"PNP030a"},
-	{"PNP030b"},
-	{"PNP0320"},
-	{"PNP0343"},
-	{"PNP0344"},
-	{"PNP0345"},
-	{"CPQA0D7"},
+	{ .id = "PNP0300" },
+	{ .id = "PNP0301" },
+	{ .id = "PNP0302" },
+	{ .id = "PNP0303" },
+	{ .id = "PNP0304" },
+	{ .id = "PNP0305" },
+	{ .id = "PNP0306" },
+	{ .id = "PNP0309" },
+	{ .id = "PNP030a" },
+	{ .id = "PNP030b" },
+	{ .id = "PNP0320" },
+	{ .id = "PNP0343" },
+	{ .id = "PNP0344" },
+	{ .id = "PNP0345" },
+	{ .id = "CPQA0D7" },
 	/* i8042 aux */
-	{"AUI0200"},
-	{"FJC6000"},
-	{"FJC6001"},
-	{"PNP0f03"},
-	{"PNP0f0b"},
-	{"PNP0f0e"},
-	{"PNP0f12"},
-	{"PNP0f13"},
-	{"PNP0f19"},
-	{"PNP0f1c"},
-	{"SYN0801"},
+	{ .id = "AUI0200" },
+	{ .id = "FJC6000" },
+	{ .id = "FJC6001" },
+	{ .id = "PNP0f03" },
+	{ .id = "PNP0f0b" },
+	{ .id = "PNP0f0e" },
+	{ .id = "PNP0f12" },
+	{ .id = "PNP0f13" },
+	{ .id = "PNP0f19" },
+	{ .id = "PNP0f1c" },
+	{ .id = "SYN0801" },
 	/* fcpnp */
-	{"AVM0900"},
+	{ .id = "AVM0900" },
 	/* radio-cadet */
-	{"MSM0c24"},		/* ADS Cadet AM/FM Radio Card */
+	{ .id = "MSM0c24" },		/* ADS Cadet AM/FM Radio Card */
 	/* radio-gemtek */
-	{"ADS7183"},		/* AOpen FX-3D/Pro Radio */
+	{ .id = "ADS7183" },		/* AOpen FX-3D/Pro Radio */
 	/* radio-sf16fmr2 */
-	{"MFRad13"},		/* tuner subdevice of SF16-FMD2 */
+	{ .id = "MFRad13" },		/* tuner subdevice of SF16-FMD2 */
 	/* ene_ir */
-	{"ENE0100"},
-	{"ENE0200"},
-	{"ENE0201"},
-	{"ENE0202"},
+	{ .id = "ENE0100" },
+	{ .id = "ENE0200" },
+	{ .id = "ENE0201" },
+	{ .id = "ENE0202" },
 	/* fintek-cir */
-	{"FIT0002"},		/* CIR */
+	{ .id = "FIT0002" },		/* CIR */
 	/* ite-cir */
-	{"ITE8704"},		/* Default model */
-	{"ITE8713"},		/* CIR found in EEEBox 1501U */
-	{"ITE8708"},		/* Bridged IT8512 */
-	{"ITE8709"},		/* SRAM-Bridged IT8512 */
+	{ .id = "ITE8704" },		/* Default model */
+	{ .id = "ITE8713" },		/* CIR found in EEEBox 1501U */
+	{ .id = "ITE8708" },		/* Bridged IT8512 */
+	{ .id = "ITE8709" },		/* SRAM-Bridged IT8512 */
 	/* nuvoton-cir */
-	{"WEC0530"},		/* CIR */
-	{"NTN0530"},		/* CIR for new chip's pnp id */
+	{ .id = "WEC0530" },		/* CIR */
+	{ .id = "NTN0530" },		/* CIR for new chip's pnp id */
 	/* Winbond CIR */
-	{"WEC1022"},
+	{ .id = "WEC1022" },
 	/* wbsd */
-	{"WEC0517"},
-	{"WEC0518"},
+	{ .id = "WEC0517" },
+	{ .id = "WEC0518" },
 	/* Winbond CIR */
-	{"TCM5090"},		/* 3Com Etherlink III (TP) */
-	{"TCM5091"},		/* 3Com Etherlink III */
-	{"TCM5094"},		/* 3Com Etherlink III (combo) */
-	{"TCM5095"},		/* 3Com Etherlink III (TPO) */
-	{"TCM5098"},		/* 3Com Etherlink III (TPC) */
-	{"PNP80f7"},		/* 3Com Etherlink III compatible */
-	{"PNP80f8"},		/* 3Com Etherlink III compatible */
+	{ .id = "TCM5090" },		/* 3Com Etherlink III (TP) */
+	{ .id = "TCM5091" },		/* 3Com Etherlink III */
+	{ .id = "TCM5094" },		/* 3Com Etherlink III (combo) */
+	{ .id = "TCM5095" },		/* 3Com Etherlink III (TPO) */
+	{ .id = "TCM5098" },		/* 3Com Etherlink III (TPC) */
+	{ .id = "PNP80f7" },		/* 3Com Etherlink III compatible */
+	{ .id = "PNP80f8" },		/* 3Com Etherlink III compatible */
 	/* nsc-ircc */
-	{"NSC6001"},
-	{"HWPC224"},
-	{"IBM0071"},
+	{ .id = "NSC6001" },
+	{ .id = "HWPC224" },
+	{ .id = "IBM0071" },
 	/* smsc-ircc2 */
-	{"SMCf010"},
+	{ .id = "SMCf010" },
 	/* parport_pc */
-	{"PNP0400"},		/* Standard LPT Printer Port */
-	{"PNP0401"},		/* ECP Printer Port */
+	{ .id = "PNP0400" },		/* Standard LPT Printer Port */
+	{ .id = "PNP0401" },		/* ECP Printer Port */
 	/* apple-gmux */
-	{"APP000B"},
+	{ .id = "APP000B" },
 	/* c6xdigio */
-	{"PNP0400"},		/* Standard LPT Printer Port */
-	{"PNP0401"},		/* ECP Printer Port */
+	{ .id = "PNP0400" },		/* Standard LPT Printer Port */
+	{ .id = "PNP0401" },		/* ECP Printer Port */
 	/* ni_atmio.c */
-	{"NIC1900"},
-	{"NIC2400"},
-	{"NIC2500"},
-	{"NIC2600"},
-	{"NIC2700"},
+	{ .id = "NIC1900" },
+	{ .id = "NIC2400" },
+	{ .id = "NIC2500" },
+	{ .id = "NIC2600" },
+	{ .id = "NIC2700" },
 	/* serial */
-	{"AAC000F"},		/* Archtek America Corp. Archtek SmartLink Modem 3334BT Plug & Play */
-	{"ADC0001"},		/* Anchor Datacomm BV. SXPro 144 External Data Fax Modem Plug & Play */
-	{"ADC0002"},		/* SXPro 288 External Data Fax Modem Plug & Play */
-	{"AEI0250"},		/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
-	{"AEI1240"},		/* Actiontec ISA PNP 56K X2 Fax Modem */
-	{"AKY1021"},		/* Rockwell 56K ACF II Fax+Data+Voice Modem */
-	{"ALI5123"},		/* ALi Fast Infrared Controller */
-	{"AZT4001"},		/* AZT3005 PnP SOUND DEVICE */
-	{"BDP3336"},		/* Best Data Products Inc. Smart One 336F PnP Modem */
-	{"BRI0A49"},		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
-	{"BRI1400"},		/* Boca Research 33,600 ACF Modem */
-	{"BRI3400"},		/* Boca 33.6 Kbps Internal FD34FSVD */
-	{"CPI4050"},		/* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
-	{"CTL3001"},		/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
-	{"CTL3011"},		/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
-	{"DAV0336"},		/* Davicom ISA 33.6K Modem */
-	{"DMB1032"},		/* Creative Modem Blaster Flash56 DI5601-1 */
-	{"DMB2001"},		/* Creative Modem Blaster V.90 DI5660 */
-	{"ETT0002"},		/* E-Tech CyberBULLET PC56RVP */
-	{"FUJ0202"},		/* Fujitsu 33600 PnP-I2 R Plug & Play */
-	{"FUJ0205"},		/* Fujitsu FMV-FX431 Plug & Play */
-	{"FUJ0206"},		/* Fujitsu 33600 PnP-I4 R Plug & Play */
-	{"FUJ0209"},		/* Fujitsu Fax Voice 33600 PNP-I5 R Plug & Play */
-	{"GVC000F"},		/* Archtek SmartLink Modem 3334BT Plug & Play */
-	{"GVC0303"},		/* Archtek SmartLink Modem 3334BRV 33.6K Data Fax Voice */
-	{"HAY0001"},		/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
-	{"HAY000C"},		/* Hayes Optima 336 V.34 + FAX + Voice PnP */
-	{"HAY000D"},		/* Hayes Optima 336B V.34 + FAX + Voice PnP */
-	{"HAY5670"},		/* Hayes Accura 56K Ext Fax Modem PnP */
-	{"HAY5674"},		/* Hayes Accura 56K Ext Fax Modem PnP */
-	{"HAY5675"},		/* Hayes Accura 56K Fax Modem PnP */
-	{"HAYF000"},		/* Hayes 288, V.34 + FAX */
-	{"HAYF001"},		/* Hayes Optima 288 V.34 + FAX + Voice, Plug & Play */
-	{"IBM0033"},		/* IBM Thinkpad 701 Internal Modem Voice */
-	{"PNP4972"},		/* Intermec CV60 touchscreen port */
-	{"IXDC801"},		/* Intertex 28k8 33k6 Voice EXT PnP */
-	{"IXDC901"},		/* Intertex 33k6 56k Voice EXT PnP */
-	{"IXDD801"},		/* Intertex 28k8 33k6 Voice SP EXT PnP */
-	{"IXDD901"},		/* Intertex 33k6 56k Voice SP EXT PnP */
-	{"IXDF401"},		/* Intertex 28k8 33k6 Voice SP INT PnP */
-	{"IXDF801"},		/* Intertex 28k8 33k6 Voice SP EXT PnP */
-	{"IXDF901"},		/* Intertex 33k6 56k Voice SP EXT PnP */
-	{"KOR4522"},		/* KORTEX 28800 Externe PnP */
-	{"KORF661"},		/* KXPro 33.6 Vocal ASVD PnP */
-	{"LAS4040"},		/* LASAT Internet 33600 PnP */
-	{"LAS4540"},		/* Lasat Safire 560 PnP */
-	{"LAS5440"},		/* Lasat Safire 336  PnP */
-	{"MNP0281"},		/* Microcom TravelPorte FAST V.34 Plug & Play */
-	{"MNP0336"},		/* Microcom DeskPorte V.34 FAST or FAST+ Plug & Play */
-	{"MNP0339"},		/* Microcom DeskPorte FAST EP 28.8 Plug & Play */
-	{"MNP0342"},		/* Microcom DeskPorte 28.8P Plug & Play */
-	{"MNP0500"},		/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
-	{"MNP0501"},		/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
-	{"MNP0502"},		/* Microcom DeskPorte 28.8S Internal Plug & Play */
-	{"MOT1105"},		/* Motorola BitSURFR Plug & Play */
-	{"MOT1111"},		/* Motorola TA210 Plug & Play */
-	{"MOT1114"},		/* Motorola HMTA 200 (ISDN) Plug & Play */
-	{"MOT1115"},		/* Motorola BitSURFR Plug & Play */
-	{"MOT1190"},		/* Motorola Lifestyle 28.8 Internal */
-	{"MOT1501"},		/* Motorola V.3400 Plug & Play */
-	{"MOT1502"},		/* Motorola Lifestyle 28.8 V.34 Plug & Play */
-	{"MOT1505"},		/* Motorola Power 28.8 V.34 Plug & Play */
-	{"MOT1509"},		/* Motorola ModemSURFR External 28.8 Plug & Play */
-	{"MOT150A"},		/* Motorola Premier 33.6 Desktop Plug & Play */
-	{"MOT150F"},		/* Motorola VoiceSURFR 56K External PnP */
-	{"MOT1510"},		/* Motorola ModemSURFR 56K External PnP */
-	{"MOT1550"},		/* Motorola ModemSURFR 56K Internal PnP */
-	{"MOT1560"},		/* Motorola ModemSURFR Internal 28.8 Plug & Play */
-	{"MOT1580"},		/* Motorola Premier 33.6 Internal Plug & Play */
-	{"MOT15B0"},		/* Motorola OnlineSURFR 28.8 Internal Plug & Play */
-	{"MOT15F0"},		/* Motorola VoiceSURFR 56K Internal PnP */
-	{"MVX00A1"},		/*  Deskline K56 Phone System PnP */
-	{"MVX00F2"},		/* PC Rider K56 Phone System PnP */
-	{"nEC8241"},		/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
-	{"PMC2430"},		/* Pace 56 Voice Internal Plug & Play Modem */
-	{"PNP0500"},		/* Generic standard PC COM port     */
-	{"PNP0501"},		/* Generic 16550A-compatible COM port */
-	{"PNPC000"},		/* Compaq 14400 Modem */
-	{"PNPC001"},		/* Compaq 2400/9600 Modem */
-	{"PNPC031"},		/* Dial-Up Networking Serial Cable between 2 PCs */
-	{"PNPC032"},		/* Dial-Up Networking Parallel Cable between 2 PCs */
-	{"PNPC100"},		/* Standard 9600 bps Modem */
-	{"PNPC101"},		/* Standard 14400 bps Modem */
-	{"PNPC102"},		/*  Standard 28800 bps Modem */
-	{"PNPC103"},		/*  Standard Modem */
-	{"PNPC104"},		/*  Standard 9600 bps Modem */
-	{"PNPC105"},		/*  Standard 14400 bps Modem */
-	{"PNPC106"},		/*  Standard 28800 bps Modem */
-	{"PNPC107"},		/*  Standard Modem */
-	{"PNPC108"},		/* Standard 9600 bps Modem */
-	{"PNPC109"},		/* Standard 14400 bps Modem */
-	{"PNPC10A"},		/* Standard 28800 bps Modem */
-	{"PNPC10B"},		/* Standard Modem */
-	{"PNPC10C"},		/* Standard 9600 bps Modem */
-	{"PNPC10D"},		/* Standard 14400 bps Modem */
-	{"PNPC10E"},		/* Standard 28800 bps Modem */
-	{"PNPC10F"},		/* Standard Modem */
-	{"PNP2000"},		/* Standard PCMCIA Card Modem */
-	{"ROK0030"},		/* Rockwell 33.6 DPF Internal PnP, Modular Technology 33.6 Internal PnP */
-	{"ROK0100"},		/* KORTEX 14400 Externe PnP */
-	{"ROK4120"},		/* Rockwell 28.8 */
-	{"ROK4920"},		/* Viking 28.8 INTERNAL Fax+Data+Voice PnP */
-	{"RSS00A0"},		/* Rockwell 33.6 DPF External PnP, BT Prologue 33.6 External PnP, Modular Technology 33.6 External PnP */
-	{"RSS0262"},		/* Viking 56K FAX INT */
-	{"RSS0250"},		/* K56 par,VV,Voice,Speakphone,AudioSpan,PnP */
-	{"SUP1310"},		/* SupraExpress 28.8 Data/Fax PnP modem */
-	{"SUP1381"},		/* SupraExpress 336i PnP Voice Modem */
-	{"SUP1421"},		/* SupraExpress 33.6 Data/Fax PnP modem */
-	{"SUP1590"},		/* SupraExpress 33.6 Data/Fax PnP modem */
-	{"SUP1620"},		/* SupraExpress 336i Sp ASVD */
-	{"SUP1760"},		/* SupraExpress 33.6 Data/Fax PnP modem */
-	{"SUP2171"},		/* SupraExpress 56i Sp Intl */
-	{"TEX0011"},		/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
-	{"UAC000F"},		/* Archtek SmartLink Modem 3334BT Plug & Play */
-	{"USR0000"},		/* 3Com Corp. Gateway Telepath IIvi 33.6 */
-	{"USR0002"},		/* U.S. Robotics Sporster 33.6K Fax INT PnP */
-	{"USR0004"},		/*  Sportster Vi 14.4 PnP FAX Voicemail */
-	{"USR0006"},		/* U.S. Robotics 33.6K Voice INT PnP */
-	{"USR0007"},		/* U.S. Robotics 33.6K Voice EXT PnP */
-	{"USR0009"},		/* U.S. Robotics Courier V.Everything INT PnP */
-	{"USR2002"},		/* U.S. Robotics 33.6K Voice INT PnP */
-	{"USR2070"},		/* U.S. Robotics 56K Voice INT PnP */
-	{"USR2080"},		/* U.S. Robotics 56K Voice EXT PnP */
-	{"USR3031"},		/* U.S. Robotics 56K FAX INT */
-	{"USR3050"},		/* U.S. Robotics 56K FAX INT */
-	{"USR3070"},		/* U.S. Robotics 56K Voice INT PnP */
-	{"USR3080"},		/* U.S. Robotics 56K Voice EXT PnP */
-	{"USR3090"},		/* U.S. Robotics 56K Voice INT PnP */
-	{"USR9100"},		/* U.S. Robotics 56K Message  */
-	{"USR9160"},		/* U.S. Robotics 56K FAX EXT PnP */
-	{"USR9170"},		/* U.S. Robotics 56K FAX INT PnP */
-	{"USR9180"},		/* U.S. Robotics 56K Voice EXT PnP */
-	{"USR9190"},		/* U.S. Robotics 56K Voice INT PnP */
-	{"WACFXXX"},		/* Wacom tablets */
-	{"FPI2002"},		/* Compaq touchscreen */
-	{"FUJ02B2"},		/* Fujitsu Stylistic touchscreens */
-	{"FUJ02B3"},
-	{"FUJ02B4"},		/* Fujitsu Stylistic LT touchscreens */
-	{"FUJ02B6"},		/* Passive Fujitsu Stylistic touchscreens */
-	{"FUJ02B7"},
-	{"FUJ02B8"},
-	{"FUJ02B9"},
-	{"FUJ02BC"},
-	{"FUJ02E5"},		/* Fujitsu Wacom Tablet PC device */
-	{"FUJ02E6"},		/* Fujitsu P-series tablet PC device */
-	{"FUJ02E7"},		/* Fujitsu Wacom 2FGT Tablet PC device */
-	{"FUJ02E9"},		/* Fujitsu Wacom 1FGT Tablet PC device */
-	{"LTS0001"},		/* LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in disguise) */
-	{"WCI0003"},		/* Rockwell's (PORALiNK) 33600 INT PNP */
-	{"WEC1022"},		/* Winbond CIR port, should not be probed. We should keep track of it to prevent the legacy serial driver from probing it */
+	{ .id = "AAC000F" },		/* Archtek America Corp. Archtek SmartLink Modem 3334BT Plug & Play */
+	{ .id = "ADC0001" },		/* Anchor Datacomm BV. SXPro 144 External Data Fax Modem Plug & Play */
+	{ .id = "ADC0002" },		/* SXPro 288 External Data Fax Modem Plug & Play */
+	{ .id = "AEI0250" },		/* PROLiNK 1456VH ISA PnP K56flex Fax Modem */
+	{ .id = "AEI1240" },		/* Actiontec ISA PNP 56K X2 Fax Modem */
+	{ .id = "AKY1021" },		/* Rockwell 56K ACF II Fax+Data+Voice Modem */
+	{ .id = "ALI5123" },		/* ALi Fast Infrared Controller */
+	{ .id = "AZT4001" },		/* AZT3005 PnP SOUND DEVICE */
+	{ .id = "BDP3336" },		/* Best Data Products Inc. Smart One 336F PnP Modem */
+	{ .id = "BRI0A49" },		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
+	{ .id = "BRI1400" },		/* Boca Research 33,600 ACF Modem */
+	{ .id = "BRI3400" },		/* Boca 33.6 Kbps Internal FD34FSVD */
+	{ .id = "CPI4050" },		/* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
+	{ .id = "CTL3001" },		/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
+	{ .id = "CTL3011" },		/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
+	{ .id = "DAV0336" },		/* Davicom ISA 33.6K Modem */
+	{ .id = "DMB1032" },		/* Creative Modem Blaster Flash56 DI5601-1 */
+	{ .id = "DMB2001" },		/* Creative Modem Blaster V.90 DI5660 */
+	{ .id = "ETT0002" },		/* E-Tech CyberBULLET PC56RVP */
+	{ .id = "FUJ0202" },		/* Fujitsu 33600 PnP-I2 R Plug & Play */
+	{ .id = "FUJ0205" },		/* Fujitsu FMV-FX431 Plug & Play */
+	{ .id = "FUJ0206" },		/* Fujitsu 33600 PnP-I4 R Plug & Play */
+	{ .id = "FUJ0209" },		/* Fujitsu Fax Voice 33600 PNP-I5 R Plug & Play */
+	{ .id = "GVC000F" },		/* Archtek SmartLink Modem 3334BT Plug & Play */
+	{ .id = "GVC0303" },		/* Archtek SmartLink Modem 3334BRV 33.6K Data Fax Voice */
+	{ .id = "HAY0001" },		/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
+	{ .id = "HAY000C" },		/* Hayes Optima 336 V.34 + FAX + Voice PnP */
+	{ .id = "HAY000D" },		/* Hayes Optima 336B V.34 + FAX + Voice PnP */
+	{ .id = "HAY5670" },		/* Hayes Accura 56K Ext Fax Modem PnP */
+	{ .id = "HAY5674" },		/* Hayes Accura 56K Ext Fax Modem PnP */
+	{ .id = "HAY5675" },		/* Hayes Accura 56K Fax Modem PnP */
+	{ .id = "HAYF000" },		/* Hayes 288, V.34 + FAX */
+	{ .id = "HAYF001" },		/* Hayes Optima 288 V.34 + FAX + Voice, Plug & Play */
+	{ .id = "IBM0033" },		/* IBM Thinkpad 701 Internal Modem Voice */
+	{ .id = "PNP4972" },		/* Intermec CV60 touchscreen port */
+	{ .id = "IXDC801" },		/* Intertex 28k8 33k6 Voice EXT PnP */
+	{ .id = "IXDC901" },		/* Intertex 33k6 56k Voice EXT PnP */
+	{ .id = "IXDD801" },		/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	{ .id = "IXDD901" },		/* Intertex 33k6 56k Voice SP EXT PnP */
+	{ .id = "IXDF401" },		/* Intertex 28k8 33k6 Voice SP INT PnP */
+	{ .id = "IXDF801" },		/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	{ .id = "IXDF901" },		/* Intertex 33k6 56k Voice SP EXT PnP */
+	{ .id = "KOR4522" },		/* KORTEX 28800 Externe PnP */
+	{ .id = "KORF661" },		/* KXPro 33.6 Vocal ASVD PnP */
+	{ .id = "LAS4040" },		/* LASAT Internet 33600 PnP */
+	{ .id = "LAS4540" },		/* Lasat Safire 560 PnP */
+	{ .id = "LAS5440" },		/* Lasat Safire 336  PnP */
+	{ .id = "MNP0281" },		/* Microcom TravelPorte FAST V.34 Plug & Play */
+	{ .id = "MNP0336" },		/* Microcom DeskPorte V.34 FAST or FAST+ Plug & Play */
+	{ .id = "MNP0339" },		/* Microcom DeskPorte FAST EP 28.8 Plug & Play */
+	{ .id = "MNP0342" },		/* Microcom DeskPorte 28.8P Plug & Play */
+	{ .id = "MNP0500" },		/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	{ .id = "MNP0501" },		/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	{ .id = "MNP0502" },		/* Microcom DeskPorte 28.8S Internal Plug & Play */
+	{ .id = "MOT1105" },		/* Motorola BitSURFR Plug & Play */
+	{ .id = "MOT1111" },		/* Motorola TA210 Plug & Play */
+	{ .id = "MOT1114" },		/* Motorola HMTA 200 (ISDN) Plug & Play */
+	{ .id = "MOT1115" },		/* Motorola BitSURFR Plug & Play */
+	{ .id = "MOT1190" },		/* Motorola Lifestyle 28.8 Internal */
+	{ .id = "MOT1501" },		/* Motorola V.3400 Plug & Play */
+	{ .id = "MOT1502" },		/* Motorola Lifestyle 28.8 V.34 Plug & Play */
+	{ .id = "MOT1505" },		/* Motorola Power 28.8 V.34 Plug & Play */
+	{ .id = "MOT1509" },		/* Motorola ModemSURFR External 28.8 Plug & Play */
+	{ .id = "MOT150A" },		/* Motorola Premier 33.6 Desktop Plug & Play */
+	{ .id = "MOT150F" },		/* Motorola VoiceSURFR 56K External PnP */
+	{ .id = "MOT1510" },		/* Motorola ModemSURFR 56K External PnP */
+	{ .id = "MOT1550" },		/* Motorola ModemSURFR 56K Internal PnP */
+	{ .id = "MOT1560" },		/* Motorola ModemSURFR Internal 28.8 Plug & Play */
+	{ .id = "MOT1580" },		/* Motorola Premier 33.6 Internal Plug & Play */
+	{ .id = "MOT15B0" },		/* Motorola OnlineSURFR 28.8 Internal Plug & Play */
+	{ .id = "MOT15F0" },		/* Motorola VoiceSURFR 56K Internal PnP */
+	{ .id = "MVX00A1" },		/*  Deskline K56 Phone System PnP */
+	{ .id = "MVX00F2" },		/* PC Rider K56 Phone System PnP */
+	{ .id = "nEC8241" },		/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
+	{ .id = "PMC2430" },		/* Pace 56 Voice Internal Plug & Play Modem */
+	{ .id = "PNP0500" },		/* Generic standard PC COM port     */
+	{ .id = "PNP0501" },		/* Generic 16550A-compatible COM port */
+	{ .id = "PNPC000" },		/* Compaq 14400 Modem */
+	{ .id = "PNPC001" },		/* Compaq 2400/9600 Modem */
+	{ .id = "PNPC031" },		/* Dial-Up Networking Serial Cable between 2 PCs */
+	{ .id = "PNPC032" },		/* Dial-Up Networking Parallel Cable between 2 PCs */
+	{ .id = "PNPC100" },		/* Standard 9600 bps Modem */
+	{ .id = "PNPC101" },		/* Standard 14400 bps Modem */
+	{ .id = "PNPC102" },		/* Standard 28800 bps Modem */
+	{ .id = "PNPC103" },		/* Standard Modem */
+	{ .id = "PNPC104" },		/* Standard 9600 bps Modem */
+	{ .id = "PNPC105" },		/* Standard 14400 bps Modem */
+	{ .id = "PNPC106" },		/* Standard 28800 bps Modem */
+	{ .id = "PNPC107" },		/* Standard Modem */
+	{ .id = "PNPC108" },		/* Standard 9600 bps Modem */
+	{ .id = "PNPC109" },		/* Standard 14400 bps Modem */
+	{ .id = "PNPC10A" },		/* Standard 28800 bps Modem */
+	{ .id = "PNPC10B" },		/* Standard Modem */
+	{ .id = "PNPC10C" },		/* Standard 9600 bps Modem */
+	{ .id = "PNPC10D" },		/* Standard 14400 bps Modem */
+	{ .id = "PNPC10E" },		/* Standard 28800 bps Modem */
+	{ .id = "PNPC10F" },		/* Standard Modem */
+	{ .id = "PNP2000" },		/* Standard PCMCIA Card Modem */
+	{ .id = "ROK0030" },		/* Rockwell 33.6 DPF Internal PnP, Modular Technology 33.6 Internal PnP */
+	{ .id = "ROK0100" },		/* KORTEX 14400 Externe PnP */
+	{ .id = "ROK4120" },		/* Rockwell 28.8 */
+	{ .id = "ROK4920" },		/* Viking 28.8 INTERNAL Fax+Data+Voice PnP */
+	{ .id = "RSS00A0" },		/* Rockwell 33.6 DPF External PnP, BT Prologue 33.6 External PnP, Modular Technology 33.6 External PnP */
+	{ .id = "RSS0262" },		/* Viking 56K FAX INT */
+	{ .id = "RSS0250" },		/* K56 par,VV,Voice,Speakphone,AudioSpan,PnP */
+	{ .id = "SUP1310" },		/* SupraExpress 28.8 Data/Fax PnP modem */
+	{ .id = "SUP1381" },		/* SupraExpress 336i PnP Voice Modem */
+	{ .id = "SUP1421" },		/* SupraExpress 33.6 Data/Fax PnP modem */
+	{ .id = "SUP1590" },		/* SupraExpress 33.6 Data/Fax PnP modem */
+	{ .id = "SUP1620" },		/* SupraExpress 336i Sp ASVD */
+	{ .id = "SUP1760" },		/* SupraExpress 33.6 Data/Fax PnP modem */
+	{ .id = "SUP2171" },		/* SupraExpress 56i Sp Intl */
+	{ .id = "TEX0011" },		/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
+	{ .id = "UAC000F" },		/* Archtek SmartLink Modem 3334BT Plug & Play */
+	{ .id = "USR0000" },		/* 3Com Corp. Gateway Telepath IIvi 33.6 */
+	{ .id = "USR0002" },		/* U.S. Robotics Sporster 33.6K Fax INT PnP */
+	{ .id = "USR0004" },		/*  Sportster Vi 14.4 PnP FAX Voicemail */
+	{ .id = "USR0006" },		/* U.S. Robotics 33.6K Voice INT PnP */
+	{ .id = "USR0007" },		/* U.S. Robotics 33.6K Voice EXT PnP */
+	{ .id = "USR0009" },		/* U.S. Robotics Courier V.Everything INT PnP */
+	{ .id = "USR2002" },		/* U.S. Robotics 33.6K Voice INT PnP */
+	{ .id = "USR2070" },		/* U.S. Robotics 56K Voice INT PnP */
+	{ .id = "USR2080" },		/* U.S. Robotics 56K Voice EXT PnP */
+	{ .id = "USR3031" },		/* U.S. Robotics 56K FAX INT */
+	{ .id = "USR3050" },		/* U.S. Robotics 56K FAX INT */
+	{ .id = "USR3070" },		/* U.S. Robotics 56K Voice INT PnP */
+	{ .id = "USR3080" },		/* U.S. Robotics 56K Voice EXT PnP */
+	{ .id = "USR3090" },		/* U.S. Robotics 56K Voice INT PnP */
+	{ .id = "USR9100" },		/* U.S. Robotics 56K Message  */
+	{ .id = "USR9160" },		/* U.S. Robotics 56K FAX EXT PnP */
+	{ .id = "USR9170" },		/* U.S. Robotics 56K FAX INT PnP */
+	{ .id = "USR9180" },		/* U.S. Robotics 56K Voice EXT PnP */
+	{ .id = "USR9190" },		/* U.S. Robotics 56K Voice INT PnP */
+	{ .id = "WACFXXX" },		/* Wacom tablets */
+	{ .id = "FPI2002" },		/* Compaq touchscreen */
+	{ .id = "FUJ02B2" },		/* Fujitsu Stylistic touchscreens */
+	{ .id = "FUJ02B3" },
+	{ .id = "FUJ02B4" },		/* Fujitsu Stylistic LT touchscreens */
+	{ .id = "FUJ02B6" },		/* Passive Fujitsu Stylistic touchscreens */
+	{ .id = "FUJ02B7" },
+	{ .id = "FUJ02B8" },
+	{ .id = "FUJ02B9" },
+	{ .id = "FUJ02BC" },
+	{ .id = "FUJ02E5" },		/* Fujitsu Wacom Tablet PC device */
+	{ .id = "FUJ02E6" },		/* Fujitsu P-series tablet PC device */
+	{ .id = "FUJ02E7" },		/* Fujitsu Wacom 2FGT Tablet PC device */
+	{ .id = "FUJ02E9" },		/* Fujitsu Wacom 1FGT Tablet PC device */
+	{ .id = "LTS0001" },		/* LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in disguise) */
+	{ .id = "WCI0003" },		/* Rockwell's (PORALiNK) 33600 INT PNP */
+	{ .id = "WEC1022" },		/* Winbond CIR port, should not be probed. We should keep track of it to prevent the legacy serial driver from probing it */
 	/* scl200wdt */
-	{"NSC0800"},		/* National Semiconductor PC87307/PC97307 watchdog component */
+	{ .id = "NSC0800" },		/* National Semiconductor PC87307/PC97307 watchdog component */
 	/* mpu401 */
-	{"PNPb006"},
+	{ .id = "PNPb006" },
 	/* cs423x-pnpbios */
-	{"CSC0100"},
-	{"CSC0103"},
-	{"CSC0110"},
-	{"CSC0000"},
-	{"GIM0100"},		/* Guillemot Turtlebeach something appears to be cs4232 compatible */
+	{ .id = "CSC0100" },
+	{ .id = "CSC0103" },
+	{ .id = "CSC0110" },
+	{ .id = "CSC0000" },
+	{ .id = "GIM0100" },		/* Guillemot Turtlebeach something appears to be cs4232 compatible */
 	/* es18xx-pnpbios */
-	{"ESS1869"},
-	{"ESS1879"},
+	{ .id = "ESS1869" },
+	{ .id = "ESS1879" },
 	/* snd-opl3sa2-pnpbios */
-	{"YMH0021"},
-	{"NMX2210"},		/* Gateway Solo 2500 */
+	{ .id = "YMH0021" },
+	{ .id = "NMX2210" },		/* Gateway Solo 2500 */
 	{ }
 };
 
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5fbab54171b7..db6e66631c9e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -631,8 +631,8 @@ void __init acpi_early_processor_control_setup(void)
  */
 static const struct acpi_device_id processor_device_ids[] = {
 
-	{ ACPI_PROCESSOR_OBJECT_HID, },
-	{ ACPI_PROCESSOR_DEVICE_HID, },
+	{ .id = ACPI_PROCESSOR_OBJECT_HID },
+	{ .id = ACPI_PROCESSOR_DEVICE_HID },
 
 	{ }
 };
@@ -655,7 +655,7 @@ static int acpi_processor_container_attach(struct acpi_device *dev,
 }
 
 static const struct acpi_device_id processor_container_ids[] = {
-	{ ACPI_PROCESSOR_CONTAINER_HID, },
+	{ .id = ACPI_PROCESSOR_CONTAINER_HID },
 	{ }
 };
 
diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index bdd797fcb054..098845895fbc 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -130,7 +130,7 @@ static int nvidia_ghes_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
-	{ "NVDA2012" },
+	{ .id = "NVDA2012" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 73a9efe07160..66a57eea2280 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -60,11 +60,11 @@ MODULE_DESCRIPTION("ACPI Button Driver");
 MODULE_LICENSE("GPL");
 
 static const struct acpi_device_id button_device_ids[] = {
-	{ACPI_BUTTON_HID_LID, ACPI_BUTTON_TYPE_LID},
-	{ACPI_BUTTON_HID_SLEEP, ACPI_BUTTON_TYPE_SLEEP},
-	{ACPI_BUTTON_HID_SLEEPF, ACPI_BUTTON_TYPE_SLEEP},
-	{ACPI_BUTTON_HID_POWER, ACPI_BUTTON_TYPE_POWER},
-	{ACPI_BUTTON_HID_POWERF, ACPI_BUTTON_TYPE_POWER},
+	{ .id = ACPI_BUTTON_HID_LID, .driver_data = ACPI_BUTTON_TYPE_LID },
+	{ .id = ACPI_BUTTON_HID_SLEEP, .driver_data = ACPI_BUTTON_TYPE_SLEEP },
+	{ .id = ACPI_BUTTON_HID_SLEEPF, .driver_data = ACPI_BUTTON_TYPE_SLEEP },
+	{ .id = ACPI_BUTTON_HID_POWER, .driver_data = ACPI_BUTTON_TYPE_POWER },
+	{ .id = ACPI_BUTTON_HID_POWERF, .driver_data = ACPI_BUTTON_TYPE_POWER },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index e8c60f902846..189dc68b8875 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -179,7 +179,7 @@ static void ged_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id ged_acpi_ids[] = {
-	{"ACPI0013"},
+	{ .id = "ACPI0013" },
 	{ }
 };
 
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 818359e21d1a..ed5711d26cb3 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -415,7 +415,7 @@ static int acpi_pfrt_log_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id acpi_pfrt_log_ids[] = {
-	{"INTC1081"},
+	{ .id = "INTC1081" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_pfrt_log_ids);
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 993ab5a479f5..997dbc3a95be 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -594,7 +594,7 @@ static int acpi_pfru_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id acpi_pfru_ids[] = {
-	{"INTC1080"},
+	{ .id = "INTC1080" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 913da04062b7..0a607a741215 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1821,33 +1821,33 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * by the drivers/platform/x86/serial-multi-instantiate.c driver, which
 	 * knows which client device id to use for each resource.
 	 */
-		{"AWDZ8399", },
-		{"BSG1160", },
-		{"BSG2150", },
-		{"CSC3551", },
-		{"CSC3554", },
-		{"CSC3556", },
-		{"CSC3557", },
-		{"INT33FE", },
-		{"INT3515", },
-		{"TXNW2781", },
+		{ .id = "AWDZ8399" },
+		{ .id = "BSG1160" },
+		{ .id = "BSG2150" },
+		{ .id = "CSC3551" },
+		{ .id = "CSC3554" },
+		{ .id = "CSC3556" },
+		{ .id = "CSC3557" },
+		{ .id = "INT33FE" },
+		{ .id = "INT3515" },
+		{ .id = "TXNW2781" },
 		/* Non-conforming _HID for Cirrus Logic already released */
-		{"CLSA0100", },
-		{"CLSA0101", },
-		{"CLSA0102", },
+		{ .id = "CLSA0100" },
+		{ .id = "CLSA0101" },
+		{ .id = "CLSA0102" },
 	/*
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
 	 */
-		{"MSHW0028", },
+		{ .id = "MSHW0028" },
 	/*
 	 * HIDs of device with an UartSerialBusV2 resource for which userspace
 	 * expects a regular tty cdev to be created (instead of the in kernel
 	 * serdev) and which have a kernel driver which expects a platform_dev
 	 * such as the rfkill-gpio driver.
 	 */
-		{"BCM4752", },
-		{"LNV4752", },
+		{ .id = "BCM4752" },
+		{ .id = "LNV4752" },
 		{ }
 	};
 
@@ -2355,7 +2355,7 @@ static void acpi_default_enumeration(struct acpi_device *device)
 }
 
 static const struct acpi_device_id generic_device_ids[] = {
-	{ACPI_DT_NAMESPACE_HID, },
+	{ .id = ACPI_DT_NAMESPACE_HID },
 	{ }
 };
 
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index ced334e19896..d9891b00d090 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -18,7 +18,7 @@
 #include "../internal.h"
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
-	{ "ACPI000E", 1 }, /* ACPI Time and Alarm Device (TAD) */
+	{ .id = "ACPI000E", .driver_data = 1 }, /* ACPI Time and Alarm Device (TAD) */
 	ACPI_CMOS_RTC_IDS
 };
 
diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 0171eef00484..50b6db40bb18 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -351,41 +351,41 @@ static const struct x86_cpu_id lpss_cpu_ids[] = {
 
 static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	/* Generic LPSS devices */
-	{ "INTL9C60", LPSS_ADDR(lpss_dma_desc) },
+	{ .id = "INTL9C60", .driver_data = LPSS_ADDR(lpss_dma_desc) },
 
 	/* Lynxpoint LPSS devices */
-	{ "INT33C0", LPSS_ADDR(lpt_spi_dev_desc) },
-	{ "INT33C1", LPSS_ADDR(lpt_spi_dev_desc) },
-	{ "INT33C2", LPSS_ADDR(lpt_i2c_dev_desc) },
-	{ "INT33C3", LPSS_ADDR(lpt_i2c_dev_desc) },
-	{ "INT33C4", LPSS_ADDR(lpt_uart_dev_desc) },
-	{ "INT33C5", LPSS_ADDR(lpt_uart_dev_desc) },
-	{ "INT33C6", LPSS_ADDR(lpt_sdio_dev_desc) },
+	{ .id = "INT33C0", .driver_data = LPSS_ADDR(lpt_spi_dev_desc) },
+	{ .id = "INT33C1", .driver_data = LPSS_ADDR(lpt_spi_dev_desc) },
+	{ .id = "INT33C2", .driver_data = LPSS_ADDR(lpt_i2c_dev_desc) },
+	{ .id = "INT33C3", .driver_data = LPSS_ADDR(lpt_i2c_dev_desc) },
+	{ .id = "INT33C4", .driver_data = LPSS_ADDR(lpt_uart_dev_desc) },
+	{ .id = "INT33C5", .driver_data = LPSS_ADDR(lpt_uart_dev_desc) },
+	{ .id = "INT33C6", .driver_data = LPSS_ADDR(lpt_sdio_dev_desc) },
 
 	/* BayTrail LPSS devices */
-	{ "80860F09", LPSS_ADDR(byt_pwm_dev_desc) },
-	{ "80860F0A", LPSS_ADDR(byt_uart_dev_desc) },
-	{ "80860F0E", LPSS_ADDR(byt_spi_dev_desc) },
-	{ "80860F14", LPSS_ADDR(byt_sdio_dev_desc) },
-	{ "80860F41", LPSS_ADDR(byt_i2c_dev_desc) },
+	{ .id = "80860F09", .driver_data = LPSS_ADDR(byt_pwm_dev_desc) },
+	{ .id = "80860F0A", .driver_data = LPSS_ADDR(byt_uart_dev_desc) },
+	{ .id = "80860F0E", .driver_data = LPSS_ADDR(byt_spi_dev_desc) },
+	{ .id = "80860F14", .driver_data = LPSS_ADDR(byt_sdio_dev_desc) },
+	{ .id = "80860F41", .driver_data = LPSS_ADDR(byt_i2c_dev_desc) },
 
 	/* Braswell LPSS devices */
-	{ "80862286", LPSS_ADDR(lpss_dma_desc) },
-	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
-	{ "80862289", LPSS_ADDR(bsw_pwm2_dev_desc) },
-	{ "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
-	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
-	{ "808622C0", LPSS_ADDR(lpss_dma_desc) },
-	{ "808622C1", LPSS_ADDR(bsw_i2c_dev_desc) },
+	{ .id = "80862286", .driver_data = LPSS_ADDR(lpss_dma_desc) },
+	{ .id = "80862288", .driver_data = LPSS_ADDR(bsw_pwm_dev_desc) },
+	{ .id = "80862289", .driver_data = LPSS_ADDR(bsw_pwm2_dev_desc) },
+	{ .id = "8086228A", .driver_data = LPSS_ADDR(bsw_uart_dev_desc) },
+	{ .id = "8086228E", .driver_data = LPSS_ADDR(bsw_spi_dev_desc) },
+	{ .id = "808622C0", .driver_data = LPSS_ADDR(lpss_dma_desc) },
+	{ .id = "808622C1", .driver_data = LPSS_ADDR(bsw_i2c_dev_desc) },
 
 	/* Broadwell LPSS devices */
-	{ "INT3430", LPSS_ADDR(lpt_spi_dev_desc) },
-	{ "INT3431", LPSS_ADDR(lpt_spi_dev_desc) },
-	{ "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
-	{ "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
-	{ "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
-	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
-	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
+	{ .id = "INT3430", .driver_data = LPSS_ADDR(lpt_spi_dev_desc) },
+	{ .id = "INT3431", .driver_data = LPSS_ADDR(lpt_spi_dev_desc) },
+	{ .id = "INT3432", .driver_data = LPSS_ADDR(lpt_i2c_dev_desc) },
+	{ .id = "INT3433", .driver_data = LPSS_ADDR(lpt_i2c_dev_desc) },
+	{ .id = "INT3434", .driver_data = LPSS_ADDR(lpt_uart_dev_desc) },
+	{ .id = "INT3435", .driver_data = LPSS_ADDR(lpt_uart_dev_desc) },
+	{ .id = "INT3436", .driver_data = LPSS_ADDR(lpt_sdio_dev_desc) },
 
 	{ }
 };
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 74e36c6365dc..51c9cbf5beb4 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -122,7 +122,7 @@ module_param(check_lps0_constraints, bool, 0644);
 MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraints");
 
 static const struct acpi_device_id lps0_device_ids[] = {
-	{"PNP0D80", },
+	{ .id = "PNP0D80" },
 	{ }
 };
 
@@ -520,10 +520,10 @@ static const struct amd_lps0_hid_device_data amd_cezanne = {
 };
 
 static const struct acpi_device_id amd_hid_ids[] = {
-	{"AMD0004",	(kernel_ulong_t)&amd_picasso,	},
-	{"AMD0005",	(kernel_ulong_t)&amd_picasso,	},
-	{"AMDI0005",	(kernel_ulong_t)&amd_picasso,	},
-	{"AMDI0006",	(kernel_ulong_t)&amd_cezanne,	},
+	{ .id = "AMD0004", .driver_data = (kernel_ulong_t)&amd_picasso },
+	{ .id = "AMD0005", .driver_data = (kernel_ulong_t)&amd_picasso },
+	{ .id = "AMDI0005", .driver_data = (kernel_ulong_t)&amd_picasso },
+	{ .id = "AMDI0006", .driver_data = (kernel_ulong_t)&amd_cezanne },
 	{ }
 };
 
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 32c74864226f..e723575399b8 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -47,7 +47,7 @@ struct override_status_id {
 };
 
 #define ENTRY(status, hid, uid, path, cpu_vfm, dmi...) {		\
-	{ { hid, }, { } },						\
+	{ { .id = hid }, { } },						\
 	{ X86_MATCH_VFM(cpu_vfm, NULL), {} },				\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index aed3ddb388c0..a77f476115da 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -828,9 +828,9 @@ int acpi_mrrm_max_mem_region(void);
 #endif
 
 #define ACPI_CMOS_RTC_IDS	\
-	{ "PNP0B00", },		\
-	{ "PNP0B01", },		\
-	{ "PNP0B02", },		\
+	{ .id = "PNP0B00" },	\
+	{ .id = "PNP0B01" },	\
+	{ .id = "PNP0B02" },	\
 	{ }
 
 extern bool cmos_rtc_platform_device_present;
-- 
2.56.0.rc1

