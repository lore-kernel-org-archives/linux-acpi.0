Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D638B7D2
	for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2026 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212876; cv=none; b=ZD5kymRF/y9CDYnlYQPi369bH1Ur0zBm9DDgtReuzB/hQMu9qWjFREBV093HTHxmul2GPa/jMv04a4i9VtDuWFJrXvVvqN7dwbSn2AtnrLRauTSOBofd/SPaIZAY0nXEXr5JVn+VRx2MIkFXJ9qVAkqiGrEpQIEON0w6HPoqtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212876; c=relaxed/simple;
	bh=cC1YOs027YlAqZAqs9J6yM8CSZ469b20i+ByfNS783s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUEsqp3SuOwthpEH7kfOW7CFc8rbz+i0QL3eBomURd+k9aak0wkgKU+p3ZGrX6N4SYV004QtJvloL3NIQLR78x7K/yQ1y432kjcHxX4j0zo5OhCvfQ7+WEGIj1T2ZsDNY230JQpY3HyK+mESI5pZw/PHJ5sQBoPwghegvoAOnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO4U2jF+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO4U2jF+"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so473320a91.0
        for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2026 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789212874; x=1789817674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AX3b+/Rd5JBxR9PSq0SxNQZUrSxVi/vmNM1MS2Zuudo=;
        b=dO4U2jF+uWlD0zxfHqXNtLWuweFU8mwlmiEsl4RAgvLMD72o9K25yAm/sUbCEr4JKu
         hG07vrMLF7lnBIb4dMfF+Ba3XHLPKkVZYLKphaOsih+VkEZJGPppu1/sbxoVrsCW9dPe
         uW40yukbc0JrPxBuL6oP8C3DRbTkv7PZs1dF7rqaJqIdBh9VpZq2kjVRzXcKYkgHAiGX
         pvVpajqzP2woWP683xa5j45OSQAhHOCRLNPgeB9bDAa0wpxWTy3FJw5V7oQjzeJfyjZ2
         P1POKPF737kdsKt9LFBzRZLLFOIenJI6lpxhWz0EHzC2czOhkmlcTqv1lVbqOETUyyzd
         lG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789212874; x=1789817674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AX3b+/Rd5JBxR9PSq0SxNQZUrSxVi/vmNM1MS2Zuudo=;
        b=mTiAnBiRZym9lO0KkRJFvt7moEXmkPkUIdwoxenH7v/0S8eVy3opqdqZb1UHwqj/5d
         Rde1WM0tBHKqk8BufmYGLtbpsiB0dTqLyfpTFE7Mgrm3f4HSe+zPcpjaYH815/axoNHI
         app/x7CjEMM6i1rYjUG7NvqqymNbsveOX7do/Z9vR9W8z0EmyG0fENM+6mOnBscqXcrH
         Bw3eEuQNSUEANnWDLSEfKpNSVVuHc0/wN/72CHdFWECBMdVimFuUYGhyKyhuq32uxmEM
         lgUzgptZAVhGPmWcfIcmkEE7dFZUpKe4KHndkwHNuc8Fje4YioGeDXuPgzE2KHvYhO2p
         LqQQ==
X-Forwarded-Encrypted: i=1; AKwUvByL56XzE/2EJ3azvd68lO2P4c07G7zmr4/5EToFwLDnIP+TcwfvwXYaP+dblmY6qRjvOkbWJvOH2XU6@vger.kernel.org
X-Gm-Message-State: AFuF++lg0pK3B4MUY3MOmZFOhYJ4vdZ5Gu6sTLstArq/iuuoc9g7t2qm
	7B20mX0+9ziJ28MlT+TDQ/g01QJdSAL+dPAn2zMjuiJOUL1PqGMavs0p
X-Gm-Gg: AYBFou3dGx3xYvlz/dMIHztgVtMWrxH2qIA4m4ylWLtMIrDPnc1uFmf7rSEHHMLv8Ap
	Kb9ngvCgYAlMCRvgpCR595vW7LhWhqF6d/oS2HTiKRBnuFtVQGg3XhFYiJCdOcok6dXZl8dAgGd
	VDtr3hQRhkkAyCHvXuGjKkaOcS3HcFoddHY1tkrKWKlmAxLjuez4q8NFOBoDqR9H8foUxSdZc42
	SwxA1qR+mp2VXXDeKRn96PIYqq5X7g2Ic52+3cW+FgJ7bPwJ79KoEgVjAqFzpjNf7xGoOCVqLQ2
	/g0oomKq97HFbLKScTKg1og3oMZ6q8WzOtWvE4SVc3RxNh0LCaut73vtU1TlyxlpwkXToAPCwte
	EBHcvhxZDhs5EIM/2OS1qzvUk7H1S3NKZpn8PTlL0Ty5ecmgsMttPXbZKqVPDVlYoyJ8i2nWn0D
	9zHho4MPrRnfPKdl651xJez77Kz4a5Bg1btqXgJXR2jVKVk5Md9H3SMA==
X-Received: by 2002:a17:90b:1dc9:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39d9c0b79efmr15378795a91.13.1789212874173;
        Sat, 12 Sep 2026 04:34:34 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm10046220a91.13.2026.09.12.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 04:34:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: SBS: Fix NULL pointer dereference on allocation failure
Date: Sat, 12 Sep 2026 19:33:55 +0800
Message-ID: <20260912113355.644238-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_sbs_probe() jumps to the common error path when kzalloc_obj()
fails, but platform_set_drvdata() is only called after the allocation
succeeds.

The error path calls acpi_sbs_remove(), which retrieves the unset
driver data and dereferences the resulting NULL pointer when locking
sbs->lock, causing a NULL pointer dereference.

Return -ENOMEM directly when the allocation fails, since no resources
have been initialized at that point and there is nothing to clean up.

This issue was found by manual code inspection.

Fixes: 9460eaae2ee42 ("ACPI: SBS: Convert the driver to a platform one")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/acpi/sbs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 86b7c7975852..4b84b3cd11e3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -639,10 +639,8 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	sbs = kzalloc_obj(struct acpi_sbs);
-	if (!sbs) {
-		result = -ENOMEM;
-		goto end;
-	}
+	if (!sbs)
+		return -ENOMEM;
 
 	mutex_init(&sbs->lock);
 
-- 
2.43.0

