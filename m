Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117817;
	b=1gQZ/3NTisfxmp9XdJE/Fh9ScodgWyqDTGQL4JTSQFRrJVd16m9RPiRdrKOOevHfKbeC
	 ENWUDm0bSl+FBecIn0o/1xe3S6G/49JhnlkGmEwZ0M4K4XozOBmR5hhuCIPvZJ+OePkiT
	 BpQkDgMk7K1di/hKzLufjpXNOyumr1Mtp4i3NhsWjysqN3ylzXj+RTko7L3EPuhqht59l
	 ClGoNWZ6q6O9nHWmZi0FrdfUzH7Rfra8ySqrJLTJBJ/lBhfZmXotYNayKJp/tkXSymQ0l
	 JNjoaxeLqnSF3Wq30Z2IPKkQ97shBPIBzzWezhbcAUxNgMobgKtySkI9oa5KiCaMagQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cPCyqMaKTCMcPIZaD/DpSt+b55Xb3f31eMSeD9/YiJM=;
	b=Qwgc3qwQaENQQbR83RJoFSThZfsiYdKKCTWKB6m1ykDL7zLjNIvR6WiKz5RHDhn53Ut3
	 b7iHajWn7s44Fr5O53+UIvF5Mrsjeh/HEzbROECk6o09IV5Qxr9xh7Dbq3p6MeW9pKoXY
	 WlUgAhI6Ppz+JGBDtJsiCPJpYW9KCBJxvIhBI3Ct143UAdPy/6x+rqHtc+SIN2EU8AAtd
	 dapR4IVodQGZxTuxEjitXc342fQXrvjRPPcjElIdT37e6v7zAHDzDUE1RH0E8dYpsQHnk
	 LPTSBjVCe19pk4FxTbkpm0oWzd78edkeU7QeEfPM4SeygpdVW5k1iYtMffiT1qDVJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZUTYq4j;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4B606A324
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 16:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F4B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZUTYq4j
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso284465e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117816; x=1793722616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPCyqMaKTCMcPIZaD/DpSt+b55Xb3f31eMSeD9/YiJM=;
        b=qZUTYq4jWuhlp5D7gKVp1d8huuo/rVtE5YFvyEvvMtnZMFOAAU5lSpyqhfb1kNkXZQ
         lrixdFFqke4HgiNc3dGkWfXMJxDtDnbqFd3xh3UdSQAToTTethCybrMJKZBj88M+uJ5H
         OwoKT/felqMYVOaJQ+7/ql74bUD8rAWmlU3NPvygMdNk9xbv7MHF0ycmz0oovQ2BbkBj
         j7T4sGUvYJziH3uqZF/b5pgTS8/Q2pvh7YeqX/XxekKs2PhVD7S//EKKjxZBcZRPb6AN
         KO0yRxMV/PSm3GorLG4hL9GcHu65evuRNWUdRY7FhyD5LBO1Az9Fui7W8ntX+9z/cF2n
         BxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117816; x=1793722616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPCyqMaKTCMcPIZaD/DpSt+b55Xb3f31eMSeD9/YiJM=;
        b=H2cr1tSxuDrs7OhMIrK/pqll97Iy5v9DcwP2/FxD8XTrJdi2gG8zA72GjKt6GzdhAF
         BitM377D8xo2w9pBHsbwzAcs1mVsT+YCJVX32pULCSu7dTc6RPjFtiDxEChP08X4VNYM
         cq5OxDw14iCHcwkVEOcYp23JhDC3u93T3eZviCFyvv/evfirvB1bUkVWghkwjBsaCNYy
         ncuBKRW7K6/hwc80DRHDDXZoCCpPPHYQw32SPz5bnTKXSpBkZC5SWjKdkjxuFVC9cvw0
         DNANPVfRu6lwEeieKJG2CoPVvwIcup1B9FQL6Llt+134K8vTsC0d/jlUmt3KhzScAcpp
         s2VA==
X-Forwarded-Encrypted: i=1; AKwUvBzXSyfHARyv4KrU+VQZ3BDNinBNgM8PJf8ERwDnkXLBnKOXsIyFdhBHJSffBJY/xQWX8xGp/WZFFNEW@vger.kernel.org
X-Gm-Message-State: AFq9FYIuAFxfT994degQmSdz4LvYFh/wCc3nd2bhqc8+eZy9ddASivxc
	tewMjC9yJgDgn66J8Y4uBypJ3GwNFw0ugyx0Jz94zQ+ExO0dHr0B9vRBMoQs3Q==
X-Gm-Gg: AYBFou19gxEKz2HgKhEN6z+OqXWQAyvb927S05EIes2p5W/hrLVXxPEMXDZY0+x3Knz
	Kjt3lXdaGRRzdKis9DNiYHG8BmK58vBr4nfqoAHMc5c9NMrxzshL1TleFQkS3p+gU+BWlg5uKpW
	HCPWqZI7B00Uqt5y3QILpl1jPKVmwd298iCUFr2MPWlrZyp4Y/Ilwou/OhY5DTAG/BJUAnOpYea
	M6cLLgmunOSVyleqIJnfg0SL1afSS0UTATcVHh7rqlxPkoyKeeXK4nU6z2q8Djm4daLk8PnileD
	mbCAnfq5PpeodmjlZPAk6jEsC9C+MCN4t4nBzcM64F5bOdB46YhlMvNK+GKm1GwD6OOdWoQPep/
	OcTJ3NUd5gOoUwxin59i5YccgWmwSMmxuypNlCpVgK1Qzktk9Y/u3tnhBCuVDaQ9aDpHU7rsOsp
	fDT+gx4RgnQYVrANzoRDP43bHUVMpkr1D/p3YDdW1rsFw11qBoUWrGfp4j9CVzUgBr3vohCyb33
	pkcZAXbQb2Tb1tt8DHtPWGIa8wePX03Wn095Uq2G0vX4g==
X-Received: by 2002:a05:600c:4e0e:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a35ac9d227mr200480015e9.8.1793117814801;
        Tue, 27 Oct 2026 09:16:54 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a928c50222sm1765075e9.1.2026.10.27.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:16:54 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH] ACPI: fan: add missing MODULE_DESCRIPTION()
Date: Tue, 27 Oct 2026 18:16:50 +0200
Message-ID: <20261027161650.59170-1-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modpost now warns about modules without a MODULE_DESCRIPTION macro.

Add one for the ACPI fan driver to silence the warning and provide

proper module metadata.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/acpi/fan_attr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 9b7fa52f3c2a..6b3d91c14f5c 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -15,6 +15,7 @@
 #include "fan.h"
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Extra sysfs attributes for the ACPI fan driver");
 
 static ssize_t show_state(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.56.0

