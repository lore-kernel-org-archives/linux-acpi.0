Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423851120F;
	Tue, 29 Sep 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677841; cv=none; b=g8/5ckr8rW1U+S2yarmizb8kUeprSivl4IKmbh6WJBdb3vwz3iRQoD31FVuk95vJb+3Wchk1yhXx8eF2miWMT9dGxYUDwYi0eaX3jLSMrX53OYMJmmrj7OFEJvbgxzg7sip0V/PhFOVlXdOlLUcuNiE7jMRZLY3YfcHGOIVoilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677841; c=relaxed/simple;
	bh=pgtgm8oCBfWgTizqvar+fay5aufquDRaH/ZtXkwXIuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd8fSiGUYYmy/lhJLte4KJORqGmqqWSKA1QdanFhlSGf9KR5Ud9wFYbSEuiYdnPGpiPY3GIG5fozA/81pWt0Sj55rcHYF9uFvcwa5AkWWzScQLWLffKgVWvl1WudgeFk5oLHozVMZPaebbkmm+2adyG+rvxQzJT1id2LcFrnjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fr1CgNRU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fr1CgNRU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A47A1655;
	Tue, 29 Sep 2026 03:30:20 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 998E73F86F;
	Tue, 29 Sep 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790677824; bh=pgtgm8oCBfWgTizqvar+fay5aufquDRaH/ZtXkwXIuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fr1CgNRUGUZkEfQAFZvYcBHrKgELp+wutD+eOOApcVbUso74X3BwSppTqAYhj+3bJ
	 BX0tOAJXSIFSssRvJb1c0nE8OV4gxK9xUd9K/2PShbBB/FyQQ+tqTED/cn8NxBxSyE
	 0jrokF6ivmP8SIK3YYmPj/mBDIxRrT9ASzY8dfzw=
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
Subject: [PATCH 3/3] cpufreq: Skip updates for unchanged resolved limits
Date: Tue, 29 Sep 2026 11:29:57 +0100
Message-Id: <20260929102957.2591657-4-christian.loehle@arm.com>
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

Commit 9801be8bef65 ("cpufreq: Avoid redundant target() calls for unchanged
limits") introduced policy->update_limits to skip ->target() when both the
frequency and effective limits are unchanged. schedutil still bypasses its
frequency cache on every limit notification for CPUFREQ_NEED_UPDATE_LIMITS
drivers, and fast switching never consumes the pending state.

Keep raw QoS/limit notifications triggering schedutil recomputation, but
only let CPUFREQ_NEED_UPDATE_LIMITS force a same-frequency callback when
resolved policy->{min,max} changes remain pending. Expose that test through
a cpufreq-core helper.

Consume pending state before both slow and fast callbacks, including
frequency changes, instead of clearing it only in the target == cur case.
Use release/acquire ordering for the limits and restore pending state on
failure, preserving concurrent updates and retries. Favor the maximum
if lockless limit reads observe an inverted pair.

This applies to cppc-cpufreq and amd-pstate's frequency-based paths; the
->adjust_perf() path is unchanged.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cpufreq.c        | 82 ++++++++++++++++++++++++++------
 include/linux/cpufreq.h          |  1 +
 kernel/sched/cpufreq_schedutil.c | 19 ++------
 3 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44bda2f32fcf..9e932c2a986d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2058,6 +2058,21 @@ bool cpufreq_driver_test_flags(u16 flags)
 	return !!(cpufreq_driver->flags & flags);
 }
 
+/**
+ * cpufreq_driver_needs_limits_update - Check for a pending driver limit update.
+ * @policy: CPU frequency policy to check.
+ *
+ * Return: Whether changed resolved limits require a driver callback.
+ */
+bool cpufreq_driver_needs_limits_update(struct cpufreq_policy *policy)
+{
+	if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+		return false;
+
+	/* Pairs with cpufreq_set_update_limits(). */
+	return smp_load_acquire(&policy->update_limits);
+}
+
 /**
  * cpufreq_get_current_driver - Return the current driver's name.
  *
@@ -2183,6 +2198,30 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
  *                              GOVERNORS                            *
  *********************************************************************/
 
+static bool cpufreq_test_and_clear_update_limits(struct cpufreq_policy *policy)
+{
+	if (!cpufreq_driver_needs_limits_update(policy))
+		return false;
+
+	return xchg(&policy->update_limits, false);
+}
+
+static void cpufreq_set_update_limits(struct cpufreq_policy *policy)
+{
+	/* Publish the new limits before making their update pending. */
+	smp_store_release(&policy->update_limits, true);
+}
+
+static void cpufreq_read_policy_limits(struct cpufreq_policy *policy,
+				       unsigned int *min, unsigned int *max)
+{
+	/* Lockless reads can mix limit updates; favor max if inverted. */
+	*min = READ_ONCE(policy->min);
+	*max = READ_ONCE(policy->max);
+	if (unlikely(*min > *max))
+		*min = *max;
+}
+
 /**
  * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
  * @policy: cpufreq policy to switch the frequency for.
@@ -2209,14 +2248,20 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
-	unsigned int freq;
+	bool update_limits;
+	unsigned int min, max, freq;
 	int cpu;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	update_limits = cpufreq_test_and_clear_update_limits(policy);
+	cpufreq_read_policy_limits(policy, &min, &max);
+	target_freq = clamp_val(target_freq, min, max);
 	freq = cpufreq_driver->fast_switch(policy, target_freq);
 
-	if (!freq)
+	if (!freq) {
+		if (update_limits)
+			cpufreq_set_update_limits(policy);
 		return 0;
+	}
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
@@ -2367,12 +2412,16 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int min, max;
+	bool update_limits;
+	int ret;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+	update_limits = cpufreq_test_and_clear_update_limits(policy);
+	cpufreq_read_policy_limits(policy, &min, &max);
+	target_freq = __resolve_freq(policy, target_freq, min, max, relation);
 
 	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
@@ -2384,11 +2433,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	 * calls.
 	 */
 	if (target_freq == policy->cur) {
-		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
-		    !policy->update_limits)
+		if (!update_limits)
 			return 0;
-
-		policy->update_limits = false;
 	}
 
 	if (cpufreq_driver->target) {
@@ -2399,13 +2445,19 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		if (!policy->efficiencies_available)
 			relation &= ~CPUFREQ_RELATION_E;
 
-		return cpufreq_driver->target(policy, target_freq, relation);
+		ret = cpufreq_driver->target(policy, target_freq, relation);
+	} else if (cpufreq_driver->target_index) {
+		ret = __target_index(policy, policy->cached_resolved_idx);
+	} else {
+		if (update_limits)
+			cpufreq_set_update_limits(policy);
+		return -EINVAL;
 	}
 
-	if (!cpufreq_driver->target_index)
-		return -EINVAL;
+	if (ret && update_limits)
+		cpufreq_set_update_limits(policy);
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2681,7 +2733,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      CPUFREQ_RELATION_H);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
-		policy->update_limits = true;
+		cpufreq_set_update_limits(policy);
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
@@ -2689,7 +2741,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-		policy->update_limits = true;
+		cpufreq_set_update_limits(policy);
 	}
 
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a0a7619d11fd..acd60c2b30f1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -499,6 +499,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 void cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
 bool cpufreq_driver_test_flags(u16 flags);
+bool cpufreq_driver_needs_limits_update(struct cpufreq_policy *policy);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..43e448ee3c4c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -123,22 +123,11 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->need_freq_update) {
-		sg_policy->need_freq_update = false;
-		/*
-		 * The policy limits have changed, but if the return value of
-		 * cpufreq_driver_resolve_freq() after applying the new limits
-		 * is still equal to the previously selected frequency, the
-		 * driver callback need not be invoked unless the driver
-		 * specifically wants that to happen on every update of the
-		 * policy limits.
-		 */
-		if (sg_policy->next_freq == next_freq &&
-		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
-			return false;
-	} else if (sg_policy->next_freq == next_freq) {
+	sg_policy->need_freq_update = false;
+
+	if (sg_policy->next_freq == next_freq &&
+	    !cpufreq_driver_needs_limits_update(sg_policy->policy))
 		return false;
-	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
