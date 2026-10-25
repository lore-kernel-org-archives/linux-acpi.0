Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896529;
	b=v8bhymKuQgY/xPcVbyehOrfQZH5FlVK22wDiZAg91AsfxcprS0sWWDhJtxo9ZK7eX+cg
	 Ay/3Fk2TjDpMCsOOx/+eqZSkXWfWlXV+DDwoafB6D4Lm9I2RmDY/rblVmxtAxlKAhMSkK
	 vIa+LDmo+EtVZ2zojPNQ4CH5WqpJLrPcZoFU9q/9PnsUeTV1L0C1IGcAAY3xt2/RpjV+0
	 BRVfleBAGqS1f82Th+V+7u+aCrB/cqD88tJVU/pw8rshX/deJSkmOwxPi36Wd5lNZXXTd
	 PFYiFvgOTtVMtjtPhhXTgWlRniH+VRUNuSFWOj+zIxSJNXmfFazc689X921m1jlh4mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
	b=WR08BIRtqMarmxOuwJts1iZozPc9tMnpd3lYKWnV564DkpV9CPN3KxLKv0ucFDvttnLY
	 In/CnaShtf+JXvQrIoDrIZQ91R5gkcfwwB+8S18USJeYhcQJA2IqNJVIU5FH92gWQAp+T
	 r/IHqiyUg5MPvbpGoH8e0CcwXayvOAsO8KC2V43IYuiWaSIqtAFyQO4Z8K08vI6z767lh
	 7hHebhYMOLjZGvEyKbt1ydYUbheqEnQOnqOiaKBGjr9Kg8o3DWH30QiI1YZ6MLlK+wQvj
	 oQ3fhjqVQp5trxoNaML9wrjIAuioTMcu6GPMZS5aEKcyGEx4aJdA/u7rkw5qZLCR3sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659BD606A330
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659BD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3384200eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896528; x=1793501328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=TpxwA813+P5znsifZUJ8deji2Cfy3YNYm07xUH+eLP83aZg54OT8spSktYMe6uqGRE
         iQECHez5gjvBbx6xLGeVbfT8DSZ1k8Qt62vdK8EaDhI3b1+wztqIkJbaJlCtnuCA5esL
         QRH/IaQA0IS4/4rwKKtRZShp/VJZY5B2CGAQ4+oQP9868SHQzHcsRMqbIUIJIrKAZ80n
         lruFtXxmDd9FsV8X+PllJ668rF3ZZJTTNnl5/6dcw99NfAg8N0Yo5T4C0J1RuHQYX1ve
         +cFbn2eSkjaZFV55MBT+LCMMz8FPEg4aiNN52QkcwWnlvHZrZ4/6zCg7MfQQ7POzh5gG
         lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896528; x=1793501328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=FtyAkmseJXJYcFXYenVtTSfqpWibIE/G3j/VSqdafxpzEJ5qt20Hvv6R5+TKUxv9wW
         g1bd10CrPHBZ5vHYUxJGIuOk2PZ0Ct2sNQo/tFyqypLJqVO2BIb0lizx0oC4COJRfuT0
         WAeI8Iyg+eDc/sKzHz3WjtR6/YeBEodPOnqJQ5fIVhqFgyXz6L05ErRIaunoEzMSl4/0
         AwnYIyJPKfU3O4S7ED7VH8IjEij3g2e9YO5toZEosZbWJKa+UJxEZE7vQwmoSM1f4Bgz
         EPNwQPPvk6HSxCxtxrjmuEoSzuJnnjVX5gj3SreBMPlG3v54jLAyYwczPdho4TbL7z3H
         Bvkg==
X-Forwarded-Encrypted: i=1; AKwUvBwZ+QHEE+7ig4lp4HuMsRChZocvVblCel30IPc4bso1gZS0HNgWdwThAc9pSF8rXoZlOip6iHrUmkbE@vger.kernel.org
X-Gm-Message-State: AFq9FYIN+cF8IrJf6H1FVPpMVJOqVSvXgkhbaOZHN70sG73Tn79Qi0GB
	zxxdQrz3BI9L7bo3CZO9d5NkTdaacZNkeTo/hyMjhmy5cQm7sekRvUsY
X-Gm-Gg: AYBFou2q1cy+UVvrF5aNqVkIKmMYM5PKAJMpOgmCJ2BNgh/NJaFyX6WkjtL9iAuSI0v
	epzA9b0HVno/zp0sSA7ZRyqiYz9MG1zY365elBKX90V5kJKVBjek6x3ZV/kw4XC3n9CGl6/w543
	3EXFcz4+X5amORmTVXUMrWEHZM5+6adXNAv6hARMST3NUZFkZaPdb/gjfkQyVyy5qkMHTrGLxFl
	dI6KEc/SUP+QINENPNt8Ht5S2nfDgvsrH+oas/Jl6fgp7YUDhFGkeL259hzNOgEq4C6I+T733HZ
	peju5GqwYOjXa8DxkjBtuO1jVZd3fM3p6On8jQ++oi+LlnkMZMw4ttIVM506Dy05doKZWWRPo1E
	E48HhBc+YyPzeK3ALc8KPwidCV+O6DJd4IKdTGwz8k5el3lMBiYPBHNMsob8Re7SaGEXm5Wru9s
	bcJtYuu7QtIBZuavUJaK8VaTn0WyngM13kzBXDY5cKgNY3IJFjGobD+HRGpWYa34qUDhKO8Wdte
	dnRJulYDD8l/X2LnrjUQL/2yYnwpiQL922TrrHO/zTdsr90RoUZ83DN72wlUGxe/MNU+uwibLW6
	zRuT4TLKuHNfR5Ii670L5Ui18RLlR6NH4sir6sUmEow=
X-Received: by 2002:a05:7022:1087:b0:17d:7b45:f905 with SMTP id a92af1059eb24-19937025befmr4633321c88.31.1792896528487;
        Sat, 24 Oct 2026 19:48:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:41 -0700
Subject: [PATCH 1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>
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

Pass I2C_SMBUS_BLOCK_MAX to i2c_smbus_read_block_data() in
i2c_acpi_space_handler().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..4acce685457f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -751,7 +751,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
 		if (action == ACPI_READ) {
 			status = i2c_smbus_read_block_data(client, command,
-					gsb->data);
+					I2C_SMBUS_BLOCK_MAX, gsb->data);
 			if (status >= 0) {
 				gsb->len = status;
 				status = 0;

-- 
2.56.0.257.gf7497c7d27-goog

