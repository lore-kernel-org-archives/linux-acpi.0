Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CC22689C
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425876; cv=none; b=DE2od0vjxjm2++P5fi2HaB9mhNwmGCnKF4uxlcahqtO2pbbrPzZKTku0x/6TF2Rp4pEwXZAl4VlnZ6en36eQHBNRswnVSq7BUWjaasj4I2pYADVB/p49tyD6C0ktfDN2naRuxTP4iMXeU+IGTeTbsksiwTG3L1MZQ1DrBvvBj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425876; c=relaxed/simple;
	bh=sdE3HZ2WWh9xCAetQq89H7QvT7sDNTXcJuttc9icsxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzCwflOy+nzqYuJTIgkwqNaJcz3ov1azwfw3L9cjr9adzZKgc6hn5tD4QZKNIC2Ije41XjIZ+RHd0fhZQixrvQImcIVKaN0T9t/c2UumkmR4Q/Qpn5jR/KAYtlo5ZwtXhGX7JBX3QW/wZB4V36+rkLnQEyGwBMRnnCs8RsFtL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ISpUws; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ISpUws"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479d593a0c3so358911b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777425874; x=1778030674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iARcmdHaItAm1KXrF1/orXYN4BX1QhrDkunvvha6bDY=;
        b=g1ISpUwsuTiYIoaG+p24ckVoyslnbvxwRaL9tlRl2DAcT4Pd7y/sRPyhJEuo0GuFnv
         OJRcIuTrM20slkg8+giMbm75xLAyrfyrKsih9HAOqBev5hjjB/tXrBSLLN9fGfPS1eAf
         Qxijm9xLOGacqE61bRUrc5QBG/KI0whv3ku/LLjnSICcQ/fmPqAoBNOZf7YDuVPEZL92
         SeraEvCR85NOsAkW9WpFl48MUABfka3xE8pXrxdSJ18w3d+VcRIt97PPi5CsUUt5deAK
         fTXVXPp7xhJLN0G42OwFJuEd1RYxU++FQ2rMUWh6Xr7hYfQp108bEzsy/gQRlIcEos8R
         0SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777425874; x=1778030674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iARcmdHaItAm1KXrF1/orXYN4BX1QhrDkunvvha6bDY=;
        b=jNmdGc++qZP1o5zntuX9NC8k6OJtxp40gFJAFVXACnaNzUAD+SI+40OYnBZZ937zE6
         fshP+Yoycr/KUh/jpVRB/LE8i+boQ1pt8yS39/fgI8sJ6xSh9UYKKDLoP+WjNE+UBfvi
         cGE4ptH4kl992bUMdW86N1mTciGrRjB98ecG/gnz0WWMB26P+lzhSKwRYzLHOrZtxezK
         TqQbABPeAFUDZ3M8dK7XvpBy5nrX8EEwzyud2ZfFkFQkfZMel64Z/Bbr49kcIBAZPJqt
         Z6eV4zND5baZUPLraI2288eR4TybrulO8sph+VgpCzKsRNga8UxTyHIT28XR0C3QHxLa
         aJNQ==
X-Forwarded-Encrypted: i=1; AFNElJ99zUA/zQeXrEbJbooyP/7mymYoLR+U+fAjhrLIG9aovhDWltKC9ZFPL33XWPS9J0YfM3xPeVWTYTmM@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7eTZiKh/KPJdkKrsfFtlOYz5LV89fG2pNe46Y/WStBgsG5+R
	aLZpqr5t8MAd+YIM31enyeoTdK6BtBO5B4YicH+6mlEoc9qru/Az4xxt
X-Gm-Gg: AeBDietBKtPj8+K7V8PCBOQDWdy0aejqPp+Q5blzGkZTDPjgmrLNqcg/sHmne4/49XM
	TSRw+97J3aG9rvYeyxsnXoygxv4DRfGi4cXiTPPd6brH6lW8bSQEQBBVs6++kFsFN+Tom+Q9ab7
	uCx+Ucp9Ue7BQhrdNLecutRakHWUdX3gQj32cSgKyVttZsNqxQjzWxbdLWL9y1QInt8Zb38mutz
	FIL4xeD2nc+vLTJW1wa7nF30+XQfDnqjxJHA6kjLi8PZpxiPrQb3WhLqY9qjWAcArjzbINKtW4o
	pgOUD0ZEAURRU3vSQhB2WeY+4S7aw/Dhd/T+7aheJWneOWRJroYAlB5ba42GDhTZy8ht8pxESyQ
	3q0zCUXcxCMBdj6XAKI7traGxV460FcnIEhgub4qV9QnUTc6pNvifqH6xCAYhZf12zpawsFG69W
	3nicTB8GmAI73wQ3tBh9A0qD6TSVoIaUw/cR1FzFeoO2vhW7qaSJOXypG3gFY1SwisaN3C
X-Received: by 2002:a05:6808:4f11:b0:47a:4fd:95f0 with SMTP id 5614622812f47-47c3fb7a34cmr668818b6e.12.1777425873805;
        Tue, 28 Apr 2026 18:24:33 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab9d5b9asm330190a34.21.2026.04.28.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 18:24:33 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: andy@kernel.org,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
Date: Tue, 28 Apr 2026 20:24:32 -0500
Message-ID: <20260429012432.120830-1-m32285159@gmail.com>
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

 v4:
 - Added else keyword to if statement in
   intel_soc_pmic_exec_mipi_pmic_seq_element() per Andy's request.

 drivers/acpi/pmic/intel_pmic.c | 60 ++++++++++++++--------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 134e9ca8eaa2..594c07211a8b 100644
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
@@ -354,30 +348,26 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 
 	d = intel_pmic_opregion->data;
 
-	mutex_lock(&intel_pmic_opregion->lock);
+	guard(mutex)(&intel_pmic_opregion->lock);
 
 	if (d->exec_mipi_pmic_seq_element) {
-		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
-						    i2c_address, reg_address,
-						    value, mask);
+		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
+						     i2c_address, reg_address,
+						     value, mask);
 	} else if (d->pmic_i2c_address) {
-		if (i2c_address == d->pmic_i2c_address) {
-			ret = regmap_update_bits(intel_pmic_opregion->regmap,
-						 reg_address, mask, value);
-		} else {
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

