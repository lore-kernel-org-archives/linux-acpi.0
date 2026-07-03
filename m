Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438C33EB1B
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052058; cv=none; b=nQDIPVJCFifkY9nmrTFHEwq1AT2bVwpZ6O9LpjMM73rdBM6Howv32kD/st6tyF84jJmk2t2cVBuZu8G27348NoSOUCbEL6kxb0K+Jk1sFDJejzN4KyFtO6xdHZSi6jEXtG0vUfeSpAXC4GTRQFzQjq72mMxpCcCTlvDGqGWxaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052058; c=relaxed/simple;
	bh=qExiG3cXDPtTY1KaS4pQA4Hs8luH3s0Ytpsx7ob/gwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyKG6o6ljiM4q2fINi+tY3+0UWvsDyQRj8m7LocnHkIZO6B6jT0680wGMywQLFJZFiPx8ryeqRQi8uGvrC+TioRsfpaFvjD4ItE52pTy4SamvAcaDoqJPy0uP91aM2P+EtoX/oPxRxQ34/Db7hYSH10KqiWeAaQbYaa0f0Q7JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGB+B6R+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGB+B6R+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so126497b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 21:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783052045; x=1783656845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcDVoZL/NYCcO87EVs1DzwCYLIxfylDfBkgHyvQhJNM=;
        b=WGB+B6R+88c38enWjumTk+oIxuiPBL+/daJFsYf+UswTw5CO0lo4AtqrTcho8bJaE6
         JIcXE8Om+81xlwQG9htoFny3RETr3JlWS0f9v2yzDBjBVAX21yWSPHUENv7A+3EABWOJ
         FWP1Uo2jMIixoLAr/urxgs7z4JBIFnX3JaneCObzOjq5m3zsMY25idZqf8jelzUSo08P
         TWQ+qZyK7GFxfFj7hlgj1YUSJizJZ02ku7kpMLvzXpW4umU86PtZcPG7nNfCzBBtzZoY
         uuIyKY2AEK+wej7MuWFPiHvgJ2XOMSiT8fk2mW9DPR7ohPQG2pjFXzcNJAnxwVcp6I5x
         HAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783052045; x=1783656845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcDVoZL/NYCcO87EVs1DzwCYLIxfylDfBkgHyvQhJNM=;
        b=r00bd6lKYtWJEjJp2R9/xT3Z1Phx9sy2dUwk5+pInHTNQ+qI0n2ep44TeZApv0tl6x
         wwpPBtbNS2W1ohbUs88XXuBkh7kNYWw1nCb/Uv+874aORuQQW5nadCPOwyGRxjZ6uorv
         /C5wzGjAycPfjRr/V4hWmqiAFqdEHlSeyEM6KhvYmf0K44OJj2ff1NjyJzR/tItsnGFS
         8AOKlwT4SmSnVDPUMc3zFXEzQOOE0gsDkbOmkg51W55pc68v6GYt42tAkzD1A5HwXyAR
         USSQleILPTYx8L6TJ+PzY3Z8ZX6/RqfR848B8sEaWGUh2/t42OP0lc0/O/ogD3awJZKk
         ox8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpjOJlGKvBGWb2Wq439hY0SPQ+uIAik90S4U9A3haYP2HUXewNa9sPxu85XO1SYd5upHrIbIYmOsHWh@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX6e+XauKq1dOXp3MvFr5FNuV6QaRz4Qe1m0clZBOoFIOwDC2
	KFBQStQ2CGwvd3DRMnh/uRpXtQr/dc5k4lZXLNfHL5ersqNjM27uu8tN
X-Gm-Gg: AfdE7cn8Lc/O1m2VGZ5w/Ao7/pVI1ty91fQnOOlCh8GRFFUeeGG5nhWjYHBwaD+I581
	t5YTKTHz5GmQHbvdHzhULQo4nreKOaURbg2ck24dpo/LDyuHt4RcAKvcm0cfvuwiQwoq3W97NHu
	P3OdlSfiU0RDTxZ7Ro2FLlzfCmo9XtPWtCJOvA+yL8DLFPxDj+GmA2173C6XId0MZ2s9vPMNmhb
	YZSMg0MKXZEZajL3FEcRC3W20s0j7JQn1/wIT01lhXQxHacKLmLG1RtLtVvpi53aEQKsyJbxy9x
	SRf9oa0q18n6CxTA6qwztfg52tb0A49AHhc/MUerVsbfv1zzGFoSvX2lBLRnGN2VqFQQHz++spu
	iMwht6HxWmN0g/oQFtDBxW/LagJ3S+7lww0LNu5H+QoV2wz9S6XadnfpZc5rY1RLp8slctPVkrf
	l0J7FhbyY=
X-Received: by 2002:a05:6a00:66d1:b0:845:eb00:ecbd with SMTP id d2e1a72fcca58-847e186ddf4mr2055507b3a.21.1783052044773;
        Thu, 02 Jul 2026 21:14:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94bd7esm2207768b3a.38.2026.07.02.21.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:14:04 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v2 2/9] ACPI: NUMA: remove redundant numa_nodes_parsed node_set()
Date: Fri,  3 Jul 2026 13:13:22 +0900
Message-ID: <20260703041329.2797584-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703041329.2797584-1-ekffu200098@gmail.com>
References: <20260703041329.2797584-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

numa_add_memblk() now sets the node in numa_nodes_parsed itself, so the
caller's own node_set() is redundant.  Remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 62d4a8df0b8c..5c407dc6401e 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -399,8 +399,6 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 		goto out_err_bad_srat;
 	}
 
-	node_set(node, numa_nodes_parsed);
-
 	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
 		node, pxm,
 		(unsigned long long) start, (unsigned long long) end - 1,
-- 
2.43.0

