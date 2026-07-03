Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AD3BED33
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076633; cv=none; b=Q7/6pWaAWspqRm0ObualIEW/Kl2DmleMrdn73Gdyi6+iQQ7u35n4qGBqZKrh6CBHHE6s7IMEBK+2PZa5YFZq6EGm2CumeR4fxYlJ469ixiSeoZwLJ56CnQ+SrVmqMbV2xsVkkMq5IlgRabTDRLLkJBvaaNRK9iBJ3Bh/Lvwk+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076633; c=relaxed/simple;
	bh=AzJgC/RVsjJ6k/SwatcooMrO5iTJhfE4K7EewIxT/yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0ql1sXLGmkltcfrHAMwjg/ibEh/8z4by4dMQlTdH7/n6x0g548CcHMmYHo0nzqBypq6A4odJY1tqBMZHaBfpMPXTwMR10dFriDNVOPohyLZAsoGFvj/LUkEdFzMlWtM+kWLJuPCkRAsMS4HWkSTchf1y+SPYM2MYTfmHUKsgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gbs5uP8o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gbs5uP8o"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caed617615so628985ad.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076631; x=1783681431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRSQjBy62puZgUQngLjPxg+AegEI44LbaTaSEWvc+ks=;
        b=Gbs5uP8ozw1JQlSQnh0yXwdTHI5FERylCKPEkmA4LPHdMOFN9l5ixriYiyLapiQpaq
         QbqvJx9onMxQZgbuGmj1murrw7lC6/j4j/MKoUvfxTuHmUN2tCi8ykZHS6Xx6HmpnZVR
         gsoiVadah7COv31sQiN3j/MjbeSsGPPvkDG28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076631; x=1783681431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRSQjBy62puZgUQngLjPxg+AegEI44LbaTaSEWvc+ks=;
        b=d4XgrVo3ybM32cDhwSmRfsMTVEA6zvjp3/fZgObOeljnPQ++usH7l7065X3f+hNLc/
         Thtiwm8rS9vD98i2/lu7SxoAFHyJgIsj02wWYAwUhW5+6gmRm6DSzzSi1veRgkHA4iVR
         llSBH9mwzaFNbw5QZkWIbJ6K5BvABsBWRcWM87HCzEts0mzvQ97+eJc0O/FWUCU2kyWF
         nlvOYHp74ofIg9+//SQ0rGfCChSSOtNpf1TAlrvjpQ1MuSMVDtsfzV6H0n5/cNH3N+qN
         eVhNI3sabsMYUv919X0jK9Gonn2+VKqa2KDboSKXRsFZEcoEVT+rtGNbtuCu9dqYT7sI
         cF2A==
X-Forwarded-Encrypted: i=1; AHgh+Rq1I1yaWYiVptBYgk3dMccjadf0c4teAOZw2UFymhxfQPAg7ZkVxSW4fubSCwQAdXvIjm117bt8reGH@vger.kernel.org
X-Gm-Message-State: AOJu0YwhK39tGL32mNqSaO310ql9DjaWkHTSYXDnw4GzMhFwR+xHueDV
	aOo3CelYtPFP8YFfgNf7FJsH4SABVBloz0hs/6l7Ldd3uB4smlVepMnryl7S/7OvWw==
X-Gm-Gg: AfdE7ckbG6O7/zvyKM6JHeWFIzydHcXwxltXASppKIZkAGzUciK7AG4/Bn3+hJ2ol9s
	ugAQFek6j1aoEZlSQC2XsKKrMuyuhIZz0Q8KLyCrP2mPwaAyxt44VtvtdJoPvRQ/smYSyUb92VI
	o+EcupNwDqf+HxN20NOQDrFJ2TiJPUlDglukj1uC94OXS6WaQr9N07VGwOSURjHdZT9ko/wjvPB
	cHWaByuv/AP0ZEMFXnuThABbH4v/EZjANHZ/WYzdEheDomIWfiMnrom4EgQVXoNkEsWneIgso0t
	ecTozPJwBFws2FCILTOpAnxQI66JLWzIQWeeOmLU8WqQUFd9d2mZ77wbsUyPUUikF4r0xCcj4XO
	y7zGVGelX67+nZTl3e5WcPIU92IzhILaZawmavPZCHisJW+U6my5ThDTVk6gKSmsfxDj5dDTp/G
	D4ri/90z4N1/0vrydSkSHOddeEefjFNyfx7zP6O1mwVU1nVAWIDUj3PTWCjv1/ljasCLQyLw==
X-Received: by 2002:a17:903:2383:b0:2c9:e261:95c4 with SMTP id d9443c01a7336-2ca7e8d9f8fmr111666555ad.30.1783076630618;
        Fri, 03 Jul 2026 04:03:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:03:49 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 03/13] power: sequencing: Add pwrseq_power_is_on()
Date: Fri,  3 Jul 2026 19:03:04 +0800
Message-ID: <20260703110317.1283411-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power sequencing consumer API already does power on state tracking
internally. Expose the state to consumers through pwrseq_power_is_on()
so that they don't have to reimplement it locally.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency.
---
 drivers/power/sequencing/core.c | 18 ++++++++++++++++++
 include/linux/pwrseq/consumer.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da91598..72b96d36920e 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,24 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
+/**
+ * pwrseq_power_is_on() - Queries the last requested state of the power sequencer.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This returns the last requested state of the power sequencer.
+ *
+ * Returns:
+ * On success, 1 for on and 0 for off; negative error number on failure.
+ */
+int pwrseq_power_is_on(struct pwrseq_desc *desc)
+{
+	if (!desc)
+		return -EINVAL;
+
+	return desc->powered_on;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
+
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
  * @desc: Descriptor referencing the power sequencer.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885..5a5eaf85d5db 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -22,6 +22,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_power_is_on(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

