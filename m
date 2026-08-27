Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE7360EF9;
	Thu, 27 Aug 2026 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863500; cv=none; b=XmD2PRXkXP+glhb4ddx0RxfdmIdU8VFv5ltF0ExMQbRNQ13H33FN8CtbzU+EUPkhB9sEG4AM/oJERAdAOnFYLW0Ooz4fkhWXphaGTQUWK3vJEPBgaTfXdhFDR+r+2keDpLEHjt/hYSlDLxGViBOtO1MCxrJF9zW4HJZEXA/9R4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863500; c=relaxed/simple;
	bh=KYfICtcSFfvQ8TeE0qIMFHRGjD2Zc7/d73fIGpwp7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJQ+UVwxXKIR5WwgCT6FiWDp9uSYkqXCJLFE4aDBZjG2Xzu5FPxblZuylwG5dBEsMk8pqz43+xdYsKx2BcctBe7wvG/0IT7S1HbgMzWEHbcyUr3y/S5p7ACCaMcQYLouEU0NGkaoP+BMeTw8doop4+QOxGFCq6wDIKsdnYr4ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MpZbZg+a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MpZbZg+a"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A66E40E01D0;
	Thu, 27 Aug 2026 20:44:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aOu4f02GyiEU; Thu, 27 Aug 2026 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787863485; bh=1RgFFsZHeTL4RzO7yrSrgFLZyu6C+Vvc4pK8jxo7bH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpZbZg+a/cxDR/LH+wUtC1l7LLjhE4cAzQ2I8JG75pNB47b7kO7aoFA9uFHQQFI0F
	 L3i7FifVYLFvYnqvlafGRrarsUnWUnWdNiD5KpVUEirpAw06C+av73n3t09T9nSzct
	 8QWEq0mfsb9YJEyJkTfRvdcGSZD99SKIH8TZsYMK2VOXy0/YGUhl5yQq+jLkftzoRB
	 RAzDQbCSYUhaCWieqUTq80LxxdHrPyx5XznpJR6vbUYN+6jM2j+33ZXrbXEdPqfaaz
	 iSAXtFyBtKgBUuDvhzYu66P5kD/MxNB0v48HLlFGEc/uxBOG38Fxphtc+3kkPplddG
	 cenVhF106hF5wpxjbUxQ/4866Kr9bRtbZ1KYqOjZL7kyTC2VrNlpy53xRDdeYSJkr9
	 xckymJCfsDYOIcWTTBBSH4WFCasn+Zl+wJXUHT6E4Y6RKSSg+Mwy9AKVM2zEo6PyNm
	 2zP1klMmMKZdO7gKh6UWWLaXX+SWetOmGhPsgiH4VWoNCmXYRaoiG/u50NDYmWpTGI
	 qBqzrwsrllmuwMiRXHF2rX768pqdMHEyEga/wPJEIPfSZPobA+HckoOu6QNkT8pUYo
	 kpOTuQKHW5zU3LZmfdtQTU11ORLRip1+GzK7fN2uQcd1MHU7s6moDZ5ZOgpH5EhDN4
	 fKgM6HnQyZpZiSRhVgu60BRs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46AE340E019F;
	Thu, 27 Aug 2026 20:44:29 +0000 (UTC)
Date: Thu, 27 Aug 2026 13:44:25 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	dave.hansen@linux.intel.com, Vishal Badole <Vishal.Badole@amd.com>,
	mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, peterz@infradead.org,
	tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH] x86/topo: Map vendor CPU types to generic Linux such
 types
Message-ID: <20260827204425.GDapChqT4IymVmrf7T@fat_crate.local>
References: <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
 <87fr1us7sa.ffs@fw13>
 <20260721031858.GEal7lIlYLnsf-aEPZ@fat_crate.local>
 <6ff5asua7jywnn7ge4k37bu22artrkfgqybfdt747cm5ieiybo@bwkdi2bqlsm6>
 <20260722183152.GCamEMmAiE2BnyrNOV@fat_crate.local>
 <un5ex54iuszxdubdkjhhtezk4rqkgrzrx4ewgu74id3n3swkyy@hh4df7yq32ox>
 <20260722195105.GEamEfKQIPgWp4HiBk@fat_crate.local>
 <bpncabyd5x7q2niuopingb4ztimoxz7ldw3mha7yntyq5mbsyb@5qjrfihupvym>
 <20260722212314.GFamE0wsvHL6eLvTjT@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722212314.GFamE0wsvHL6eLvTjT@fat_crate.local>

Here's the cleanup ontop, lemme know pls whether that makes sense.

Some noteworthy things:

* this basically switches to TOPO_CPU_TYPE and only the detection code knows
about the vendor-specific ones. The generic types are union set of both.

* We do some CPUID calls where needed:

-			native_id = c->topo.intel_native_model_id;
+			native_id = cpuid_eax(0x1a) & GENMASK(23, 0);

and in get_topology_cpu_type() but those will go away too with Ahmed's rework

The rest is just manual conversion labour. Oh, and TOPO_CPU_TYPE_ANY is gone
too, so that Pawan can sleep at night :-P

Thoughts?

I think it is better this way instead of carrying intel_type and amd_type in
cpuinfo - now the topology code is preparing things for us.

I'll split it into proper patches if people are ok with it.

Thx.

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cc13164d948f..f14775968308 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5682,9 +5682,9 @@ static int adl_hw_config(struct perf_event *event)
 	return -EOPNOTSUPP;
 }
 
-static enum intel_cpu_type adl_get_hybrid_cpu_type(void)
+static enum x86_topology_cpu_type adl_get_hybrid_cpu_type(void)
 {
-	return INTEL_CPU_TYPE_CORE;
+	return TOPO_CPU_TYPE_EFFICIENCY;
 }
 
 static inline bool erratum_hsw11(struct perf_event *event)
@@ -6292,7 +6292,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
-	enum intel_cpu_type cpu_type = c->topo.intel_type;
+	enum x86_topology_cpu_type cpu_type = c->topo.cpu_type;
 	int i;
 
 	/*
@@ -6301,7 +6301,7 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 	 * on it. There should be a fixup function provided for these
 	 * troublesome CPUs (->get_hybrid_cpu_type).
 	 */
-	if (cpu_type == INTEL_CPU_TYPE_UNKNOWN) {
+	if (cpu_type == TOPO_CPU_TYPE_UNKNOWN) {
 		if (x86_pmu.get_hybrid_cpu_type)
 			cpu_type = x86_pmu.get_hybrid_cpu_type();
 		else
@@ -6318,13 +6318,13 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
 		u32 native_id;
 
-		if (cpu_type == INTEL_CPU_TYPE_CORE && pmu_type == hybrid_big)
+		if (cpu_type == TOPO_CPU_TYPE_PERFORMANCE && pmu_type == hybrid_big)
 			return &x86_pmu.hybrid_pmu[i];
-		if (cpu_type == INTEL_CPU_TYPE_ATOM) {
+		if (cpu_type == TOPO_CPU_TYPE_EFFICIENCY) {
 			if (x86_pmu.num_hybrid_pmus == 2 && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
 
-			native_id = c->topo.intel_native_model_id;
+			native_id = cpuid_eax(0x1a) & GENMASK(23, 0);
 			if (native_id == INTEL_ATOM_SKT_NATIVE_ID && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
 			if (native_id == INTEL_ATOM_CMT_NATIVE_ID && pmu_type == hybrid_tiny)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 71ed5b2acea2..89418310b788 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1051,7 +1051,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
-	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
+	enum x86_topology_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 66d964afe18a..ee5a88ffc849 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -207,20 +207,6 @@
 #define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
-/*
- * Intel CPU core types
- *
- * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
- * of the core. Bits 31-24 indicates its core type (Core or Atom)
- * and Bits [23:0] indicates the native model ID of the core.
- * Core type and native model ID are defined in below enumerations.
- */
-enum intel_cpu_type {
-	INTEL_CPU_TYPE_UNKNOWN,
-	INTEL_CPU_TYPE_ATOM = 0x20,
-	INTEL_CPU_TYPE_CORE = 0x40,
-};
-
 enum intel_native_id {
 	INTEL_ATOM_CMT_NATIVE_ID = 0x2,  /* Crestmont */
 	INTEL_ATOM_SKT_NATIVE_ID = 0x3,  /* Skymont */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ec9db0dfa0df..89b0e0886b54 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -69,12 +69,11 @@ extern u16 __read_mostly tlb_lld_4m;
 extern u16 __read_mostly tlb_lld_1g;
 
 enum x86_topology_cpu_type {
-	/* X86_CPU_TYPE_ANY */
-	TOPO_CPU_TYPE_ANY = 0,
+	/* Must remain 0 like X86_CPU_TYPE_ANY for x86_match_cpu() to work */
+	TOPO_CPU_TYPE_UNKNOWN = 0,
 	TOPO_CPU_TYPE_PERFORMANCE,
 	TOPO_CPU_TYPE_EFFICIENCY,
 	TOPO_CPU_TYPE_LOW_POWER,
-	TOPO_CPU_TYPE_UNKNOWN,
 };
 
 struct cpuinfo_topology {
@@ -107,24 +106,6 @@ struct cpuinfo_topology {
 	u32			llc_id;
 	u32			l2c_id;
 
-	// Hardware defined CPU-type
-	union {
-		u32		hw_cpu_type;
-		struct {
-			// CPUID.1A.EAX[23-0]
-			u32	intel_native_model_id	:24;
-			// CPUID.1A.EAX[31-24]
-			u32	intel_type		:8;
-		};
-		struct {
-			// CPUID 0x80000026.EBX
-			u32	amd_num_processors	:16,
-				amd_power_eff_ranking	:8,
-				amd_native_model_id	:4,
-				amd_type		:4;
-		};
-	};
-
 	// Linux vendor-agnostic CPU type
 	enum x86_topology_cpu_type cpu_type;
 };
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1825691af941..ef76ba674f1b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,12 +114,6 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
-enum amd_cpu_type {
-	AMD_CPU_TYPE_PERFORMANCE	= 0,
-	AMD_CPU_TYPE_EFFICIENCY		= 1,
-	AMD_CPU_TYPE_LOW_POWER		= 2,
-};
-
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index bbade0da5130..bb2840c15397 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -274,7 +274,6 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
 		switch (cpu_data(cpu).topo.cpu_type) {
 		case TOPO_CPU_TYPE_UNKNOWN:
-		case TOPO_CPU_TYPE_ANY:
 			pr_warn("Undefined core type found for cpu %d\n", cpu);
 			break;
 		case TOPO_CPU_TYPE_PERFORMANCE:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7352827f491..d0dd120b9c14 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1394,7 +1394,7 @@ static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 	 */
 	if ((boot_cpu_data.x86_model == 0x97 ||
 	     boot_cpu_data.x86_model == 0xB7) &&
-	     boot_cpu_data.topo.intel_type != INTEL_CPU_TYPE_ATOM &&
+	     boot_cpu_data.topo.cpu_type != TOPO_CPU_TYPE_EFFICIENCY &&
 	     !boot_cpu_has(X86_FEATURE_HYBRID_CPU))
 		return false;
 
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 74e02bacd854..b948e87f1722 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -2,6 +2,25 @@
 #ifndef ARCH_X86_TOPOLOGY_H
 #define ARCH_X86_TOPOLOGY_H
 
+/*
+ * Intel CPU core types
+ *
+ * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
+ * of the core. Bits 31-24 indicates its core type (Core or Atom)
+ * and Bits [23:0] indicates the native model ID of the core.
+ */
+enum intel_cpu_type {
+	INTEL_CPU_TYPE_UNKNOWN,
+	INTEL_CPU_TYPE_ATOM = 0x20,
+	INTEL_CPU_TYPE_CORE = 0x40,
+};
+
+enum amd_cpu_type {
+	AMD_CPU_TYPE_PERFORMANCE	= 0,
+	AMD_CPU_TYPE_EFFICIENCY		= 1,
+	AMD_CPU_TYPE_LOW_POWER		= 2,
+};
+
 struct topo_scan {
 	struct cpuinfo_x86	*c;
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index c5a6944df86a..457c27626028 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -177,10 +177,8 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		tscan->c->topo.hw_cpu_type = cpuid_ebx(0x80000026);
-		tscan->c->topo.cpu_type    = get_topology_cpu_type(tscan->c);
-	}
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+		tscan->c->topo.cpu_type = get_topology_cpu_type(tscan->c);
 
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 6845e3c63fbb..40476f5c5cfc 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -35,13 +35,17 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
 {
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
-		switch (c->topo.intel_type) {
+		unsigned int type = (cpuid_eax(0x1a) >> 24) & 0xff;
+
+		switch (type) {
 		case INTEL_CPU_TYPE_ATOM: return TOPO_CPU_TYPE_EFFICIENCY;
 		case INTEL_CPU_TYPE_CORE: return TOPO_CPU_TYPE_PERFORMANCE;
 		}
 	}
 	if (c->x86_vendor == X86_VENDOR_AMD) {
-		switch (c->topo.amd_type) {
+		unsigned int type = (cpuid_ebx(0x80000026) >> 28) & 0xf;
+
+		switch (type) {
 		case AMD_CPU_TYPE_PERFORMANCE:	return TOPO_CPU_TYPE_PERFORMANCE;
 		case AMD_CPU_TYPE_EFFICIENCY:	return TOPO_CPU_TYPE_EFFICIENCY;
 		case AMD_CPU_TYPE_LOW_POWER:	return TOPO_CPU_TYPE_LOW_POWER;
@@ -172,10 +176,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
 
-		if (c->cpuid_level >= 0x1a) {
-			c->topo.hw_cpu_type = cpuid_eax(0x1a);
-			c->topo.cpu_type    = get_topology_cpu_type(c);
-		}
+		if (c->cpuid_level >= 0x1a)
+			c->topo.cpu_type = get_topology_cpu_type(c);
 
 		break;
 	}
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ceb340f7a110..17cfde971f0b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -868,7 +868,7 @@ static struct freq_attr *hwp_cpufreq_attrs[] = {
 
 static u8 hybrid_get_cpu_type(unsigned int cpu)
 {
-	return cpu_data(cpu).topo.intel_type;
+	return cpu_data(cpu).topo.cpu_type;
 }
 
 static bool no_cas __ro_after_init;
@@ -931,7 +931,7 @@ static int hybrid_get_cost(struct device *dev, unsigned long freq,
 	 * capacity.  Similarly, P-cores start to be populated when E-cores are
 	 * utilized above 60% of the capacity.
 	 */
-	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_CORE) /* P-core */
+	if (hybrid_get_cpu_type(dev->id) == TOPO_CPU_TYPE_PERFORMANCE) /* P-core */
 		*cost += 2;
 	else if (hybrid_has_l3(dev->id)) /* E-core */
 		*cost += 1;
@@ -2235,7 +2235,7 @@ static int hwp_get_cpu_scaling(int cpu)
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (hybrid_get_cpu_type(cpu) != INTEL_CPU_TYPE_ATOM)
+		if (hybrid_get_cpu_type(cpu) != TOPO_CPU_TYPE_EFFICIENCY)
 			return hybrid_scaling_factor;
 
 		return core_get_scaling();


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
