Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7837DE9C;
	Tue, 28 Apr 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406284; cv=none; b=Um6izXIVNaIULr8VeaN7GBorHJiNAm1z3PrMNFTwaJxutKpO7SMbo0M8veZEpEHIfBjXtNNKtZH/Nhhrx6bztymdrK796vKq+BAVyYzcJSXUxiv1I0Nt9xDldkrT4PfJaNLXUVytZUbadzPdmMfsbY1qbvrHv7djlFL2Yh/qN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406284; c=relaxed/simple;
	bh=zFgNWfZSEqgCFcgqcUHtQKyZTcZwk3wBCHx6C7PWvi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiByOSebO5bTZLjRf1fCsbxx1rDlL3nheS4RVGmzk7VUrDTLMWCI3SPjbJYg3HR6E7aQkPjVSUD8AZfWbRPV4oHd4hXoeZB/tzDZkKqFyTZicO1whx10pKgn5g1q5LT9nt5XghbgqSCOusMuSKL2cS1BCWdAAGy9/DiT+n9SXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naLVyCr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naLVyCr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FC3C2BCAF;
	Tue, 28 Apr 2026 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777406284;
	bh=zFgNWfZSEqgCFcgqcUHtQKyZTcZwk3wBCHx6C7PWvi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naLVyCr5CUdgRGOGvSLpDyJGH8yptYqJiR+S6hz4bTGBNVeIl7o4CRd6vezA1TCcP
	 Ks8rk3vMJ4aJ0arX5e1CjNSM2/SwBlwxbLTNN7qDuN5CDRQ3XqB1sj+R+s9/yeRsYa
	 Mym+ExvCa83itBWy01qbXotNJqBuXEYWxneD+65+SYRr6GIQ+eF4HMBcg7BdIZNBq+
	 g4Xd0bY7H/ur83Tywu3wFm7WQyvlDPBmZt88T8hABMFA4LiUZe0fDwP7z1sRuO1UOP
	 FsDmFjxBo/sniHryZkM2T8TTvdE5k0vJeLYTCzC0IOY9lILvHj99qYK8yJcsKuK2/l
	 Um72PJvr3hExQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Tue, 28 Apr 2026 21:58:01 +0200
Message-ID: <12904177.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY1VBXN_6xY0WiraJt-BQiYp_kSdTt8xbPkgP8xPB26=WQ@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <6281827.lOV4Wx5bFT@rafael.j.wysocki>
 <CAGAxtY1VBXN_6xY0WiraJt-BQiYp_kSdTt8xbPkgP8xPB26=WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, April 28, 2026 9:11:34 PM CEST Evgeny Sagatov wrote:
> Yes, the PC froze when I pressed the power button.

Well, in that case, let's try to serialize all accesses to I/O ports
used in the ACPI code.

The patch below replaces the previous one, please give it a go.

---
 drivers/acpi/osl.c             |    6 ++++++
 drivers/cpufreq/acpi-cpufreq.c |    4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -664,6 +664,8 @@ u64 acpi_os_get_timer(void)
 		(ACPI_100NSEC_PER_SEC / HZ);
 }
 
+static DEFINE_RAW_SPINLOCK(acpi_os_port_lock);
+
 acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
@@ -682,6 +684,8 @@ acpi_status acpi_os_read_port(acpi_io_ad
 	else
 		value = &dummy;
 
+	guard(raw_spinlock_irqsave)(&acpi_os_port_lock);
+
 	if (width <= 8) {
 		*value = inb(port);
 	} else if (width <= 16) {
@@ -703,6 +707,8 @@ acpi_status acpi_os_write_port(acpi_io_a
 	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
 		return AE_NOT_IMPLEMENTED;
 
+	guard(raw_spinlock_irqsave)(&acpi_os_port_lock);
+
 	if (width <= 8) {
 		outb(value, port);
 	} else if (width <= 16) {
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -913,7 +913,9 @@ static int acpi_cpufreq_cpu_init(struct
 	data->resume = 1;
 
 	policy->fast_switch_possible = !acpi_pstate_strict &&
-		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
+		(!policy_is_shared(policy) ||
+		 policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) &&
+		perf->control_register.space_id != ACPI_ADR_SPACE_SYSTEM_IO;
 
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");



