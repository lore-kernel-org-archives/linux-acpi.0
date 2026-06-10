Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C663F0763
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102627; cv=none; b=tWNuONUKMar8xjHrCgh0hDZLnWtFvk93Iv1CZq9M5aBufDJfKP9zoIPdtOw4yD5OZpjNWv8S9zL/qfFMCEKzhEpMfXjeo093w6p3miC4+2vX97E+eIc2lpmkPCdqAfA6Zvi0UFYQpfUwyzKWg3URPUTItfb1twLP2NmYa+HR1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102627; c=relaxed/simple;
	bh=BIcQVW3NiSa4TcafxjnWIVFTTD39f9kj5LoYad542co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mi/9fXvauppCCKoslnSPouJq15N713LxH48jvl62Qa9dxzUmc9Lm2D+Wngjgqz1RzB3/JUbDsFpB4OayaepB7hqSQUBfXa0hWclcfBkUhNGVNKg4W95bOzeZxPUyeYppwk2mj3QfzBNimi4gPINRVknQV9UYE6BImB9AkHqUkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HQ8GJvoC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HQ8GJvoC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b613a17bso67483235e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781102622; x=1781707422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qY02gV7602O0gl4IDv3u7HeBHwsKtV7+RuTCrCnSkG4=;
        b=HQ8GJvoCqW9Y28HpGLoPoM0zk3pu53YFSyS/K8N2zXljq2++Zs7/e5iEi95NL4MMwN
         9Kvdm2baTkKiliugvRrcmicDEQ9DgExwjoqe7rH/yov5Ydw/vWKT+x8ONdl6sR3tocrg
         92MwjNmc7b1tISmvUfD3wRwuOQN4D5bncYIcqCxW/MGmywUP7uSFJ/WRmcv5h7UV4s/u
         9KNx/ugW0ghOD9uOQcUNpDEgjhUB8NC/1NPS8r6+R9xzifpA/xXIIzr7rduTZM905Gw/
         F3Qd8yAFnkuGrnfrafHedsptMuyD68GJEXWmsaSfZ6mbKIUr0gWdoK+em5ZcpbU+qoLj
         +YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102622; x=1781707422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY02gV7602O0gl4IDv3u7HeBHwsKtV7+RuTCrCnSkG4=;
        b=VH/wgcNDcC3ajsrZuegcBeAjVB3tl0KbqS2vdVLYQiRfWmd30A6uZqxYicOLNN2Psf
         5TXbH4pgjGpI/DaycKbzQuB+vdIagRsRId3IWeXmEz91S/7K3sexmUlQ3U/oSoNr1LY5
         eJ8RDqbIK0Qrzgqr1DRbuc3+FKR86XkncQQgvRE7OVxlnoz+/JVbVakEEYbKQZHL/ckk
         hs8m8xSVdKqgE16JdYDMTcgSiOAJVqiPTP/6mgDkNhIUgkNICxv7SPpMCgXnWMCBmV62
         fYP/Eb7nCyaYGJ3XgXzrDVBH+ach+MtsZgT2d183NyRLWJGj/FfMFr6g520yTlucNRwd
         gKbQ==
X-Gm-Message-State: AOJu0YxGVUXqxjXahAhI+CfTl/MrR97yGejM5XNsV4np8NcfbDVs82Jz
	iMfmAu2eadTUtCFhwaGBjfC+lQhaSQx4abivyh3X6w9LJ7l7Ra1rUdLOkiVh9xjLCYc=
X-Gm-Gg: Acq92OEhPEhaEQyGWBJD1h4zMNVWSy0tFRr94lQrd14QLySZ+cTQF3DwyoMv/iE4YLv
	CtCHGXSQ8sl3lFl9hHWE92Ttz4kJjbUwM4PDnSIlhJs9LcEYoDdDONnqk3KYqZJcp/KOnOgwSwM
	SI66QyGB+6xDj6p04ttM+9bOWsqPh2ilDUrekLeLHswTZtgkXSuXFg4p6mc730/j3algbuG2KJ8
	rpteNgAcr3mP5Ngyd642W5uKRP0tkXj7Fo8/Ov7nATV+3+VsODtgny80jIqNkSN4kI+h5/hH4B0
	Hpy52FdZzAMVCYIAJ1ZcE4KQkJe+YCUbrQ4s/SwSVQvwWVzkoApmA5KNEf4y5Z4Ei3B2Hg2MnXU
	9BpSsZA6izrrqnwkcYtUMv7/AmRlgO75nqBgPWh6lZxhgFyu9SF43aNaqQhb1IEhiq3ZC8R/6aG
	Zi4tpPt1iP+GYXIQqLWj+ZqFowidxxWWPJGOGTxCyVtFzwI9kwJxFYmkyq7ihLyD/U3Ok+qvIgc
	EC+7tRBUwJ76S0Q2SC5mmAr6A==
X-Received: by 2002:a05:600c:5250:b0:490:b642:ce2c with SMTP id 5b1f17b1804b1-490d720455bmr91689645e9.14.1781102622450;
        Wed, 10 Jun 2026 07:43:42 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc3cc0f8sm561381805e9.8.2026.06.10.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:43:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] PNP: Drop unused assignment of pnp_device_id driver data
Date: Wed, 10 Jun 2026 16:43:33 +0200
Message-ID:  <0484b30b6935994f5a2d97c55a47a95e1557dd15.1781102535.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=BIcQVW3NiSa4TcafxjnWIVFTTD39f9kj5LoYad542co=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKXgW3adRqJ0h7MWGUHU/D9IdljhxJXHgfMs4D KEUCBQDnSeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCail4FgAKCRCPgPtYfRL+ ThrhB/0Sq1Ehsscq8Wlvy10qsTIk+ngwIpnpntSCI3nxzNRYa5FnevC8PEKl+c6Tgsxg2Doaic7 4gOdicglOm1UbIVgKi5vfo2yrbg5fnyL+O3i0fnGsywgbu1l70W0nn6vxqeFME+Rz+iAzOyI1rG ZxL7ynaYdLMWFQE/DKZW5QypndNN8TZXHqGsJduyd17qTuLjjdBIyRrHerFt2YYIHKNy9SOnFZG YE6aGM007grt/PpN7gm3ASZjBN3bq3Q07RQuHxuYzpPy9n2xyhEwR04jIDImM2fuSciszo0oyMD ogNg6et6Q6IR+38NfB1hNtNPhuGmifeqKjKPi+FJ+Psu3JUZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver explicitly sets the .driver_data member of struct
pnp_device_id to zero without relying on that value. Drop these unused
assignments.

While touching this array simplify the list terminator and align the the
array's coding style to what is used most for these.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with builds on x86 and
arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I intend to change struct pnp_device_id and for that it's required that
.driver_data is not assigned using a list initializer. Instead of
converting it to a named initializer, drop the assignment as the value
is unused. So this is both a cleanup and a preparation for a later patch
series.

See
https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/
for a more verbose description on the mentioned change to struct
pnp_device_id (though this is about platform_device_id, but the idea
here is the same).

Best regards
Uwe

 drivers/pnp/system.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
index 835113b2cb04..bd939b564379 100644
--- a/drivers/pnp/system.c
+++ b/drivers/pnp/system.c
@@ -17,10 +17,10 @@
 
 static const struct pnp_device_id pnp_dev_table[] = {
 	/* General ID for reserving resources */
-	{"PNP0c02", 0},
+	{ .id = "PNP0c02" },
 	/* memory controller */
-	{"PNP0c01", 0},
-	{"", 0}
+	{ .id = "PNP0c01" },
+	{ }
 };
 
 static void reserve_range(struct pnp_dev *dev, struct resource *r, int port)

base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.47.3

