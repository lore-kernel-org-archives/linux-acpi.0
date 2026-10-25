Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896531;
	b=qRIaAMuAlbTBzpGjXhFjEjOICJsdjJqtNgF2iW/IKvVIqQ2oAGf+J7/TpGa5FazxbBVt
	 6lugszFO55GihPx592l+LHr++EqbkDFaHLHIMyG42rUTm08dnz2J/iebWDAxHtLFLgH28
	 8VK2IjGLvYOYX2A9IIQYWDTzzVEZ2PvohpuqHPkZxsshzvnM+wBFdyANnWoYiICnZxV7+
	 TLmOka7wHbjXTU2LD5v04u0+0KgPkVODM44m4bg6db2n0QiO0/QcMTS0qc4ohU08yGmoS
	 EUF9PTE7lHv9b996BPbzh7UBuPgy5o5KA6enSL4mVh2xZyRu28UNA5cHqbKGuXYd3IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
	b=1YnwXIVfdhqOi+HXWV2KBhHQjkf7x0C5LxX1HbBL2nRmgusEGOP8V19v6bBj+9X9uT/d
	 /XBTLJ1MbC6cfMaodEDIaR8Q0T8zv1Cx1tpxgkF8YbN7Rtq/bIGVkPCRVJJiyLDF/xHRT
	 PIX29U9Ioa6qQI32aIJ84rziL7JZQX2z5hDOBoEOKijqBOcDw+hkqr6pAPHn1myf0ZEpI
	 pYtqvO6/0s3gHIpBYp00Ipo3Ijo78iYcsIehicK1LthSEQ6wkuYeKSkylQORYIVLy0hXT
	 RC0ByD4HIP9SzrHcaORSK7zukIoy2jL/astC4txXmiorubBP6RcsWc1yDOqx596k/HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55F60A260C
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A55F60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3281702eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896530; x=1793501330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=D13wWGtzDrlBw9Im7u0R1IdFHg4wNG1163II6ub/nPI2fH0oV74hQzstoAqgvSxI+0
         myknq9Ug9x38jjUUZwY/vyXKIDGMNo3ZKXP0bAWsSPufchByNmfUqbjLR9h5DiQc64wx
         b41VuTc+OHb/42Uk60MIIq5H5njnW+qeWoLqYxKwISqmgf8YvNXxGq+BL+Qjc6HvXh7N
         0UFuKY7bms75KP1rs6qbQXAEM6K6vURDSsJu7wqzwbTz0/lIFC+uDNdCBWcUI60PHNnA
         Gm3DGTK35BKOy4/WnhcBiampzvbAyAb4nyB/WhiSNzemLHUAH++XTonf9uwlP/Mvv71a
         ZGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896530; x=1793501330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=gGaj83bzOWVSPRluPyWdSQg2Zlq3NxQx2Qa1pSFz4jwr2xev9LfOYQA4SU8oiukXCn
         NPKdxZjNKhx77o5wChHU44wV/65NVvqCW5USyeUUV6ZKa1tJde07dbO8TbqFOjo92eF9
         q/XsBtwgY50XqQWp1uRYGyGyJkppm8n+arzn6fT15vmhFKBXpgUmt1GAZ9ij04B5EC5r
         6DqJOg806iaRBPeWF0Ycy0l2wBE8GXgzJihERVvM1dLWjkKb+LdbDglTPLgGJgnwK+Tk
         ZA8WhsfANPNj05slKrAx80iAuMuYe1vDMKqBQrxlGMwcwAwb9rmVrHV1ae8YQr6E75n+
         r1IA==
X-Forwarded-Encrypted: i=1; AKwUvByYb6DDNPbebDKYpz6UYsTpg62uBWXzpQmk5U7x2dOAivfoVN9gqmOz8G5EXMxVH5LTX+ZS8rVxCtuB@vger.kernel.org
X-Gm-Message-State: AFq9FYKSF/w+Bdzz1IjbcUUGoLXSWjJnNLKnYyOpWaZqaCRA7oNoFK7K
	EHrUxEKtdNAl1ShBWvXgX9xoMmpbZgI2YrFT8seZXMRNyOVOVXpF1BTQmqYtRQ==
X-Gm-Gg: AYBFou1ap4mE3xQyDOKLAgd9WXMFao/25mnD1AyVfhl+HeoUnD1I42KEYhcH45jMcW3
	WHYmU4tuIFvD+RP/zTAIRPMMDJzl6It3VNKtBKRLAFhW8yuJWUe+xG22GX/Pxd16uRvoWnOiRtL
	TxvAIL7HhvT9XqVzlS2eUPNfJB1ypQxu3TWqpw0Hyrw5JBMa0HWIz3gigc32ZKeZqL4w7zdA8P6
	eBUSDIOz7awO0tkvdivnMU60i6xhEKMR2IpYoDhcgCpkliK97viIkDthKwH6KrQ9XWpLulGtP/L
	Lc+hzkbToCnfaC4Dgu9RMg2pvAF14kLD8rPV8VVo2ct9XBp+VYC39p6Vc51yVSCpMp7gCkYSByJ
	3mNfolq6L/L6TlYMhibqSullSZaXw61J0p261ysgMpZYGTZDXKdPn2jMfBiRDEINMxzf4nhril4
	PQy0QfPyg7uSxZb+bKOk5MbFSFlkJXku2/PHKUhuNoxRA6OTv87HoIp66kYh8TTVS+NE4N5DD44
	XUu/y/Z/NNXI/Viaseb0LUc1qTmXpkYawJvjzrsLzfYSwPLn1EGQRWnbjXQo4YY+lcH5/H3w1EZ
	CJg+xYDQDuw7E/m8OM47naqQksqlRjZp3ZjLoBluvGI=
X-Received: by 2002:a05:7022:7f0f:b0:187:c940:21b7 with SMTP id a92af1059eb24-19934e71e37mr4620736c88.9.1792896530109;
        Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:42 -0700
Subject: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
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

Update the prototype of i2c_smbus_read_block_data() in the SMBus
protocol function table to include the length parameter.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/i2c/writing-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index 8bab8b16ca8a..896bf79ea564 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -366,7 +366,7 @@ in terms of it. Never use this function directly!
 	s32 i2c_smbus_write_word_data(struct i2c_client *client,
 				      u8 command, u16 value);
 	s32 i2c_smbus_read_block_data(struct i2c_client *client,
-				      u8 command, u8 *values);
+				      u8 command, u8 length, u8 *values);
 	s32 i2c_smbus_write_block_data(struct i2c_client *client,
 				       u8 command, u8 length, const u8 *values);
 	s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,

-- 
2.56.0.257.gf7497c7d27-goog

