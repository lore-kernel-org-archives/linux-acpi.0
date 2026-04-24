Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F33D410E;
	Fri, 24 Apr 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041608; cv=none; b=jwRyfBFXcPvzasvqSuDBalARbSpYelTp7s48tkG2ggZ/rmWB1Tcjqyitgy7tpybDtbljTkFRk9mL9ckUt+gHNuXoMiCz5GTW7bGAEzpazKhpenuWbgimj7dEW7xZIudOvKfk/zsNQjpx3144oCxhIC1OzfnJSl/WFRjwCIJcMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041608; c=relaxed/simple;
	bh=/HUHBYr7J8fvctu0YDBJBup+H6tg/5xrzZBGF+e9KeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDtoLgvM42hFVDjFeElc+5dVKbG259zmd7WBbfkTi8F9cKWWAj1Bc5ITfwvfk/p9eDWwWOi3ed6fjtCi7F7WXW43OzjpXqmFXkMZ55y0Js5lsp3tUYUQL/JEhcMCfJ82Hixt4Jf8dWwAVOXVUE6rtqlyhoB+c0ty3LfKx5+5jMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyG0o2y7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyG0o2y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB650C19425;
	Fri, 24 Apr 2026 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777041608;
	bh=/HUHBYr7J8fvctu0YDBJBup+H6tg/5xrzZBGF+e9KeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyG0o2y7erh/w6NST0BQpmqle1ZDa7h43hJco97yxKQU1VxYFOkq/89edruc7o/BM
	 sPvw7T6H9sNDuevxMwqFNSF/QvlWc+2FxwRZ7sYFlBShisictDWkSu2Al8mwVx7qf5
	 pEjLfRkhO9qGFOuQq8YZMehuzxjaEBLWvNt0508jDPBUtQ+xpEGcIhvgeDrxd2U1J7
	 ZM0n/u72+qQAcL+28AtUiPXsRPc52+2T5ZlYleOJuvfqIFKrHTK/LWxp+R9OBvYm9L
	 BgLcnIUhCvzQ71/PzxrMZmpJdrrvzZSUbj1IjcyiKu6WwqwfTPwFvawWExNPLI54zz
	 CIJnFAAflOkbg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Fri, 24 Apr 2026 16:40:04 +0200
Message-ID: <5107109.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY2vstAuswt0b6sS_0Gi1=S6fd6cetskjfOEKnWqmMZBiw@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <5996744.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY2vstAuswt0b6sS_0Gi1=S6fd6cetskjfOEKnWqmMZBiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Thursday, April 23, 2026 10:07:39 PM CEST Evgeny Sagatov wrote:
> This patch doesn't change anything. The PC remains frozen when
> pressing the power button.

Well, thanks for giving it a go.

This at least means that the issue is related to certain activity in schedutil,
and the specific values used by it are most likely irrelevant.

This time, I'd like to check two things in one go.  First, whether or not
fast frequency switching is enabled on your system (if it is, it will exercise
a different code path in schedutil) and second, whether or not the power button
press processing gets beyond the clearing the associated event status bit.

For this purpose, please apply the patch below and (1) after booting the
system with the new kernel, run

$ dmesg | grep "Fast frequency"

and let me know if it produces any output (and what the output is if so).

Then (2) press the power button and see if that still locks up the system
if schedutil is the cpufreq governor (if it doesn't lock up, a message
will be printed to the kernel log every time the button is pressed).

---
 drivers/acpi/acpica/evevent.c |    5 +++++
 drivers/cpufreq/cpufreq.c     |    1 +
 2 files changed, 6 insertions(+)

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



