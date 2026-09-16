Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B63D25A3
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545539; cv=none; b=rt1JkKOmepfNNRaSwGTCVZ+d26tM63cs2u1BwwtdHTYNh87gdhgW1PxLtfsoOG01Zf9PO4SgcrMfM6mJkYKRKlQtuNHUw2TAxjkUPb4GhP/J/xNfT2BUDTnwjNM43MYrKJlFMybtt1VRK65vp3FPrQ2fWntUqGzqvln3wY80quU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545539; c=relaxed/simple;
	bh=L6VSMNKkPXg4l9VS1SCcav8nfu3ymTFtfF0ofUQlcoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANcy8vRXDGlSLT5lHceEoW1LQqv82HafsxN0fFvBP0JnJ6O7IvSpEq6+F++aU6Tqu+cUnTZRnBVJbVaDhbGRGoc+hcj0rHc567ZYMrnmbhHuKGIRjl8Ikmem58hhZL70KVzIXIqaa5OkX03/xNm+BJYEmIkvfCZntA8g/ajpvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GBzusWew; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GBzusWew"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a1676000so460581a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545518; x=1790150318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fm2NU1dVk2SpuJ0fFyLgsSQpwqAtZZWxE/JzixP9q9s=;
        b=GBzusWewVtBHhHke5RksqATpbU0/huc+d336SYPaxyosNfiesaXKtV1JgWg0Jzote7
         f0roi3BJSDAhn5jtc4jwhwyBeYGHfyAaASrTMR2G8i1AtFJNbyzNkh27gYu5wvEWIyZC
         /AasNZCngh+Vrs6oFwRqMyrj3mTU0TGUCj3Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545518; x=1790150318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fm2NU1dVk2SpuJ0fFyLgsSQpwqAtZZWxE/JzixP9q9s=;
        b=iEtblU1e5XaHT9nIVw8ioyBfjqIO6663Xyb6/dw00HpZZ8qoHu52AcXijaLozwForq
         HeiDPlc+8ql915+cPY3CCu+BVDctV8yfUz6X4sjzy3ZpmIDF7lHBO+vpsia3rgt979WH
         SRa77tRnxkLat+vYXigAkSL8Bl6cLUaxK8+Z551blK3R6PQpR/mV6ULDB72eh/g0gFHT
         ZhlBNUYhl8mQ1Bd8UVMKoBuGP/6jy5HsQiFJgDQHatDKhrMuo1/IB9Jl5E11RjKw9mL0
         EI3BhRN0MK60V5ZpbQ1OV63CUYdWZKsrvi6zKCV9+5a6HS4VDRJByMhpYjBRjJbCXr05
         j8hg==
X-Forwarded-Encrypted: i=1; AKwUvBwps2XGJPStho5XFjoR6Mw8b1CSyxD53w/mwSmyOghNKM4Clh5dDiPyHMRsN0kjdHRajNyIDKhtrTjV@vger.kernel.org
X-Gm-Message-State: AFuF++naF5LaYtyICf/MbIhANHbr6zWWWr3iedBKWWYpTTEVlUgQGS5P
	LUNW+N+u/bjKXX6iEqk3O1tJfPIJjdP156kYtaB8OnzhalzmFvJ15wmuN+iHFIsRLA==
X-Gm-Gg: AYBFou3WO/6HsCTpPye+UEhvmiQMDBXqUaTu7lo1lTt/UyTL7uReaS98YBlzUv4Ffhw
	BuUR71ETN7uAZosiZEDKcsQauVZJdgXZwJJ42DneGf2q/f3ygOKMV2GEkEMbmCksr+RuyIZwmal
	KxdF9NfbHMIHv1znf9tnl8fGJEMEPDKtCFTukdFYEFVgWV9AjVDQnHMjOCUfz7YaMydi1O+UI/x
	GD0ERkveNcFOBlTroeUSzZ65dqcB5p28aRfGLk2pFCWWwUx8nNG4p85UjhnjNscqOqzH1DJqLM/
	IxSNR82yz6rvdPWLS/s1m0Br0uyUVY44jR0HHc+EWxqVBOVMwssZrdjcM+KEd6LKQgx/hBR/OE6
	+278nFOjkZd0R7JzHOa4Gi6l5uFQSKJ4oYMq7VVDLsdYjyScKQ/bjzBbBkDxv5QMbQfhXi9lyyk
	kfSnMlO2AWqrboucgkOAfR8pNLGsW9y9M6UjTjBb9fLiy1Y3x4iVUILAHwM58Pa5/TGgC9HU7df
	gfT8sL+j6XMcWW8fINAPhAXdabvHqllW8rmjFMjkPNWT/yj0AGI36IZgw==
X-Received: by 2002:a17:90b:2885:b0:39d:f130:8f13 with SMTP id 98e67ed59e1d1-39e1e4d3357mr4064349a91.21.1789545517871;
        Wed, 16 Sep 2026 00:58:37 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:37 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v9 03/15] power: sequencing: Add pwrseq_get_state()
Date: Wed, 16 Sep 2026 15:57:29 +0800
Message-ID: <20260916075745.3549953-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- Adapted to pwrseq_enable/disable() rename

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
index 3076b3879af9..8e06fe77fd6a 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -971,6 +971,25 @@ int pwrseq_disable(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_disable);
 
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
index 16fad5f3e3ab..e2a2991b20c2 100644
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
 
 int pwrseq_enable(struct pwrseq_desc *desc);
 int pwrseq_disable(struct pwrseq_desc *desc);
+int pwrseq_get_state(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +60,11 @@ static inline int pwrseq_disable(struct pwrseq_desc *desc)
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
2.55.0.1032.g73a4cd73de-goog

