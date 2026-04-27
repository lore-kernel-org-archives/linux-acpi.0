Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6638A717
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331484; cv=none; b=pKNOcoW/S3kSeHn+nta1fkKCAqDYrh0VDlSUWhjzTS0P+drjNzTYu/AFT12u2nktxTgbaUeB6xxFOZL5CzG/pK+2DvinHcxFku7YU0vdMuvjUOCAc434EicPh7G7PsXkIu19K6raUzxtHu4K9z9/oXFQD8bGpXy0PcSYjm/jpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331484; c=relaxed/simple;
	bh=9epae0Y17V03nwPv50Q4iZhYe2dwcmJD1z1kPgH8V8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjghXbl16yP6wBsNL+pbj+kY4JM9k/+kvB1nEvKSX4BqraC6MdgMZIEI8OYZN5LFXevli9HTHOz5kqnLan4nmc6ZZjpRErVCGboZQFKDgvAb2yMU6TZbb8bQr6StWYjTPoDMixWzUsMcrTMnYsYI7LL61a1npN+0TeTiu3pgfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWWa8TLA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWWa8TLA"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-42fc6923f38so3360893fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777331481; x=1777936281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQJuwVnLXkBQ+b908Jxq9pZvBupGjkmcb1ReNC4HqXI=;
        b=sWWa8TLAMLqmhHoGJIyj8WmmGF0eeXBVQw8tJuKI1xMCeFMC0aOxtMbQ9CZ1e9fR5T
         fQNnyxEB4QM1D+MItbPl9A1Keg8tR6u1TGA5vD0P2cE34PkojYleRIf8ueqrGG2NsNxi
         KSuYPAGaGt5lfwIekYY5thTPSiEV+5y6bBzV2DhPf/m5Yf6ArKJ2pv3OQfHm+i5Apy89
         v86tb8x+yQHbLol96Oxhjh1rXCLJ/sLXFwj4UgfI9MQxwEOwdU7ZS8U/P46k6ALL1LZK
         myOw0ebMraYs1SijNCU3VQhES/HTaIyn/EizeaqZ+eIgetjusAxd37KEkgfKBcPLS+Pu
         SjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777331481; x=1777936281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQJuwVnLXkBQ+b908Jxq9pZvBupGjkmcb1ReNC4HqXI=;
        b=Q88gcLkoF41V6nCPTb2Bx6YLTIW8+p6VMNZf2igsViJU7vu8ZUZ3xZhx/M3O5PCiBk
         M6afLDAH9FVWgzsSdXSt0XhQWFeAeDyR/mcnN6MJ0jEQ9FHhPFsUpX8xXe4WzzRiEg1A
         m0eOaUR/ulnILRYN9BxrwtZ21pnMnyNzYMO0n0J2cHWOxrxKzrNG66C4680T3EK+SFkJ
         89iuoqyWB18TI5uSS1jyKUFtlG7qF5p8crTXjYZfg4YB4ub3jX0nRRU/tfqmUImBRzN2
         VhoMDUyFyyuyaBFChazzwY1FK87/vXtW/ibrdrootjvCygVYyPUmdEYTPnvvKsaDiQs3
         ZkOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aACN3qmHbMPPSLr9jJf9kikgN8t525VWyfawHtOnHIVkRBzEiYQm6JX2G2r/cfMD2rQ9t+QuAX0Xa@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFEo+13g16cxRcVryLXKwkBx9Tu023VG5Q8tXZNVIyVR9P6tX
	UrJm2UK3+2bWD8pqffXyAiRzLbuaO2kjJcwjdIvIokXGjnLkta7N6Rl3
X-Gm-Gg: AeBDievdHEOBOQL6BCArieL3kRnKIP17PnQpfSILGjVtaOYRLSj5ozuTDvtQnS3Bb8W
	vIdB5pvD/w/4uAiIvRJ9zjMh1OPTruYj2Sz62ocYSTgWSuDAlNZ6V7JFsO1Lj0PQRTLJ7fBEB9W
	GtsUuYtnF7MH9FZ/Wngg1fr3Zp8wSmDCeSOLIcaCufkfNBp27Iqn/FrjhOfvdHIGRFF2gSKzutg
	HcvN84qwaYDK3seSbcB61FzCluOLsf8InHyY2xyav/JaipAto3q47eagxZ0gQ9HNAipEqfX7UbJ
	3UE0KBJhSG6VlvzbhI1QiDCX861FvKoquqiCnVgmAcvP+lCad0xVUucq8tXLdYjttSqmTUhmrc3
	zlbeQdEU45sVlVp9+Yv3vpIJmD4FsHdRgSraxWyJc5/WkrWxtKDcutdxUgqimAhjEkVJnh2S6lh
	uYFe+V4WlceEBk0rrQOw+SOwkjLQKtDDRZ8xWXxAUPRPcAoyh/pyYL0Q7EhO1PchjJB8Mk
X-Received: by 2002:a05:6820:c2c2:10b0:694:a30c:24fc with SMTP id 006d021491bc7-6965c62c627mr228236eaf.7.1777331480729;
        Mon, 27 Apr 2026 16:11:20 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6965b951a17sm471949eaf.8.2026.04.27.16.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:11:20 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
Date: Mon, 27 Apr 2026 18:11:19 -0500
Message-ID: <20260427231119.55486-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and unlock() macros with the newer guard() and
scoped_guard() macros. This will help modernize and clean the code.

In intel_soc_pmic_exec_mipi_pmic_seq_element(): While at it, remove
now redundant "ret" variable.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Refactored control flow in certain functions as suggested by Andy.
 - Indent code in scoped_guard block as suggested by Andy.
 - Fix parameter list alignment issues that I found while making this
   v2.

 v3:
 - Fixed guard(mutex)() and scoped_guard() syntax.
 - Added some logical and style changes per Andy's request. The
   requested changes and my personal thoughts can be found at
   https://lore.kernel.org/linux-acpi/ae8QBnSs9fYvkv_i@ashevche-desk.local/

 drivers/acpi/pmic/intel_pmic.c | 64 +++++++++++++++-------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 134e9ca8eaa2..19a97d085efb 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -67,14 +67,12 @@ static acpi_status intel_pmic_power_handler(u32 function,
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
-	mutex_lock(&opregion->lock);
+	guard(mutex)(&opregion->lock);
 
 	result = function == ACPI_READ ?
 		d->get_power(regmap, reg, bit, value64) :
 		d->update_power(regmap, reg, bit, *value64 == 1);
 
-	mutex_unlock(&opregion->lock);
-
 	return result ? AE_ERROR : AE_OK;
 }
 
@@ -182,19 +180,16 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
-	mutex_lock(&opregion->lock);
-
-	if (pmic_thermal_is_temp(address))
-		result = pmic_thermal_temp(opregion, reg, function, value64);
-	else if (pmic_thermal_is_aux(address))
-		result = pmic_thermal_aux(opregion, reg, function, value64);
-	else if (pmic_thermal_is_pen(address))
-		result = pmic_thermal_pen(opregion, reg, bit,
-						function, value64);
-	else
-		result = -EINVAL;
-
-	mutex_unlock(&opregion->lock);
+	scoped_guard(mutex, &opregion->lock) {
+		if (pmic_thermal_is_temp(address))
+			result = pmic_thermal_temp(opregion, reg, function, value64);
+		else if (pmic_thermal_is_aux(address))
+			result = pmic_thermal_aux(opregion, reg, function, value64);
+		else if (pmic_thermal_is_pen(address))
+			result = pmic_thermal_pen(opregion, reg, bit, function, value64);
+		else
+			result = -EINVAL;
+	}
 
 	if (result < 0) {
 		if (result == -EINVAL)
@@ -345,7 +340,6 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 					      u32 value, u32 mask)
 {
 	const struct intel_pmic_opregion_data *d;
-	int ret;
 
 	if (!intel_pmic_opregion) {
 		pr_warn("%s: No PMIC registered\n", __func__);
@@ -354,30 +348,28 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 
 	d = intel_pmic_opregion->data;
 
-	mutex_lock(&intel_pmic_opregion->lock);
+	guard(mutex)(&intel_pmic_opregion->lock);
 
 	if (d->exec_mipi_pmic_seq_element) {
-		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
-						    i2c_address, reg_address,
-						    value, mask);
-	} else if (d->pmic_i2c_address) {
-		if (i2c_address == d->pmic_i2c_address) {
-			ret = regmap_update_bits(intel_pmic_opregion->regmap,
-						 reg_address, mask, value);
-		} else {
+		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
+						     i2c_address, reg_address,
+						     value, mask);
+	}
+
+	if (d->pmic_i2c_address) {
+		if (i2c_address != d->pmic_i2c_address) {
 			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
-			       __func__, i2c_address, reg_address, value, mask);
-			ret = -ENXIO;
+				__func__, i2c_address, reg_address, value, mask);
+			return -ENXIO;
 		}
-	} else {
-		pr_warn("%s: Not implemented\n", __func__);
-		pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
-			__func__, i2c_address, reg_address, value, mask);
-		ret = -EOPNOTSUPP;
-	}
 
-	mutex_unlock(&intel_pmic_opregion->lock);
+		return regmap_update_bits(intel_pmic_opregion->regmap,
+					  reg_address, mask, value);
+	}
 
-	return ret;
+	pr_warn("%s: Not implemented\n", __func__);
+	pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
+		__func__, i2c_address, reg_address, value, mask);
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(intel_soc_pmic_exec_mipi_pmic_seq_element);
-- 
2.53.0

