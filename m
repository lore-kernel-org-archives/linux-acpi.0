Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896539;
	b=h9JogSBF/2qaeWTGVxoyjY7X3WJsv+eBDOyrq/ygL8lG9db9TpanPqs3KfX/wvQsQofR
	 hzRRcB9LqN1Tsh4k1RD0nLnxPs0d1+P8IfRCv/HrfJMq2jeI4CVjtlyyEJnCxNYMPbvv8
	 +wOyrXuz13++2zCxfwG8XnYJf87ib/OkDnLkond2u8CLVXt1gQhuyx3T0tjh+7w9ghcjO
	 MRfRArWyhmAd8vfre3n/EO6DzlFIL2EQ+NrktiW8OLCHPGCUMA0Dj2hDo+XDkxVmzZYSU
	 7a54gy3LcD+8tC74EyiUN6D5C1HWp9pgb2VzpIlvQ6Sfl0loFuEwu7ChTT2CMPGIEGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
	b=WICp69zuiZbB4hgynrnrieasvtxpDdyrLostPTp/VzQRn6uoD3i4HQovm0giEg0EsSh4
	 qS2VvuiUTtcXxYATqIEDtSkByXKQzPxrCvgaMqt/z+me2Pgq99JnMI92/2gGGncnfXFVR
	 LmyBxFndQRxl4U7vH9bYh+5oyVQm+g6FRB077S7LBo7vGbQMEXotUsctdWCZVQEp42MlU
	 68Xksan1x9j+G3qDwt/oNxuJMXbh/8Q4HwVjP5EA7aAnblkiB/eyVPwN4PYBZHP1e6m9W
	 r0uqWMU9tdmnEUKskpExTLOw/YlsujaGag2PX/CFbClWe5NoXV5zMzgLfDuNenBM0zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FB606A33C
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47FB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f036b17easo4771173eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896538; x=1793501338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=KoY+mptHC0CdbSXyXRIQLOUk+sIQ2V8zR/H4vg66uM1mRxvr8C2tagJSF+7ZHnvhXb
         mrm+QXgnkIMNQlrG+qcqoZpD2EjjNBgf7f9tWH1pbJYvt9qCPRW9+uC87jYr5Ky702+k
         AnIyrs+SQfRs/p/9TcI61sYs1h+H/Fsfw++AkiPkMECbrp3cvdsYXqI2VnhX7hkgOGEj
         mD+1RWZQm1044SZN0wrIX9xjwCRD/zU0pUFMP5Gs6Ypw/7ixhIsI0b0kGgurBXqbWMeO
         eC+o04P9a2kRz69dA+KfBCr9OukmHDQDjvSOZdjBIcjV7OxjDDtIWYnbg+PLlF0D+H3m
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896538; x=1793501338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=SR4FOWKqUDTKyrZlm7KyTX9cXAj2m9o0E8FDOLyXbfkSlcT33q8Wo/0fngJbGUx+Nv
         2T2bURCBqoN58AFrUJRprFNji31sQvdKI3xcI1Qvpac2Ux3/U5Eg7oyV8q53C7HzR/gZ
         Nt9bPk+kR89sYiRtX9nXUqLGMj2cdradEYMwXYvQ9/EYiA11ijRWV+0yLClrAlImQh/l
         BBhSBOVs8t4We3raEqH4qgiGqAixBRpiYauTNvBtRs6y0Gp6y6KOAzrH1W6NcqtON/R8
         ph/jCwPlKtlog5vP7DYoSfzzxcedtrieA/zwo5QThsaIpWU6dIjBURLeBWfOTuGEnkZW
         9w6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1KLieHZl9/ktcFBJi0pozuAKlJ27guN1ApNs6tIquaLN3xn1gluIO5/wlKQ2epGfD3Qs2zBiSwqQc@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ3yuCTv8t3TgAEwVUja3NbbTHiB1sj6Wxf5P9LEvRyf03hE+J
	98pCem9TEzOWo9bWDfiKuRQrZXjpBhPMuuWj5XKMu8TUhXPdMKrkECeH
X-Gm-Gg: AYBFou2Bk+NojvwKGZElYTbRSOVTlZQlTZdWIfI26SAYPExgtuz07uOyP2/dEURfgHw
	ez6Ar3xJ6CmggdbEl9FZZbzgFFOYjw+hSuRSTK6/gfmjgoMZBZfDNNsiI82L/T4Ulz932Dx7QaD
	Xv00Dyjb2jd7M/WyGhFVrfWpAyUCUVwpakzw0kvulIaYplRu4g8dzAPcBFcSwyh2oLJAnKb7GG/
	pbkuFGuM14sbWE51XLnHxMm1AowGTs/nVsYnlBhaFv74GUKG36edNiSNT5nTwlPdwDYeRoJPOl7
	xfNGV3j2307z+dKbWFQD6Nq1vXZjE9x/2MPRJYo/+Jq1xLazSiLxY3zSXeFLKv/PHMLK1WxiWga
	g/V0sjdzYQiO1JJkcsTImyz6Ozu1BDHJCCwQ5TU0PK0BEkEYaLfRL7ZroTplu2uTN4Okhjm9YaT
	AdP9FXv9HDpHeL72TTvRZPTaocHE3t2W450RP7Sgmr3nTEC3bZOJHHungkxo78qwZzXGKrCppLJ
	8cqFC0kk846Y7diakbfSl6cqdmDc6vqZAAMhkUGD9EcE0Iv356THhh7EtenTfGbXNKBI4cQimEl
	qiUitRKKIjRsbpwg3ikQxDq+Kj8rIgP7Oa609xYNOt8=
X-Received: by 2002:a05:701b:2714:b0:19c:dd9b:d09e with SMTP id a92af1059eb24-19cdd9bd124mr1585077c88.23.1792896537822;
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:47 -0700
Subject: [PATCH 7/8] platform/x86: x86-android-tablets: use 4-argument
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
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

Pass the expected response length and destination buffer directly to
i2c_smbus_read_block_data() in atla10_ec_cmd() instead of copying
through an intermediate buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 67dba9aa51f6..bbfa040cd4ec 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -65,16 +65,14 @@ struct atla10_ec_data {
 static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
 {
 	struct device *dev = &data->client->dev;
-	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
-	ret = i2c_smbus_read_block_data(data->client, cmd, buf);
+	ret = i2c_smbus_read_block_data(data->client, cmd, len, values);
 	if (ret != len) {
 		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
 		return -EIO;
 	}
 
-	memcpy(values, buf, len);
 	return 0;
 }
 

-- 
2.56.0.257.gf7497c7d27-goog

