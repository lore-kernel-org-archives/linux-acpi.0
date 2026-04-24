Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE4368287
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068075; cv=none; b=Xp+AfgFIv93ztglI5iDLTDgkG3YdoqTilBGQoENM8QQBwlX551U0OhSUsqHmR9c9fnWeEJzncdehqy649YbIAIeP3pssQ4DvpAV/VFj6y32x1ViBrGPnFi1428crghSeAbskTLLnddA9dJzM5QkZ73EjCElwaq8F5YuqH7zYf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068075; c=relaxed/simple;
	bh=SgpABllvXTrrFe/JQQVF8RwwJ9FmWuh1BBQVz5IsZDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYNHGL9osupyCrh7jkSTZ1lS5qfXWU0ZzrDmiC8G/E6QYf2kLl6td1BB6cxTQslF4UNRIkyr/z12gV3CA72EtPTdapn1ff8Qd5lSJyjZzqB/7st3KQEbgXXdZdlGHeWvjW+6TI8Gj1yNbu7CH28vjNaFsDoJyMtkGfbCRl/S31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTK7OQgT; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTK7OQgT"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4645dde00a7so6604433b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777068072; x=1777672872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahF7cKkpd8LfIy+caOhLjgF6XGeAImE+egeOfwAJjxM=;
        b=oTK7OQgTKqS/rSLDafo8iKNNPYdOu5TzQx4kY+I1+LW8AiSGTPqRU45pekkjTDEs7Z
         rp18XPslyJNNYZdlpx5UH/sB61ZmS4/ik7ODqWA4Ajt/ru8dlj0SrAaVkbuQ8K9pQcTO
         ysRTop126o1ECfUVL4XHFI6H6XSBkHuLWfKWy/Lje96a5ZGG9FHxlL8qU3/lM1QiGYBK
         jyyE5nJmVXwciXXkZ2Ut+ndnUZNrXYEohnTqUDIvOSKt7bLTdlFJN82kZQ2ejxf0IaAh
         FeXPWk3zZt7T/Y2UEHcNqPIJO63xO/87ybGnlmAO49eYCqC/hobgXdBaVn5y65UhpFOE
         tT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068072; x=1777672872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahF7cKkpd8LfIy+caOhLjgF6XGeAImE+egeOfwAJjxM=;
        b=m4XfjTBo2NSmzkwytW00bHzlHBD7ef1R3KCGPhwQ/JlfSapPRQ8+5semiAWCpk0uCS
         CumiAQJtLXe7QcRKoeCPOb3EU2vpSUsoxYW5hRhrLpaclIu28837Jsr2pK3u3O05h2n4
         Y2GHRTbdozHEurRlCbiQ31R+Foq8KmkAAlux8ZTxDbZYtlCcNhKKeDgjjYakfk8fWPqE
         xBhdTrGhb3L0GXB0IqwSL9AHu5xJrfl+6fQobiHMzbQ4qARAhxsEhOuKyCEL/4JRb1z7
         FG6dsYKvxyvnpGlqi4iK2VexVTzRNgOPEFfT9ClPs8QD0zEtoWE8SBWMVlrD8TgRI7R+
         6u6w==
X-Forwarded-Encrypted: i=1; AFNElJ+oo57KpwlgZxrWaxSF9rG33h3HE2dJk+oemsmPq83ywjS6waldyFiBLknA/VZUcTmSFN5j40f9D+Ti@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52WUxfu0vY1pJXS60f/o6NgIryleC/IBYFrfEr7WVlXy3DZS9
	79Dyj5rCfGmhgiKVgKUUnlPqzuJ0nsitVX3AtIrp5ZvQB9u8uiL1FF7G
X-Gm-Gg: AeBDieuZqfDr77tf8uIyFj9UPcfDGpDyoFVuML6huj0ePByYv5JR/f+PNozUAqHznY6
	/xFNmYkQ0w7sKLU2NmpVm29xkv9BrtTudl4dA1UTbtBeqgRimvbWqq7Dbtszn4qpmyQZSyAGCSO
	edmegQRXkx7x67T1aIG8mZ6PlE4ks1YOG/la2bY+BbWuPU7FNLhVyOOMi0uhdXntq201RcZ10dM
	VDOpJqdTT4NeDlwGzK8x6UeDv55PyscO/RS9ap633ibYj0AEbouxb9EsRPXTbpEO9iwxCesuAsN
	oaiMUmlCTdqHUlLKMPgOhpLfM/M8Bhq73smVPEM42TB79SWw09Jom8F0Imf+t/SeGBtXB6OTYOW
	KE5f9ocQBfT8hWqxEzJJU2E6Y2XgVJs8S7qrpzhUMIks+8JTpBuNAjMg0oLg6LzNpRiBv7q6+lr
	dWsXpxm2R7rcPRe8wMoRnfRmdbP+GXjBogfit61R2tfOWuFkhtt1omxxzkLSkyzhp2HyfknwvdE
	Ryfreo=
X-Received: by 2002:a05:6808:4f0a:b0:450:b249:71bb with SMTP id 5614622812f47-4799bf4bb0fmr15003579b6e.19.1777068071827;
        Fri, 24 Apr 2026 15:01:11 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac6f2a3sm22966707fac.16.2026.04.24.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:01:11 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: andy@kernel.org,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
Date: Fri, 24 Apr 2026 17:01:10 -0500
Message-ID: <20260424220110.25929-1-m32285159@gmail.com>
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

Refactor control flow in affected functions by using direct returns,
as we no longer need to manually unlock mutexes at the end of
functions. This will simplify the return logic of affected functions.

In intel_soc_pmic_exec_mipi_pmic_seq_element(): While at it, remove
now redundant "ret" variable.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Refactored control flow in certain functions as suggested by Andy.
 - Indent code in scoped_guard block as suggested by Andy.
 - Fix parameter list alignment issues that I found while making this
   v2.

 drivers/acpi/pmic/intel_pmic.c | 69 +++++++++++++++-------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 134e9ca8eaa2..5c37a8f28e71 100644
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
 
@@ -182,27 +180,23 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
 	if (result == -ENOENT)
 		return AE_BAD_PARAMETER;
 
-	mutex_lock(&opregion->lock);
+	scoped_guard(&opregion->lock) {
 
-	if (pmic_thermal_is_temp(address))
-		result = pmic_thermal_temp(opregion, reg, function, value64);
-	else if (pmic_thermal_is_aux(address))
-		result = pmic_thermal_aux(opregion, reg, function, value64);
-	else if (pmic_thermal_is_pen(address))
-		result = pmic_thermal_pen(opregion, reg, bit,
+		if (pmic_thermal_is_temp(address))
+			result = pmic_thermal_temp(opregion, reg, function, value64);
+		else if (pmic_thermal_is_aux(address))
+			result = pmic_thermal_aux(opregion, reg, function, value64);
+		else if (pmic_thermal_is_pen(address))
+			result = pmic_thermal_pen(opregion, reg, bit,
 						function, value64);
-	else
-		result = -EINVAL;
-
-	mutex_unlock(&opregion->lock);
-
-	if (result < 0) {
-		if (result == -EINVAL)
-			return AE_BAD_PARAMETER;
 		else
-			return AE_ERROR;
+			return AE_BAD_PARAMETER;
+
 	}
 
+	if (result < 0)
+		return AE_ERROR;
+
 	return AE_OK;
 }
 
@@ -345,7 +339,6 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 					      u32 value, u32 mask)
 {
 	const struct intel_pmic_opregion_data *d;
-	int ret;
 
 	if (!intel_pmic_opregion) {
 		pr_warn("%s: No PMIC registered\n", __func__);
@@ -354,30 +347,28 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 
 	d = intel_pmic_opregion->data;
 
-	mutex_lock(&intel_pmic_opregion->lock);
+	guard(&intel_pmic_opregion->lock);
 
 	if (d->exec_mipi_pmic_seq_element) {
-		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
-						    i2c_address, reg_address,
-						    value, mask);
-	} else if (d->pmic_i2c_address) {
+		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
+						     i2c_address, reg_address,
+						     value, mask);
+	}
+
+	if (d->pmic_i2c_address) {
 		if (i2c_address == d->pmic_i2c_address) {
-			ret = regmap_update_bits(intel_pmic_opregion->regmap,
-						 reg_address, mask, value);
-		} else {
-			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
-			       __func__, i2c_address, reg_address, value, mask);
-			ret = -ENXIO;
+			return regmap_update_bits(intel_pmic_opregion->regmap,
+						  reg_address, mask, value);
 		}
-	} else {
-		pr_warn("%s: Not implemented\n", __func__);
-		pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
-			__func__, i2c_address, reg_address, value, mask);
-		ret = -EOPNOTSUPP;
-	}
 
-	mutex_unlock(&intel_pmic_opregion->lock);
+		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
+		       __func__, i2c_address, reg_address, value, mask);
+		return -ENXIO;
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

