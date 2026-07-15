Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B513E3152
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105729; cv=none; b=QMWWqv7q8MGdI+M81x++4NIYVQdbH1C4o/G6CQEKjHmvwc0PUOHxJhyJNVUD8K7GFR13b/yAPlmrq01ebRSAE1DhEshz2N/DhvyW18mqBvQEhoe/+DfsQf8RQYoX9X/Xta9+vPkepRAx4bQ4H82vLz4DAgLqKUvFC+8GKmokcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105729; c=relaxed/simple;
	bh=5/IN0+syw1+quFd0dmc3wlZb141a8fcAYXzlkitn7j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrOeoI3mxaEmsTg5I5ACssYi1zMXQUCG+p7/PPGWvon0VEUjfiNICjUzXym9sNq+DMRWulBfOd5WpDAahkimfZr/Kpqr9tbeaV2t73SdsmTAsFx3b4FH4oRHh6R/0SiFSCe12v3xEy4lYvNw9qpOcReETgl38zlgbErneppuL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=idup/aKM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idup/aKM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2914618a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105724; x=1784710524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4sxxYjabBMDuNPYs/dekkLCAVyFQe7dZPVIfnECI90=;
        b=idup/aKMYmrAJ1Br9sFr+Q9yHCeHXIN8C17e+SZneXQY8JqndzpaAfdJu5lIsVbNgL
         yb9hUBj7fg66XSRjTwK4Q7CuerbGaXIMJUzhQglNB6yAH0msrd8hR+ecdL702cPlQFd+
         9WjDkaQ5ZSuCp/qYwJU1Mn397kqkJvQ3E3w9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105724; x=1784710524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4sxxYjabBMDuNPYs/dekkLCAVyFQe7dZPVIfnECI90=;
        b=TPDu6iH9PPFR9BorZzti4t1QkIjBtKqg0CiBi4Zma9U49ZN45N4TwBkz1oWvI6Yy9h
         z4J/vyGzQO6d4sElZQ57nCYe+5Kc+rCqlk2hCb6ncTMgp6qzEA9x5BSg0DHfQVyDhQyk
         JMeZwnEEbqwmLQ3MEXzbqsgtsLg2gqSLVnN18wyVRPrV106BuWlQjftSrQdp2ZMkjEmv
         Bly8rNK+Qjan0fjM2qxFehOza7sKVZqGA30KeKOX0dit13hkCU2/quZdR16fjQjsBhcP
         UEfRSpztTzmQACeiSiR1loUSvMEbkQXItfvJySShlvi0RwgfIFqQYF4QpkJcHCw99ct7
         8Yrg==
X-Forwarded-Encrypted: i=1; AHgh+RrjEDM5KcYi1H1JbV1MLAcvRewqX0b1cWIFGWNg0R0vu7Cp9PQsJeReL/OBsAPrK+2TeOGR3ZEH50AY@vger.kernel.org
X-Gm-Message-State: AOJu0YzcI4QnS83l84R4EXEmsG0BOsi0y0cV30P1MWsiL2yKuKdOgj8k
	uL1RTw9012JP10TS7N0z24RDo0zOURbCgVMRy78jv0RYYAH8tQsDz/0tjRR504SZEg==
X-Gm-Gg: AfdE7ckf+nmuoMJV1qrx+qbwvE+5WUROBi25woSfRmy/tL/ApqEA1yFR0GWvGP7PJIk
	xbapoMgHh9ppmSHDLSFfp/86ZwXfUp6O/r5IxadfyYxoXjG1/bllxqkyqXFDX0GkF3Md3/ZoqOV
	8YUST2VF5qlenuW7xR/sar0ZJzq34G/0fcPpS5sYLO2cNVxWPnRBggQ2L4dCU/l8invfVB4/hCI
	Y94NZKu4mW7jd7RSSASjhR0I7wPxAsg8IU/B4KOZjP3H/xxdg7VIK7+kHL6Vn5Ar0SPuYNLyf9o
	RUGH0jih779Z7kYWmErgW+kZLldIMhbN0E3FfGlqeRKFJsnd6sb7TvRHAdRSWz8nWDJDhutndka
	GIzh3AMfNMJQP/y3XcCcY43tIwMzZgLTdNaEOBIGO87qTqYPzCBiXNVgdfhoclLnC309I6d6tDM
	mJJgRKudwX6OtjKBMF5RPCcfTqGP05U0TCC8cJbVztxTdn7v6/71YFd4T+t47aCidQEIZTq5QDu
	qnAZgTQ
X-Received: by 2002:a05:6a00:12e6:b0:847:712d:19ac with SMTP id d2e1a72fcca58-84a67242621mr1719045b3a.8.1784105724146;
        Wed, 15 Jul 2026 01:55:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:23 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 14/16] power: sequencing: pcie-m2: Split Bluetooth unit based on interface
Date: Wed, 15 Jul 2026 16:53:44 +0800
Message-ID: <20260715085348.3457359-15-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some UART / serdev based Bluetooth drivers need to be able to reset the
hardware during initialization or recovery. This is not possible with
the current power sequencing API if a unit is shared between USB and
UART interfaces.

For now, split the Bluetooth unit into two, one for each interface.
This allows either interface to independently toggle the power, with
the last action prevailing, thereby unbreaking the Qualcomm Bluetooth
serdev driver. This is also needed for the Realtek Bluetooth serdev
driver (hci_h5).

Having independent control from either interface unfortunately means
that userspace is able to shut down the controller from sysfs using
the USB port's "disable" setting without the serdev driver knowing
about it. On the USB side, independent control is also desired, as it
allows the USB core to power cycle the port/device during faults, and
for userspace to initiate reset and recovery using the aforementioned
"disable" setting. However when USB is used, a serdev device is not
created, and there is no conflicting usage, which allows the power
sequencing to work even without the split unit.

Suggested-by: Wei Deng <wei.deng@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- New patch

This patch is _not_ squashed into the previous to provide clear context
on the change, and the less than perfect nature of it.

I think what we need in this case is some sort of lockout. The serdev
consumer would want "exclusive" access, locking out the USB consumer,
which can tolerate "shared" access.

Something similar would be needed for the WiFi if we ever add support
for SDIO for toggling the state of W_DISABLE#1. At least the SDIO and
PCIe reset signals are separate.
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 693b0d33f8cf..56e4f40e0480 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -83,8 +83,22 @@ static int pwrseq_pci_m2_e_bt_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_unit_data = {
-	.name = "bt-enable",
+/*
+ * XXX There are two Bluetooth units to allow either one to be able to power
+ * off and thus reset the controller. In practice only one of the interfaces
+ * is used, so there is no conflict. However userspace could power off the
+ * USB unit by disabling the associated USB port, without the UART unit or
+ * its consumer ever knowing.
+ */
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_uart_unit_data = {
+	.name = "bt-uart-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_bt_enable,
+	.disable = pwrseq_pci_m2_e_bt_disable,
+};
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_usb_unit_data = {
+	.name = "bt-usb-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
 	.enable = pwrseq_pci_m2_e_bt_enable,
 	.disable = pwrseq_pci_m2_e_bt_disable,
@@ -130,13 +144,13 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
-	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data = {
 	.name = "usb",
-	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_usb_unit_data,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
-- 
2.55.0.795.g602f6c329a-goog

