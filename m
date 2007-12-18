From: Pavel Troller <patrol@sinus.cz>
Subject: Re: ASUS P5N32-E SLI PLUS and cpufreq ?
Date: Tue, 18 Dec 2007 10:33:39 +0100
Message-ID: <20071218093339.GA28511@tangens.sinus.cz>
References: <20071217084827.GA17568@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:44523 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbXLRJdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Dec 2007 04:33:41 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.14.1/8.14.1) with ESMTP id lBI9XdcB029356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 18 Dec 2007 10:33:39 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.14.1/8.14.1/Submit) id lBI9Xdgt029355
	for linux-acpi@vger.kernel.org; Tue, 18 Dec 2007 10:33:39 +0100
Content-Disposition: inline
In-Reply-To: <20071217084827.GA17568@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Hi!
>   I've built a new machine with an ASUS P5N32-E SLI PLUS motherboard,
> equipped with an Intel(R) Core(TM)2 Quad CPU. The system seems stable
> and well-performing. However, I'm curious about the following:
>   In the BIOS settings, there is an "Enhanced Intel SpeedStep (TM)" item,
> which can be disabled or enabled. I've tried to hook a cpufreq module on it
> but it seems to be unsuccessful. Neither speedstep nor acpi-cpufreq modules
> are recognizing the hardware, so the feature seems unsupported.
>   However, when the BIOS SpeedStep setting is enabled, strange things happen.
> In /proc/cpuinfo, the CPU frequency is always reported as 900 MHz (while
> normally it's 2.6GHz), but the bogomips value is at 5220, which corelates
> with the standard 2.6G clock. Also the system performance is not so low as
> for 900M clock - I can see a small slowdown, but it may be about 5%, not more.
> Even with an artificial load of all cores (4 cpu-eating tasks run concurrently)
> the frequency reported by /proc/cpuinfo is at 900 MHz and doesn't never
> increase.
>   So what does it mean ? Is the SpeedStep feature usable just by setting the
> BIOS ? Isn't it limiting the performance too much ? Why the clock always seems
> to be low ? I'm keeping it off until I know all the answers :-).
>   I'm attaching my DSDT for reference.
>   With regards,
>         Pavel Troller

Hi!
  I'm here again with a new info, which may be important.
  When the "Intel Enhanced SpeedStep" feature is active, there are 5 additional
SSDT tables, which are not there, when the feature is disabled. Linux states
that the tables are there, but I can't see any other difference than that
with exception of another ordering of CPU cores and some minor timing issues.
  Can Linux profit from those tables ? Their dissassembly is attached.

    With regards, Pavel Troller


--AhhlLboLdkugWU4S
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ssdt.tar.bz2"
Content-Transfer-Encoding: base64

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
DApRgYRP/xdyRThQkCeagEQ=

--AhhlLboLdkugWU4S--
