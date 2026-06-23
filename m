Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEE12C534;
	Tue, 23 Jun 2026 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182850; cv=none; b=UUKaFBnne6QKZfxi/V12KDZbK2OIZfDKK7hhtWtxkUk6ALD7vffCL4G8sXlmp3KGc7ds6eG5h7cLzL5mh6XoNB1HX4yCxSUCMdk8bIhF99Yj0qd7By41OIVQy10TCaZZiMqVDdEBnP/g2+/J9HV8ui1o8yvuXpyKUH/lw1U3kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182850; c=relaxed/simple;
	bh=WDpomkbvwEpJn6hUgEgoTMBNIp4gTsbMXNgFuCjAp7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2M8QfWBnvacCUEATVQOkozNhuoe3dzBaAmtereOeuiXsSlibyklpXwYf9M7lj+0j/eFcAcXzurRmNPndP7sM9NW11SMlJ55L7ijVy33qCcvyc9h1yvKhoiC46fUTT8L0gj121gB4smwHzm6T5+Z5L0IpndoR9y7Eqf9F+V4wqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d71f2ee46ead11f1aa26b74ffac11d73-20260623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:57e4046d-e2fe-4921-88a0-35e3f2cdd9ca,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b120238e1bb89aa4ce6b6f1014414011,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850|865|898,TC:nil,Content:
	0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d71f2ee46ead11f1aa26b74ffac11d73-20260623
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1455545477; Tue, 23 Jun 2026 10:47:14 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: lpieralisi@kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	guohanjun@huawei.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pengyu@kylinos.cn,
	rafael@kernel.org,
	sudeep.holla@kernel.org,
	will@kernel.org
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
Date: Tue, 23 Jun 2026 10:47:12 +0800
Message-Id: <20260623024712.3480399-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ajkFE6TmwW6B/huP@lpieralisi>
References: <ajkFE6TmwW6B/huP@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo, Hanjun, Will,

Thanks for confirming.

I will send a proper patch for this. The change I plan to post is along
these lines:

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index ... .. ...
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -79,7 +79,11 @@ enum fixed_addresses {
 	 * Temporary boot-time mappings, used by early_ioremap(),
 	 * before ioremap() is functional.
 	 */
+#ifdef CONFIG_ARM64_64K_PAGES
+#define NR_FIX_BTMAPS		(SZ_512K / PAGE_SIZE)
+#else
 #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#endif
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)

Thanks,
Yu Peng
