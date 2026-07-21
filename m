Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98935435500
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616944; cv=none; b=I8LuJvJBPvP1gLI0uvKqxOLU9cGb+iy5Uu/WSHoZ2+CUXxKLRCgsbSPCAnGPVI24s/6FC5YyTw01UkpLYa1VbiYveLzhjOX5xFgNzf3UnzqvEKwuT1OL9CVe/vNKhejVuthps0n11Nl1LdAUwKE1r6EAUJsSZ9Y+V2kN3kKgKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616944; c=relaxed/simple;
	bh=2bdpJglUXNu6BBTggJFiuCLLgE+aHPv4Z4H92NilTHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaQzh3RlLHyKBUENxPWiL3PEss39rhAeC2rqjQ8WOPzQ0RxHxx9wDWsQPmyaXxeIeV7A7sc4/DIrYLkbYTcl49W4K2c8j9Kr8f28hpsl0Zd/9hVbgI1CSxObUSEb61JZMwbVRLJQLCdhmBfE53IYMG1AbH6gLWI+vTXbsk8sb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R55nUNqx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R55nUNqx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cca0c5799eso86502825ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616942; x=1785221742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPhOqCEBzv3eJgxR2FHq6mhzbCgxaYl9KnF0Ou483ms=;
        b=R55nUNqxy1xz0q5oWp8eETsmYQZhHVUPqssMTfpjqsnSt6X15i0X6RgVqGDQ59UStH
         TIpm9HEy9ZYiav5ptINLaMjif+lnT4C+w8BRleVW7JA1iF7GEOZUuMrH1X6HQOfyiViv
         Sr2S47HSNoKFtV7XdHfPPGcILPOOlykZXP6YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616942; x=1785221742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPhOqCEBzv3eJgxR2FHq6mhzbCgxaYl9KnF0Ou483ms=;
        b=FHEH8itrIJGQHN7lHGJfzZFICz2z997U3OkTMJil2FTZu/jAXfwye0Ed64MocOfbAe
         zjySV1JzaPqydr+oJqEbrOe+VL1DkRdK7T6JU/IDB6ycC+nJkefw+GNpSQLmG5gBf5jO
         of6t0SKZocH18qJq23WLtcxia1nb8Y6srY+5ymSy82BrR8cZ0fr1MQqhuDPm9oYBaEbU
         WLSwnBcUphtwA7HLwaH6W1SYE1S3rQQyCLgYI4qaiNcm0aLYMIZJMEUGuyvpvIBXkvlP
         pSH2EjdLgHi3/V8fmll+AEgHpZFnHRYyh4ilNJhcqGEj6QKpyG88UABrinEUO9t40X5S
         2yQg==
X-Forwarded-Encrypted: i=1; AHgh+RrDzO0yROs+EWq9IK8tv6F8UH5l+9UU3Lxc8U5fwf+ENjDQ5Zlxz38IeDRwo0LDEk2bpbi61YnMy1co@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+fTUzr9kdn9hAxr+Yq8KELiI7IpDxZDpSZx1+pYA1jozEg2r
	0JJMiULnwZvsBIsb+JDUE+nStdiwAucwF1PqDLFQbgLT9FcBPKwdMpbSVwNEIGoc2g==
X-Gm-Gg: AfdE7clrbU1B/74jiY4F5N3100SYxvwMHzWAJpfwj8GhtxKcAClFiJPbK6geQ33V43P
	y2OGTL+qJiAK1SYQ9AmFtY3+asxzCX/Xz0/fh1bkzhnFDdWgODBqtQrIGo7EsUz2dNNzabzMicH
	jfGuPb+9rejOz+QNmtBq/HYvYFgByn36KrMBQoO/UKIuRPTNtYF5VmOj5ZgyChmoh8U4ije7/zZ
	/yIiFhRnOojL5IEcJtv2Ia7skqiEsN0Bxscd73uvy2ucAbdIhTVvBoYVXjQN/fj3unhl3NndFlU
	EPlcn5dj4pZmkLiiMjFMLWPftzDOfNmrZXz5aNLAxFCvHCe919naDG7H4izOKi3UGaG6MeeBH3j
	8V20B3T/G7uGHMVdMpi5MJrZU2yutuhbPOddy+jtMJ9wcaB3WXCrRTmUhfiU84+TO4nJXjiJRmF
	O4qhDgop6GJXUGZh1f03P93V42o+FYtcOAP2v1RsCpLEIP89FGQ/sYBEgyKoYLuG/FOl3kgg==
X-Received: by 2002:a17:903:3550:b0:2c9:97a8:aff1 with SMTP id d9443c01a7336-2cf349f76b7mr179989295ad.42.1784616941867;
        Mon, 20 Jul 2026 23:55:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:41 -0700 (PDT)
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
	Wei Deng <wei.deng@oss.qualcomm.com>
Subject: [PATCH v6 14/16] power: sequencing: pcie-m2: Split Bluetooth unit based on interface
Date: Tue, 21 Jul 2026 14:54:09 +0800
Message-ID: <20260721065413.2306137-15-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

