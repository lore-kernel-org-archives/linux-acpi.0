Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387067;
	b=yGqTqV1PrUKNNy9zUuKou2jZdr1xdmPq69jHxNfDaRoGmivB0QwRSSlZyF/nAaNEXQgw
	 /EGTOVAFbhnfEFx9cCskjXgGnucxsyrs+SwY6tIkkWFpbz1sVh79/Dydv3vkRAeiBOSCj
	 lDigUa/NnBzfwhQqNcuAe57j+gJgZpa55fVgE242wyXSgB2PEbsR3U1mIIP1rN1ZRDBAK
	 ILLi3C2aBPObUDcLuF31B2wrFOhsmKDJMD+MI7Bs0iGtqH0gDV7Y8NFLxCNDFK8pmsue1
	 VOR7ozZwO66VM19LH3IHOs7qeIJcPQX4lhkAigmdlnHV6+O8O3/QWjGZx6rHaETTsvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387067;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
	b=gdncJz85cF8/bugpxdzAuSeTmdmd+lqpQJ6m5JBW+kUj5ZkhQ0b+pnpTL9hcNQaJvwv5
	 xaDAgAb/sg/fS1q8hWBcFWKzron9LkwxAE3iCZRHYSXtcIXPB0bADXFg0JNGxYzd5Bcan
	 MYweI36msQ0k5jlm2mzSALfsWhzNJs8RJAF1ALyRR4PQyh2FutEkz7CLo2JsllvzTMGDQ
	 54mpsxJ2yEH1UYS/4hrfl472DF5bLKcTazMp8ymXD71X8Gm2spsc06EU6rmri8bMEcHKu
	 B43KkXIyX9IqgZmis00RQLFDVzTiw2szUqGdtVKl4CJ2zQZ0FQA1hYjs1kK0TOzJxPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D8606A326
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3564so859288a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 00:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387065; x=1794991865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
        b=So1To2EBX4YqERkvE9juReXiFJkRIC+3IcmknbbRyRv6XgqADJyHCyUz4SRUD6uZy0
         aiOEY4cUrKDAYZB8fYChMmsqiDzpOimS2zJ2+ZPo37+QOM9jp7noA6/UH83E1JVswXc6
         4omdFLFY4NE2iLM33MoD2DT3+Y2QHFPebOO9LhqNpPEEdOEoDpoyEyXtXA7R7r8JzPjc
         GfHwY9cb3RtH0sPpYeTEBGXoZiRQq/TaIa/0hu6vBVMjutVwlS/gkvwCH60Hj04R8I02
         V1fR2R9Jzni4F7qyXGinhBtdwNnVpieaN7WEYirtL5baoxuAClRoOjjfiTYuUOkp9Dk9
         jq8Q==
X-Forwarded-Encrypted: i=1; AL+hErEi8EE99W6eTMZ96/XRU4DU7UrAZR0CK+QsWeG5+mB9A6ZD/rO6Y6ZXu+r69kHf3fXm3AStQ3LYvyww@vger.kernel.org
X-Gm-Message-State: APuU4Z+n4HzBdji86JV2eCZuCJzO18rrJI880Muz81P8ZcibVxYAT6nc
	Cf0lmSHgEXb0sygFJw0dI7T1As29RbSMIPQoD0TWj1f4ooMzfL205lHWx2apDe42
X-Gm-Gg: AYBFou2pTrGT2TtiDiXL4TGTRHsyTm+eLW1yuXO8gpACkoyrKc2N9TvDmXSo4B7OLXZ
	v4P8Mqrec6WnVjCt7TkkTnR4VpFmFrEEAN5lX7HnQv3aT2lrFTo4+7BxvPIA59v8Mwux3jyvFaJ
	lIjSOF2ieHsJgU/NpeqI0IId8pd0/gu+se48XkmYpuT4yv6LzVXOLb190pInWltps2jCzCBxuOe
	mj0fAXmVcGgE8Cl4eeqm5ClnaOCTiccgaMpzbK/l+TLRcwUjCcBqfG+LwfPGio127FRsTF6KGD4
	gCm/mGrGPVxoxOXdZek4NJb9+6tt7TfUPyAJaC3wCJMkUCZcla1FdJGVMNWbIY+viTq15lByU+u
	/av7bt7suKsTu9QD2cb4Do8MbqGRnpX6tXZY0+uzUQKR4mKWwE1mMsSXHxXHxspg4k/BBJiApiD
	oj9FQf+wElSdruARoskZ5sYHl8u2IzcWf/awxPvLG48RJnkKePb5X05t2WZunrQkrytCvFkwGAr
	X3vR0s9ORq1fZ23trvdci4XHbLdkrYj9QWxztFGEhbSz5SfBWCcFPx9M+hgHKvU/EzWkHCsCplw
	X64CUIcionzPhvOZEy/nR8K3ZuAIzdSkxRR5acEeApzJpbI1/LM=
X-Received: by 2002:a17:90b:4c4c:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3b182eec040mr1437917a91.20.1794387065472;
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 2/3] cpufreq: cppc: Refactor autonomous perf bounds into helper
Date: Wed, 11 Nov 2026 16:50:21 +0800
Message-ID: <20261111085022.1229866-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
References: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the autonomous selection performance bounds programming from
store_auto_select() into a reusable cppc_cpufreq_set_autonomous_perf()
helper. The helper saves and restores MIN/MAX performance on failure,
keeping the rollback logic co-located with the programming sequence.

Reuse the helper in cppc_cpufreq_update_limits() so that when
Highest Performance changes at runtime, the autonomous MIN/MAX
envelope is re-programmed against the updated capability. Add a
pr_debug message on failure for diagnostics.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3bca30f5c0d5..7dab6e046b9f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -868,6 +868,29 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+/*
+ * Program the autonomous MIN/MAX_PERF bounds from the current policy
+ * limits, restoring the previous bounds if the write fails.
+ */
+static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
+	u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+	int ret;
+
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		cpu_data->perf_ctrls.min_perf = old_min_perf;
+		cpu_data->perf_ctrls.max_perf = old_max_perf;
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Boost being off is enforced through the boost_freq_req QoS request
  * (capping policy->max) rather than by hiding the hardware maximum in
@@ -961,6 +984,18 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	/*
+	 * Autonomous selection mode uses MIN/MAX performance as runtime
+	 * hardware control bounds. Re-program them when highest_perf
+	 * changes so that the platform uses the updated bounds.
+	 */
+	if (cpu_data->perf_ctrls.auto_sel) {
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
+		if (ret)
+			pr_debug("CPU%d: failed to update autonomous perf: %d\n",
+				 policy->cpu, ret);
+	}
+
 	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
 		 policy->cpu, prev_highest_perf, highest_perf);
 }
@@ -1008,20 +1043,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
-		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
-		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
-
-		/*
-		 * When enabling autonomous selection, program MIN_PERF and
-		 * MAX_PERF from current policy limits so that the platform
-		 * uses the correct performance bounds immediately.
-		 */
-		cppc_cpufreq_update_perf_limits(cpu_data, policy);
-
-		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
 		if (ret) {
-			cpu_data->perf_ctrls.min_perf = old_min_perf;
-			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
-- 
2.43.0

