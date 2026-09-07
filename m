Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F03FF1D0
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763690; cv=none; b=fgmX2QYdo4SFvzuEQnhEXBS/JiqFC+AbAXtiFBOwOep6fI/gRLFJ0H728judRmA4TgT3SIXPlSOhs4zDGYOr7kSXlO5RYJVo6i6dr5L/2KAZYAm0Wh2pfwimJfPG/onf0VE/mcXM+lCi55heT2C/tro7ic45i/dp4robnSiijVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763690; c=relaxed/simple;
	bh=NySkzWKGvAVQrs22Wj3YGugY/Vl4ZuUmyHXC/e0Qdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p49rQnSKjmdT6X/w2ptM99cc1QbGDvzdPXZitH5pKlNOVf83XkkSdx3ozPMTbKFuouGkmb78ZhjRNzrEHGh57ISx0ScUE+CkDgJSrYCdw+g4DTiT02AjNEyKjUJ/J1JCdyl7WytIdbDgWNCJ4MvPvmQbeLO4WzSvNgd6k4JK8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcmxg0Qd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcmxg0Qd"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2388722a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763684; x=1789368484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp3Y74c4rqp4LQw7mbFodFzkhcskiP8CvJ8q4Odm34Y=;
        b=pcmxg0QdhaGNJULz7S3WvjNFTMfgKEnfQ1lTzIJKt7RAkiFS2bIbnccWhd7edV+msg
         eZW1TE/UXd3aAnYa/UbJ/Vh/YnJGXPkczE/i+KPtxwS9xsYnDMNyY3aRoWwpt5AbZOYF
         U/T14xjPplnfMUBMcMmR2EJZizqH2g3dNQ+2nh9Pfz2nZ+NVypi8s/7kPnQLeLS+588U
         ineD/9arkUWnWG+W6H9J35qKfU1zihcCS4IAqodFNKl7dpagHbzrjd53C0/z+zAnieK2
         0VLOTRj1DFtJ7T3Hy7nQEJlsOF2C8RQYtrRwVhtGqnmHgHRAYUuBv1hNhIlmk3eLpQdN
         dbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763684; x=1789368484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sp3Y74c4rqp4LQw7mbFodFzkhcskiP8CvJ8q4Odm34Y=;
        b=OF86Fz9ac3oWMaTFNCCxkBJH0ftIw/4C8l2ljVjox32jG3o0938FTTZvZ8U27G0g8k
         Ocqmg60sH2Mb0qlaA1zx4dKpLoS/JZl53PRbK/ZsunxWJ5pjxuX6vnA5Krm7kYMVCmoZ
         3hNFqWOCp7ZEPyVbZYJ+IB9qb/JIiQJoYzp+hqHVUfxhUwgZkM/4SEsOBu8i8sOIrPmS
         vZ02eln2SmiNuH+CigkRxwjyJXq7moW+Ll6GDKocMEDFJWxWs7MEe0Fp3IVB0dt7NeHD
         OZKvP/mAOXFUFVz4zngCBS0J+hgZ9tEK80WkbT41zV6+nmf/XRpFC54EfnxRGMV3ocvn
         wHAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzF6xyBqtD1W3zWkfbJE2QljIWdPbosRv5PObwnXt8wyE5lTSRyVMd16uafG2U8RIUehmwY3ATeYn2@vger.kernel.org
X-Gm-Message-State: AFuF++l5tenutLBi7511a3jqQzShzyMtWYREsQa1Y/SjZtJmFDUGF80O
	cB2XyFG4fKIaj7RwUxaePFmTdiU+KhAwe2eFVCmrdLpA3f91vbAGbBnn
X-Gm-Gg: AYBFou3WyJfm9adve48wiQbvhRoXjSh5vmEE+vg6L4eyK2poi+fu+q3faBpbyzJTbE3
	L2b+RCyruzGsTKGu8XcUg2r1mg7Zg+VQT6o7nEBpa/Ao7oquO4TrVkr6btYiqOBRUC399QZOxpZ
	hRZyRVlhq3CXJ4+LtZXb/T0C0c//cx+BAoVCXrIKkqxYMEUr0ZNHBelmEnWjvyD8wQ1hJmH3yLY
	ZILVIV3aK8Z1L5wE4rP0L4XN7SBJhDRfyFX17o1vqMc4L1Pgr9bewBZbNECp/V9UlV9eowkJv4Y
	YcxSUAu6zFVe6szrPQwYHpNDWW44tshP54d52wYNDBgK2TOFHVv25iFD+7d2D1JK1DiGdqiY0o6
	LyaRQEWOVpins6N+MCJR8Idp8ZgqBQgu7YPufB/Xr/s1GFeYF8X9e2yfPZGnzgdsZs5Ih2DuZVM
	bApqgkDN6HjU7rMe1S0vlLiufBaqHz7FWsf8+qORkQgb9VdHaxdUZoKNsCkdfBP7qKXfGRmnwKU
	B7CkwVgQ85uV+ZI1OgN7Ip2
X-Received: by 2002:a17:90b:3804:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39b25f4397emr32259222a91.0.1788763684190;
        Sun, 06 Sep 2026 23:48:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:48:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 5/5] ACPI: NUMA: fix typo in log message
Date: Mon,  7 Sep 2026 12:17:25 +0530
Message-ID: <20260907064725.10686-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the misspelling in a message the user sees, reported by
scripts/checkpatch.pl using the list in scripts/spelling.txt.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 5c407dc6401e..f5616830f5a9 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -111,7 +111,7 @@ int __init fix_pxm_node_maps(int max_nid)
 			for (j = 0; j <= max_nid; j++) {
 				if ((emu_nid_to_phys[j] == i) &&
 				    WARN(node_to_pxm_map_copy[j] != PXM_INVAL,
-					 "Node %d is already binded to PXM %d\n",
+					 "Node %d is already bound to PXM %d\n",
 					 j, node_to_pxm_map_copy[j]))
 					return -1;
 				if (emu_nid_to_phys[j] == i) {
-- 
2.48.1

