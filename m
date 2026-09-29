Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286A3D811C;
	Tue, 29 Sep 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677828; cv=none; b=Ada5Rwg1iV9fP39567AlTDQkkahWElm1zHRw2cD0QpPU4nOAfcH7LKz7F8fzUafzY9uz/VW2l2R/7btlNB0xuNaGvb41IpHuLxX47v4Rkrcgt4iOk3OyegW5oS85c4AIgd7V9sZm1x1GUvdxWxnb/CNfGDs9sgpIjBSSfcpmwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677828; c=relaxed/simple;
	bh=3jvnpx6ciNS2cbKDocJORo//5TgXhSMCsijbl9aFnAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJ5XvFGYRWsB7GuUFiGYhe7Df/86C7NzxJy+742CzrcRGlQ/5ypFcvmdQygr3z81X7sPz1N9bgmSzANYOK10fSuUlOqS1yAMp1lzjbfbG+B9W2ix6kC44t4Bm90YFtqfNd5FiC676vQ4D/sRYYbI7oAfKPdMggMLOvdpsuYsqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lfz3Vj5z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lfz3Vj5z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E36152B;
	Tue, 29 Sep 2026 03:30:09 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96D743F86F;
	Tue, 29 Sep 2026 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790677812; bh=3jvnpx6ciNS2cbKDocJORo//5TgXhSMCsijbl9aFnAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lfz3Vj5zCxHxFsRYSeob/Q6ePM6eRq++uaBozDEi9CJTKKnYKT19/01wHyh6feyKb
	 Brl28H+4FesiQvA+/ZvhSbCKkpg8wWwzIYiz6RO/g1WVSSlV8n/2DtD7pBeS3cB/tW
	 FMBXFPIt6lEgVneZTqfxCGTh+UkFU7+CzMjOFouI=
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org
Cc: zhenglifeng1@huawei.com,
	zhongqiu.han@oss.qualcomm.com,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jonathanh@nvidia.com,
	zhanjie9@hisilicon.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/3] cpufreq: Add a driver frequency resolution callback
Date: Tue, 29 Sep 2026 11:29:55 +0100
Message-Id: <20260929102957.2591657-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929102957.2591657-1-christian.loehle@arm.com>
References: <20260929102957.2591657-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without a frequency table, cpufreq treats the policy range as continuous
even when the driver selects discrete performance levels. Governors can
then issue different kHz requests for the same driver setting.

Add ->resolve_freq() for table-less ->target() drivers to canonicalize
requests within the supplied limits using CPUFREQ_RELATION_{L,H,C}.
Document the callback and verification contracts so callers can safely
cache resolved requests.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/admin-guide/pm/cpufreq.rst |  4 ++++
 Documentation/cpu-freq/cpu-drivers.rst   | 19 +++++++++++++++++++
 drivers/cpufreq/cpufreq.c                | 17 +++++++++++++++--
 include/linux/cpufreq.h                  | 10 ++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 34baf20cc202..e634b87a62a8 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -144,6 +144,10 @@ that belong to the same policy (including both online and offline CPUs).  That
 mask is then used by the core to populate the policy pointers for all of the
 CPUs in it.
 
+A table-less driver whose discrete frequencies are derived at runtime can
+instead provide a ``->resolve_freq()`` callback to map arbitrary requests to
+deterministic, supported frequencies.
+
 The next major initialization step for a new policy object is to attach a
 scaling governor to it (to begin with, that is the default scaling governor
 determined by the kernel command line or configuration, but it may be changed
diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index 17c69f83691e..4f327760bc04 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -86,6 +86,9 @@ And optionally
  .set_boost - A pointer to a per-policy function to enable/disable boost
  frequencies.
 
+ .resolve_freq - A pointer to a frequency-resolution function for table-less
+ drivers with discrete, runtime-derived frequencies.  See below.
+
 
 1.2 Per-CPU Initialization
 --------------------------
@@ -170,6 +173,22 @@ limits on their own. These shall use the ->setpolicy() callback.
 1.5. target/target_index
 ------------------------
 
+Table-less ``->target()`` drivers may provide ``->resolve_freq()`` to map a
+clamped target to a supported frequency within the supplied limits.
+``CPUFREQ_RELATION_L`` selects the lowest frequency at or above the target,
+H the highest at or below it, and C the closest, choosing higher on ties.
+If no supported frequency is at or above the target, L returns the highest
+supported frequency in the interval. If none is at or below the target,
+H returns the lowest supported frequency in the interval.
+``CPUFREQ_RELATION_E`` is stripped before the call.
+
+Equivalent requests must resolve to the same frequency, which the target
+callbacks must map to one canonical driver request even if performance levels
+share a kHz value. This lets callers cache resolved requests. ``->verify()``
+must leave a supported frequency in every accepted limit interval.
+The callback must not sleep: it may run in scheduler context.
+Policies providing both a frequency table and this callback are rejected.
+
 The target_index call has two arguments: ``struct cpufreq_policy *policy``,
 and ``unsigned int`` index (into the exposed frequency table).
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..44bda2f32fcf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -480,8 +480,12 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 
 	target_freq = clamp_val(target_freq, min, max);
 
-	if (!policy->freq_table)
+	if (!policy->freq_table) {
+		if (cpufreq_driver->resolve_freq)
+			return cpufreq_driver->resolve_freq(policy, target_freq, min, max,
+							    relation & ~CPUFREQ_RELATION_E);
 		return target_freq;
+	}
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
@@ -495,7 +499,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
  * @policy: associated policy to interrogate
  * @target_freq: target frequency to resolve.
  *
- * The target to driver frequency mapping is cached in the policy.
+ * The frequency-table resolution path caches the mapping in the policy.
+ *
+ * Keep the policy active and exclude driver teardown; a policy reference
+ * alone does not protect driver-private data.
  *
  * Return: Lowest driver-supported frequency greater than or equal to the
  * given target_freq, subject to policy (min/max) and driver limitations.
@@ -1445,6 +1452,11 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 		 * If there is a problem with its frequency table, take it
 		 * offline and drop it.
 		 */
+		if (policy->freq_table && cpufreq_driver->resolve_freq) {
+			ret = -EINVAL;
+			goto out_offline_policy;
+		}
+
 		ret = cpufreq_table_validate_and_sort(policy);
 		if (ret)
 			goto out_offline_policy;
@@ -2925,6 +2937,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	     (driver_data->target_index && driver_data->target) ||
+	     (driver_data->resolve_freq && !driver_data->target) ||
 	     (!!driver_data->setpolicy == (driver_data->target_index || driver_data->target)) ||
 	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
 	     (!driver_data->online != !driver_data->offline) ||
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..a0a7619d11fd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -364,6 +364,16 @@ struct cpufreq_driver {
 	int		(*target)(struct cpufreq_policy *policy,
 				  unsigned int target_freq,
 				  unsigned int relation);	/* Deprecated */
+	/*
+	 * Optional for table-less ->target() drivers. Resolve a clamped request
+	 * within the supplied limits using CPUFREQ_RELATION_{L,H,C}. Must not
+	 * sleep. See Documentation/cpu-freq/cpu-drivers.rst for the contract.
+	 */
+	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
+					unsigned int target_freq,
+					unsigned int min_freq,
+					unsigned int max_freq,
+					unsigned int relation);
 	int		(*target_index)(struct cpufreq_policy *policy,
 					unsigned int index);
 	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
