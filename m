Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06A2C21F1
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002905; cv=none; b=JaCRQ3fl2ESRRXy7M+uZk5PevFcS+Cfn1anQVQ69qAjBDy/qSUpikoOLrXg2xCyDW8wYEydi+ITOq0R7xAPtQxvCFfQxfppgZ3CObHzBaCvXDdGdwUQQ/lNIIO7XROXXtHk9fDXxJ2DF6xL41Byq4zl63MdCXORjdKojo5wSgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002905; c=relaxed/simple;
	bh=fbqp/tLWEdUGwCbgseVMqb+BZIIg/c3ifxxcNciO5T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9Ma2Li4yp31nsyQ1hMA4BPE9ifupBRR/fW2KigAMBPt865x4FmsJEnosuCzwcxXNeSCy1ma7pzETzVbS0vo8PDeLIt5UUHC/0KMtf1oJEHPjtSqM7VWldBBwkSXRBJGQ9RJLpuYY1LhIev99D7L8xwxQaglSzwcm+EYk7/CppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf1KCpNi; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf1KCpNi"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4be94eeacso7470573a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777002903; x=1777607703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+QqOEvBQQNNJhPCAHarXJy9IMtNIeogs/9KHIMbr2g=;
        b=Nf1KCpNiy9Yl/2YyhhS2fQxovhzx5gOnOQbtzCw2/CjzrobmJge4awhoJoKhJGtQDZ
         CLZKlpWJ9sgDgrdO/5xBBO0ivNykoxXifPlxu0kwyfgV/cjkxLPJSKytpO97wiRiHKyk
         XVFR6fXsvFAmt7fNPGdBEy5/75E1udDSylHMjsqCihTq99RLq/UYniHcrBkTHxAqJVwo
         6K+RPdQdNG/XeGEhPp5qXI+MjR8d3+LeNwT5XEjnImRkCnOPq41W6VvTp5lI9hrX5lS3
         V6QWUGCUlLfpk3DnQY/+EGvMBfk3HYxpHv/5mzLkp/So/Bsniw3LV7fd7PqCAASqkCJL
         EYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777002903; x=1777607703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+QqOEvBQQNNJhPCAHarXJy9IMtNIeogs/9KHIMbr2g=;
        b=K61QMt4SaTHlU6xXPlv5ZCs/z2e6dmQj8KOPEiYCrmPpny2LAD9vZF57f6R39gWjxK
         tlRnhTFlOuJvdcEfNz8Vm1Csk+Q/8lsxVAkUluZnx5uJsjRhnt16FLg3HP9XZCEkimRR
         XSaFTgsF1Jaw+5uXr36fCx9bP1BhNyGz0e9beBK5ctjlBgoIlDlmwop+DaO1HpUNSuk8
         MluOSOZmJQm/5NPik+rVd87AvcWY6C18Hz8ImPPqg6v8LHyNf+hj3W7vZoSnTda3z9ob
         FUeX8ihQn0B7eLxAp3T/QxV2UI7eHlqzm0IYIIQpxHeQSHAhKPXGzn9TAUPJ0So+cjqV
         KIsw==
X-Forwarded-Encrypted: i=1; AFNElJ+H4rqn8kYtmcdrHIw2H7T07SMfT5wzRcw6radW9cEvam5J1uUlCU2EYDUvNH6hmUIQyhLtwbO9tjhE@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0R9/yDJ4a7l8rweBchY4hhR7MDnI9H57/vzB/vkPKoTF6HWn
	M/zuDcL+nCyZgcMVtzOIqRPh6ugevhQVdfSLbUJLs2cXPOnE5Lh35ik/
X-Gm-Gg: AeBDiesRZFsGPmvPDnn7PUEH2l8Rw/JMEYP0Xn3mG1tNBYHlnBKEppOkIBOk/beq76J
	tjXHCIvUuXxWJ8E9PCDz9WLA7S2WFfBzwbmE/cgmi8UeZoH/Iq8Ea6hgnfLUgU8dXVd+J8gZ4bB
	siduvVtj76CCq8eWgOlPf9YgO+1P8VZgL+8C0unzBYhbTULEzhMLAl3ccDYeTet6Mz5rqzVTx0R
	iftpVS32ulSNi2BTNGkMNwfpjlMqXQ47FSv2KbEGDsBVy9y5Wwy43UDp766nKaqmRDQn/SUYd+H
	WUJ/PIplBtFJE3xG5+2y75lIVY71g1KTvXSLvOvFT7n0FFwNT/bVjwMZOGf4GLrAT4FLkBV9MQc
	GD49CNpSQSzmzfePgdX+9EIz/Nypmakd0K0iB4HuSQdVMdJqNETH7KN3J/JShwgn1ptiOxr+BMe
	PQXKviQcDoo5W9dHjIsk32F63CD+ICmz1ULCkETC32mK1a7gKE7kljiyWcd1EXXB+PKnAC
X-Received: by 2002:a05:6830:67e8:b0:7dc:d7e8:cb30 with SMTP id 46e09a7af769-7dcd7e8d77emr9368379a34.26.1777002902836;
        Thu, 23 Apr 2026 20:55:02 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm11722342a34.21.2026.04.23.20.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:55:02 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: andy@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
Date: Thu, 23 Apr 2026 22:55:01 -0500
Message-ID: <20260424035501.219946-1-m32285159@gmail.com>
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
 drivers/acpi/pmic/intel_pmic.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 134e9ca8eaa2..36a43328c550 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -67,14 +67,12 @@ static acpi_status intel_pmic_power_handler(u32 function,
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
-	mutex_lock(&opregion->lock);
+	guard(&opregion->lock);
 
 	result = function == ACPI_READ ?
 		d->get_power(regmap, reg, bit, value64) :
 		d->update_power(regmap, reg, bit, *value64 == 1);
 
-	mutex_unlock(&opregion->lock);
-
 	return result ? AE_ERROR : AE_OK;
 }
 
@@ -182,7 +180,7 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
-	mutex_lock(&opregion->lock);
+	scoped_guard(&opregion->lock) {
 
 	if (pmic_thermal_is_temp(address))
 		result = pmic_thermal_temp(opregion, reg, function, value64);
@@ -194,7 +192,7 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	else
 		result = -EINVAL;
 
-	mutex_unlock(&opregion->lock);
+	}
 
 	if (result < 0) {
 		if (result == -EINVAL)
@@ -345,7 +343,6 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 					      u32 value, u32 mask)
 {
 	const struct intel_pmic_opregion_data *d;
-	int ret;
 
 	if (!intel_pmic_opregion) {
 		pr_warn("%s: No PMIC registered\n", __func__);
@@ -354,30 +351,26 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 
 	d = intel_pmic_opregion->data;
 
-	mutex_lock(&intel_pmic_opregion->lock);
+	guard(&intel_pmic_opregion->lock);
 
 	if (d->exec_mipi_pmic_seq_element) {
-		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
+		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
 						    i2c_address, reg_address,
 						    value, mask);
 	} else if (d->pmic_i2c_address) {
 		if (i2c_address == d->pmic_i2c_address) {
-			ret = regmap_update_bits(intel_pmic_opregion->regmap,
+			return regmap_update_bits(intel_pmic_opregion->regmap,
 						 reg_address, mask, value);
 		} else {
 			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
 			       __func__, i2c_address, reg_address, value, mask);
-			ret = -ENXIO;
+			return -ENXIO;
 		}
 	} else {
 		pr_warn("%s: Not implemented\n", __func__);
 		pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
 			__func__, i2c_address, reg_address, value, mask);
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
-
-	mutex_unlock(&intel_pmic_opregion->lock);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_soc_pmic_exec_mipi_pmic_seq_element);
-- 
2.53.0

