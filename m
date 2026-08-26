Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27ED301709;
	Wed, 26 Aug 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779607; cv=none; b=A/8et4uNi6n7u9eTJf9QD718YGM89rF2+B/n1A1LhNDW0w9nLd03Zmg1qU0yaL50p7OzRWFxE44LHd5hcQviqw9fIEhBCskTPDmPz0v2nZiRNM1xpNGOOuNbtjYb32ZETt5ajCvLBWbPonSPyRHCEWAtaMUVS2VLBU/A6qUmZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779607; c=relaxed/simple;
	bh=TkYvFTvMt02jy5gMlyF59wDDmPbKmvAMS+8plOg1xys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tvx2Fv5/F6LU5hmBeXdxbEGEf5mot9UT38cjFXgZjUto8PAnabQthiHsYHeSTaJyjiw7I28/kqXtB5gBQ7ahjN7/bLFh9DSkl7qGxHgDTvxKX1xDFfbNiCL82dX48YG+e80iN4QlkSZxHSFExYzShLKWarS8nDFxd/DCzqhkXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IL57l9jo; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IL57l9jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787779604; x=1788384404; i=w_armin@gmx.de;
	bh=TkYvFTvMt02jy5gMlyF59wDDmPbKmvAMS+8plOg1xys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IL57l9jobdg4H3f3D2+nHv+njiXMl5VOZMcjuYnd4/26JkItKG4sQKKnLjNEHI3O
	 lrMBHsR9iAGZw4RQI8hgzU4oxP4AhKUuj9+V7mCKSSs+dulI5Hhls3oH5SShnJB8S
	 N4jF6dw95QYa4P2LkN88vqaG2MphRs92OTmCpw5Rr8ysIwkYtC8lQXUl3V4Jtfs+a
	 L/H2GUvGNbS3R0zIXiZDfRAoIJDVaBqcGUCtGihNc87SzmN7IIZ5IpV778eO8deM+
	 iMbIaQ+znNDlyrrd/nIRBmKt9Ass5VtfYQl9C5ZJXd3ptJiMYAd+eGLD/k8ps7I4F
	 y5wzmkb/YcWLu/yDNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1xIUaP3ALq-00Hob8; Wed, 26
 Aug 2026 23:26:43 +0200
Message-ID: <3b58a0ae-f050-4dd5-80f6-bf2cdfc20318@gmx.de>
Date: Wed, 26 Aug 2026 23:26:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Redmi Book Pro 16 2024 platform_profile write fails on
 Linux 7.1.7
To: Martiya Aryan Mehr <martiya.ar@gmail.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAM-sYPpgNU+tmfHKWg0KHfVF8f-K8oaNvfYwj-vaUGsEvf1tjg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAM-sYPpgNU+tmfHKWg0KHfVF8f-K8oaNvfYwj-vaUGsEvf1tjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FGZQUttSrsKntN8CPNjPxROrX+3bvwGMJYhXqPUYqQvxdnYCXkI
 6Pmm7tfY13V4WvnB0tWTVaZCfD5w1HWDTLoBscwTtELfLhDukTArWAjtTghV+igAn1dI2Wg
 SStjW+X4hyfQp7fb+2WWNXsPYs8XQ5KEQQt5gmiMQwPDo4VietNOoyybCVcGHoECiHuDIwC
 /U9O9uluXBNE6f+cLrA6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tGiXiDEzt6k=;3FZMKNNlecGvMpwgIRANi/Pr7Kf
 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

Am 11.08.26 um 20:55 schrieb Martiya Aryan Mehr:

> Hello,
>
> I am testing Linux kernel support on a Xiaomi Redmi Book Pro 16 2024 laptop.
>
> I found a problem with platform_profile handling on the Arch Linux 7.1.7 kernel.
>
> Hardware:
>
> Laptop: Xiaomi Redmi Book Pro 16 2024
> Model: TM2309
> CPU: Intel Core Ultra 7 155H (Meteor Lake)
> BIOS: RMAMT6B0P0B0B
> BIOS date: 06/10/2025
>
>
> Kernel comparison:
>
> Problematic kernel:
>
> Linux 7.1.7-arch1-1
>
> Reference kernel:
>
> Linux 6.18.43-1-lts
>
> On Linux 6.18.43 LTS the platform_profile sysfs interface is not
> exposed, so the issue cannot be reproduced there.
>
> Installed packages:
>
> linux 7.1.7.arch1-1
> linux-lts 6.18.43-1
> power-profiles-daemon 0.30-1
>
>
> Problem description:
>
> On Linux 7.1.7 the platform_profile interface exists and exposes the
> following profiles:
>
> $ cat /sys/firmware/acpi/platform_profile_choices
>
> low-power balanced balanced-performance performance
>
>
> Current profile:
>
> $ cat /sys/firmware/acpi/platform_profile
>
> balanced
>
>
> Reading the current profile works correctly, but writing some profiles fails.
>
>
> Working example:
>
> $ echo low-power | sudo tee /sys/firmware/acpi/platform_profile
>
> Result:
>
> low-power
>
>
> Verification:
>
> $ cat /sys/firmware/acpi/platform_profile
>
> low-power
>
>
> However, the following profiles fail:
>
> $ echo performance | sudo tee /sys/firmware/acpi/platform_profile
>
> Result:
>
> performance
> tee: /sys/firmware/acpi/platform_profile: Operation not supported
>
>
> Same behavior with:
>
> $ echo balanced-performance | sudo tee /sys/firmware/acpi/platform_profile
>
> Result:
>
> balanced-performance
> tee: /sys/firmware/acpi/platform_profile: Operation not supported
>
>
> The same issue causes power-profiles-daemon failure:
>
> $ powerprofilesctl set performance
>
> Failed to communicate with power-profiles-daemon:
>
> Failed to activate platform driver 'platform_profile':
> Failed to write to acpi_platform_profile:
> Error writing '/sys/firmware/acpi/platform_profile':
> Operation not supported (15)
>
>
> Expected behavior:
>
> All profiles listed in:
>
> /sys/firmware/acpi/platform_profile_choices
>
> should be writable successfully, especially:
>
> balanced-performance
> performance
>
>
> Actual behavior:
>
> Writable:
>
> - low-power
> - balanced
>
> Not writable:
>
> - balanced-performance
> - performance
>
>
> Module information:
>
> Linux 7.1.7:
>
> $ modinfo redmi_wmi
>
> filename:
> /lib/modules/7.1.7-arch1-1/kernel/drivers/platform/x86/redmi-wmi.ko.zst
>
> srcversion:
> E64350B38255B1100E64863
>
>
> Linux 6.18.43 LTS:
>
> filename:
> /lib/modules/6.18.43-1-lts/kernel/drivers/platform/x86/redmi-wmi.ko.zst
>
> srcversion:
> 369C9F3502463ADD78FDC0F
>
>
> Dmesg information:
>
> The laptop is detected correctly:
>
> DMI:
> XIAOMI Redmi Book Pro 16 2024/TM2309
>
> WMI device:
>
> input:
> Redmibook WMI keys
>
>
> No specific redmi_wmi error appears in dmesg.
>
>
> Additional observation:
>
> On Linux 7.1.7:
>
> $ powerprofilesctl
>
> performance:
> CpuDriver: intel_pstate
>
> balanced:
> CpuDriver: intel_pstate
> PlatformDriver: placeholder
>
>
> The platform profile backend is detected but cannot switch to
> performance or balanced-performance.
>
>
> Possible affected components:
>
> - drivers/platform/x86/redmi-wmi
> - platform_profile framework
> - processor_thermal_soc_slider
> - ACPI platform profile handling
>
>
> I can provide additional logs, ACPI tables, or help with testing
> patches if needed.
>
> Thank you.

Sorry for the late reply. Could you please share the output of "acpidump"?

Thanks,
Armin Wolf

