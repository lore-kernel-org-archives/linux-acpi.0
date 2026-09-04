Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8C41E6DC
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511352; cv=none; b=hbL04qaZbU/bwDeQnH0MxHK8eTq9u998iqm/drwWs4Ts2NSBQ/PKFESFa+UyE+BpEssHL3m/0B18grVZAHbz2XjHyfglguo/KMieVJs0F3Of3ODVYHF7VHrsVa9waM7KR/LvHxd/4hstLMxDy8ofFG+H+d8gm22qgahJuSlk6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511352; c=relaxed/simple;
	bh=yg835mCmcfMqyyZMo2K7NS9o2JVbGcnLZ8ClgruKi9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxEA9o4d7/MIM/C27140ygfwDESpzLAxq078ezaY5kgq0ve1PuNSk+RwENot7fO9q07OoApPTS6pXHuupMPJL27sPjUwMuX8nk/a9xtk4KcURIb6OS2vx6aJ2DIV7fx+cgwBTCs1iqYwCKjWKlF4mlx0WYgKy/sZ30f6JMXcv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/gyr6Au; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/gyr6Au"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d7195706f1so8518095ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511350; x=1789116150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUco8k8loeDw75nokYqtCIPRhQuEjxppf2mE5m0ZQ1k=;
        b=m/gyr6AuUq/7OUDNULHHrbaIahHhyIKwWsKNs9OgoSCjud/8a25yEMU/sGmXsFP4Wa
         Y64U7cvg2JrZMImM1rvy01TyzeWvelnO/sU3+fM0xYV908vIJ/am/suXPdYAZ7sPem/T
         WO1uelv5bNRHEgIgGNZ+eytrZKLQZAZA47mAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511350; x=1789116150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUco8k8loeDw75nokYqtCIPRhQuEjxppf2mE5m0ZQ1k=;
        b=PIhP8LnER8gKnwf/G3w6fEnSyIQHRoFMuufwjB5kNHfuw1yAVmKWLYcYLoeer/USJU
         6PiagtnfXkQJGqsuR+LLDKjrnDHIqGr//DLwc8jfOEhZcVu+5TaN/FylnvVMy47Pdh1J
         g+SwQsuEyrTn3mZOniZ5KpNW16gdyp036PCJYJpVetj4yOAulq7YefpESNpQPpU3EL6T
         0z9TAlnV1NPYI79mLO7ICZJR+G7KIRvPtK3Dzzeuv740VlQOMiQS7DSI5ypJuMsCQA2B
         V+Rz/Iyq+AkPGMbZgMeXYol5vb5XOi9RWFGzAnvFDrkLtd2a2YFghfdSfHAuQxRedPt7
         WsbA==
X-Forwarded-Encrypted: i=1; AKwUvBzwSKXTUW46L1M2J2PEnkbmJ7d1H+pRtj8JA8ez0plqgWPbhQxKXNIZQznCDG0ag/8WVFAX85OTN33h@vger.kernel.org
X-Gm-Message-State: AFuF++k3izm+jK76MPZ+TpbLyGMK7celBmYs345fiRfc7342s+3Sr07c
	6/i0GSF4nF7iMFAv3EWr4X7yYhIfgiS2guNZLK+s1ga4kqJm9jBZPc3e3KtByZd9AQ==
X-Gm-Gg: AYBFou0kGY8giHWor+9yYl5VZnyJof9p2PUy8Gszm6+TpVhnm369YpTAVS5v3F82KzY
	IXJNoWFJVCOm298c2t4jHseLFBuG5cxO+/p7pj7/shlsmOnciEaQfeqqBT6D3y4LfLN0J2JnrgE
	pUXhyLn1k8lY/4kn7rEw35enYvBhMw57sX2oNWWYv4TyfQYhXi8auI6PAc57zfbAuW1BTengFJb
	ccF0qRrcaOyph/o9LhIe6yO6mmAj6n+pfz4D1a1rcc+bxzGv94P518du48rMLmfaczcb+TmwbUI
	RI4WT4Mvc1CD1UjYBBjnl/Ny58iyAx0yWzCvi2HB5iiUFiW8gjxByj/TVMP4qlWkKfazIcmA05U
	tiAfpDcenOP8z0SE8LiNBmwu5sLSDVpDoJlDkdK71TGo889uv89j2ikB5KhXGumuOKtsqsX3pG7
	XqSk0NsR5EMapq/whcsFHGx7XGvTqpbtbMEez5zBMN9uWZ03YFpgeAC9NHj28m/EDL5e/qqeAAW
	B5ziRmWL1DkFm/bHup7LWtD4o7mDYDbLYeoe8R3plzB
X-Received: by 2002:a17:90b:3a8e:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39b260d2eb3mr6786889a91.7.1788511346596;
        Fri, 04 Sep 2026 01:42:26 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:26 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v8 03/16] power: sequencing: Add pwrseq_get_state()
Date: Fri,  4 Sep 2026 16:41:42 +0800
Message-ID: <20260904084158.1341550-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
index 721e888b658d..dbb2bd2f8864 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,25 @@ int pwrseq_disable(struct pwrseq_desc *desc)
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
2.55.0.979.g7e5102b832-goog

