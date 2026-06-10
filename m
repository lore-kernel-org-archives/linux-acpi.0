Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBC3290BA
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055941; cv=none; b=I6Ap28LXWEGzw817uf3TvP1yw3Dm072x3/d6MHLdlAsWgUITEmo0fVIiBq8CkWWJbp/NZY+NCsTWJeFq/6dhBhBj9Af25a2WxdOqA+gSB5bMdf+Dj+FkQQqeoTJkGYTPcffXbEpYrUM7YO66fmxnEE+327fdOGu/Q66FPxbF4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055941; c=relaxed/simple;
	bh=4lm3filvyu7qL3c3XAtVgVtfMqNVCD7xcUCj3uoAlw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXYcvhePJpDYBN6373Mi7PzdsWkfSibQdE0FRXZSiuZgNRAEJApVOuyoioNHHCzk01Vpjf6eCCdF4jYBbBe10aUXBbYA9dy1CzDnnpS6he4feThMx83p8NJHXWEuuKDM3AR7JcE8wLx754VxUItUecjzzHZ/utzR4UTgI1E3Ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=R4ABMR3B; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="R4ABMR3B"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175b6c4e19so65514101cf.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781055933; x=1781660733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsslT2SHe3Ngpr6+flW/+aA6XcPRV1aWnG37ChpGzVM=;
        b=R4ABMR3BVqUKgpCrs5HX9Qx21n9we9fMMneuOfN+2o+j+SxTUqIzgsTId4RsIjLFur
         x3gzwUzxl3WWgUKUhOslcR3bUoaUaraetL/fYz39bUjDJK/2kn8aWeVfHWQXHWb94iqv
         0ROGcQ3THu1iiunBAzWPX2G5b8RGEBCvgzVy6hFUXvhEdpqyg2rGomVXZSZ1X+6UGsIt
         mcmIymrI8zTBPAYRFQDu0iaDm37TgWM7juT+unyOA5BFtJA02qPKhjrdShUBWVixgXZ5
         8n0ltGSw1FzMfaVk2+qfzRCvdlKNmuOJ7ksoQLVgOAWf5s4ctnHPgy9PmJUN9631joTK
         E0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781055933; x=1781660733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsslT2SHe3Ngpr6+flW/+aA6XcPRV1aWnG37ChpGzVM=;
        b=lTXjHaqDvgx1uz2hVbDzyJh5DRFxkix23pBxBs8eZPEqBpXAA0BApYGm3G1K0XYA8C
         XUFMv3U8OEMEiy7AWi1fh6K+BK2aByxHOBiH8VQvmmup5yFfMGI0z8lfv9qFqRmFIyAQ
         KexzlkxGDV3piTvk0bMSfEVsmRXR6VKM8JJPQ9pdXSee9eyIrltmuXBTpZpnd78b8bKf
         nPvDqq95D7IQtElGzDCNT4FTsjvFXZZsF9yv/EI4sJ86fwcnqlmUApN9i+W//DC7b5Da
         CC0c0piM6ib4g2sMVJ4dCRzp2WSETXZ6s/xxq5IlSd0aX0mAJwhC4pZcJK9Wup3FzU6q
         nekg==
X-Forwarded-Encrypted: i=1; AFNElJ+SzhC5rU/edwGlNfZqJtqt86hJYFTsQHz46HOgMvZb70L8rG0i8XxfUC3bpzK9QmFi1mlTs38HQbK1@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCSZZzWSonefFex1evV2f5xKzvUrc1TZtJMOkwf7d51sC+gd9
	9/VsYMcSQoPDaOHZgSKzoS5UbM+M+H7Dshb2sACun9Up1ozY+GCJyb8pcUCfWhhOfvQ=
X-Gm-Gg: Acq92OFePiK6ssU9mw58QA6XN9PeKu599H5oZ4amMkrXBUFbF/+pa5/jWQB5l89aWDB
	BpTWRVqfjqiwjhVG7ZCcpK2kq0z0exMfnEFYcdYku6+buSjqxpEGShRxAR60W+EuB2Y8ja7nYRy
	iMVrfRpZmquiuFGKGjb0ASoIy5oQfmYhQruAp3A5Fyw9C3A0wJwo9/VsNsRf5YI8abqpi0SdSrU
	oZ5TrBIgUxm0qRpvTAVbegIBhF4M72xZuXhNq0sauSsSUN+qHS1dLb27jW6A1ZNVavTRwlhJLxe
	MrY7rNOuKvS/tEA/6c3BiIgN84f7qPGiBtkhbMB/v2FghIcOn73nX6Ypyfnmbn3ESQ67W4q5GCU
	YtlDbN2YMbisarytwtKEge2Ls1IQMYXvwTBiRVgDkIEBrqPFHRlZ8W7UuQtlg/D+SJVBEV8631b
	ALw5oNvgLPcM+8taidEQjJiuIRk2PMZH+suD7EHwHGGuL44QpfwHohHaTW/m82Qm0tWFiMDhfhc
	nZYmgnyW18hSEtJogyO+gk=
X-Received: by 2002:ac8:59cd:0:b0:517:b68a:8d84 with SMTP id d75a77b69052e-517c22529e3mr130851341cf.56.1781055932831;
        Tue, 09 Jun 2026 18:45:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm205923261cf.4.2026.06.09.18.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:45:31 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	kernel-team@meta.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	rdunlap@infradead.org,
	feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com,
	elver@google.com,
	kuba@kernel.org,
	ebiggers@kernel.org,
	lirongqing@baidu.com,
	paulmck@kernel.org,
	gourry@gourry.net,
	dave.jiang@intel.com,
	jic23@kernel.org,
	xueshuai@linux.alibaba.com,
	kai.huang@intel.com
Subject: [RFC PATCH 3/3] acpi/numa: add CONFIG_ACPI_NUMA_ADD_CFMWS_NODES
Date: Tue,  9 Jun 2026 21:45:17 -0400
Message-ID: <20260610014517.253609-4-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610014517.253609-1-gourry@gourry.net>
References: <20260610014517.253609-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL is intended to be a programmable topology, and a single CXL Fixed
Memory Window (CFMWS) may back memory that a driver wants to split across
multiple NUMA nodes for tiering or isolation.

Those nodes must exist at __init time to be usable later.

Add CONFIG_ACPI_NUMA_ADD_CFMWS_NODES, the number of additional standby
NUMA nodes to reserve per CEDT CFMWS entry.

acpi_parse_cfmws() records the per-window count, which is folded into
the standby request on successful acpi_numa_init().

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/Kconfig | 20 ++++++++++++++++++++
 drivers/acpi/numa/srat.c  | 13 +++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index ecf27bf45e5b..65d7eb9a4022 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -14,6 +14,26 @@ config ACPI_HMAT
 	 performance attributes through the node's sysfs device if
 	 provided.
 
+config ACPI_NUMA_ADD_CFMWS_NODES
+	int "Additional standby NUMA nodes per CEDT CFMWS entry"
+	depends on ACPI_NUMA
+	range 0 4
+	default 0
+	help
+	  Number of additional standby NUMA nodes to reserve per CEDT
+	  CXL Fixed Memory Window Structure (CFMWS) entry.
+
+	  By default ACPI reserves 1 NUMA node per unique PXM entry in
+	  the SRAT, or 1 node for a CFMWS without SRAT mappings.
+
+	  Setting this > 0 reserves additional standby nodes per CFMWS
+	  that drivers can claim at runtime via
+	  numa_request_exclusive_node(). This is useful for CXL drivers
+	  that want to place memory on distinct NUMA nodes within the
+	  same CXL Fixed Memory Window.
+
+	  Set to 0 (default) to disable.
+
 config ACPI_NUMA_STANDBY_NODES
 	int "Additional standby NUMA nodes for runtime claiming"
 	depends on ACPI_NUMA
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index d7b0e4ece610..6c54d5f0cf0a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -354,6 +354,7 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 }
 
 static int parsed_numa_memblks __initdata;
+static int cfmws_standby_count __initdata;
 
 static int __init
 acpi_parse_memory_affinity(union acpi_subtable_headers *header,
@@ -454,7 +455,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	 * window.
 	 */
 	if (!numa_fill_memblks(start, end))
-		return 0;
+		goto standby_nodes;
 
 	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
@@ -473,6 +474,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 
 	/* Set the next available fake_pxm value */
 	(*fake_pxm)++;
+
+standby_nodes:
+	/* Request any standby nodes (created after numa_emulation runs) */
+	cfmws_standby_count += CONFIG_ACPI_NUMA_ADD_CFMWS_NODES;
+
 	return 0;
 }
 
@@ -607,6 +613,8 @@ int __init acpi_numa_init(void)
 	if (acpi_disabled)
 		return -EINVAL;
 
+	cfmws_standby_count = 0;
+
 	/*
 	 * Should not limit number with cpu num that is from NR_CPUS or nr_cpus=
 	 * SRAT cpu entries could have different order with that in MADT.
@@ -666,7 +674,8 @@ int __init acpi_numa_init(void)
 		return -ENOENT;
 
 	/* Request any standby nodes (created after numa emulation) */
-	numa_request_standby_count(CONFIG_ACPI_NUMA_STANDBY_NODES);
+	numa_request_standby_count(CONFIG_ACPI_NUMA_STANDBY_NODES +
+				   cfmws_standby_count);
 	return 0;
 }
 
-- 
2.54.0

