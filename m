Received: from mail.www403.your-server.de (mail.www403.your-server.de [116.202.139.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234114052D4
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.139.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660330; cv=none; b=XeKWP+S1gpGziHS6S3TzkS84+U1Rnz43Br2J+dIqS43pBI1B1/bggJjs5ogt2qFxQ2xjoZsNp/34h2wjpsZUvgnzosJEsEtyLdeT06IogepWcejpM0DWN7n/ar9TVjvDwUobhhkONKWc3NOgZG2Ta7wvKkkDdnpdfW9PW4ZEfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660330; c=relaxed/simple;
	bh=NE7H1QqexBXiI98A4QeWK3vUdM9Ty561634SctWKIAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUOGpS9l2mGU9nOZQIOqn5nk1C0TIc90Zf+9moV3MYNGgDa3Yy+OUuMK41V4PyV6ppA2rl3sXjBsMHlhpDushXLkUsgf4ReqiykBvzoOW9ZVFzX1a5/HYQezWxIXHCM3kt87Mf8W8ptJxoU+SYpS7YWhbbJZEb7eUcgBpxIT9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-reisinger.at; spf=fail smtp.mailfrom=stefan-reisinger.at; dkim=pass (2048-bit key) header.d=stefan-reisinger.at header.i=@stefan-reisinger.at header.b=qcIsCUy5; arc=none smtp.client-ip=116.202.139.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-reisinger.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stefan-reisinger.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stefan-reisinger.at header.i=@stefan-reisinger.at header.b="qcIsCUy5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stefan-reisinger.at; s=default2406; h=Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=YtCThPdcHL0I4o06mZ5weH6gLybIVjLb5Oh5RV2Wk2M=; b=qcIsCUy5w8A2idSSefqrk/bN97
	xebMKTfB/KmG8dzCVaWqQ6vGq+B+hmM4Kn/ThVOIR8wESeYB7fa1m0Bwp3+RBcfghQI3tqQI3JBnd
	0bs+0OgdgT7PovNhGopGlyi9X3owAx9CfTFfZdZduIDyf7NBWnApffbG+AWYz145TSphRhJ9WOHNc
	JMR0B2aU1vesM5D6bQBaVub5fvs+cw9GOhmNMJpQQwA5Jh6mJuTeu+RoqU4nlFwIfoNRWdmfM3xkU
	eYylM3ugXCPmlOSk3tg3m59TPLjQrgOELCGShkd8HDPj1XAU6SFpjU/IViwPPGs+Fhfgx8oCSdelD
	j9zlhUnA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by mail.www403.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <linux-kernel@stefan-reisinger.at>)
	id 1wyplI-000Ji8-1u;
	Tue, 25 Aug 2026 13:56:16 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux-kernel@stefan-reisinger.at>)
	id 1wyplI-000Fes-18;
	Tue, 25 Aug 2026 13:56:16 +0200
From: Stefan Reisinger <linux-kernel@stefan-reisinger.at>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org
Subject:
 ACPI: battery: _BIX data (last full charge capacity) stays stale forever on
 firmware that never sends Notify 0x81
Date: Tue, 25 Aug 2026 13:56:09 +0200
Message-ID: <m3scjOJOQ56oIpfVW2acEg@stefan-reisinger.at>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

Hi,

on machines whose EC never issues Notify 0x81 (Battery Information Changed), 
the values the ACPI battery driver exposes from _BIX -- most importantly last 
full charge capacity (energy_full/charge_full) and cycle count -- remain stale 
indefinitely. On systems that run continuously and are never suspended or 
rebooted (for example a laptop repurposed as a small always-on server), the 
reported battery health never updates, potentially for years.

Observed on: Lenovo ThinkPad T460 (20FMS1VA09), BIOS R06ET71W (1.45), EC 
firmware 1.12, kernel 7.1.9-arch1-2 (Arch Linux). BIOS 1.45 is the current (and 
presumably final) release for this model, so this is reproduced against the 
latest available firmware. I can reproduce and test patches on this hardware.

Observation

The battery's fuel gauge (SANYO pack, SBS over EC) commits a new 
FullChargeCapacity after an undisturbed full-charge termination. Directly 
observable: after a full charge, energy_now settled at 17750000 uWh while 
sysfs energy_full still reported 17830000 uWh (the pre-learning value). The 
new FCC of 17750000 only became visible after a reboot. Replugging AC does not 
help (EC sends Notify 0x80 only). The threshold-based charge stop confirms the 
gauge itself uses the new value immediately, so the stale data is purely on 
the reporting path.

The impact is not limited to a stale health figure. The driver derives 
POWER_SUPPLY_STATUS by comparing fresh _BST data against cached _BIX data: 
acpi_battery_is_full() tests full_charge_capacity == capacity_now, i.e. it 
compares values sampled at two different points in time. With a stale cache the 
comparison can never succeed, so the driver reports "Not charging" indefinitely 
for a battery that is physically full -- while the firmware-side data is 
perfectly self-consistent (a fresh _BIX evaluation yields energy_full == 
energy_now with rate 0). I could observe this directly: with identical 
physical state, sysfs reported "Not charging" (energy_now 17750000 vs cached 
energy_full 17830000) before a reboot and "Full" (17750000 == 17750000) after 
it. Userspace should be able to treat POWER_SUPPLY_STATUS as authoritative; 
anything that does and waits for "Full" (charging indicators, calibration 
tooling) never completes on such systems.

Firmware analysis (DSDT of the T460)
BAT0 (internal): a query method containing Notify 0x81 exists (Method _Q4A: 
CLPM() + Notify(BAT0, 0x81)), but the EC never raises this query when the 
gauge commits a new FCC. Manually evaluating _Q4A (e.g. via acpi_call) 
triggers the expected refresh, confirming the kernel side works when notified.
BAT1 (removable): the DSDT contains no Notify(BAT1, 0x81) at all; the only 
notifications for BAT1 are 0x80 (status) in the status/hotplug queries. 
Firmware relies on physical reinsertion for info refresh.

Both contradict the platform requirements Microsoft documents for battery 
firmware ("the platform firmware must generate ... a Notify(0x81) ... whenever 
any of the battery state data in _BIX changes. This includes last full charge 
capacity, design capacity, and cycle count.") [1].

I have verified this on one platform only. I suspect it is not unique to it -- 
under Windows the frequent suspend/resume cycles of modern usage would mask 
such a firmware omission entirely, and Linux likewise refreshes on resume 
(PM_POST_SUSPEND in battery_notify()), so it would only ever surface on 
machines that never suspend. But I want to be explicit that the cross-vendor 
part is a suspicion, not something I have data for. For what it is worth, user 
reports of the same symptom and folklore workaround exist for other ThinkPad 
models -- reported capacity exceeding 100% after a recalibration (remaining 
energy running past the stale energy_full), fixed by a reboot or by physically 
reinserting the battery: https://www.reddit.com/r/thinkpad/comments/tqc4cw/
tlp_recalibration_110_charge/

Current kernel behavior

drivers/acpi/battery.c evaluates _BIX only at probe, on Notify 0x81 
(acpi_battery_refresh()), and after suspend/hibernate (PM_POST_SUSPEND handler 
/ acpi_battery_resume()). There is no other path that ever re-reads _BIX. That 
is spec-conformant, but combined with the firmware behavior above it produces 
permanently stale health data.

Possible directions

I would be happy to work on a patch, but since I have not worked on the ACPI 
subsystem before, I cannot judge the trade-offs well and would appreciate a 
pointer on which direction (if any) would be acceptable before writing code:

(a) Re-read battery info on charge-state transitions that plausibly coincide 
with a gauge commit: "charging" -> "neither charging nor discharging while on 
AC" (charge completed -- the moment fuel gauges typically commit a newly 
learned FCC, and the moment [1] recommends firmware to update it), and possibly 
also "discharging" -> "charging"/"not charging" (the empty point, where gauges 
resynchronize as well). Would need a rate limit (e.g. once per 60 s at most), 
since ECs oscillate between charging and not-charging near the stop threshold 
(top-off cycles). I am aware of the recent work on merging consecutive battery 
notifications to reduce pressure on the ACPI methods and the EC (acpi_notif_fifo 
/ NOTIF_MERGING_MS) -- though that effort targeted call rates of several per 
second, while transition-triggered _BIX reads would happen at most every few 
minutes, several orders of magnitude below that, so I would not expect it to 
add meaningful load back.

(b) A maximum cache age for the _BIX data, checked lazily: when a _BST update 
runs anyway (i.e. something is reading the sysfs values) and the cached 
battery info is older than some limit, re-read it along the way. No timers, no 
wakeups, zero cost on an idle system; additionally covers commits that happen 
without any observable charge-state transition. Downside: up to the cache age 
of latency instead of seconds. I have no good intuition for the limit -- tens 
of minutes? hours? -- you probably have a much better sense of how often well- 
behaved firmware refreshes this data, so I would defer to your judgment there.

(c) A DMI-gated quirk (bat_dmi_table, as done for the notification-delay quirk) 
limiting either behavior to known affected machines.

(d) An explicit userspace-triggered refresh (similar in spirit to the SCSI/PCI 
rescan attributes), leaving the default behavior untouched.

My current workaround is invoking the DSDT's EC query method that contains the 
Notify (via acpi_call), which works but is obviously not a general solution.

The driver already carries several quirks compensating for non-conformant 
battery firmware (percentage capacity, ThinkPad mAh units, degraded full 
charge, notification delay), so I hope this fits the established pattern. If 
this has been discussed before, pointers welcome -- I did not find prior 
threads.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/acpi-battery-and-power-subsystem-firmware-implementation

This is my first report to this list and my first contact with kernel 
development -- apologies in advance if I got parts of the process wrong; happy 
to redo this via bugzilla or in any other form if preferred.

Thanks, Stefan


