Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7F1DF261;
	Fri, 24 Apr 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059954; cv=none; b=KERSK1Wij82ZRPTvcVD42kFbg01NBJCICGm61Ro12Ms+QuzqJ3wino1XB14S6g6lr59JmtLDO+yLlHIob9BCTpUjm6JKrrk3GJZckhTlVuLPqHvaSFjFz3B+BJ8T4MqY9G2p36SlCjCTaNjhvdRIRhACufcNhqeTEZMX3U/AvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059954; c=relaxed/simple;
	bh=8fGdRD+I7sMsJmZir5HbEEQayBQy7LDbY2vgEgcS4TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcuUVpcI1fBOdHNPX2recJa0EdHkXjY8mzj2mBxclBux7A+XHKpK1JETsTi9c8s6zbZ9sGy6aoKF2+y1en6NjtG+gxzfTOSCmAluz0Y1WLdkRByCJ5iQyr/LrAF5JgPcmO+7j8ycj08YJxH9SMUDnVAK4dsVwXbcJ+pwhhfyRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfYCR557; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfYCR557"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1784BC19425;
	Fri, 24 Apr 2026 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777059954;
	bh=8fGdRD+I7sMsJmZir5HbEEQayBQy7LDbY2vgEgcS4TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfYCR557pbsCAd1r4wmbWbznp4nSBM9TBdy36fmL27O/z4U4niSfH6z/JWBxCnMa4
	 5fuMPdEfEGjJvcYkTmxaJTk3DCLV5KeJQPD1d2/ZM0XIrokWV6ezK+hBM9Miw80miX
	 U3060Oq67MTMVunD4CqMRW7WwcAi2B51nk2yo007FEBltersflT7GASCVA37bmKkN+
	 jiV934RYi6NPieild5GWH6V6RuZUdBnmHVRrjRXAj4yF6Y3mYUSHxSrFG6gqlFP60n
	 nQhgcEPBu7QR1VN1Sde9Ts9rI0Ya5RWDldL108OJcfL5foL/2Ts1CtlAlfdGsWjKE4
	 cz3+YtZScLfgw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Fri, 24 Apr 2026 21:45:51 +0200
Message-ID: <12895688.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY0av_gAk6Up9W8RHjrzWurHEou4RBNnv5wwSEsTUNT52Q@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <5107109.31r3eYUQgx@rafael.j.wysocki>
 <CAGAxtY0av_gAk6Up9W8RHjrzWurHEou4RBNnv5wwSEsTUNT52Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Friday, April 24, 2026 7:06:50 PM CEST Evgeny Sagatov wrote:
> dmesg | grep "Fast frequency"
> [    8.903099] cpufreq: CPU0: Fast frequency switching enabled
> [    8.903181] cpufreq: CPU1: Fast frequency switching enabled
> [    8.903247] cpufreq: CPU2: Fast frequency switching enabled
> [    8.903316] cpufreq: CPU3: Fast frequency switching enabled

If it is enabled, let's try to disable it and see what happens.

> When I pressed the power button, the PC froze. Nothing in the log.

Below is an updated version of the previous patch which additionally
disables fast frequency switching in the ACPI cpufreq driver that is
in use on your system.

The "Fast frequency switching enabled" messages should not be there
any more in the log with this patch applied (please verify) and
please check if pressing the power button will still lock up the
system.

---
 drivers/acpi/acpica/evevent.c  |    5 +++++
 drivers/cpufreq/acpi-cpufreq.c |    3 +--
 drivers/cpufreq/cpufreq.c      |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -243,6 +243,11 @@ static u32 acpi_ev_fixed_event_dispatch(
 	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 				      status_register_id, ACPI_CLEAR_STATUS);
 
+	if (event == ACPI_EVENT_POWER_BUTTON) {
+		pr_info("ACPI power button event\n");
+		return (ACPI_INTERRUPT_HANDLED);
+	}
+
 	/*
 	 * Make sure that a handler exists. If not, report an error
 	 * and disable the event to prevent further interrupts.
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -912,8 +912,7 @@ static int acpi_cpufreq_cpu_init(struct
 	 */
 	data->resume = 1;
 
-	policy->fast_switch_possible = !acpi_pstate_strict &&
-		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
+	policy->fast_switch_possible = false;
 
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
 	if (cpufreq_fast_switch_count >= 0) {
 		cpufreq_fast_switch_count++;
 		policy->fast_switch_enabled = true;
+		pr_info("CPU%u: Fast frequency switching enabled\n", policy->cpu);
 	} else {
 		pr_warn("CPU%u: Fast frequency switching not enabled\n",
 			policy->cpu);



