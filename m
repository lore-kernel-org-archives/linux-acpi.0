Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896540;
	b=ewR4ixZtDiWbHaezA6mfH1LR1sRL68OU2lQs9/E++R1yt6VXriJLhhuC5pbrvK8OOZ0+
	 BQwsGsWBkPUQpvFZZ/7aYyDxe/B8EfMvn+n3FtgPCUYD2ssFBGXQm8LfrhRAuyEiV8kfV
	 pPar5MdBCQcM3lrj9m3bk5mO6Bqt9PRs7VF1Xqy5CFfy0brXQ5qKZb5T0+kIcmZ2O/p4l
	 La16NHKMDQWaeA0xyxzWdbK37eptUVNVsGYi3iPhi+8xRb8op5SC6xZ1d1DgrfosCtzHM
	 lez+J1MMjkVaP/H3XRBqWzWRnC/UJ/mjW9zm0GBZITUCVUSCUfV9yv7sDkj1J+5HFXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
	b=1fXMwzUj7RclaqqYxdMW7pz6N5l5dW4SbmopfPqvV+oChQfZxzAAcAz7AgRgyS/V+k/z
	 4tK/Nl6bAm+oBbVpLb4pVv2aeaBZEWaEu9r72NGQLPKxXM7xpTEBaaQJGkHrmgJyFUW4J
	 c/Vpx5WrtF57RCyTFppok/EE7Cbzb0HpPqMpg0J9TkOInjxAJvIn17UZ1KEMf5SSqVZB2
	 qWbS2jDNdeKsKaMQyS0Ks0XOfWbluZyoMOtDlx8g8NviFhzdj0gzG4m08H/3O7SGCYDPf
	 u1criDQv1AlKRCS3tMDW4pO+PJiJ8G6RiWGESZph45xw5NlzKmwILO2L8tw8iT4uj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C69606A31B
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C69606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14fd9dafb0dso1595242c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896539; x=1793501339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=MRUtJt7Gkp4vafFe0rMwqOvDHoXxAMNyVJYKgIxP6STY7JiEtaQfRGX4Bfxa00RzZd
         LL9z7cyZsOY/4U6jo0Y82ZKnYeZ1xnNi4d2t5k2uSo3AfAtxKMndyfDNAgGYy05aj8O3
         +NOHRUj7mM7v7fo+STYhhLtoX7v3SUKlWkXZeFFQzfGnr+1EFv7yXE1lbrNRa/fILIlL
         PH4YGconi0OlzRG16TfoWqLahojfLcD9IiRsXiKBSsaWXiKATHLwZ+qecfhZ4HPZyt5D
         pN3gc5vWiZm5akOtpG9Dj9qY7/RqqfmML7d/xeFrZiipH2FEafl+aiMOHS0bvZbGQNJD
         kWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896539; x=1793501339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=BoQU752I/6zZEDoSnMsmz1YrDhZgHUuO1axik/km4GbomIa+OAEsmFwjGfMfPPKHPS
         Jig0iRkzo3XQK8P3L/sFoJM86gyn2cOle5ky2jeTFVwTvRo9TGz4UaXCw+XlTNYx9orS
         P89UtbPRGUzff0BY5cb7uQV6AHZSPssy0ms26NmMFwDic7k260RH/S/y3NKgGuF6eS1h
         fZ81DJCHIJzy7vGQiiTG785cGcZTe0NBqmlFxn106PN+LHuBf13ixqG2uY4SI0ELGx0X
         dnWW7t5s30n10Mj2bt29tLf0NpoLpaBAom3CPnwecHkjcmLpRHzBmmAwuy8nqqZrO+XY
         R9KQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6BtdmcdT9MlBx/wR7wINoj2AAO5hP8ftpZY5GVqsJ9zYcFwiVADnXoA+nW/PS0S8uF6OcCMQf2iLx@vger.kernel.org
X-Gm-Message-State: AFq9FYKtAQGal+nbn+yr8m7sGmk9K40jyGlv/u8CJGxlX6CY3qo/qTQY
	aOgKmRKfO8WhcL5Qr7RLNqv8vdBXL2W17W25eGLVfB5bElXwvsmcEwU2
X-Gm-Gg: AYBFou2GK3ywb+xmgszbEQmZIa/GTRkPg86ImACeEsp+TOoVA09AnP1Zlvvb1lBnP4G
	2P/ktzDh1p0NjTQW2uKAUtqkLrKVWPDwVxY12r3EFAYloQ8HLuvCO2exJEZIA6UI8zGZTOIigLX
	N2t5ftcqgeB2hdy1QJ4tb/uD5g/SoUhKJRivOGF3W7XqOkXsQu5Roctb5MdaG310PXYN5itmzWj
	/RdC0FH0V0YYXMCeaGPNiWV+foSBv01qCFQX2wMxArUTmxZa1GvpyHWUy2uMBBp/DsUnEGca6Om
	cXAswRxHk6YFy4rNWc2sOXXCnM1WM6orxsQiywbjF+jmPtNLiLhV+ZUHy2f8M30mQaoHQWvA/Fz
	02J8dCZkgjEHFYSP7cV/nlmPVtpRGu3NsfpfcrACiRlVAi7GL9Eqp47FC+SmQiOzsvbUhXn7JaU
	hivR4U7qmmUTdapV7bgm8UveDnA2AMWT1V2z4DMZFHWtVji0yuG48JSDV9AddMaSAR6gYdeSMq1
	LmPwZgQkFx6LH6m0WoofaZKIBj9WnYeFtFveyozWG832EAVxmuiHUIRyxJVKENk4R4TSfVEs6yC
	icCVgQa/YtsKtWI5CJdOashvG+ctOQmg9WSfPXzifnw=
X-Received: by 2002:a05:701b:21c5:b0:194:b2e5:473d with SMTP id a92af1059eb24-199298b3af6mr4872191c88.5.1792896539394;
        Sat, 24 Oct 2026 19:48:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:48 -0700
Subject: [PATCH 8/8] power: supply: sbs-battery: use 4-argument
 i2c_smbus_read_block_data()
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the destination buffer size to sbs_read_string_data(), and pass
the buffer capacity reserving space for a trailing NUL terminator to
i2c_smbus_read_block_data().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6714313bb3a3..f8b194c58a62 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -424,7 +424,8 @@ static int sbs_read_string_data_fallback(struct i2c_client *client, u8 address,
 	return ret;
 }
 
-static int sbs_read_string_data(struct i2c_client *client, u8 address, char *values)
+static int sbs_read_string_data(struct i2c_client *client, u8 address,
+				char *values, size_t size)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	int retries = chip->i2c_retry_count;
@@ -440,7 +441,7 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address, char *val
 	}
 
 	while (retries > 0) {
-		ret = i2c_smbus_read_block_data(client, address, values);
+		ret = i2c_smbus_read_block_data(client, address, size - 1, values);
 		if (ret >= 0)
 			break;
 		retries--;
@@ -709,7 +710,8 @@ static const char *sbs_get_constant_string(struct sbs_info *chip,
 
 		addr = sbs_data[ret].addr;
 
-		ret = sbs_read_string_data(chip->client, addr, buf);
+		ret = sbs_read_string_data(chip->client, addr, buf,
+					   sizeof(chip->strings[0]));
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}

-- 
2.56.0.257.gf7497c7d27-goog

