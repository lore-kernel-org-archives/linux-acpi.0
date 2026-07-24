Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FB3CFF62
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882660; cv=none; b=Al2fouKEniKnsaA9XKmQWFokAMJ/4HKlxxTHFluNHyzAtAS+vXqK3/s4tBvxNCyym4rmWs4MszAvbpqByZpItWzPGFPCvY6hr7bRpNVdBR/wd7nq7Ia0jUqSD0+wavjbw3lL/Uhf4WrNs2CnKKX38h+l2vSXIlG4yZjwdWvTPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882660; c=relaxed/simple;
	bh=GfR2p9/Kj/F0C3wXj1i4wv7w/Gl8fUFvNscov5zqDHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUVFGFmFMlM7F7Zc5KOO8hD56KbflR+RFI4ZcaP90C41QKIkQG5mrCGWY4V+XeVoUa4Y82H3EX3BA+5DKwGdlYtvGr0ONpe4ga8fq7NI7He91xNVK64+1MW8bhqIN8dZOUOrMHxt+oM8KQ7OSBBRIbEX2mEpF5VZ7puAQoazW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fMKUjVI7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMKUjVI7"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so156874a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882659; x=1785487459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J9f0ysj5iLgXAfZrr4tNewoNqni8L/Xnuw2lNVMgtk=;
        b=fMKUjVI7GAYqn9Hu6WFkqtdYMARneNf6Jo37kWGxlX7KOaRFbP+ayHIwwgCSbyCyXI
         eF0rPAEJcwrzBQgoNHttV8gXnefRInwHBdo+DYw/d2feX1PRBPuVTI6578LyjhxZl1dX
         wFV0FIqiCy6E7vX1gVm3RwRJjDRgFx+K5/0gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882659; x=1785487459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J9f0ysj5iLgXAfZrr4tNewoNqni8L/Xnuw2lNVMgtk=;
        b=Su11FtDrr1XthWpVRupaNjn63WxvKeWlIiNg+tOFWE2nfaOuC7QPpX8PfEhVa1gvjR
         mf//GLGm0MKMDKxN2oUVKm0A8G0mR5WccVRkzGnUU358yq2HV/sLxjDV/PrSutdHWpG/
         AHR+nQyNV/dC+iAQjDw+eN0RYVTpZ5FHpscWVbv4gqpwKkFSwhQPw9ZB+xNQrgKmQJXz
         54KksiBg96KYnK4SVpBRscKGXSlpwTfbSuNz5Z7wO+/0W/UujSZ9QDXmtiLDcBfHd0HR
         UMvbm3SFlOYnFunJqVHuAlwU4jz6LJ8XW8ePoXphkTuNrl5l7koYenKURl+yBNbPiVwv
         wtKA==
X-Forwarded-Encrypted: i=1; AHgh+RpQUdyZeU576GLhLa5CpZdjtPv89ojmkATsDhoferqJE+ig+Mfyj4+XIG82mZy1yk0MOBPcgVs1W89T@vger.kernel.org
X-Gm-Message-State: AOJu0YyRlql/sh8BYKP3xrlFV7+Cz/uQTRLY8rmrhW43svM6su5nJ/i6
	4rpcTvD5hAyvIXFo20d/mYA3LUvrcvP/mlnXTG9b84k0OhQ658ddiXdvsQt92KBaZg==
X-Gm-Gg: AR+sD12mk+c3SoTblaVZ6BwebkMlouqDv2ZhbcBvZJpk+l0/wZNI8syUTzHBAVJBJ23
	qggXI6WUxR/WSIDN6Sw1hDQyoeoXbt1ju0VDnggih4rLOIMvN2hmO4fanBI0Ly56YrGMXsvRNqV
	Fkc/Kownf3mYNE37vKQhLHqwCG/13MwcVrY/a5+2w083qYN+gr6C5NNrBb0f9Avyi5whrxsbB9A
	un7zIsgpBhbZzOm3jVIQD11x2RmK5IFmclpFk7ZnL1Kxs3I7e9dl69ctCSLaqggzVTC16piOFPU
	PZhhmDEkwVTE+tqSDhyntQjwSmUqcr9l/ZJkeCQSLWS4XdSe96RfTJr0H4pm5gWcMP9Qr0bsh4Y
	FEwN2300JLXh3amodv8cxsVrTRsty9uXsz40lBX/KHcbAZMKulp4/l+T4F8Gp/kinrRzw0FUkv4
	rPE/ejDUQuZkKxlh5uc8h2iPa4nrDGuFf9PKK+6BLX6CMUn2fzv0G3tvcfjNo=
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr7371473a91.41.1784882658880;
        Fri, 24 Jul 2026 01:44:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:18 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 03/16] power: sequencing: Add pwrseq_get_state()
Date: Fri, 24 Jul 2026 16:43:12 +0800
Message-ID: <20260724084328.3943997-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power sequencing consumer API already does power on state tracking
internally. Expose the state to consumers through pwrseq_get_state()
so that they don't have to reimplement it locally.

Instead of just on/off and error codes, the function can also return
"unknown" state. This is in anticipation for "uncontrollable" power
sequencers (such as GPIOs left unconnected).

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v6:
- Changed to pwrseq_get_state() with enum return value

Changes since v5:
- Reverted back to returning -EINVAL if descriptor is NULL

Changes since v4:
- Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
  the descriptor is optional, matching the other pwrseq consumer APIs

Changes since v3:
- Added missing stub function for !POWER_SEQUENCING

Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency. Bartosz wants the change on an
immutable branch to pull into the pwrseq tree.
---
 drivers/power/sequencing/core.c | 19 +++++++++++++++++++
 include/linux/pwrseq/consumer.h | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da91598..701728e60a26 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,25 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
+/**
+ * pwrseq_get_state() - Queries the last requested state of the power sequencer.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This returns the last requested state of the power sequencer.
+ *
+ * Returns:
+ * On success, PWRSEQ_STATE_ON for on and PWRSEQ_STATE_OFF for off;
+ * negative error number on failure.
+ */
+int pwrseq_get_state(struct pwrseq_desc *desc)
+{
+	if (!desc)
+		return -EINVAL;
+
+	return desc->powered_on ? PWRSEQ_STATE_ON : PWRSEQ_STATE_OFF;
+}
+EXPORT_SYMBOL_GPL(pwrseq_get_state);
+
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
  * @desc: Descriptor referencing the power sequencer.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885..af949e756bbd 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -11,6 +11,12 @@
 struct device;
 struct pwrseq_desc;
 
+enum {
+	PWRSEQ_STATE_UNKNOWN,
+	PWRSEQ_STATE_ON,
+	PWRSEQ_STATE_OFF,
+};
+
 #if IS_ENABLED(CONFIG_POWER_SEQUENCING)
 
 struct pwrseq_desc * __must_check
@@ -22,6 +28,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_get_state(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +60,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc *desc)
 	return -ENOSYS;
 }
 
+static inline int pwrseq_get_state(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
 static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 {
 	return NULL;
-- 
2.55.0.229.g6434b31f56-goog

