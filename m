Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032211;
	b=PwlJP0Kg+NUuP2dw1ehUX8M2wIGYUYcXvttIVnpAoLiE6rbZCPRhxwwnay8qaAiGuE5B
	 O1Q8RdzvkQAvuNSzQrEEJz5id7QVoQiSZN9iEQBQpSoTNwWQBDvNMG4J2FJ337jSSl5JH
	 w190RMtFS7dVXOHKULacSa8e7Wv4g1WDTYOYxXMGonB0BUjfY5Q6RWIuGNUql3CVRvdxP
	 RIN+OrpXIuZZeb/p8R1ok2a1I1SCR+dmBdfdkwqbhKn1NCwGOaW7NdD2VbxF532yWJJHg
	 k6gahcMm7654bsGoZZi7aEyZe6IFPHaK3Yw2IrBlfditsxOQo64PdL+JEgTtqhwYfcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
	b=Z5NX36rBPTRKm4eLkNzJpEi7J8Moxh4+mt2XTYPzEQOuZfDhfu68vK4L0zfzKVT7gQFQ
	 MDSryNrYNPR8w3gRGpPfR7GUmJXUYAZe7T77MZ5v8p86wItlRPotZmOtgRPWdqCHRYw2A
	 rE5fpSx/klw1JzJPIpwxiEcY0CYhk3yaWeDW2Ks4yjDF9CcQYZ5582Xu3tiqGc6Y93gL6
	 m9m46JMdNZ1kMEdUrI8N75jQqlS5lcRuNdMBNw4svBDkln3X9MMCcyDqY7+p+fn8iQ+6O
	 TcQTTVrMFG1/Eoqdu78VS1A+mqtJ4ayPXYo02SArhuZdqgi164gtuSp1EVwepW+rC2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E6sJHw1t;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B7606A322
	for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 16:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F3B7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E6sJHw1t
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso33478905e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032209; x=1793637009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
        b=E6sJHw1tBAsvqO2OPAaOZ4zRxGEFNrhfyRV4UccY4DCqYTK/5vp/KF2Rpd6y1TRL32
         bnC0N3vzhCResvG/ZLiSkstkZhscHtSirKCGrCS0ufltDjZ/zPoqjBJWcxkzYwvmFr+Z
         pwjDRm8v8olP5UfOq95yGIp8t4TuUaNHn9RpbKwkJutYyDmRuBXOyC9Neq8rHil/959a
         0vgZQky+REuacnRiAlhf1MZiaJpJTwhKR7Gqx5nT2gtBGtzLvfrU/csmKXgMlQ+cMwu4
         g3Ur75ApltXx8OVZ18lA+PlQzFF2cgfHHtyaFGuYvysKoRL5Bk4/ImIY2A4ZbMHaAgA4
         bdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032209; x=1793637009;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
        b=STESlflXMwPAqx8kAbGPA7z6khxSvJSmMtBvTmFn702yxI/glhV+UydHQBDAk6j6JO
         mlyuG2Y57ppzNZwrmic+ILm6VICPk6yuz44Qk/0n6XtgyRUGohgZUWF5KYVbYSP1r+gK
         1EuJVeC9tpI8FdW41a29pRyqPXKd4lbHO5NRD3CQiA1iMOqYLlrBPfM6zUgw5lLlkidw
         uclYvOncxYmJecL/pGR7jq7agWYbrx9nUmJzNg6vhF2J7vkSS/663yFg6Y+6vF0MkYqg
         VmhydIE1JnHfXtUbZtGxfHzQLmWDG/p8krsAGHsIWJBlAVI9cU6CJkSIrPkkmbcqakGU
         aaaw==
X-Forwarded-Encrypted: i=1; AKwUvBwzaCCdWxktaF844+0TMmfofoex70B9ER0TArMM42KlvxBvmOn3qk2Ng9XNhGeSlLDUKLqAFHK3C5MZ@vger.kernel.org
X-Gm-Message-State: AFq9FYJS3kdxNgzvVgtCKngnzWJ/PZW92ULNgIIVHUpSX4qWB8g/wuL+
	u5U8V09eZ1QEO5Z2bvJMcI1WTMApL17WQyfiZbP3QtKPZpbdNzKU3eTc+9RxA0m+Bf8=
X-Gm-Gg: AYBFou0oIfBzyMssoReZ8mjVrAi0vDbE5fCgRV4GAPo/oRam9Fk8iiU2xl0DGvFIkFb
	cWnSskDuADy0hVrGjk9xKrl/Aoy7x9J8K5gpKSMg9WPgy3dD3Y3aAJiT+E9eJVF5z7NlJZY2tb+
	lCLcOTUepfp5BMjrUCQxPCk84HbtTeaTU304THLJp8yqJwqYulkVHXWDQfNtSmlN3BE8TvT94fX
	4DAsg9oefh0fkkuavHRiHswxNJrw+yvh45xyAoDCHVdIW4TdFL3iaxO6u1iZsqDSXmelZm9ZwVg
	xynaUiJYLpaArXZKHPYjSyzWIdLS64mJh4Nb6LdFVgUJA80gBsxW2H4rtlmtFdzAfsijxwd12DV
	p7tHnByKmbmgqzI5qEWwue2LPOqT+Wl9kyE0Wk453GSyKWZjwLOfD0kyYZ7RZm2uN8urDzXgvH8
	4otFVZXWnjoH/zlljpNdTx0l6cZw3VEHoqUQBwjdAJzr48onEaaVfQdezFta77ez9IJ0vv31VsF
	2AO1afBxNAqyt3pTdCiHRB5ms9MC2tColgY7wg3TS789vQajVpe4ia3X9bCg8eDKz5pVZnBzSGq
	btNGf/b/3gfx7xe4DQynaWchmYLfI/84Gg7EI09ZAAd/9tMjKjPJIpnqQTHit/A1
X-Received: by 2002:a05:600c:6384:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4a35ac3acb7mr134780025e9.3.1793032208691;
        Mon, 26 Oct 2026 09:30:08 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecdfb8esm17396493f8f.54.2026.10.26.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:30:08 -0700 (PDT)
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
Subject: [PATCH v3 22/22] gpio: Unify style of various *_device_id arrays
Date: Mon, 26 Oct 2026 17:28:33 +0100
Message-ID:  <7a3aad753cd5bebe6dd3f05d72edff398920d1f6.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=j/C3qYFYRthO80RC2ruW66dF5Huy3Fq9N8YWUVYu5G4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33/c0ojVyzZ+u43M0bI2sq6g/5XGn+69FfExb 6JR29ElxDKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/3AAKCRCPgPtYfRL+ Tu3mCACkeeZltd8ipKxsWv88vZPp7a51zX9A/QuTuoijhYbibnTnLrZgZA76jfu63MGJaQJGlqO RZ784GJXMxzbqjs80BfJAWadFOuUNepVzzvkgn3Y+A278UUH9Vsh3Mlb2YhbI7SHJQ3YleBzjj3 0BmtkMk6cPK3D+LwmR74MSGw0vDvjW0UzNI3hbPpG58wgMHfoHv3nny+SevlCB36OXOJ5BbzS+7 OMdumhFuzEkiijn3dxQybyFAvc5crrWIPu8XZmk9XvSGj3b2iMp0/LZ/YXGbHJqMg1xVEcbZTQ3 2HrFm6e6RZWV9HGnGroKYMqkR1OKXTuNCH+/gY3/+9skqw7X
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
index 61c5ca96314b..a540f6e94f11 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -80,10 +80,9 @@ static struct mpsse_quirk bryx_brik_quirk = {
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
index 77b447c0fea5..06f7ad0299f3 100644
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
index 3ab02c5f95df..77b9e34cd618 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -465,7 +465,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "GTCH7503:00@10",
 		},
 	},
-	{} /* Terminating entry */
+	{ } /* Terminating entry */
 };
 
 static int __init acpi_gpio_setup_params(void)
-- 
2.56.0.rc1

