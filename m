Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9C3911C1;
	Wed, 13 May 2026 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641942; cv=pass; b=WbuYuu77ex3peN9MBK1L4NzlnBPyMk9yNOcjPvv04krEOmTJ00yRFaLs8un1AT+p8Iv64N6vo8da+3bvt/G0ZC2B2sVgwPopkeBslbfkjFJEMdmiqiNSylaelxmbKV4fuvtcTUiLVCqZWRygiNzNRbndys4ORO0bqT4q0F8JLbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641942; c=relaxed/simple;
	bh=x9E0UHb3U2JP39mkfpQJXdU1OgL3q2/v0Hqap0On75E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CB7P+PPHdClcvW35bbVPjSwqx1SUi/ybz0KNld4K8zzLxIdxXVmM2PZfnEigIi1wkEuShjkZnvu/4+fsWpEpcbxVL3871gzW/jAP6YeY6G4/piS68NdpOMYt4JPi2i5H09SNr+Fv7cNzxHjd4g03yxl6YqqUhutqAfQqhlaXrlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=MvVer3pK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="MvVer3pK"
ARC-Seal: i=1; a=rsa-sha256; t=1778641903; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kka2jMsgRm06958CpImZ1UlexyF421K0uVGj276HRv9isX3kqMUFoSzUAbwJE+VaCp8gXT488Spn4fIAW049m1ysUetkgCTgdmlogRERXK5MppXaGy2pgKo0F8X+yygOSFX7smRbVfzZxnSbhAG/2dSemvKaKL/xLR/1I8X1c/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778641903; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W0h2tHYagwToTY0chgGPlGziX4Ycjm/R1MNuSZOnqDk=; 
	b=aKmb5z2hfRRyh0TltIfyaXA1PSva3djTQbbhNd4fARqb5O2aI3iMW6AFK2FNs4povJH1Vgv29+6JB2Y3Vaiilv9NPsGPmRjpSwrOzuT1Rli5+B9azEoncLkjlJK9Iu9mBf3e1h43lttffpHRW8i1rsLfnZRcE3zEtz+B9C3UVZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778641903;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W0h2tHYagwToTY0chgGPlGziX4Ycjm/R1MNuSZOnqDk=;
	b=MvVer3pKnkpEzU3I/6/PhBE282oN2S64R/9GbYV++fv/OXv//PCgZojypnJ9IDKL
	mjt+4KhhzGeOHv3xCoTRQTE0gaJ6L8jyRdbnduJzcYf4wRuXAhccj+7cYs/Cpjplgey
	rGqCB0qjtRs55vaJm7Voj/Xa+9jX8ZoAvzBOYTwc=
Received: by mx.zohomail.com with SMTPS id 1778641900937132.0245035565647;
	Tue, 12 May 2026 20:11:40 -0700 (PDT)
Message-ID: <580525dd-baf6-45ba-8996-be9e90dd2d10@collabora.com>
Date: Wed, 13 May 2026 06:11:34 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/10] acpi/x86: s2idle: Introduce and implement hint
 class ABI and idle hint for s2idle
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
 superm1@kernel.org, systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20260425215734.14116-1-lkml@antheas.dev>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Antheas,

On 4/26/26 00:57, Antheas Kapenekakis wrote:
> This is a two-part RFC series that in the first part cleans up the Modern
> Standby firmware notification order and in the second part exposes them to
> userspace using a new hint class ABI that can be extended in the future to
> add more userspace hints to devices.
> 
> For more information, see the V1 description.
> 
> In the first part, we begin by renaming the s2idle.c constants to match
> their spec from Windows. Following, we place all MS firmware notifications
> to begin() and end() to match Windows, ensuring that the USB subsystems and
> EC are active when they fire, eliminating a class of bugs due to the
> mismatch. Finally, we add a small delay quirk to begin that is required by
> ROG Ally devices, which is bound to asus-wmi through the handler interface
> exposed by s2idle.
> 
> Since these bugs completely fix the sleep behavior for all models and
> firmware versions of Ally devices, including those introduced with the
> previous suspend fixes when mcu_powersave is off (which is part of the
> reason the driver forced it to on; not just standby battery drain), a
> cleanup follows that removes the duplicate handling of CSEE (the underlying
> function of the Display On/Off _DSMs and which malfunctioned because the
> USB subsystem was suspended during its calls) and the now unnecessary
> firmware version checks and error logging.
> 
> In the second part, a new /sys/class/hint interface is introduced with an
> initial hint, "idle", which allows modifying the idle state of the device.
> I chose the name "idle" instead of "activity" to leave "activity" free to
> use in the future for e.g. "gaming", "video", which might be useful
> especially for embedded devices. "idle" might alias with "s2idle" so the
> name is not set in stone.
> 
> Each driver that wants to implement hints can register a hint class and add
> hints to it, which are then exposed in /sys/class/hint/<class>/idle
> allowing them to receive updates as well. Current WMI drivers should not,
> as their behavior is already handled by the initial s2idle idle hint.
> However, non-MS devices can e.g. the ChromeOS EC or even the CPU scheduler.
> 
> The two parts are designed to be independent of each other, so that we can
> merge the re-order in an initial kernel version and the hint interface in a
> later kernel version, if needed. As such, after the first part is cleaned
> up it will be resent as non-RFC and the Asus/hid/px86 maintainers will be
> cc'd. Then, we will iterate on the hint interface.
> 
> To test this series, it is recommended to enable logs with:
> 
> sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
> file drivers/acpi/x86/s2idle.c +p
> file kernel/power/suspend.c +p
> file drivers/base/hint.c +p
> EOF
> echo 1 | sudo tee /sys/power/pm_debug_messages
> 
> Here are some commands afterwards:
> 
> echo "active" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle
> echo "inactive" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle
> echo "snooze" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle
> 
> I have not tested this series on Ally devices yet, focusing on the Z13.
> A previous version of the series performed correctly and is what was used
> in e.g., Bazzite, with around 5-10k Ally users.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
> 
> Changes since v1:
>   - Rebase to v7.0
>   - Other than the first patch, the rest are re-written.
>   - The hint class is based on a simplified version of platform-profiles
>   - Transition handling is now done in s2idle.c exclusively and is not
>     part of the main ABI. Drivers receive idle hints updates instead.
>   - The rename patch now also renames upstream ACPI_MS_TURN_ON_DISPLAY to
>     ACPI_LPS0_TURN_ON_DISPLAY for consistency. It is also fired
>     unconditionally now by the transition handler in patch n-1.
> 
> V1: https://lore.kernel.org/all/20251226102656.6296-1-lkml@antheas.dev/
> 
> Antheas Kapenekakis (10):
>   acpi/x86: s2idle: Rename LPS0 constants so they mirror their function
>   acpi/x86: s2idle: Move Modern Standby calls to s2idle begin/end
>   acpi/x86: s2idle: Add support for adding a delay after begin MS calls
>   platform/x86: asus-wmi: add s2idle begin delay for Ally devices
>   HID: asus: remove quirk handling for Ally devices
>   platform/x86: asus-wmi: Remove Ally s2idle resume fixes
>   Documentation: Add documentation for the new sysfs hints class
>   hint: Add hint class ABI for devices to receive updates on host
>     activity
>   acpi/x86: s2idle: Listen to idle hints to perform MS transitions
>   acpi/x86: s2idle: Subtract delay from last DSM fire in begin delay
> 
>  Documentation/ABI/testing/sysfs-class-hint |  78 ++++++
>  MAINTAINERS                                |   8 +
>  drivers/acpi/Kconfig                       |   1 +
>  drivers/acpi/x86/s2idle.c                  | 309 ++++++++++++++++-----
>  drivers/base/Kconfig                       |   3 +
>  drivers/base/Makefile                      |   1 +
>  drivers/base/hint.c                        | 283 +++++++++++++++++++
>  drivers/hid/hid-asus.c                     | 113 +-------
>  drivers/platform/x86/asus-nb-wmi.c         |  40 +++
>  drivers/platform/x86/asus-wmi.c            | 132 +--------
>  drivers/platform/x86/asus-wmi.h            |  14 +
>  include/linux/acpi.h                       |   1 +
>  include/linux/hint.h                       |  38 +++
>  include/linux/platform_data/x86/asus-wmi.h |   8 -
>  14 files changed, 727 insertions(+), 302 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-hint
>  create mode 100644 drivers/base/hint.c
>  create mode 100644 include/linux/hint.h
> 
> 
> base-commit: 028ef9c96e96197026887c0f092424679298aae8

The v2 patches work well on my setup, the hint sysfs works. No problems
was spotted.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
