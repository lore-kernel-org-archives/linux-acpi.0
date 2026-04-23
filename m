Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B993128CC;
	Thu, 23 Apr 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968493; cv=none; b=gx9GMQKn3EQ+nE35Ai/a2peeUkcC2tbTUDSHuV4Ja9zEJZSEluI1zokaHroPLOKDz0ykoLvJtzYTH2D+5dAYDkkBHow9LhTD9W2NsNR7DFGSBcPXs9QIOK+smdVHXRqy9aDITAvLoxxpj6mj8Yp62Fk89dK68IU80IPv62K049Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968493; c=relaxed/simple;
	bh=AqgfZwhcg86yD8dZT0r8KDNqaXpIR1T4IIkE5BfCZ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmJ3Wgglo+ZnJsUpDQ9pxtNBE6+GhLBKenLvDFCCsVEKdCgV27vVG9ASv37GY5P2yuF6ceE/OUVF37xEy3hHaeJjOx2hz0VJLIe1lsOmpoGtndB7B27PdhNktBkXniOyd0aDMSDAz+CERpoTgVX+xuCeB1cKF/Wjx6QerhktJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO6Z5QA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO6Z5QA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62DAC2BCAF;
	Thu, 23 Apr 2026 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968493;
	bh=AqgfZwhcg86yD8dZT0r8KDNqaXpIR1T4IIkE5BfCZ5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LO6Z5QA/yce3rq7bhig81id5zWLoGu+ne/7MYDSxLAwANy7hCWte15RJ1/gdCkiVN
	 KvGBpRqU7dpyQ2czntPqsCTXrzsTsuhCkNtWFKMy2/V9LbK6+Hr2RY4iJvpw7iAZLg
	 wVhdBzPetY3lKBwWtiFqVr1uROSoY01o9Xov4ZuDoYFug+MhI/SGN0hXozSvX3yTZu
	 RKUyEBYaR8AUTD6riJiRtPoUjhtSxqQz3MjiyRMoVoGZcjQ0hgWRvzerO5iwYMkO9f
	 8nH1XaByBdytSqSV0WLf16d5lBH6nPeWwO5ifFyzsb+Upw7FgE2NbLFbM5GtAKMz7i
	 uAWtgh5f6clBw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>,
 Wysocki Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Thu, 23 Apr 2026 20:21:29 +0200
Message-ID: <5996744.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAGAxtY1eVP5y6GTDoLM2xVDt2KF7fCKxDx0Mo9QO3afTA54GgQ@mail.gmail.com>
References:
 <12879883.O9o76ZdvQC@rafael.j.wysocki> <4738258.LvFx2qVVIh@rafael.j.wysocki>
 <CAGAxtY1eVP5y6GTDoLM2xVDt2KF7fCKxDx0Mo9QO3afTA54GgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Thursday, April 23, 2026 4:51:36 PM CEST Evgeny Sagatov wrote:
> I removed the previous patch and installed the new one in kernel 7.0.0.
> schedutil - complete freeze, no messages in the log
> performance - log message when pressing power button, doesn't reboot
> ondemand - log message when pressing power button, doesn't reboot
> 
> Log: apr 23 17:40:04 srv kernel: acpi-button LNXPWRBN:00: ACPI button event

There clearly is some unexpected interaction between the schedutil governor
(or generally what happens in cpufreq when it is used) and the ACPI power
button handling.  It looks like some memory gets corrupted when schedutil
runs and it is then tripped over by the power button handling code.

Kind of on a hunch, please see if the appended schedutil patch (either with
or without the previous patch applied) makes any difference.

---
 kernel/sched/cpufreq_schedutil.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -158,7 +158,7 @@ unsigned long get_capacity_ref_freq(stru
 	if (freq)
 		return freq;
 
-	if (arch_scale_freq_invariant())
+	if (arch_scale_freq_invariant() || policy->cur >= policy->cpuinfo.max_freq)
 		return policy->cpuinfo.max_freq;
 
 	/*



