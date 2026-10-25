Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896536;
	b=ZqOClY7eQOYLCkVR15EYa4ftYOM3DVckzpQChsGTStjvAPlizvCqlyc8Yb39pDygnACm
	 4d6jkI9im8dSHZCybQ/Oqfklhq/q7u8be2bWcvk/+0sZJ8ix3Wd96SeAeqJtOe0ySDs27
	 1BDPAe7WO09ZxlllvPCA3dFvvT+oxM+f6tes1MYh5vHvG7ia+LwN6VsMopoMg/JYL/aQO
	 gWVvlltfosNHVriZ9EegYMaxkRgaLxWCYu4M5ZrzLxnhWBZwmLLbC4GWLIqdWKJSbvSg2
	 r5FQdmO2+zvdgYeAAZ849Ykj/k3hOkMhTNoOmOzHbYkVDjma3Fc7iRdJQz744DK2qmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
	b=DdBAJaV0xA4oC2IVMMILU4EKqu49lhCdxWjnEqu/uGbQTQ3GdjIyOhBT9cG+ek7mTNDB
	 RMQQszUJm2inGiCmNajb6dH42n24wNXoR88UNwmLGS3NecUsD4tgFz2L4AEgVoMWlT1ND
	 mb3aCdsthywXirtAJf5x3vFvRu92pFp7inPky8AWR0g+ljuJt8wkC7H8INBwbmDyFk12d
	 mrC7kB60I5fvslBk/IpHo/mAFxmprV5GQUJPRdJyXYSyzNWr/9k7JPAEOqECK+ta09hk+
	 T30r/vp40HJIfs1qK8B+3bAQZiar8HVdtmwGx7z+VjvM8Fd09WEPtawRine9FvLJomQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03860A2611
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD03860A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f036b17easo4771093eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896535; x=1793501335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=jY+GWyYS06WKW7sEDFJqidwo1kj5aZiu+FCc59Yl6t+aaUEEs04DN9aHOSFvf4pJ8Z
         qDTsGyTd2hnl7k5Ym46s4MK+M0SwUS6QT0od/3PXQUY9mRrVY4wqzdWTtw/7QLtKhHPa
         Wl1hqNxbGN8k3SsCbjwlCsOrJRQMs4gMf/tZHs8fW9xwTRoGmWNJzJ/3nkRIzMHK2jEx
         7Yvg/dWXiInPgUoSXDzs3Y09VvZo+NgZaXTjGaJ6myy/TWg725XOGN2XlqtCb0y6wNjt
         /5awgzg0f9X0YKC3fb5ZWJ1bxfPVtsB3fUtQFpxRIUQdbgAmX+A1x2JOoOg4XWscVZWx
         qdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896535; x=1793501335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=G1L8i5SXDuvSnnFDjn9BcsroEDBn1qPaQBmFTC4XSRzDeh92kvA6/a9BfdN2Xpg+02
         ykxNJ9GkDZh4oORGLFEgGTOIeRPrHZUraXcJLnS+X8+Lto71Gr1gw1OJzAnnGPyBVPrZ
         dD3ebvsWye9UsyImG8rXYzdnBDIJD327WPexDYQ9gMV3h8YpS6wjGNJRIZytcLpPNm8r
         agsgwENM+3LVk+WfSYftC2eN6lopy536jnTYTVIDwU7JF4J/ky62KCTDL/sOotc6w21S
         uV25iZi7XiMoma9lBc8EwfBsdASYxXdGKKNK/DHUPTFXDrFcFEArzFiwwQ8B2g4/a7iX
         iYqA==
X-Forwarded-Encrypted: i=1; AKwUvBz88/xtpaJoxYhqIjzPy9tGC79UaNOUVQlpe0CZYmxWfGLauUwh33ouqZagoSQyTbpaQSN3wExRyHHT@vger.kernel.org
X-Gm-Message-State: AFq9FYKsjr6TwOABxoqzBCAobTYJ2cOw2DnbKkUXtIMBNOyOs3H24Api
	1ed3SVK4KW9dV2MLF6tcS9eWcxlklCOhJFcxq81lolrSkpQKLokdQm9O
X-Gm-Gg: AYBFou1qfFGPEQVCyQ3x5/PTARJKB0hIH/gAhINaWzirN8aTfavUyPjVE3owi2QV/mw
	bWyeutykv4KZpWrEzwN/+QVgJejxMO8QIsaCJ+pao+DXELWBD7TEJ40RzAdsfcuGb8JAYpmjqi4
	MBED/6vgkT/DVVmy9PJdagi/XQph9fdD2uHeEmd85GVvIvBBPPVRwt7b48BVc9eCKd5TUYW8qhp
	7FNGZXo9BvHzG/u7Ezy/KyVxg6h1mCqXbF3BybhiUDu9UueWC0cZgoEdwmTN+BSS0mziDcSCiHA
	JP6m5SZtZLVgUz9muidLTk/5qYRVGo0cmoeWT0UwqFedG3Y47DD0Z7mjNGxNTvL+TpdBq6sNhUT
	GWuGaV9mxGVTC9WVWvg6ejVpg1BrhszahvoRFOclpjvBymqoC3evVTlxNbGtJ0/jDPnRec0mgfU
	qpfyBGavsXRJXzNSJfmMRN4Qbxb4VteOLZv0/LT+42e1VXT9yGMWnXDz/ejTSIOP3863fmm8d7n
	Z467/4EdZdgHJ8JD9FxErcLLYwHeTsw+FWu79OWfW7psw/EMqkcL8Tf24ZCkCWmiq281m3IttNs
	MjYjTB1jWN0ssg+/RshR66vMvOICIlDWxvi7334gjfA=
X-Received: by 2002:a05:701a:ca07:b0:184:d593:2897 with SMTP id a92af1059eb24-1993f3ecfb6mr5382379c88.29.1792896534741;
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:45 -0700
Subject: [PATCH 5/8] Input: synaptics-rmi4 - use 4-argument
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-5-19bb97467982@gmail.com>
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

Pass the transfer length to i2c_smbus_read_block_data() in
smb_block_read().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..a180becb7670 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -172,13 +172,13 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 
 /* SMB block read - wrapper over ic2_smb_read_block */
 static int smb_block_read(struct rmi_transport_dev *xport,
-			     u8 commandcode, void *buf, size_t len)
+			  u8 commandcode, void *buf, size_t len)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	return i2c_smbus_read_block_data(client, commandcode, len, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,

-- 
2.56.0.257.gf7497c7d27-goog

