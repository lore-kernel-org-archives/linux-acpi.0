Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483B1B7910
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512912; cv=none; b=etO29awQHhKiMjUpp9VYGQ/XVHaahgpA8His+UgETOPOr63KqKjF4xnJS4ZimRqZc6a0vc7yr9iBYYR7+oAXU3xmV5pnR13ik0L2U+Vj6k27IToJtnYyqqsat/DyF31A80wmlfBaXKbuoWWMmpFwGcfHvfYjY8+c/2I8lDrt3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512912; c=relaxed/simple;
	bh=KCoLp0j3FTegGrIPOExoI3s2QCcH3vtOwGfkyr+f12U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkZDU0XHFiD86WVbJq7nv0OwIuZANFC/rswg/tY1B5si3/eYgzDfrxLepjx+ukqKhKCp+B5zcw3Am5fxChFOamq9wG4uG2UG9zd76M5BOCy5K9Hwx1618QZBu7TChGw2qKjIfojyhnQ9OKnnexE+lSJZo5GVAH0Rbl+ESR8ZSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpAVFJYK; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpAVFJYK"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4042905015cso293201fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 18:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777512909; x=1778117709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp95W0VqHVkDzd5U4y+n96qXR08Kl1YBa2o5v19LXc4=;
        b=SpAVFJYKASVmIyyvZLIaK4VRni/lwrGrsGVPM4czvzs5CQoOfLKKpW/jeI5KUhVXpA
         0i4ailMKIbKXyeDWMalO6yF7xrr14cPyy7iT8XK0jrpGJSji7rZ3YjH5EY32fcM8Plse
         zcDwddMlHQjjpnE/PBZHfOhjQ1Fw78SibOYlj1FGp2hb1owH7iNt1eqMCvGv2SVxsMhP
         fmqDUNBfHuMRXGaI5MohQSzFRFKqDRPFNxjESBRA4Wl/kKMHHKD7RqByHpnwUKyT4kGt
         ZgscCK/gjqnr8+VkcI8pONPN2Zg9CW8IY/NEsKHFR9yAtLQ5yOHs4V8vsVa0k5W7xLGt
         z/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777512909; x=1778117709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp95W0VqHVkDzd5U4y+n96qXR08Kl1YBa2o5v19LXc4=;
        b=gWu6dL3ZdDzSg9Sz7Q36wYnk8QCvwz3Niaf3HdtCt9m27fYNk6fPqrtLMaoRPcTYs+
         U586AjHpuQpIoO6EuISZ5Lm1Vw3IYObmd5o2d3FkpmDn7kTTc6FGaoFcKjiqMDKnvlAk
         VxTV1KRnhWtSVDvJsi6Vgv2KTILKyv5QXCEqOdUMW34ZqGifOYZRmItmO9FNLCjO8+hY
         pumWx2QaOUtqvSQPoJ8Z7UZ5dNPTRXZf3a0mRCzIoY0nl+Sx1v3mSOEWA/ZkSMekHL82
         CmbZH0sYXK5X5uMH/n6qgBhciIYvqNEp2ZjHR0cAVBe17wgX577QJ+9xSNTJuhNTJFbn
         k/UA==
X-Forwarded-Encrypted: i=1; AFNElJ/0aTLiRpD+N28oxh1RcFZ+3MiDFWEzoH4R64r7l1PCUdRPaCFoqkivxBJOlBpi8ViREYzhXlQChE1/@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDpEfuas4/tlj9DXS4iV4Ql+pSOCxk4PgfpaECNHmYAEg0M3K
	1V4+YoSy0X0Arw35+sgZ6YZvj0QcNDs8YDrfqSI/VVuZC4xQgDxuS9j/
X-Gm-Gg: AeBDietny+aOs6y3peYev7ImZkR1qZbgM5nqLWwsazvX8qIazu8In8X2mAk3dl2/va7
	gk5IaogIrOubvhy37kPuGI7+bLbldnRryMk1XyrHMr3eKb+O+oyzPibmwof2VsJCcnff7sDUuX6
	xVse049WkIGQttr5D7twXZKH5lAdH3X+DIikqCwPfq3HkyqQ4uXEbNQpeOH+nCu/R+K8GkNjm6C
	4t86oD3iie1jlR8uNJEu79g5Xy7/rXpunUj8YStEv/pzBBo/dHQnAsp76KV9KLKvK8Q7gpOeEuU
	NxCkSoVnhC6CzB3LWM65lfNzzLCefSUNp2KMDemnR3wdG7gbvCT14T7+q1hQm8vQZ3FdRQ85zLy
	/RHSqbPv8PL22rJVa9QM0N6R+8hk+Apxb7kQNC/jnqerrNhncSpfZmE05J+/RLGNLX88tp3ajdb
	ouESdV4QHMYfe9WnMWtpNJfXIEKKdpAFAz/ldZLznjtdVpNzYiz5lNL8dRUyvnO4MfHDII6GAQu
	Jv8v8k=
X-Received: by 2002:a05:6871:c8db:b0:40e:dcc9:c3a9 with SMTP id 586e51a60fabf-4343373792cmr624490fac.3.1777512909526;
        Wed, 29 Apr 2026 18:35:09 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43437231ca6sm410226fac.11.2026.04.29.18.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 18:35:08 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI PMIC DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
Date: Wed, 29 Apr 2026 20:35:06 -0500
Message-ID: <20260430013507.46259-1-m32285159@gmail.com>
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

 v5:
 - Misunderstanding at last version, v4 has been reverted.
 - Made diff less invasive per Andy's request by leaving most code
   below d->exec_mipi_pmic_seq_element check in
   intel_soc_pmic_exec_mipi_pmic_seq_element() intact.
 - Reinstated ret variable in
   intel_soc_pmic_exec_mipi_pmic_seq_element() per Andy's request.

 drivers/acpi/pmic/intel_pmic.c | 37 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 134e9ca8eaa2..9bd46defc5a2 100644
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
@@ -354,13 +349,15 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 
 	d = intel_pmic_opregion->data;
 
-	mutex_lock(&intel_pmic_opregion->lock);
+	guard(mutex)(&intel_pmic_opregion->lock);
 
 	if (d->exec_mipi_pmic_seq_element) {
-		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
+		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
 						    i2c_address, reg_address,
 						    value, mask);
-	} else if (d->pmic_i2c_address) {
+	}
+
+	if (d->pmic_i2c_address) {
 		if (i2c_address == d->pmic_i2c_address) {
 			ret = regmap_update_bits(intel_pmic_opregion->regmap,
 						 reg_address, mask, value);
@@ -376,8 +373,6 @@ int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
 		ret = -EOPNOTSUPP;
 	}
 
-	mutex_unlock(&intel_pmic_opregion->lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_soc_pmic_exec_mipi_pmic_seq_element);
-- 
2.53.0

