Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387040;
	b=FyGY9R8b2uzfh+38V8pS1wf1FA1RHIKtMVdrQ1sTbrXd3hlNuIM6TJ07j0sdD2RtoN06
	 z+7fqCpH+PG3peRpQKSWgQd5iPuRgkTTO/TuA1ZIzrbAhO27YbOQe5xAkQgvO/KSPeQs3
	 n+hMqqKAst+wKslLxFIAp0NOdOiACppwlx58CPnPuS82/sFhk1c2XU6ivDbC5lK51d64c
	 6t/X1eMnHA/MmxyR49QGgPMA9r/xPJTIEATn2SYYzgD+OxARw8IN2UKmqwuugSGMxG/Xg
	 E6X0cueOMfua1S8pMVjJzzU4UO4G+1JevMkDC6wgDRdv1IhdyNM2y3qDJYmXxIcXpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387040;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
	b=yETxnqOTKLiewQG0r3NjdhX0aFryv20UmzbYdHD8MGsN0VCNzpognZ+kkcxwJTb/dIvK
	 CWDjyn6gQ/GvIdgHejQt/H+wJncF0G8lLNWfSUn0Xtmp5dc1rdLzxtZ1o+QBKNDIfX8zK
	 yPL6U4eAkxVKSTn4/R2BACu0RgzvATtldFdV8ie7ktMBzAhhc5QcyizMwN1LFcgfctwc2
	 tpTVPWFLATzShB+O1cHDUGERcw6F+c9k54MXQLCYuOGnEXHQhw399lInTPVuNSst+nZF4
	 g6cBGwy4aWf74tn1+IyFrQ0X+S1mGkhKNSYj74Lsn0m9pIyHEbdiOUaW/CDt7FoHZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D459606A324
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 08:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D459606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b0d11b85f0so1780668a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 00:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387039; x=1794991839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
        b=weK7KX9PZl1GEkkzuzejniTtZqbRaISQtimHKaDXvNk17ImRwogyG6nTqBgyrA/sUu
         vHwLbN0KzRnb7cvjL/3wGQyR0eF9t6J3GeyADatOb+BW5uZp1zI2eJZQxzKUoPRsQO8s
         Ox227pVLqRxUVgWiSj0u0Ebbc3UYPWHMAIE60KWr5KfLQb6EjQ4a3fds0XRvA+vFU4rJ
         5jg1sy1LKcRvJPB/3JUW+xz41MACfxijgn8seGbZ5EbZ7jIM2+27TKB+Z9lq3lfIOVBH
         VACs0pXhXWIR266GR8XlfSFt4UdLZu37wGZC0b6ywldb3mUVwBcDo+5bM/TZLj+80gmN
         yY8Q==
X-Forwarded-Encrypted: i=1; AL+hErGIw5hqIcaMEUl/hr5E/IlHoyrDozsBpKCsWTosBO0Wf4d1ioRZZnHXaTprQJdjwhJHQRWEjEkVqZGg@vger.kernel.org
X-Gm-Message-State: APuU4Z9oXvImEO/5h2TXVp2Zo8E9i2z/jojvQYp8XTgfv0DKJPUvJZY2
	HY3C6H6dyiKsUeCZg/4Yaeyb37b/5d/M6QUZZoq7MHpkXyJau2p8fKZY
X-Gm-Gg: AYBFou0zAJMox7aG7iHA4wuAig/pVUKENmwBpCyRMv4hFR4DQTVAz48zRWfN/ClgUed
	wme1VLSx/mb+BjGOuIXlkh29yBHT0bRX5wm2n7rhRfO9Zis2Pu0oCSlLSDsnnTSNW++t7fJpN9V
	xLWcC5BI+iuSjOceBixnxdpGNQLSzXRzxoQ4cXgiMX7647oLksCtt1jYFBbmBbU7wbMBaFNWrFj
	G6MqZEh+jdRuKRu5J8M5sPPc1QO4pvPyeK/3y3r9Ud7pvFX0meFWueMXwJjNhEeKpOZP/ZQKoKj
	wzuQigfcw++ixu1MV3pY1F4ot2V/isYvBDONQTnzhjRNRSGhJMH82CowGKuo2263zknjxOwbp6I
	xI0SndLJ6wtQHbSD0m47LoT7Xhc5iCXYZ0CkFou6LtlhASDU787rZjeGHQKBB5D6Yzvlt5pLWJm
	e/vDBHrr0Ww38YMqFEGW3P1aTMuiNO+1J3VhIeqaab9P+pyZ6OhylXUSpTOEq28Z/Vw8mZaZlV0
	Fulf8tkGQqlo0fNlUtoMTqOdhybcpQwkjAYpcckIMezX7kI7KJ0gDi5KlXd0uvssoGl7fEFVKhw
	ZqXjEBWQrzIXr9dTGukzhxeYfmOe7kHJGX7vjw5TCkF6UKSl/EQ=
X-Received: by 2002:a17:90b:4fd0:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b182eee784mr1752558a91.33.1794387039460;
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
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
Subject: [PATCH v6 0/3] cpufreq: cppc: Handle Highest Performance changes at runtime
Date: Wed, 11 Nov 2026 16:50:19 +0800
Message-ID: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

Hi Rafael, Pierre, Christian, Jie,

This series adds support for handling ACPI CPPC Highest Performance
register changes at runtime, triggered by Notify(0x85) on a processor
device. When the platform changes the Highest Performance value, the
OSPM must re-evaluate the cached capability and propagate the change
to the cpufreq policy, the scheduler's CPU capacity model, and the
frequency invariance engine.

Concrete use cases discussed during review of the previous versions:

- A processor can age over time and its core frequency degrades. It
  is good if platforms can make OSPM and userspace aware of this
  (Jie, Christian).

- Platform operating mode changes between "performance" and
  "powersave" (longer battery life) when the top-most OPP is a
  high-cost one (Rafael).

The mode-switch use case can also move Highest Performance back up,
e.g. when switching from powersave back to performance. update_limits
therefore accepts changes in both directions, capped at the Highest
Performance probed at policy init, as proposed by Christian: any
value above the first probe is ignored, since it would allow boost
support to appear after policy init, which the cpufreq core cannot
handle today (the boost QoS request is only created at policy init).
A policy that started without boost cannot gain it at runtime;
supporting that would need runtime QoS request creation in the core
and is left for later.

v5 -> v6:

- Cap runtime Highest Performance changes at the value probed at
  policy init (Christian): any value above the first probe is
  ignored, since it would allow boost support to appear after policy
  init, which the cpufreq core cannot handle today (the boost QoS
  request is only created at policy init). Within that bound both
  decreases and increases are accepted, so a platform switching back
  to a performance mode restores the previous Highest Performance
  (Rafael's mode-switch use case).

- Refresh the topology capacity for every CPU of the policy
  (policy->related_cpus, covering offline CPUs of the domain as
  well) instead of only policy->cpu, so a shared-policy Notify(0x85)
  targeting any CPU of the policy refreshes the whole domain at
  once (Christian).

- Trim the internal helper comments (cppc_cpufreq_sync_boost_limits(),
  cppc_cpufreq_set_autonomous_perf()) down to the essential notes,
  drop the debug-only value dump, and report boost QoS sync failures
  through pr_err (Jie).

- Ignore values that would drop Highest Performance below Nominal:
  they violate the CPPC invariant and cannot be handled cleanly, so
  the special-casing for them is gone; such
  values are now warned about (Jie).
  topology_update_cpu_capacity() rejects such values as well, to
  match the boot-time validation.

- Return early from cppc_cpufreq_update_limits() when the policy is
  inactive: a concurrent CPU offline may have freed the driver data
  after cpufreq_update_limits() acquired the policy reference.

Note: proposed spec extensions would allow nominal_perf to change
at runtime [1] and introduce a highest_freq value; neither is
handled here.

[1] https://lore.kernel.org/all/20260430142430.755437-3-sumitg@nvidia.com/

The series is split into three patches:
  Patch 1: Core update_limits callback with boost QoS handling;
           runtime changes capped at the boot-probed value.
  Patch 2: Refactor autonomous perf bounds into a reusable helper
           and wire it into update_limits with error logging.
  Patch 3: Topology subsystem runtime capacity updates with
           validation, early-return optimization, and concurrent-safe
           normalization for all CPUs of the policy.

The v5 series was tested on an arm64 8-core big.LITTLE system with runtime
highest_perf changes injected through a debugfs hook that exercises
the same code path as ACPI Notify(0x85), including values above
1024 and full capacity re-normalization (see the v5 discussion for
the measured capacities).

Xueqin Luo (3):
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes
  cpufreq: cppc: Refactor autonomous perf bounds into helper
  arch_topology: Add topology_update_cpu_capacity() for runtime updates

 drivers/base/arch_topology.c   |  77 ++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 157 ++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h       |   1 +
 include/linux/arch_topology.h  |  13 +++
 4 files changed, 235 insertions(+), 13 deletions(-)

Cc: Ionela Voinescu <ionela.voinescu@arm.com>

-- 
2.43.0
