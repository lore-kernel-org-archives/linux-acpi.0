Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9443946A
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410434; cv=none; b=Irgu79HvYV1hEr40nITunwlxV7fjyC6TLPv4j23M0Tf20JNys+cDqXbhVfSjkKfLT5fRwjs+vouuv4HUmCIquW1VxVu5hJfqYH64iARNh4atavQeNzJ/3fejIaSBmG22vxluQvEBhkz8nKIjKGoiiGCKko+CDtSlxm59r/JMJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410434; c=relaxed/simple;
	bh=GDLIp50/iwvJOhmsgn+XW1DNb97u/bsnO1G/17qtNT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDtyR6X4Uo3xITQboukxqeLX5FU6YxwbnBCYdsHB3qu5WnvSzqw1X9eE2ACle13fSKINrxeFux1B21XlMYs0braFTQV2UiFiovbfVgyWH6Zr2aphhGcReiszaqsbQTaFlg0i4/E05fHZYpU253lOzfwBfLrlbikxcwRC9N80YO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBPtDzj/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBPtDzj/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4143270a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774410432; x=1775015232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3437scQg7pxEmWre44sOIkcnGhzeJ+EgrTInolW3aS8=;
        b=aBPtDzj/YtAlQzUwrXRuXG2Xjz/WAUx/fahcwmKEDOuLyyCkrjEFjcGfhUhURbVYjD
         R4jrnINgVTImSf5yy0vNSteynSFukdaGlPMIE27kOnMJSCOI3SgZfOMT451c+G+wlt3X
         xHzVfM0MOc3d5twEn85Kx0TguEmkCVwqJEqlwXl8tE7sPMo1ELpcOaQf0OTKU9KN7fhh
         zp9VIDMMSUq4LDxlTmje70XZy8J3fn4aSsmk/pHwKrpEFc3cPl+UPaZgiyglIUkQrvC0
         5TYNy53m6yqtBzCUAmf0Nkxnl7n0KrEOrk0dEt4+Q7wZLbhRsYmNHiVwWjnOQJRbZulb
         u00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774410432; x=1775015232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3437scQg7pxEmWre44sOIkcnGhzeJ+EgrTInolW3aS8=;
        b=eCbHv/MPxzzEKDggqb4v827yYtbU+pcUE0dbW8R3HXwDn7aP2Oi/KzQw50IX+roRSv
         g7qVPkxD9tyoeac1RZCIBrgY2q+Ayx4c+1qVXzxn91jkMzmtW3CbonxxIupm5qcAHuxn
         fH8haX8yDJ23o3RQlmQVxS4ZNolfJaZ7egBzMLfWIYlhJ7otovpk+Pm/Pi2uebEBfAnz
         tRpBVnyF7LFyJGc6U5j/65RQ8FULPdoNnsxEsJiN+VF/NVvOCduX5mwXDXh7MR6T9lLq
         86L1zMtbkUtnfdTyUcXMsvFEWYSSuAxE1iS60mXw1Ilh9hxI6nJFNmqaTGvtmko2ZPHb
         INpA==
X-Forwarded-Encrypted: i=1; AJvYcCVBo11w449a/d9Z+0fki+9qvl2/vzQjQt/qWV2yqA7MXkJ3sdj97ENiDxfSZpNZJ0yt+D6pQD/QbPrd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw208XLzwwKrEPxSE8XTFYIUBCxCJ45A1QOVbg9JnfILyOqSbs2
	XIWV6UUDTb98E6MAfGGyUTQ/t4ItSVlRZOITmoxQk6e1kI3BKNf9tk26
X-Gm-Gg: ATEYQzzW0Xy5++WgBt/Vpj2h/NzIax4qIWNXFZ4ulCddjg24/Os/KLkxqH1GoZqIqSd
	2+PizikJdIk1UxGsbLkXWg2W71Ds39iRgJG21LRxVQXETMJej4CLt+HP+iJGfX5bwpkb054Uu12
	LiqORnOPfbvreH2iQQA/AM9tyR7wgMOiyr2QDTIHETFySqXnuL38NjpTf/3wUCyuXtnCQLQNKIk
	UuJDPXN9Ubexh0FFh501mNgOwmnK4et+shsOCMZY1FGnfusdXEaFsCNmQLqs5ZQBX+NaLufffW+
	IbeTvcH+WAyseVfnnE1OXvMGjqoB3RHqo42NL1+h8pRrOH6zbhWLn8e2RA4SK0UwqZfKuxbZooB
	XcqtqtsIfuswpBpUrmG25Ti+0irZy9Uhj6Z47oEt/r2rczJoP0/G6yd30/J1yvt/P6VEBlvmfaq
	K7tiyU3Vhi3HKCx5FFHxJREM25wLVKs+0ZPOyUlg==
X-Received: by 2002:a17:903:4b07:b0:2b0:63b6:dfd2 with SMTP id d9443c01a7336-2b0b087d8c2mr20869355ad.0.1774410431839;
        Tue, 24 Mar 2026 20:47:11 -0700 (PDT)
Received: from padmashree.. ([2401:4900:91c6:55b1:a867:2be9:abfe:7b9f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c56bsm230658015ad.57.2026.03.24.20.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:47:11 -0700 (PDT)
From: Padmashree S S <padmashreess2006@gmail.com>
To: rafael@kernel.org,
	tony.luck@intel.com
Cc: bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Padmashree S S <padmashreess2006@gmail.com>
Subject: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
Date: Wed, 25 Mar 2026 09:16:26 +0530
Message-ID: <20260325034626.405366-1-padmashreess2006@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse reports a warning for einj_initialized being a global symbol
that is not declared static. The variable is only used within
einj-core.c, so mark it static to limit its scope and resolve the warning.

Signed-off-by: Padmashree S S <padmashreess2006@gmail.com>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index a9248af078f6..4a16c4b85a03 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -178,7 +178,7 @@ static DEFINE_MUTEX(einj_mutex);
 /*
  * Exported APIs use this flag to exit early if einj_probe() failed.
  */
-bool einj_initialized __ro_after_init;
+static bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
 static u32 v5param_size;
-- 
2.43.0

