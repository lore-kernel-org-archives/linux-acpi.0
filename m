Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6281A0B15
	for <linux-acpi@vger.kernel.org>; Sat, 14 Mar 2026 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451934; cv=none; b=eOB4qGy4uiNXytlo1Amz9y7INE7cNDt/qc5hs3VUG6zkzrR7xNyGcpbnUbli/HRbULEyeDe7Ps2wsSjeZxQHNUi1Zt74jQO6Otbw+ANM8fFXIGLw/AhSEOW4Rcz6rp0NAkEoy+uyAI9pOsPKcTz2sadDAnAjXiGx3lAGPZQx43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451934; c=relaxed/simple;
	bh=mUxCPP/m7AMSSH1pxHzOmtIKNsUap3vsjNULA0fzP4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSHsvNydBdw5ZpVbjJQqgr838Ts7XOGyRgqv39VrP1r/HmRqB6xcxzBudTpvFX7Di0Fwk/4a5g5M0ngMkb/UePqez5xf1wzrGKd7KVFCTyh+mf+gzPz0hFot4RbeDK5+QOASlUu3W5z0Mk7DexYcQ+0mtw33wD13nocrJUKl8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf7Ujhb8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf7Ujhb8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so2728053f8f.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773451931; x=1774056731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR0JNXye1PQ32tEpIdRTYUVyYik8LC1u1H+imbfX1oQ=;
        b=Pf7Ujhb8dtVkmMW1sYsmFyRiaTAg+CNq/Kje8X6lJgZTbaMtsSpsd/xOmfxnbOfpfd
         xRlwOCJDaZz+Btk8wQCnls32+3PTli+M2NwqaNOeeAnshzswbZFcablBSyQxjnUky86Q
         9xPCWjQ8GPb080Ab2bucOWYip66HCaVd0LYfNiEuMxzwb7hNYI4yZdzgxVukpCDd0pYk
         0wLajObpNsEup5MfL6bBHe2E+ch2DJkCph9hKhYheH1p2KONv2M1m2FgdBNPo/5oCSxk
         hRfExYrFYL1ymx/qmT/Eni/lKEuweArN1EPxIX7pb1+B87/09RD8F4M05Yp92UPlSjiW
         UJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451931; x=1774056731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iR0JNXye1PQ32tEpIdRTYUVyYik8LC1u1H+imbfX1oQ=;
        b=AmoFhvybKixOba3vkE1YclUxB0m4MWMgHLBT7kafVbPjxsY88rn6zAbveizG8Y8l4Y
         zh7BWdc/vZM0ATHXErPe2vQwmaHBjT7PevmRafjpKBINvroA0DsO/juOo+kq36sCb4Iq
         3dOy4ep3M38e5Fs0MnkLzS8+AKtYPaYrwWDfMGTnHVosxczSt4nfzzERccXV3KPNNgbk
         dcOAspewp2sO1G7UDVMuz83vEc8vGOI6+wKc6cQyAKWWUUHqDxR2KubW0yojUzucrZcz
         w2LemjD0A67j6mAybZQgXeRGZKlxkGMmxNL/RRpC6st7fn5irzUiG0nhOWuk5tKjb+N6
         Z7MA==
X-Forwarded-Encrypted: i=1; AJvYcCWACExawgdZHkOmfSaWpeE7Xj5SiybZ16m3vKVzl1aO84VLd97tNLtRXZixjJbu9k7RhBZp1+kQXqAk@vger.kernel.org
X-Gm-Message-State: AOJu0YyJRcP/zXUsaI7oPXMzGEn4f9nLk+hxrgox7KB1yiPvtram2gV0
	vK303PZ1wmxPrNVk/+oTWaJzAfMaiQhPSq8ImHlFQ+St6YaoeW6eXmxE2RKAanVxmK4=
X-Gm-Gg: ATEYQzzpv4UUa0kUgvR6EXd5IASyWRMzqD9VSITBcITdxT81+HCIWtBUoQHf4ImoHnm
	wgS+W/xCqQTzqNLFJcRyhe6rC2W4gKVzRqnDSwW35mNHUqtTt1t2ujO9cckUTM9gtWXGwBwEJWZ
	855Y/NvXKx0w4kAOADMdOykxGfeLlsS4M2fLAM3aW39VNQN6gA9ck7ByVs0mx1XWPUgud5cFMzv
	8AFcWg7wPoYWIzfLD5Un2EAEaI/UlZCWPq+YSLyfLGQoblP28W3NdQh7jdhSQVlEy7DHJZaWKHR
	QjJbatbTlo30ec38AmRDPdLfZnNXnBymun5c9M/c0o6Z9xDsc0PchGNBFp/oWRnK5gH1Zxenhg6
	jebf9HaI0KeqiyxaZ7op1ksa3jZxGWR3nMeDlu6/XV3r4bt+UzQCsFr7PN0Lc+v1yapKSm/u70V
	pr/7o8FksfK82nFxQxZ8WcSKQrRwK9C8rBw7srfPUigCfCORJNcWrMDFWbgW+wXMcUu8DzaEEeL
	cW2PIU0stqQKcZIRCMAqEXMp0ulwcJyvu3U3abx1l8LEiz4eBNmW4q217SDD+ebg4CQwR/+z7/0
	WmMRKNx675M=
X-Received: by 2002:a05:6000:2501:b0:439:ba4d:bf40 with SMTP id ffacd0b85a97d-43a04dc831fmr10711463f8f.43.1773451931220;
        Fri, 13 Mar 2026 18:32:11 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm21876575f8f.31.2026.03.13.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:32:10 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	wsa+renesas@sang-engineering.com,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH 1/2] i2c: acpi: skip generic I2C device when vendor-specific sibling exists
Date: Sat, 14 Mar 2026 01:31:55 +0000
Message-ID: <20260314013157.7181-2-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314013157.7181-1-edward.blair@gmail.com>
References: <20260314013157.7181-1-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BIOS implementations (notably ASUS Z690/Z790/X670E motherboards)
declare both a generic UCSI device (MSFT8000) and a vendor-specific
device (e.g., ITE8853) as ACPI children of the same I2C controller,
both referencing the same I2C slave address.

During ACPI I2C enumeration, whichever device is walked first claims
the address, causing the second to fail with -EBUSY. When the generic
MSFT8000 device registers first, the vendor-specific driver cannot
bind, losing access to device-specific features like GPIO interrupt
resources that are only declared on the vendor-specific ACPI device.

Fix this by checking, before registering a known generic I2C device,
whether a sibling ACPI device exists at the same address on the same
adapter. If so, skip the generic device to let the vendor-specific
one register instead.

Signed-off-by: Edward Blair <edward.blair@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 2cbd31f77..87582eac7 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -137,6 +137,17 @@ static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
 	{}
 };
 
+/*
+ * Generic I2C device IDs that may be duplicated by vendor-specific devices.
+ * When a vendor-specific sibling exists at the same address, the generic
+ * device is skipped to avoid -EBUSY address conflicts.
+ */
+static const struct acpi_device_id i2c_acpi_generic_device_ids[] = {
+	/* Microsoft UCSI - often paired with vendor-specific UCSI device */
+	{ "MSFT8000" },
+	{}
+};
+
 struct i2c_acpi_irq_context {
 	int irq;
 	bool wake_capable;
@@ -274,6 +285,76 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	return 0;
 }
 
+struct i2c_acpi_sibling_check {
+	struct acpi_device *self;
+	struct i2c_adapter *adapter;
+	unsigned short addr;
+	bool found;
+};
+
+static int i2c_acpi_check_sibling_addr(struct acpi_device *adev, void *data)
+{
+	struct i2c_acpi_sibling_check *check = data;
+	struct i2c_acpi_lookup lookup;
+	struct i2c_board_info info;
+
+	if (adev == check->self)
+		return 0;
+
+	/* Only yield to vendor-specific devices, not other generic ones */
+	if (!acpi_match_device_ids(adev, i2c_acpi_generic_device_ids))
+		return 0;
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.info = &info;
+	lookup.index = -1;
+
+	if (i2c_acpi_do_lookup(adev, &lookup))
+		return 0;
+
+	if (!device_match_acpi_handle(&check->adapter->dev,
+				      lookup.adapter_handle))
+		return 0;
+
+	if (info.addr == check->addr) {
+		check->found = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Check whether this generic ACPI device has a vendor-specific sibling at the
+ * same I2C address. Some BIOS implementations (e.g., ASUS Z690/Z790/X670E)
+ * declare both a generic UCSI device (MSFT8000) and a vendor-specific device
+ * (e.g., ITE8853) at the same address. Skip the generic one so the vendor
+ * driver can bind with proper interrupt and device-specific resources.
+ */
+static bool i2c_acpi_has_vendor_sibling(struct acpi_device *adev,
+					struct i2c_adapter *adapter,
+					struct i2c_board_info *info)
+{
+	struct acpi_device *parent;
+	struct i2c_acpi_sibling_check check;
+
+	if (acpi_match_device_ids(adev, i2c_acpi_generic_device_ids))
+		return false;
+
+	parent = acpi_dev_parent(adev);
+	if (!parent)
+		return false;
+
+	check.self = adev;
+	check.adapter = adapter;
+	check.addr = info->addr;
+	check.found = false;
+
+	acpi_dev_for_each_child(parent, i2c_acpi_check_sibling_addr, &check);
+
+	return check.found;
+}
+
 static void i2c_acpi_register_device(struct i2c_adapter *adapter,
 				     struct acpi_device *adev,
 				     struct i2c_board_info *info)
@@ -302,6 +383,13 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 	if (!adev || i2c_acpi_get_info(adev, &info, adapter, NULL))
 		return AE_OK;
 
+	if (i2c_acpi_has_vendor_sibling(adev, adapter, &info)) {
+		dev_info(&adapter->dev,
+			 "skipping %s in favor of vendor-specific device at 0x%02x\n",
+			 dev_name(&adev->dev), info.addr);
+		return AE_OK;
+	}
+
 	i2c_acpi_register_device(adapter, adev, &info);
 
 	return AE_OK;
-- 
2.53.0

