Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA34BC00B
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134594; cv=none; b=rn5ugkiHw67z91aQ2bgeYr8/Q4795RiH1cFtMX4hvtZMrKXngdSmY4I8TBGmQHoQ59uDbAYs77ctza5Sh0xLhg7T1wwkXSTM9wmswhqx54sbsP7fTfeg34wWa8QzjRk7hoZHXfWLomacrVHu/TyIQ/+GvKx2jN4mIOEGvfOvcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134594; c=relaxed/simple;
	bh=qeMqNCPR4JZWZmIFkke1fRMQtsN1pMrftafnXla94ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+A4h2FJWGIT4c+gjwi3U7bFEJNySOl1aTmBq5L4tBBChbDnVG5V8NhhyJysjv5uHSSoPPvTW6NM9aAdDcHkL2hSiImxagJ/04aevEdyqqt4bLqA2JmWVNqH8y/lSo4SlOEqy6SoNtr898hFWTyH1HXQ+04J/XBgnL58knYmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Dl6D7QSB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Dl6D7QSB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2115182f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784134591; x=1784739391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YbKISqvDXzDxXFBLILdiprJK/dXdWku3hILu+bMdhE=;
        b=Dl6D7QSBJXz0wwLN/j1UJisnYjrNgkYUb9bNiSA+MuWJPuQW7tcFHi1pytl2DOsGxp
         A5f5ldhAEPaPhbclexDzVV1RAtvWMqlYxY3OQVW1PV1lZH0PKkYupkYxLCN/csqEt9n4
         kcv+GdK37iEE+V8QRTuc+XAFm29Ivb+15Ws+jf5lqCU//6OE3Bs19kTu5fWQDm2wzpoc
         WYscaQd3CKXgzQMFvZWSSEeRlsPy7hXu15SIowrQ0RQ0ETyddWqr7L6nQFw1zdFnqJYB
         Jdh+hGGvhCd2qXiDzu+P/wPoEwPrY5Nx3g0wMPyd4mYzo5Zc48zPxHdL/Yf14oZz1EeG
         lTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134591; x=1784739391;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YbKISqvDXzDxXFBLILdiprJK/dXdWku3hILu+bMdhE=;
        b=Lf0mR+Xj4L92Hgiy+sUcGnK7P7qT6St3Tlo5YK2xm2g2SPnKBz9rNGEjCSI0rsam10
         QN7zazz92EzM5O+wGMIhQScS6hVnoDsxU2UC1NBqfuuFYsBaaZ4V1OUXgkp1i8SO4FsM
         P3QsJZGY9MzuvZNJSmJsnuY1D03j1VOGKFM8W4JsPGN9UelvnnZNe5alkbz8GBUVRPH7
         fHAIpPc64S2wCdD2aBaE0q3tSeHIEwlfiaMzntXd8kM5FBS9rzstSbE5Hk0wOalT6M7B
         p+yrCW75z70D3rKcdi5wsnimV+qHXnpRUNrsr0vc9f+n6R6w9xnj+2PQIRRibYvIJBj4
         2PJQ==
X-Forwarded-Encrypted: i=1; AHgh+Roz4K1jd8REk7TcT07woPxQ9DRGAyMJ54DLQ68sY6CK0OdvBzSlIJxDn/rDM0+Q9uZ836HJMK7lPHEi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxos+NzFRTSGW/tLFTeWnd4lsatfFxv2G1WgTt223YFi4nBY9l
	UCfDR2keyMSxQnOg961YbHdP27kY08myC6Uv/heR2EC4sL6se/wndTZp9BBwAp+menQ=
X-Gm-Gg: AfdE7cmyySu491NbKrrlp3bxqs2c9wNXvPWN4g7UicfOQhs06gJyKaeHgcmzYWbj4Sp
	qQPquhUyzlzLNusqRnfpIhH4tlFR8F4yNwcj9nqEhK8vCJ0wxUncSpSg9rpoKe703b2HW+6VuAK
	f4i7j1AoO+CYdOMaIEjS3eNKIo1ClJU2qnklDtMonBChtffCcmT6WAaApEnkz21TQBg0mghGeTI
	rrY5x856ciP1iqI7YsA0idpIvKdOklkcq9hj0fSaniuf/aBChRITvzXdrAplXCLCS76C1UO/5rO
	W+56i4NIkBiurkZ3OixRQTANt1M08liQ7Co0c5/HDgrurRw+mO2/jovV9ieHpZGSVlIMHbejfzL
	f7hoNpmNSywjw3rX4DW+M+lvbYlERkLMmTiD2k6i/Pi1ou3x2WuiAf+xVnadGAaSkj/NA1Mycky
	ZFeUPeV6CVIZEh5lsNnDQVecPrM46W84fhyFVHVwZkWlAIX23y3vIU1lXbd58k8SB6BYnogSLHz
	ik=
X-Received: by 2002:a5d:5f45:0:b0:475:f100:35fb with SMTP id ffacd0b85a97d-47f2dd42e56mr22174405f8f.56.1784134590979;
        Wed, 15 Jul 2026 09:56:30 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f464d6fa7sm17882394f8f.37.2026.07.15.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:56:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 21/21] gpio: Unify style of various *_device_id arrays
Date: Wed, 15 Jul 2026 18:55:26 +0200
Message-ID:  <74f18045a53d99047c5c2cc83d970b5b429dd14c.1784133987.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
References: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qeMqNCPR4JZWZmIFkke1fRMQtsN1pMrftafnXla94ZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqV7uch2g9AnBq1MR+kOpC5ck2xFfv/uUZWPUsd dNPkiBW/PqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCale7nAAKCRCPgPtYfRL+ ToM0CACLAvIimVfXS8xTho2bAKb8xdVegyIEW1xqvduBfKnWYNQHbpxbenrwDf69EjXN9Yp3/Ca +Mg5ERVlDCQemWelrhbq3sq/MCemWG2YnPB6Uqo+96bx4RG3YUzxi0poqp8VHZqjhETsBmvbbyP r8rKwus6aIFV6pbAm/f4BE1MhP8yxnm3TEMvUpUK28jcJxbpCIT69TKqwZGnrM4V7sbC4ClMtMA UJR9JO5nFu9Pn+bp/5TMBiJX6+WvokZmkDKNgH1PjKl0qX3MI6L5WZ6daFTkkFlCR54I0lQF9JL qEMgBzYaSdfrXDpvYi5Zjbtttg7vqYMoTs7wtT2QKc04sGzb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Update the various *_device_id arrays to conform to the most used and
generally recommended coding style. That is:

 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - no explicit zeros in the list terminator;
 - a space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the few offenders accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-ljca.c           | 2 +-
 drivers/gpio/gpio-mpsse.c          | 3 +--
 drivers/gpio/gpio-pca953x.c        | 2 +-
 drivers/gpio/gpio-virtio.c         | 2 +-
 drivers/gpio/gpiolib-acpi-quirks.c | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index ad5dc9a3a119..d9d7394d8b95 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -473,7 +473,7 @@ static void ljca_gpio_remove(struct auxiliary_device *auxdev)
 
 static const struct auxiliary_device_id ljca_gpio_id_table[] = {
 	{ "usb_ljca.ljca-gpio" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, ljca_gpio_id_table);
 
diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index a859deab2bca..7ca06bdb2c4b 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -77,10 +77,9 @@ static struct mpsse_quirk bryx_brik_quirk = {
 static const struct usb_device_id gpio_mpsse_table[] = {
 	{ USB_DEVICE(0x0c52, 0xa064) },   /* SeaLevel Systems, Inc. */
 	{ USB_DEVICE(0x0403, 0x6988),     /* FTDI, assigned to Bryx */
-	  .driver_info = (kernel_ulong_t)&bryx_brik_quirk},
+	  .driver_info = (kernel_ulong_t)&bryx_brik_quirk },
 	{ }                               /* Terminating entry */
 };
-
 MODULE_DEVICE_TABLE(usb, gpio_mpsse_table);
 
 static DEFINE_IDA(gpio_mpsse_ida);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 918cadc2db07..7db33477faf1 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -175,7 +175,7 @@ static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
 		},
 	},
-	{}
+	{ }
 };
 #endif
 
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 42871db05ec1..062c70fe4671 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -647,7 +647,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
 
 static const struct virtio_device_id id_table[] = {
 	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(virtio, id_table);
 
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975..7c5817a3157e 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,7 +392,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
-	{} /* Terminating entry */
+	{ } /* Terminating entry */
 };
 
 static int __init acpi_gpio_setup_params(void)
-- 
2.55.0.11.g153666a7d9bb

