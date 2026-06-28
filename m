Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F43137923
	for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655128; cv=none; b=m/HJfOrJ9xzvU7tc8P9ywB74MuRxQ1MdltAnjcscWY2+yhbn/mN57g4W6f9D8iW/1JKfRQd7/RNueyda5hyOvRCEpn++8ta6Fr1jI0+lpOWQhii8HuoiBa8j8MMRlmZPNB/Knh1vV9PR0lWRNokrJnmspapCAxKyle2HKQKDbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655128; c=relaxed/simple;
	bh=6v6v2ULEr3fHA6z2S75XCk0D6N6PWELU8FGUV4DrvhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF5ydFQIaDagHfemt6ued+ef3tVBUigwd8rrU1uX4u2MCF0D3KgKh3UXzXZoTX6iA+oA3G819FPxUra1mQcn/CseaZslLIZMBPPhZMPk7o/lj/SYeOPHjo3McFXhr0H7oMDqFX5m5XrXBf0jnHrAvVM3m9Z+GFvoDKZBN2qdkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9QYZI5z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9QYZI5z"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842358aaf36so1037789b3a.2
        for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782655127; x=1783259927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcDVoZL/NYCcO87EVs1DzwCYLIxfylDfBkgHyvQhJNM=;
        b=l9QYZI5zdiZOTU83PIJphAvwig99F+6pprYQhA9qxS9nkNWTbT6PlAGDlAc3KSHMT1
         8dnxMt2T/5yqniOSqOl4FPllF321iNDBfxgxFslC2EszN7chx3FdRC+GmYndGw8TUxtM
         tO7ymmeO+7ee8vQ/naRW7Kwps3cMUINf/RlesxGbGRGjIFYu43DGOMER+OqTrtMAen1f
         R6RQFkfJldfW8sLMDmMLDCM2g12TDyVF4fexgaSSiUzKMvab/dUtMRyrapzlS8P0fJHf
         XS796xk4GEshViI+ok4MMlh9z2vwEyaSfU67IfQyR+C5QEgytJR1Ct5+bxkijSDZHAN1
         bang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782655127; x=1783259927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcDVoZL/NYCcO87EVs1DzwCYLIxfylDfBkgHyvQhJNM=;
        b=KxlmjIb881B91JnpEgJdcapFXySbUE8KRJBrtviBsCJrrIzDn3tEXXiXEhWIJWf4cw
         uv4FLqFhJzbnbjBSk4xq/g8vnudOzI/4BOwfWqZv1s9GEmRsFKXFWQ+cKTf78Xy1tiBz
         wRstwHVHsrgbBMLPfZoY+yN+EiISkfD5yaD/VSeP+onlfaIVqTIW60xVsb21CCjXZcet
         Rjfo0s6ZUwt2Cmyrp7sWcqyJr/H47YAnjUvnv1HP1ZSW8ZnkrF9QoecIzLxhB7aVFwy6
         cHzfA9n54kRURoPr9sPExV7Via9JygAD4fomgRnCJXXGZF3nzQfSgp1L6SrXfHd8F4lQ
         NIAw==
X-Forwarded-Encrypted: i=1; AHgh+RqBqcGWbgb9auXmAGqOpb3goBNYurPws0XBNtKQf4Js/FnIeoABYkLIXz254++rzKxivRNHLLKH3Ip2@vger.kernel.org
X-Gm-Message-State: AOJu0YzALUE//xFC1/awaZ2FPgqJVrEKNR7pv5/lDSRXVtauYh2Hkms9
	ziMQhes4xGQhXrDITqUJi7OoPbQf8qY1CEiF0UsVdx6cQ9Vw28kiL7/EB9TQ4w==
X-Gm-Gg: AfdE7cnAFxwgj+sqv5gZm7sjXPxQAeqlOZKbMZ9jdtW6pENaZGQC1cDy2F5W7P2cg1X
	TrwExrPVYD8nXEy8ah9TUVwr6MSVXp2fJESijj5GKQbQuJYFYRV6Wk2ea3CmR4XWpGfUeWsELga
	KIlO8wtH17yxwHHrlqviaGMLX5URvqVO4jgpItiGxLrK3GG4kfBW2IjZVctwxl4fnc3sFQHNcaK
	JkSAIIku4X8TaOfjskgfNZyczdsoFmJOTabMHZr7cfnIT6tSIuTxsf4TPE0dNq6jOoY/0ljdxv0
	0zqg+nDWACvW9SOYU6x78uM2V/jxODc748jey82L213NtsAy4CyttogoBl0A4Auobg8Y6aOELdC
	WnEtFYcsXR4xp9nDMv7sR19md/7LF/hTJTMevb1XuSemFDgQIw7ywtlMPjwsdJRIyHAeZR8bD4+
	pe9Rd9DVkM2egYOpNmyQ==
X-Received: by 2002:a05:6a00:4c0c:b0:845:d286:1fb8 with SMTP id d2e1a72fcca58-845d2863275mr6444084b3a.54.1782655126853;
        Sun, 28 Jun 2026 06:58:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23d7sm10041108b3a.30.2026.06.28.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:58:46 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/9] ACPI: NUMA: remove redundant numa_nodes_parsed node_set()
Date: Sun, 28 Jun 2026 22:58:16 +0900
Message-ID: <20260628135828.1393120-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628135828.1393120-1-ekffu200098@gmail.com>
References: <20260628135828.1393120-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

numa_add_memblk() now sets the node in numa_nodes_parsed itself, so the
caller's own node_set() is redundant. Remove it.

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

