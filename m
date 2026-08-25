Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6048F837
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688884; cv=none; b=pHHQFFV2pJ/KeA9vGvdBGhX2B/M5M/uEHWOj7Hta1hiXhj/m/OHB+K5ynjXfD+34yq0Afny2zak+iFatH7Hn7CLUnzzkjOdhpblFuTlZW2bigHMJ3Xyl6boDOHw7iOGhshJ0fyRlsVdVWTaH/twBp/9ZD1tEDmkT2fCcNOMZ2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688884; c=relaxed/simple;
	bh=x7nVjauRI+U0yX7J0JyAbzfVg4TDMgnH3ULu6xPpkL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFHS+vwOguM0+7MUn1vqqxjW2fsFBJ8M2QbGlBIoaPmlkomxfJr1Jvqch3poS3UYIwSNl6dPfqxh9XgtPWb1Ym0JREmK72g+zGck+pSuqownmUM6X/ZbuXtgPn7bMULZxeynjBFrP/fMk3p9J85RbFLK+9wfTAuLR8bTHUw9OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjdcXKlw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjdcXKlw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49978908b35so997695e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688881; x=1788293681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmZxmecvZG15vtYaUoB5D0+zMfbkIPe0/Mtk0u+hNh0=;
        b=sjdcXKlwbrybOV0F9tXdoDJQq0YMteCQK1XUSuXmboSw2dmirzoUQGHJ+lq1JIwtBh
         awiplPEetLEchGJi5XLF9zGxJC+T8Ndg2VAFjbprgntuYJzwmiia0jUKD+iAAgwQuRg+
         pCjttMHvBEgs+0+t/g52Y6VQpcVCHsi3kULhrrNoaJPad2zejT8yFnoq2cy32AuyUmMU
         l1LDk/5o3h8bRWeJ+LpmY84XIKfKRZhv5KSpOLfIm2FhZyyTMFeEnivo/iHMAMxyzJdq
         XuSqjm5ChFJMi+mBftbQ6PqJ+IPwfD7NpfT8v3waFl59cY4m0F8YIen5eoXBwrENFLtF
         PBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688881; x=1788293681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmZxmecvZG15vtYaUoB5D0+zMfbkIPe0/Mtk0u+hNh0=;
        b=sogtjWeZoRwPSFLYFPLSuR6v0lHn1hU+mQeM1kuqIqqkbLLqQ0d4cqAdzB7t9AqhpW
         EXwp9s8ntZ8jVlM/6Ua/ZGHkdAyhh91JJKKEroMj/Mf+dm2gONVenb6X/pViKajQ2YDq
         UnvZlbMpkat2mRUT6pi25BGGMCEuA4YH5RhsBYhItirM1fyDzYKqw2Dzoh84AJA+mQPO
         UjGvKNwsQig78cI9aNm9ULUkN0GyOCzU6hfM8Ehf90qHYRgw5tC8Gl4t1qpaaOSPSN59
         zCM3tW1VE8bS1jQxyMouJ8b+yJGTZ6+lRPkGgwcrACK6vZyrMg3X38Hn7CXAXL2ZtwsF
         vHlA==
X-Gm-Message-State: AFuF++lg/2q3V+YsVfHZtwQB3N0+h3UUiRyKZIwRype0dAbqEcjxfxof
	MNT5fhC/PYErthh3NGsSZ0bE357lrKH1tWRthjC16I3gHQ/kw5vl7ZD+yNNRAxRZgzc=
X-Gm-Gg: AR+sD11Uly4MH0mfUaaoeqRBDerNGm+/LmaX8dMbWI1JCLOObgqKVL0ego+ilyAQ+pv
	kQRu+grJ+7B4vDFIZiDwAB3tuH4t+vFvsi8aRwsPBH/d76txNxFyd7oDkLrRlItMbqWobtj2Sr3
	CeiI5Q/NCSBnGh1efww1QfddArS4d/Q/ORJv4i4jcbt3+q5CoCYYNS88mgls6FRvexA8AhXsXWK
	5qgCniKhhrfwB09ePKFAXN8qLNO4itcz+3RZLm1sq7DgwzAm8qYxO96vlC+6hKS8tTUN6o32dWt
	lex6p2Lezam/ay6tKgbH09n1bfJxDxRtnwwDgu49uEU2xoOqaJ6xVST8XYXyVgcgFw5aVX+zTpS
	iZnioGKnas5MKBuvFs0QDjdOIqaPChtVvmMwnKASK3fs6WrbUVrvGb9qpt5ZNxMNW3IxAMSmi+b
	Js9kLfetGmJgHLMbbKI/ql7dkHusNfeqo06572/yF8B7YZJC/RxgVklZd8hW/Nc67oEayyatVN4
	TPnwFR8BqecALuJHceEtjGagvZCYeZL543xHHI2Tu9nr6TX6YDQrkMm0oScoasCOIOFjXATe8K9
	auSbJhiPfb4N9QgXzQE81FUv1Yl+IUZJrNmMrKN12UodiHghnBg7ewlqxD4=
X-Received: by 2002:a05:600c:6912:b0:499:cd34:100d with SMTP id 5b1f17b1804b1-499dc703bd3mr15456995e9.7.1787688880894;
        Tue, 25 Aug 2026 13:14:40 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc960e80sm5050435e9.1.2026.08.25.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:14:40 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	heikki.krogerus@linux.intel.com,
	mika.westerberg@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH v2 1/2] ACPI: x86: hide duplicate RhProxy node for ITE UCSI controllers
Date: Tue, 25 Aug 2026 21:14:25 +0100
Message-ID: <20260825201426.47030-2-edward.blair@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825201426.47030-1-edward.blair@gmail.com>
References: <20260825201426.47030-1-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some desktop firmware describes the same ITE UCSI controller both as an
MSFT8000 Resource Hub Proxy device and as an ITE885x device. Both nodes
point to the same I2C address, so whichever is enumerated first prevents
the other from registering. Only the ITE node provides the interrupt
needed by the UCSI transport.

Override the RhProxy node status only when it contains exactly one I2C
resource, contains no other resources, and a present ITE UCSI node has
exactly one I2C resource, a usable interrupt, and matching controller,
address, speed, slave mode, connection sharing and address mode. Keeping
this in the ACPI status quirk layer handles initial enumeration and
reconfiguration without affecting unrelated MSFT8000 devices.

Signed-off-by: Edward Blair <edward.blair@gmail.com>
---
 drivers/acpi/x86/utils.c | 151 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 418951639..8601b9713 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -67,6 +67,144 @@ struct override_status_id {
 #define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
 	ENTRY(0, "", NULL, path, cpu_vfm, dmi)
 
+struct acpi_i2c_resource_info {
+	acpi_handle device;
+	acpi_handle controller;
+	u32 connection_speed;
+	unsigned int i2c_resources;
+	unsigned int other_resources;
+	u16 address;
+	u8 slave_mode;
+	u8 connection_sharing;
+	u8 access_mode;
+	bool has_interrupt;
+	bool found;
+};
+
+static acpi_status acpi_get_i2c_resource(struct acpi_resource *ares,
+					 void *context)
+{
+	struct acpi_i2c_resource_info *info = context;
+	struct acpi_resource_i2c_serialbus *sb;
+
+	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
+		return AE_OK;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
+		if ((ares->type == ACPI_RESOURCE_TYPE_IRQ &&
+		     ares->data.irq.interrupt_count) ||
+		    (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ &&
+		     ares->data.extended_irq.interrupt_count) ||
+		    (ares->type == ACPI_RESOURCE_TYPE_GPIO &&
+		     ares->data.gpio.connection_type == ACPI_RESOURCE_GPIO_TYPE_INT &&
+		     ares->data.gpio.pin_table_length))
+			info->has_interrupt = true;
+		info->other_resources++;
+		return AE_OK;
+	}
+
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
+		info->other_resources++;
+		return AE_OK;
+	}
+
+	info->i2c_resources++;
+	if (info->found)
+		return AE_OK;
+
+	if (ACPI_FAILURE(acpi_get_handle(info->device,
+					 sb->resource_source.string_ptr,
+					 &info->controller)))
+		return AE_OK;
+
+	info->address = sb->slave_address;
+	info->connection_speed = sb->connection_speed;
+	info->slave_mode = sb->slave_mode;
+	info->connection_sharing = sb->connection_sharing;
+	info->access_mode = sb->access_mode;
+	info->found = true;
+
+	return AE_OK;
+}
+
+static bool acpi_get_i2c_resource_info(acpi_handle handle,
+				       struct acpi_i2c_resource_info *info)
+{
+	acpi_status status;
+
+	memset(info, 0, sizeof(*info));
+	info->device = handle;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_get_i2c_resource, info);
+
+	return ACPI_SUCCESS(status) && info->found;
+}
+
+struct acpi_ite_ucsi_duplicate_context {
+	const struct acpi_i2c_resource_info *rhproxy;
+	bool found;
+};
+
+static acpi_status acpi_match_ite_ucsi_duplicate(acpi_handle handle,
+						 u32 level, void *context,
+						 void **return_value)
+{
+	struct acpi_ite_ucsi_duplicate_context *match = context;
+	struct acpi_i2c_resource_info info;
+
+	if (!acpi_get_i2c_resource_info(handle, &info))
+		return AE_OK;
+	if (info.i2c_resources != 1 || !info.has_interrupt)
+		return AE_OK;
+
+	if (info.controller != match->rhproxy->controller ||
+	    info.address != match->rhproxy->address ||
+	    info.connection_speed != match->rhproxy->connection_speed ||
+	    info.slave_mode != match->rhproxy->slave_mode ||
+	    info.connection_sharing != match->rhproxy->connection_sharing ||
+	    info.access_mode != match->rhproxy->access_mode)
+		return AE_OK;
+
+	match->found = true;
+	return AE_CTRL_TERMINATE;
+}
+
+static bool acpi_has_ite_ucsi_duplicate(struct acpi_device *adev)
+{
+	static const char * const ite_ucsi_ids[] = {
+		"ITE8853",
+		"ITE8800",
+		"ITE8801",
+		"ITE8802",
+		"ITE8803",
+		"ITE8804",
+		"ITE8805",
+	};
+	struct acpi_ite_ucsi_duplicate_context match;
+	struct acpi_i2c_resource_info rhproxy;
+	unsigned int i;
+
+	if (!acpi_get_i2c_resource_info(adev->handle, &rhproxy))
+		return false;
+	if (rhproxy.i2c_resources != 1 || rhproxy.other_resources)
+		return false;
+
+	match.rhproxy = &rhproxy;
+	match.found = false;
+
+	for (i = 0; i < ARRAY_SIZE(ite_ucsi_ids) && !match.found; i++)
+		acpi_get_devices(ite_ucsi_ids[i], acpi_match_ite_ucsi_duplicate,
+				 &match, NULL);
+
+	return match.found;
+}
+
+static const struct acpi_device_id acpi_rhproxy_ids[] = {
+	{ "MSFT8000" },
+	{ }
+};
+
 static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
@@ -182,6 +320,19 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 	bool ret = false;
 	unsigned int i;
 
+	/*
+	 * Some firmware describes an ITE UCSI controller twice: once through
+	 * the Windows Resource Hub Proxy and once as a vendor-specific device.
+	 * Both nodes point at the same I2C address, but only the ITE node has
+	 * the interrupt resource required by the Linux driver. Hide only an
+	 * exact duplicate so unrelated Resource Hub Proxy devices keep working.
+	 */
+	if (!acpi_match_device_ids(adev, acpi_rhproxy_ids) &&
+	    acpi_has_ite_ucsi_duplicate(adev)) {
+		*status = 0;
+		return true;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(override_status_ids); i++) {
 		if (!x86_match_cpu(override_status_ids[i].cpu_ids))
 			continue;
-- 
2.55.0

