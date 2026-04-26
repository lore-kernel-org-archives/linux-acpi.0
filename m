Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C85221721;
	Sun, 26 Apr 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777215009; cv=none; b=qG4X2NdvaVda7byHMh5tQgv0TJXR3Zl8+q+XuXLX9iyuxvRgg6Prqrfofn5FkJUYedfaLXyHjgl4ozbZ9CQBLA0VuspCfSyyZOwj99EsNH7W3wBu1oenJXw0UGkp6FipfLqOkqXAK1L36blaKBd3E0U1b1dUIBJv0bFgJkllP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777215009; c=relaxed/simple;
	bh=pUTnGoFBbG74j866rp38jUGu/WC+Prb/3pRedNHXYVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOcmETmLlHbfUAvI1T3B4Mcm9/YWIboNLw78cr1z2YArcXf/eeiLwp5Jjp6yCEreG6u+msnVNRDZoaOhZuzq3v5zgSsjx4nU/Jq1I8BuBkTBcc5Yoi6Qq9vy6tf/TgeDDNL6evW/FmOOAI8IVC2YSRk8lPOUFb0fVC1iAMnfOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkFJxewu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkFJxewu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3DCC2BCAF;
	Sun, 26 Apr 2026 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777215008;
	bh=pUTnGoFBbG74j866rp38jUGu/WC+Prb/3pRedNHXYVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkFJxewuk9c35tgrJPcljoRVIgmp/fdgd2WhNzV8tpLimaCOPH2iGO1dMPLcyaRBy
	 ycVIRbph+0hatJZRfm96d+q1EVHP2Q2cEplSIJYP86bALtHilmc//ar/y3bzzrF4lt
	 lJVkwyPIeOW037KVrNPtfv4o7omr66AywyWWfZ1A9KVoncaEHTo7LeoL1accV+RjuH
	 stlKpz9GtBhZSuXrFq5b/AAcKLGA8imgKQQnHZ06b9U1YW950p4Ab61qM9ren3MrIR
	 adOoWjan1s8b8vymiNQOA9mPmaqHyootXEJcIU3i9UzlbdQyag9aB33N4pK1SiJEa2
	 yqX26pPUd46GA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Sun, 26 Apr 2026 16:50:05 +0200
Message-ID: <5112068.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY13R3F6M4HFiwwsx8SEbcUsu5mQKJrayaCGFp14cEB2wg@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <12895688.O9o76ZdvQC@rafael.j.wysocki>
 <CAGAxtY13R3F6M4HFiwwsx8SEbcUsu5mQKJrayaCGFp14cEB2wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Friday, April 24, 2026 11:18:02 PM CEST Evgeny Sagatov wrote:
> dmesg | grep "Fast frequency"
> Nothing was displayed.
> 
> The PC froze when I pressed the power button. Nothing in the log.
> 
> I applied this patch after deleting all the previous ones. Is this correct?

Yes, it is.

> I received this message when applying a patch. Perhaps we have
> different versions of the source code? I'm using 7.0.0.
> patching file drivers/acpi/acpica/evevent.c
> patching file drivers/cpufreq/acpi-cpufreq.c
> Hunk #1 succeeded at 895 (offset -17 lines).
> patching file drivers/cpufreq/cpufreq.c

That should be fine.

We've switched over schedutil to a different code path and the problem is
still there, so it appears to be related to hardware accesses.

To test this, please apply the patch below (which is a replacement for the
previous patch) and collect the output of

$ dmesg | grep ""

after a fresh boot.  Please let me know what's there.

Also, the "Fast frequency switching enabled" messages should be back.

Then, check what happens when the power button is pressed (if the system
doesn't lock up, a message should be printed to the kernel log every time
the power button is pressed).

With this patch applied, schedutil will not access hardware in the fast
frequency switching path, so the frequency scaling will not actually work
(this is roughly equivalent to running the "performance" or "powersave"
governor all the time).

---
 drivers/acpi/acpica/evevent.c  |    5 +++++
 drivers/cpufreq/acpi-cpufreq.c |    6 ++++--
 drivers/cpufreq/cpufreq.c      |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

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
@@ -479,8 +479,8 @@ static unsigned int acpi_cpufreq_fast_sw
 			return next_freq;
 	}
 
-	data->cpu_freq_write(&perf->control_register,
-			     perf->states[next_perf_state].control);
+	/*data->cpu_freq_write(&perf->control_register,
+			     perf->states[next_perf_state].control);*/
 	perf->state = next_perf_state;
 	return next_freq;
 }
@@ -887,9 +887,11 @@ static int acpi_cpufreq_cpu_init(struct
 		 * unknown and not detectable via IO ports.
 		 */
 		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
+		pr_info("CPU%u: Using I/O space for frequency scaling\n", cpu);
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
+		pr_info("CPU%u: Using FFH for frequency scaling\n", cpu);
 		break;
 	default:
 		break;
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



