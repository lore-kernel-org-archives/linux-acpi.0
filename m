Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486148EBE0
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688887; cv=none; b=g23EMBCfR01TW0Kot3mwGe6r5EXOqT0YMiNfRGC2qOZMA6EohUA6pC/gIWriYlZ36RIy/KJmxAw/nsNUKkTU5LXrcbamOTrC4YpfXNhMaon5UGj5hUXTOTn2ccTyoTrvKzU5DbTF5jRWCQBCu/SVLEQRFNJhe6q+2ok38+N31BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688887; c=relaxed/simple;
	bh=/vTICs4rfZnQqWAY7jp6Xx8e1B3/4HZ5WGwfLBmD4E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzRRrJmGRswDSALe5cSfMGPJsQ/rlQKREXtXaffAl9JxT8jFZJzupKv6rpFWTl6UezxnHFVb7iurgkgn33d1A7OLHEh7oFpAPzJpWqHcZ2Hoohe3M9JKjmPFdsb5871XqZM0imM9uSpqOgxQT+02c8EP3HPlXJjEUrDytJvC048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no13wnrI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no13wnrI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so1123665e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688884; x=1788293684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWvvM2eJTieYNAJ1IrJEwIoJaD0ytMJ17q0W4sd4AmA=;
        b=no13wnrIWtL13vXQkmEAVFZmcye2xYOSzJISNBI57Ca0fAuh4FptkhTEq0nMYKx0fF
         Z6MwIYliX/WttdhybRmVClrS9Z4h+G94ZpgMGul8Hbcy3ZkejzgImBezpdqYP2PoGUb2
         pF3csgsWluJ3rxOcegCGElricJwL6t+E5rrGC+Csz9OHotPPJHZjj7nECzDilNVt6SAO
         C+xD263FqgJfde4TpFcIiujJY/YLLns0pWumU5qfoovrbxt/IfOgozxy8RCAbV/6auwB
         LIdxSIk4DqZX5FTr2SB7WoKHHqitAMyw8LGhE8ieeaSNCt1eVZXmclI0tODNQ0KSVyeu
         8e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688884; x=1788293684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hWvvM2eJTieYNAJ1IrJEwIoJaD0ytMJ17q0W4sd4AmA=;
        b=QYLzEcOnYokNQQ3gpXEE7bi8WzwHyv259zh7ZCx9M6jRj0tUh6WKlrtteQZ8r476aI
         BHq8nf0sbzk/h+nymcUoQ9aUJknCCjKDTwcKtLqTYiCI04nQsYXEekChgeFekaWv97qU
         w+1NG6zHmSi3BbVVz7RCIOslt6p/76R2GgwpI7vf7vgTPquPcvlnOPbqI2EaIunDdPfw
         eugTGRcx7fgH/Zmdl6UMjdbwrCdh/gQx9L+2WoBoCj4J1Tcum39amq28fATiBFoEFIIf
         056uhtn3fkJfrhlzV411uKefELAKDOEphAUAWzxFxU9XMimd5cvy2T1iNQ80IYPoI8Cl
         Cs6A==
X-Gm-Message-State: AFuF++kEad+z5+iLxp3OV5yIrmFHSnHp8Br23En19hetqLL5CqQU4XX4
	V6CIvmrMmS7Nq2yzFoUf5FELATs2D9SoUnRZbq0DlRIOiy9aa1jma3r8BT4Qy5o1rIw=
X-Gm-Gg: AR+sD10BDMJTzPgzbZvR6Ywa+JtBMVMLPKxcZHceZXeRde/oaX70wi4Y4c0Gp1uWKwh
	8z+vE9uOWcyQQ0mlle/Ruo7b6JczLNJcnyBD9W+CrkC+j4juteCBhhx3DmWNQTALMMGTsBVNuzl
	FWW57m1wsrw2kH/X3xhgvjaBp+ObdRkELWHqHYqrjAHlRJ67kds9vrbaCacmYujQmakF9b0rWFz
	jJUQtkz183/6vqHN/r0Y5GdrV8c+X3UnpmxaPlF804F4GNvFJp8Bu+fpe23H+nl5M31q1dI6rbC
	hVAFaC3nutJAyi+SePXuPjkCrS4dsq2v9XhRWlNaSaLfeb7Ye/jR/ZT8eyz+5tlDHQKzXNMjlIe
	+TH6P+915RzFyzJ7uPURUxCfyHomv3TLbqZLyUMk68rJwDQ4q9gWGXbuCRdIa72dUKwMAKlXT/H
	DNIjUrsmBmMuUhT+R841PP+sfM1xheJSoAr9qr+b4hKRnk5+ZQN8YlDz1exuXy8VCHuJhJvgDMy
	CiUsstQeTUrKwatI/XESVrTay4W+s9tirDMLKISZfkkD4IkuQWuVXmRcZvyzsVwHhEcN80EvjJ3
	e73bsiJR5VZQv/TdFMXnlOngv3immux89DJCjYq/6IEMVpXv
X-Received: by 2002:a05:600c:811a:b0:499:db9b:f253 with SMTP id 5b1f17b1804b1-499dc6ec214mr15659295e9.3.1787688883796;
        Tue, 25 Aug 2026 13:14:43 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc960e80sm5050435e9.1.2026.08.25.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:14:43 -0700 (PDT)
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
Subject: [PATCH v2 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Date: Tue, 25 Aug 2026 21:14:26 +0100
Message-ID: <20260825201426.47030-3-edward.blair@gmail.com>
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

Add a UCSI transport driver for ITE8853 and ITE8800 through ITE8805
USB Type-C controllers found on desktop motherboards.

These controllers expose CCI, MESSAGE_IN and CONTROL at ITE-specific I2C
offsets and signal UCSI and vendor events through a shared interrupt
status register. Read and cache each complete UCSI event before
acknowledging it so command data remains coherent between the interrupt
handler and UCSI core.

The interface does not expose a VERSION register and does not accept
PPM_RESET over I2C. Report UCSI 1.0, limit MESSAGE_IN to its 16-byte
window and handle PPM_RESET locally, matching the vendor driver's
behavior.

Signed-off-by: Edward Blair <edward.blair@gmail.com>
---
 drivers/usb/typec/ucsi/Kconfig    |  11 +
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 87dd992a4..3819c4f73 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -104,4 +104,15 @@ config UCSI_HUAWEI_GAOKUN
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_huawei_gaokun.
 
+config UCSI_ITE
+	tristate "UCSI Interface Driver for ITE885x"
+	depends on ACPI && I2C
+	help
+	  This driver enables UCSI support on platforms that expose an ITE8853
+	  or ITE8800-ITE8805 USB Type-C controller over I2C, commonly found
+	  on ASUS Z690/Z790/X670E motherboards.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_ite.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index c7e38bf01..9bc1d6bbb 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
 obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
 obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
 obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
+obj-$(CONFIG_UCSI_ITE)			+= ucsi_ite.o
diff --git a/drivers/usb/typec/ucsi/ucsi_ite.c b/drivers/usb/typec/ucsi/ucsi_ite.c
new file mode 100644
index 000000000..16b22c77f
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_ite.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UCSI I2C transport driver for ITE885x USB-C controllers
+ *
+ * ITE8853/ITE8800-ITE8805 are UCSI-compliant USB-C controllers found on
+ * desktop motherboards. They communicate over I2C using UCSI registers at
+ * ITE-specific offsets and signal events through a vendor interrupt register.
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include "ucsi.h"
+
+#define ITE_REG_CCI		0x84
+#define ITE_REG_MESSAGE_IN	0x88
+#define ITE_REG_CONTROL		0x98
+#define ITE_REG_INT_ACK		0xbc
+#define ITE_REG_INT_STATUS	0xbd
+
+#define ITE_INT_VENDOR_ALERT	BIT(0)
+#define ITE_INT_CCI		BIT(1)
+#define ITE_INT_MASK		(ITE_INT_VENDOR_ALERT | ITE_INT_CCI)
+
+#define ITE_MESSAGE_IN_MAX_LEN	0x10
+
+enum ucsi_ite_event {
+	ITE_EVENT_NONE,
+	ITE_EVENT_CCI,
+	ITE_EVENT_VENDOR,
+};
+
+struct ucsi_ite {
+	struct i2c_client *client;
+	struct ucsi *ucsi;
+	struct mutex event_lock;	/* Serializes IRQ and polling */
+	struct mutex received_lock;	/* Protects CCI and message_in */
+	u8 message_in[ITE_MESSAGE_IN_MAX_LEN];
+	u32 cci;
+	bool registered;
+};
+
+static int ucsi_ite_read(struct ucsi_ite *ite, u8 reg, void *val, size_t len)
+{
+	struct i2c_client *client = ite->client;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.len = 1,
+			.buf = &reg,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = val,
+		},
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret == ARRAY_SIZE(msgs))
+		return 0;
+
+	ret = ret < 0 ? ret : -EIO;
+	dev_err_ratelimited(&client->dev,
+			    "register 0x%02x read failed: %d\n", reg, ret);
+	return ret;
+}
+
+static int ucsi_ite_write(struct ucsi_ite *ite, u8 reg, const void *val,
+			  size_t len)
+{
+	struct i2c_client *client = ite->client;
+	u8 buf[sizeof(u64) + 1];
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.len = len + 1,
+		.buf = buf,
+	};
+	int ret;
+
+	if (len > sizeof(buf) - 1)
+		return -EINVAL;
+
+	buf[0] = reg;
+	memcpy(&buf[1], val, len);
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret == 1)
+		return 0;
+
+	ret = ret < 0 ? ret : -EIO;
+	dev_err_ratelimited(&client->dev,
+			    "register 0x%02x write failed: %d\n", reg, ret);
+	return ret;
+}
+
+static int ucsi_ite_process_event(struct ucsi_ite *ite, u32 *cci)
+{
+	u8 message_in[ITE_MESSAGE_IN_MAX_LEN] = {};
+	__le32 raw_cci;
+	u8 status;
+	u8 len = 0;
+	int event;
+	int err = 0;
+	int ret;
+
+	mutex_lock(&ite->event_lock);
+
+	ret = ucsi_ite_read(ite, ITE_REG_INT_STATUS, &status, sizeof(status));
+	if (ret)
+		goto out_unlock;
+
+	status &= ITE_INT_MASK;
+	if (!status) {
+		mutex_lock(&ite->received_lock);
+		*cci = ite->cci;
+		mutex_unlock(&ite->received_lock);
+		ret = ITE_EVENT_NONE;
+		goto out_unlock;
+	}
+
+	if (status & ITE_INT_CCI) {
+		err = ucsi_ite_read(ite, ITE_REG_CCI, &raw_cci,
+				    sizeof(raw_cci));
+		if (!err) {
+			*cci = le32_to_cpu(raw_cci);
+			len = UCSI_CCI_LENGTH(*cci);
+
+			if (len > sizeof(message_in)) {
+				len = sizeof(message_in);
+				*cci &= ~GENMASK(15, 8);
+				*cci |= UCSI_SET_CCI_LENGTH(len);
+			}
+			if (len) {
+				err = ucsi_ite_read(ite, ITE_REG_MESSAGE_IN,
+						    message_in, len);
+			}
+		}
+	}
+
+	/* Acknowledge each latched event with the value expected by the PPM. */
+	if (status & ITE_INT_VENDOR_ALERT) {
+		u8 ack = ITE_INT_VENDOR_ALERT;
+
+		ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
+		if (ret)
+			goto out_unlock;
+	}
+
+	if ((status & ITE_INT_CCI) && !err) {
+		u8 ack = ITE_INT_CCI;
+
+		ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
+		if (ret)
+			goto out_unlock;
+	}
+
+	if (err) {
+		ret = err;
+		goto out_unlock;
+	}
+
+	if (status & ITE_INT_CCI) {
+		mutex_lock(&ite->received_lock);
+		ite->cci = *cci;
+		memset(ite->message_in, 0, sizeof(ite->message_in));
+		memcpy(ite->message_in, message_in, len);
+		mutex_unlock(&ite->received_lock);
+		event = ITE_EVENT_CCI;
+	} else {
+		mutex_lock(&ite->received_lock);
+		*cci = ite->cci;
+		mutex_unlock(&ite->received_lock);
+		event = ITE_EVENT_VENDOR;
+	}
+
+	ret = event;
+
+out_unlock:
+	mutex_unlock(&ite->event_lock);
+	return ret;
+}
+
+static int ucsi_ite_read_version(struct ucsi *ucsi, u16 *version)
+{
+	/* The ITE interface does not expose a VERSION register. */
+	*version = UCSI_VERSION_1_0;
+	return 0;
+}
+
+static int ucsi_ite_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+
+	mutex_lock(&ite->received_lock);
+	*cci = ite->cci;
+	mutex_unlock(&ite->received_lock);
+
+	return 0;
+}
+
+static int ucsi_ite_poll_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_ite_process_event(ite, cci);
+	return ret < 0 ? ret : 0;
+}
+
+static int ucsi_ite_read_message_in(struct ucsi *ucsi, void *val, size_t len)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+
+	if (len > sizeof(ite->message_in))
+		return -EINVAL;
+
+	mutex_lock(&ite->received_lock);
+	memcpy(val, ite->message_in, len);
+	mutex_unlock(&ite->received_lock);
+
+	return 0;
+}
+
+static int ucsi_ite_async_control(struct ucsi *ucsi, u64 command)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+	__le64 raw_command = cpu_to_le64(command);
+	int ret;
+
+	if (UCSI_COMMAND(command) == UCSI_PPM_RESET) {
+		/* The PPM handles reset internally; do not write it over I2C. */
+		mutex_lock(&ite->event_lock);
+		mutex_lock(&ite->received_lock);
+		ite->cci = UCSI_CCI_RESET_COMPLETE;
+		memset(ite->message_in, 0, sizeof(ite->message_in));
+		mutex_unlock(&ite->received_lock);
+		mutex_unlock(&ite->event_lock);
+		return 0;
+	}
+
+	mutex_lock(&ite->event_lock);
+	mutex_lock(&ite->received_lock);
+	ite->cci = 0;
+	memset(ite->message_in, 0, sizeof(ite->message_in));
+	mutex_unlock(&ite->received_lock);
+	ret = ucsi_ite_write(ite, ITE_REG_CONTROL, &raw_command,
+			     sizeof(raw_command));
+	mutex_unlock(&ite->event_lock);
+
+	return ret;
+}
+
+static const struct ucsi_operations ucsi_ite_ops = {
+	.read_version = ucsi_ite_read_version,
+	.read_cci = ucsi_ite_read_cci,
+	.poll_cci = ucsi_ite_poll_cci,
+	.read_message_in = ucsi_ite_read_message_in,
+	.sync_control = ucsi_sync_control_common,
+	.async_control = ucsi_ite_async_control,
+};
+
+static irqreturn_t ucsi_ite_irq(int irq, void *data)
+{
+	struct ucsi_ite *ite = data;
+	u32 cci;
+	int ret;
+
+	ret = ucsi_ite_process_event(ite, &cci);
+	if (ret == ITE_EVENT_NONE)
+		return IRQ_NONE;
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (ret == ITE_EVENT_CCI)
+		ucsi_notify_common(ite->ucsi, cci);
+
+	return IRQ_HANDLED;
+}
+
+static void ucsi_ite_destroy(void *data)
+{
+	struct ucsi_ite *ite = data;
+
+	if (ite->registered)
+		ucsi_unregister(ite->ucsi);
+	ucsi_destroy(ite->ucsi);
+}
+
+static int ucsi_ite_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct ucsi_ite *ite;
+	u32 cci;
+	int ret;
+
+	if (client->irq <= 0)
+		return dev_err_probe(dev, -ENODEV, "no IRQ provided\n");
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "adapter does not support I2C transfers\n");
+
+	ite = devm_kzalloc(dev, sizeof(*ite), GFP_KERNEL);
+	if (!ite)
+		return -ENOMEM;
+
+	ite->client = client;
+	mutex_init(&ite->event_lock);
+	mutex_init(&ite->received_lock);
+	i2c_set_clientdata(client, ite);
+
+	ite->ucsi = ucsi_create(dev, &ucsi_ite_ops);
+	if (IS_ERR(ite->ucsi))
+		return dev_err_probe(dev, PTR_ERR(ite->ucsi),
+				     "failed to create UCSI interface\n");
+
+	ret = devm_add_action_or_reset(dev, ucsi_ite_destroy, ite);
+	if (ret)
+		return ret;
+
+	ucsi_set_drvdata(ite->ucsi, ite);
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					ucsi_ite_irq, IRQF_ONESHOT,
+					dev_name(dev), ite);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request IRQ\n");
+
+	ret = ucsi_ite_process_event(ite, &cci);
+	if (ret < 0)
+		dev_warn(dev, "initial event processing failed: %d\n", ret);
+
+	ret = ucsi_register(ite->ucsi);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register UCSI interface\n");
+
+	ite->registered = true;
+	return 0;
+}
+
+static int ucsi_ite_suspend(struct device *dev)
+{
+	struct ucsi_ite *ite = dev_get_drvdata(dev);
+	int ret;
+
+	disable_irq(ite->client->irq);
+	ret = ucsi_suspend(ite->ucsi);
+	if (ret)
+		enable_irq(ite->client->irq);
+
+	return ret;
+}
+
+static int ucsi_ite_resume(struct device *dev)
+{
+	struct ucsi_ite *ite = dev_get_drvdata(dev);
+
+	enable_irq(ite->client->irq);
+	return ucsi_resume(ite->ucsi);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_ite_pm, ucsi_ite_suspend,
+				ucsi_ite_resume);
+
+static const struct acpi_device_id ucsi_ite_acpi_ids[] = {
+	{ "ITE8853" },
+	{ "ITE8800" },
+	{ "ITE8801" },
+	{ "ITE8802" },
+	{ "ITE8803" },
+	{ "ITE8804" },
+	{ "ITE8805" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ucsi_ite_acpi_ids);
+
+static struct i2c_driver ucsi_ite_driver = {
+	.driver = {
+		.name = "ucsi_ite",
+		.acpi_match_table = ucsi_ite_acpi_ids,
+		.pm = pm_sleep_ptr(&ucsi_ite_pm),
+	},
+	.probe = ucsi_ite_probe,
+};
+module_i2c_driver(ucsi_ite_driver);
+
+MODULE_AUTHOR("Edward Blair <edward.blair@gmail.com>");
+MODULE_DESCRIPTION("UCSI I2C transport driver for ITE885x USB-C controllers");
+MODULE_LICENSE("GPL");
-- 
2.55.0

