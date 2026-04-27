Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F82F547F;
	Mon, 27 Apr 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321905; cv=none; b=Q1zhIyvya9+zTTLgUxDvUkZSdK6jjv0jwxo/lqbb+ei520XbSJASVlRjKmi6kuAu1WPldCk0v47SQWVJD1FDtyh7fmAMfADQPaCTSbPBGWVsfH17fK9yr27Bda62wQUm5kJdUDI2zbJeSJLp2pOC0gx02jacKmGzxN+KRtAhIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321905; c=relaxed/simple;
	bh=0Ri7ky56QroweDGD7QliPPyIVKk1G5Cnjzc9z2u1OpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhznHjxRq96d7UasaYBLwQvuP8mH/KhQMjh/ymVb4ncI3RseI2w+LkcycXsrl5ei0jkTxur71mZHx91FXap5aeCOIomA8b9KIkXiJ5KmZA6UDSrJa6uOOQaHGiyDrxc2k5rikmnZXVN2cTRme+G07zhDF2so+NuFiDuBXakmkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlFjA8cQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlFjA8cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14587C19425;
	Mon, 27 Apr 2026 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321905;
	bh=0Ri7ky56QroweDGD7QliPPyIVKk1G5Cnjzc9z2u1OpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlFjA8cQBhiriH37cdh7ywnf7x6P4xJfnLaksRSJuSgGzYDzAgJIepgQhcOd78Lvu
	 pB2vwJQGdCVfX7TFhTTFYW8qWUFsQrNt6PiQBSynWXjYV0HDPb8byo4LItRoSG/hBp
	 5+HrQGnse8aUOFwOUmNLRZmp9donC1QhqElfonXU8sOFgmHHfzcIF+3p9Nk099uOo+
	 vaVCxFIeCf4khQ1iGd0udQy593w2FiGRamLSPU8itEKkXLPgQR/4PYEOeIMTtzJ1bt
	 yNGZQRunu2LdShFE0gLvm1F3KxgX1Zc79C8IWOZzzNE+zr/TEKW0pSN13MTeV7MTNj
	 cNKVJZ7LIVurQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Mon, 27 Apr 2026 22:31:42 +0200
Message-ID: <6006426.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY28bho6+PRoEypepAK1UpmGQ8WzkvPnUEmGvx7vWqkHeA@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <6005325.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY28bho6+PRoEypepAK1UpmGQ8WzkvPnUEmGvx7vWqkHeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Monday, April 27, 2026 10:12:33 PM CEST Evgeny Sagatov wrote:
> dmesg | grep "frequency scaling"
> [    8.552380] acpi_cpufreq: CPU0: Using I/O space for frequency scaling
> [    8.552386] acpi_cpufreq: CPU0: frequency scaling I/O port number: 2176
> [    8.552478] acpi_cpufreq: CPU1: Using I/O space for frequency scaling
> [    8.552480] acpi_cpufreq: CPU1: frequency scaling I/O port number: 2176
> [    8.552584] acpi_cpufreq: CPU2: Using I/O space for frequency scaling
> [    8.552586] acpi_cpufreq: CPU2: frequency scaling I/O port number: 2176
> [    8.552668] acpi_cpufreq: CPU3: Using I/O space for frequency scaling
> [    8.552670] acpi_cpufreq: CPU3: frequency scaling I/O port number: 2176
> 
> Messages that appear when I press the power button:
> apr 27 23:07:33 srv kernel: ACPI power button event
> apr 27 23:07:33 srv kernel: ACPI event status register ID: 3

Of course it's a power button, so the register ID is 3 and the register
is PM1.  Sorry for missing that previously.

Please apply the slightly update patch below (which replaces the previous
one) and send the messages printed to the log after booting the new
kernel and pressing the power button.

---
 drivers/acpi/acpica/evevent.c  |    8 ++++++++
 drivers/cpufreq/acpi-cpufreq.c |    8 ++++++--
 drivers/cpufreq/cpufreq.c      |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -243,6 +243,14 @@ static u32 acpi_ev_fixed_event_dispatch(
 	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 				      status_register_id, ACPI_CLEAR_STATUS);
 
+	if (event == ACPI_EVENT_POWER_BUTTON) {
+		pr_info("ACPI power button event\n");
+		pr_info("ACPI event status I/O port number: %llu\n",
+			acpi_gbl_xpm1a_status.address);
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



