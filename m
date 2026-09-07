Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372940D57B
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763663; cv=none; b=truG37OYoGF+chPmWGDWonj6ykoBMbXnF9hgLeL1dKaUz5rXCsAsouYeWJjDcAP9vL9XCu6N2gUNhUhi/LMkGESKxlU55SBIPEplSpEAdT7pq86UwtgpxEkSw0fjtADiF9AEV9VR723Kiz9hTFi8Tpxv0UGGWUC5lvodWOBRUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763663; c=relaxed/simple;
	bh=Q3bBIxz90yEEYsWH5ikWyXfUpYba5QGg5QwQbHT02IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbnme+JDCu1nTVwur2p35dKStOw0/GXIIMbZsGEiLXLRj3ziZsphzlnX+Xi6GnRlT6neOhJHaZnRSaOtb9POcfx/84gNtkD8tdjmDNAdsZo6skaHJk1BhhawZmXsQ/WA665mgo6/SYbDC/DhKX8/JgLputLB7zzfeKVcDleDBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAZsVs8m; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAZsVs8m"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso3280101a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763660; x=1789368460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=KAZsVs8mh7GDKrQAO6O6sFD1lealyJfsfycKd4Cq8TDv5qJRo2Xv0wNqiSeksip3Jo
         bwaG3maYCK0tnc5KilVd1m53J6omDjYYFBn71RxoIQn2CjnFrZid49ZKQGlVORxQXQ4w
         3EuR+ppm5eOflUmC3jMnalDFXyARUu58qNYhC6WPGNF3VwWzx6L02Cx+4pq2qxgM6SbI
         GRZZgP026U+q7V9bSSs7Kb2SDFe+0hz87+JGgLz9N6gsHe4Cy7Xg9Uu/nYOxbahxER4q
         PD9R9MH5gP9ZU/kkKV1i5mf2HjR19R+PZXTecqVEkWMSuD7YDtCw/JMxaIZ3gYBTtH32
         0YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763660; x=1789368460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh6WnyF7wCSbyOvDJNwh7JY6+tMlKujEj6rsY7bD4mU=;
        b=WxlSlkGnPoLLbcQVHExHHclgRDWl0mylSUaFfT3r5lLFhecRt3X859OyJ8ufPzjt8T
         jnhRpgpkpV2WMrejurJW5Lw5dfRgrAcifrY5f6Cmiy+0stXnMLdRAY78MQburEz9u9Sl
         Ur01p4vBClpf6UJkr8JRhNRDx5lbplbm3tfZ3sWKf9j9GEgGbFF+deu7pb7gSu0rkUNL
         fOVDo4J71xVrUYhjFYw/2Rwkud9S29gApYjzEGRIiTTWZ4Xyd6kcpNcfc57+FYpOfFJj
         YexFDmk3u5i/MCrxxi7H1I4ui25ili/YAWxRFy6y4lIZZkwX1rRqbTPzwxwlddNivveK
         a+QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUIIAACeElVEjRZOMmQpjx5lL6ne5s0rdEijngPVmG7FoHinpkNbYS/6g0mEzI+0J/mdYYd++3c0iE@vger.kernel.org
X-Gm-Message-State: AFuF++kYpKFuHS0xBMdGPE6xRZFRFTy0N6McwbYvyngBWZWtvk7741Vx
	+iK1blIevQPu2Ff0jvjJPVmZ8n+efYPVoxVmmhrukhWEvpdv7jT/hrn9
X-Gm-Gg: AYBFou1zWjCqcuqtfauZdIxI51UtxF7d6HXWRIX9/TdOq5VZoGPkMRLpCAM3v01V275
	WJHS/qpLsvB/GYSiEOKW9YgCiBh2BNqA2/hOGCZusBzQMXzTNnxyrHxj/wWqVMOARSQD0FRSQsr
	vWLIVp8suQ6zy0er2EaX4O3+p3/0ExjTrStXS/ToieXnse6U1ZHNP3cyVelvYOjsadKnJlJIhsW
	DCOS01O0qsp47AEtdhl+d7UEJcULjRM8Oy6u59cJn60jGjehfgsKAJzb/ARdIyLntWMsVqm3c56
	rVA6EUCj0taWDAGPpAB+a6Acg0T7c14j9sx3b+wBEdXZ17c0CuxQD79tP8fU7SPRWcRPQvAkSAt
	YjV3Kn3043n3FazCj38vv0ySZv4I2k6QU+iG4zRdzrO2RkMRpu8MUd3eHHQkMrz0rV4cvZzVFMj
	NB3pZofRCzEFXvPV4RQLcQgeXDtNMv5XpjZWMaDFGB4MsTedSQliw45x7JMVJYaf3oPYg0Yrd/x
	M5NQWp67PdlnA==
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr31452068a91.23.1788763659995;
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:39 -0700 (PDT)
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
Subject: [PATCH 1/5] driver core: fix typo "sucessfully" in comment
Date: Mon,  7 Sep 2026 12:17:21 +0530
Message-ID: <20260907064725.10686-2-hemanth.selam@gmail.com>
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

Correct "sucessfully" to "successfully", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e8244c..3b8ba27802a8 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
-- 
2.48.1

