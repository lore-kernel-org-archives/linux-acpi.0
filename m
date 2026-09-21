Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E723655CD;
	Mon, 21 Sep 2026 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970818; cv=none; b=bct/REUoDyey9sOpwVqonIGUQJAXqFzVxVfPbqo6Naw0KfSEhJBUzJ5Vxco1IxSmUKtL3T8j4D+jzUoBUL8mYoSWkRfzFbiNPOWycIL+36lBuoKfrCcMq8WTulMFXgPriciY570DdUpNFdPzerXCTKW0sTGy2yz8a3P5jam9Tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970818; c=relaxed/simple;
	bh=Ke4ZswJ0Hoq/8i7ZGRi/IbZ7Ys1Lh4boTKClq491ZLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fibxl9ZQtOGAGODFMptFhUvPqD+xpXgXnGKaigdrZWoZRfu9mCWewMfmpRhL1JI37UeNbfyplrMHUxnWcstJzXv8SotMW91zsdCGLLUmMs4HEfzpUpPvGw5bYifoS4zzWg34I6DqpXLW69i+m7RULdPg1dKHQ2/eXjP1ifT2muI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9fa3b658b58211f19a56ed5b684f684d-20260921
X-CID-CACHE: Type:Local,Time:202609211347+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b91cf450-e138-4cb7-bbb5-0f1ea261bb91,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:f07779d0f31c8e52d033408c8019fe43,BulkI
	D:nil,BulkQuantity:0,SF:82|83|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9fa3b658b58211f19a56ed5b684f684d-20260921
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1250999981; Mon, 21 Sep 2026 14:06:45 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Riwen Lu <luriwen@kylinos.cn>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for platform-independent S2Idle support
Date: Mon, 21 Sep 2026 14:06:42 +0800
Message-Id: <20260921060642.1931677-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0jpwjNk9pmKN41Dh6Q9GcRJo7xQ-JJTSEviqF_HiU=XrQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

Gentle ping on this thread.

Having reworked the patch based on your feedback, I believe the main
problem with v5 was the new user-visible Kconfig option together with
the conditional select: an s2idle toggle is not something users or
distros should ever need to set.  Before posting the next revision,
I'd like to align with you on one of two directions:

(a) Keep the code split into drivers/acpi/s2idle.c, but turn
    ACPI_S2IDLE into a hidden symbol:

        config ACPI_S2IDLE
                bool
                depends on SUSPEND
                default y

    following the existing ACPI_LPIT pattern.  No prompt, no select
    and no arch changes: arm64 gets s2idle automatically.

(b) Don't split sleep.c at all.  Have arm64 select
    ACPI_SYSTEM_POWER_STATES_SUPPORT and add two tiny stubs in
    arch/arm64 for the S3-only references in sleep.c.
    acpi_sleep_state_supported() already rejects all firmware
    S-states on HW-reduced platforms, so only s2idle becomes
    functional.  This is 16 lines in total with no code motion, but
    the symbol name becomes loose and /proc/acpi/* would appear on
    arm64.

I slightly prefer (a).  Unless you prefer (b) or have a different
direction in mind, I'll post (a) as v6 next week.

Thanks!

Riwen
