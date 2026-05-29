Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D83337B87
	for <linux-acpi@vger.kernel.org>; Fri, 29 May 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042700; cv=none; b=cEQqG9e34IQknzSTzI2FkN7EuNeFZW3fLOF3/wt28gY6n3hcAIwlTbRUYLoYpruZT0y11366S7dLvFJ92cGDup2Cl8HdCd5vUYtCHgOJgR3TyZdsIHqE+2xZdBvm002dxOj9HAxmJrDbpmUZaJQNRVrjLIniKNPcmjO1KMFKcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042700; c=relaxed/simple;
	bh=IM3BzY+gKDUbwOzi0elpTmXkAq0dg7APDtCwAuuGtNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1Bi48KYMb+aIAOsWKpJ69b9798jFHRtVT3XGXuRSrR/X+0/FY1ZSIwxEKMeuYWtnXGoTEG2D+HOiWLyeAsXRm10rZ5Z9ZclnGLiIgR6h26f/sxRNjKnPrNSa1fp2MGxCc9CtIL1zpNal2/jnAvtBv4jLB2xx0nf8Ln/q8yFu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2babfd18435so61820245ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 29 May 2026 01:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042698; x=1780647498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO1vwp8sJ+t+jcxvi6cBiGKxFDrYU96NEUGJgzYEAbw=;
        b=l9mhna+gQrdmljpcdy3WjBhJLZiMk/tiRnx3u1sYy8BZCt8cG41ChTKVO5m92zQzh5
         WqnQVQVH9o5pasmbcVtoJmZpWaSfNEo4pEwNjVj8MutB/H5lFofWV2P4wcmu3OiVWyfg
         gODD23UBkdBkqDVVnqUhq4RrCcffBrjYDZrkL1uC8BHFR0KyHuOe/0pW52CG2RQhmWNF
         paIKzlnAcyOhJQBEUxXiBDgOwkft7xa9CJ34htgFoKWRImXZNJ4CJFKDynRWBin5EV+b
         uYI1XP/7TLMQX2hpKv4Tnu6CJU/LoflAI680AkskvAXhR7UKg4pIYK5VsG9NX6bDkwVk
         hMFg==
X-Forwarded-Encrypted: i=1; AFNElJ9PnH1XrTLjjIxTTnHrh33EOoTwP1O5PJ/XylIxCtgByoaG/LljQjQeV/nicknSv0hkbo69bnwGL5PX@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqwEpsJkZM1foWzH9Sd93byuh7gZwfO7MQnOUGnzirBGAx2mk
	Ot3TzogUACRyWH0dJYavwAhplmDY1r5kK7vA1jodDWdLpxpqd3WLNcYi
X-Gm-Gg: Acq92OHhEjjf8iZNvfCAxOhm7Ejm+m7KEXB1ot4bkxm71P0InsckijVb5cHBTJcdRh/
	uR9NkmP+O8wIliunao48dvT/9niMmD75gGvBfhAsOpayAw9Lr4RomehWs7HljEsuMHv5WqcHsFQ
	lsQ9rX7T3/u9fZC3nrWlnUJ1k0RGLdw8KjdljGFGMMjxZ43u8EOkGYJ3Ki3SMUIwR9IYvg6qTwT
	vECEKnaapIVrZBUPUTBqUe3PuuypjV/2ajrN4LGQcSmQ4Ib3icJXK0tRXzBP19LbIzebWR3nRyi
	9AxjMgLlc44k4br12tZrMmVQTvQCYs9LcR4ZiLfDGpCmUwY9WmkiEhGoxKRr+10EBfUIsVBcOij
	fUgVQvKMeL1MlekayPn/xyThnfBkIGk4CKUTJAv5Xiv2ctzjBtkZb36UlZh49sC4RsiPr0rqlys
	i+QRK9s7+zYGGzvnBQCG9FEW6phbcUMF79HKRVKxYwIvARevR7tZa+q7o=
X-Received: by 2002:a17:903:1ae6:b0:2bd:7191:5708 with SMTP id d9443c01a7336-2bf20bb8cbbmr26366445ad.29.1780042698270;
        Fri, 29 May 2026 01:18:18 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3a5c8sm10204315ad.71.2026.05.29.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:18:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	viresh.kumar@linaro.org,
	saket.dumbre@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] ACPI: CPPC: Add helper to get effective guaranteed performance
Date: Fri, 29 May 2026 16:18:01 +0800
Message-ID: <20260529081801.29346-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the ACPI CPPC specification, if the Guaranteed
Performance register is not implemented, OSPM assumes the
guaranteed performance is equal to nominal performance.

Add cppc_get_effective_guaranteed_perf() helper to provide a
spec-compliant effective guaranteed performance value while
preserving the raw values returned by cppc_get_perf_caps().

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 10 ++++------
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f370be8715ae..6dc11030707a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1328,6 +1328,32 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
+/**
+ * cppc_get_effective_guaranteed_perf - get effective guaranteed performance
+ * @cpunum: CPU number
+ * @guaranteed_perf: Effective guaranteed performance value
+ *
+ * The ACPI CPPC specification states that if the Guaranteed
+ * Performance register is not implemented, OSPM assumes the
+ * guaranteed performance is equal to nominal performance.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf)
+{
+	struct cppc_perf_caps perf_caps;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpunum, &perf_caps);
+	if (ret)
+		return ret;
+	*guaranteed_perf = perf_caps.guaranteed_perf ?:
+			   perf_caps.nominal_perf;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_effective_guaranteed_perf);
+
 /**
  * cppc_get_epp_perf - Get the epp register value.
  * @cpunum: CPU from which to get epp preference value.
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8dc22a65e025..8934e48f71a2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -404,17 +404,15 @@ static void intel_pstate_set_itmt_prio(int cpu)
 
 static int intel_pstate_get_cppc_guaranteed(int cpu)
 {
-	struct cppc_perf_caps cppc_perf;
+	u64 guaranteed_perf;
 	int ret;
 
-	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+	ret = cppc_get_effective_guaranteed_perf(cpu, &guaranteed_perf);
+
 	if (ret)
 		return ret;
 
-	if (cppc_perf.guaranteed_perf)
-		return cppc_perf.guaranteed_perf;
-
-	return cppc_perf.nominal_perf;
+	return guaranteed_perf;
 }
 
 static int intel_pstate_cppc_get_scaling(int cpu)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d1f02ceec4f9..c02f3bc1fc1a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -155,6 +155,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
+extern int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
@@ -198,6 +199,10 @@ static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

