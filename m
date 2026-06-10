Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE831A045
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055939; cv=none; b=TqILVLmOZFa/bVRrBHlsjh0gVCbSq/QTh6XRoD8tdLBo4ch9jXdrf2maIK0j8LC0mS996+5ocvzxkXZjtbm8Xkv0zG9d8+HFvb2sjGA5BSCGQuJ7hKrfP1ktT8VcbAulz8WVbSnuPq7bR9Ce3ZMN50AYJcomaO6JorisZpsb/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055939; c=relaxed/simple;
	bh=8Jzxfarh3kFcVduKM3nTtCfp1Kiq3jIGAAIiFN4XSUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG636XzHvZQk5KFomRS9BUk2nak39Atoi5TDqn6Yuxt2bgF+mR/yh+TCYBLx8Cm448cDqCiBZzVUJQvtLtL6V93EIxgiaJkYkpSolmLyY8Oql5nfGLPUMelnboEw+HzOjOEXll32SYQPtfEh95DGPdNOS+gQhNUcAEphBarrqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rYvBp0RK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rYvBp0RK"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177945a22eso42415501cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781055930; x=1781660730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKutm9+cyTIXeV2mo8MjsDLORYjIUZMG6rmHK81GwDk=;
        b=rYvBp0RK6rS5y9eHOoaKo8TGPX0WRF9hW1coBVw12TFzMDXM3WtuEGMTLEOVjJcJr3
         +mupQNyLOQ5bxwZ68Ou/xQB0QGoGBJkXSYqmd3tRIkuC1xsnFROsCb/ohUmDludUpMra
         ztEKMdCCteNaqWK1XmKn6slVV18pgfU0iatsRg7ei7stV/fcfemAW79oRLHOEGjEXFtd
         vmo8mpmD0KcCNMNRy2cN88bHe/cC4+CMUB8pNOksO1LV5UvZAY5s4I04I2GS0OweWk0j
         1qVWvPMy5fs/E8B2OThIlMW8AAFdGN44EOoITnzzWIVZYtoyc3tzFg16kSktdHUfoINc
         NpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781055930; x=1781660730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pKutm9+cyTIXeV2mo8MjsDLORYjIUZMG6rmHK81GwDk=;
        b=Vaj0g5OaI+jfDxGjvifj2pJbVjns/9n4arQGizgEgBsQL+h8SqRx0N3iGEyGkCA2hX
         xqzIGUZXMwc5NPi5h77du2kA5GMPUmrs9Bky0rV4rjChwyybOUvqOxGrJIq0bRF7U/9G
         XrZEowS9bk52z/nMooE7fdY4koaW643RTCTTYu3WGYiePesVvVwIV+I2avSXSDlok4kZ
         dTOwTka7dmvIimNWqweGjLuz/p9YpPdjCyfFAbJri8OohJ7grATtJSJQ22oo0WKB+X88
         9ufazReRqmS8QSRUQWB/ASvd8bb5O8ik3EtwdusWFjKRhoyq1xNh/fERlZ+kySGbV5up
         t+Vw==
X-Forwarded-Encrypted: i=1; AFNElJ92NbKxUKA6mk8q8tVR7y3umBI7AOWmHO+z3oI7nZZjevgISCCjK9EG9LxgyfkOMp4uW3saVHxAfGfa@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCSu3GKkvL7D+AQS2gw/NmtrQWpC2mYkg9Gwj5TKubm56Wquw
	75udyEU4w8W//27lrePONzihTeCkYXHgeAJcefFnUKAOUXyZT0GFHxEuLdtFa9V5ieI=
X-Gm-Gg: Acq92OEWW8RQDSrwMphRix2Lfi0zyYFAEjU1+XJdz8YsKgezvfHyxqpekhZeCd6gPoD
	Ykq0R0MmVudzGKdoOF9Op4ayVV7OpAh+Slg4Am+4RGpmPZvuZntSJYvCaPmHQiYCNmwHassJPTH
	T3Mz/7ifqp5GqNRA4LZ223XwTbtB2TRgVdmv45DZMIPAd3Rnce9LQw03W7gKx0pUp/6lp19lvX4
	7/U1NvcCOuI8jltG0HrJP9gyFZa5t+ORaTT35qAsZpmC4suJQvpbFD/hAq4qD+J3+QZfb7BdqVu
	4ozYrlG3NjJDmBUwzXjJiDQ2iGYeZy40+Q1o4FzsnHG9yMTFt7LnTIj4sqjBne5hkpUlqm2X22h
	CFbnwtuD4HSxnalVPDhSQlxs9NNAOPBfhw0+jHIZHwFRaM3vRm+WJ6TEIFynDPl5n9NKpIohwuD
	09TpnG5DlgR7ehIRbEtVDzHpYRkkvUZwcaPC3xS3CsnVE2mGMsrbWIUrkKuRVWj5Hf9yagWa3q9
	U9oTz72epbsXSPIOPSEx4M=
X-Received: by 2002:a05:622a:155:b0:516:cee1:4727 with SMTP id d75a77b69052e-51795aeb96bmr323037361cf.14.1781055930465;
        Tue, 09 Jun 2026 18:45:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm205923261cf.4.2026.06.09.18.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:45:30 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] acpi/numa: add CONFIG_ACPI_NUMA_STANDBY_NODES
Date: Tue,  9 Jun 2026 21:45:16 -0400
Message-ID: <20260610014517.253609-3-gourry@gourry.net>
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

Some platforms want to reserve empty NUMA nodes at boot so that drivers
can later place hotplugged memory on distinct nodes for memory tiering
or isolation, without those nodes being described by BIOS.

Add CONFIG_ACPI_NUMA_STANDBY_NODES, a platform-independent count of empty
nodes to reserve.

Deferring standby node creation until after NUMA emulation runs keeps
old numbering behaviors consistent for NUMA emulation users.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/Kconfig | 15 +++++++++++++++
 drivers/acpi/numa/srat.c  |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index f33194d1e43f..ecf27bf45e5b 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -13,3 +13,18 @@ config ACPI_HMAT
 	 register memory initiators with their targets, and export
 	 performance attributes through the node's sysfs device if
 	 provided.
+
+config ACPI_NUMA_STANDBY_NODES
+	int "Additional standby NUMA nodes for runtime claiming"
+	depends on ACPI_NUMA
+	range 0 16
+	default 0
+	help
+	  Number of additional empty NUMA nodes to reserve at boot for
+	  runtime claiming via numa_request_exclusive_node().
+
+	  These nodes have no memory and no SRAT PXM association.
+	  Drivers can claim them to place hotplugged memory on distinct
+	  NUMA nodes for memory tiering or isolation purposes.
+
+	  Set to 0 (default) to disable.
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 62d4a8df0b8c..d7b0e4ece610 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -664,6 +664,9 @@ int __init acpi_numa_init(void)
 		return cnt;
 	else if (!parsed_numa_memblks)
 		return -ENOENT;
+
+	/* Request any standby nodes (created after numa emulation) */
+	numa_request_standby_count(CONFIG_ACPI_NUMA_STANDBY_NODES);
 	return 0;
 }
 
-- 
2.54.0

