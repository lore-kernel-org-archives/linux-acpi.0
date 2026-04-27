Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66818259C80;
	Mon, 27 Apr 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315700; cv=none; b=bx+GZOm0bsJ89IOIf9MkO9RrcQuGny8dTGTHM4qNdqqkiCKj5OdXM9zNH/yukf0OyDxTfnFadMSwPcEyQQ3u+fg4+FGTEHm1ZNd4GNYpDQZSiLpw4qZuvW/VRvU66GO+97HSZuCLZJueUcsz6ZcL9bOUmrbDK/MH1a1u3kAkVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315700; c=relaxed/simple;
	bh=mLh6tPFmcuL5D0yiOXdc1yXDa2u/1qIKf32tMn5IUCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZeJn2ssgZ9HhsPhWKFjlHPEMOzzyZ8EtxpzVSLTtDWLsVUMq66i/5UqCatlaul5LhFe67hl/ZNQ8sV7BAnYaIxHruH11mQ6vGVQvVKG7TUoK1mH4sF3mAFfe+JS7YgiMQn68EwSuiXu7gUiJH8Isqs6uggqBXMgbSkOd8h5vQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXFhDGKJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXFhDGKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7574C19425;
	Mon, 27 Apr 2026 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315700;
	bh=mLh6tPFmcuL5D0yiOXdc1yXDa2u/1qIKf32tMn5IUCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXFhDGKJom+jWucYDifOVTH5Dul/TfCA8uBEVzktZRjI3hizWvO4iD3MdCB0GolVj
	 s2k2Zoi+T0NCXVc8rcOckztnR41VHX4MG+CxLGiQt8H9FBdHkPNLjz6deXA72RcA4y
	 eU4jNgQD+s+DdhFdonHzLNZMFXaE9g0IBoC7vCEOYA6TIV6PXGBCi2C+edVR+Npo1e
	 FjFIZB4gzhq1KsGDpqUotK0Ss0hFvpVh/YYRGckdASGtp7r9/A7wG2DwU2WhcRo3B+
	 OVXBSgihOe6oWLcc6LIOlyPwLNG+S48RLfUhGL16Uoio4iDsZ1g2bAnYRMaymksASp
	 bP7pj0ePRlnQQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Mon, 27 Apr 2026 20:48:17 +0200
Message-ID: <6005325.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY3HF3iOV7ZKq9-LTjyA-p3jNVHKSi5CBM8AJ38LYUdXbw@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki>
 <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
 <CAGAxtY3HF3iOV7ZKq9-LTjyA-p3jNVHKSi5CBM8AJ38LYUdXbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Sunday, April 26, 2026 10:45:03 PM CEST Evgeny Sagatov wrote:
> dmesg | grep "frequency s"
> [    8.622778] acpi_cpufreq: CPU0: Using I/O space for frequency scaling
> [    8.622806] cpufreq: CPU0: Fast frequency switching enabled
> [    8.622869] acpi_cpufreq: CPU1: Using I/O space for frequency scaling
> [    8.622888] cpufreq: CPU1: Fast frequency switching enabled
> [    8.622938] acpi_cpufreq: CPU2: Using I/O space for frequency scaling
> [    8.622955] cpufreq: CPU2: Fast frequency switching enabled
> [    8.623006] acpi_cpufreq: CPU3: Using I/O space for frequency scaling
> [    8.623026] cpufreq: CPU3: Fast frequency switching enabled
> 
> When I press the power button, a message is displayed:
> apr 26 23:40:36 srv kernel: ACPI power button event
> 
> The PC does not freeze.

Good.

> The single core performance benchmark shows good values.

That most likely is a coincidence.

The above means that the issue is related to HW accesses in the I/O space.

I don't actually think that the writes to the I/O space outright clash with
each other, but the timing between them may be somewhat overly aggressive.

Let's first check what I/O ports come into play though.

Please apply the patch below (which is a replacement for the previous one),
run

$ dmesg | grep "frequency scaling"

after a fresh boot of the new kernel and let me know the output of it.

Then, press the power button and send the messages printed after that.

---
 drivers/acpi/acpica/evevent.c  |   12 ++++++++++++
 drivers/cpufreq/acpi-cpufreq.c |    8 ++++++--
 drivers/cpufreq/cpufreq.c      |    1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -243,6 +243,18 @@ static u32 acpi_ev_fixed_event_dispatch(
 	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 				      status_register_id, ACPI_CLEAR_STATUS);
 
+	if (event == ACPI_EVENT_POWER_BUTTON) {
+		pr_info("ACPI power button event\n");
+		if (acpi_gbl_fixed_event_info[event].status_register_id == 0)
+			pr_info("ACPI event status I/O port number: %llu\n",
+				acpi_gbl_xpm1a_status.address);
+		else
+			pr_info("ACPI event status register ID: %u\n",
+				acpi_gbl_fixed_event_info[event].status_register_id);
+
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
@@ -887,9 +887,13 @@ static int acpi_cpufreq_cpu_init(struct
 		 * unknown and not detectable via IO ports.
 		 */
 		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
+		pr_info("CPU%u: Using I/O space for frequency scaling\n", cpu);
+		pr_info("CPU%u: frequency scaling I/O port number: %llu\n", cpu,
+			perf->control_register.address);
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



