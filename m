Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546124;
	b=zMvU6iz1docU0M6ox+XXR1ne0mO/exoxuK8Y2uXEyv5y9gLFtfbYHHd8r1F//NfZToGm
	 lZm3rPtGuF5ieJmycCY8/rWKrB+EGI13g4F5tvo0d2DdWZTAQISpmRPbm6DZL9MMY23Gq
	 lQVv2pJA4zNJG2p1voDHkpZkwDtVheRlDFI5ctx9SD3ZPmNyYbdIJRtkohu7SNFxDhayE
	 avzwyOh+KRh04qxgESO4gCR2MX/5U3GyevApdlRTanRmQm5Gi4w58emeLG5PCBOlV0qYo
	 F+ucYxvWZW4zIcSzhFhf0Yp5r/1Vfg7tB69+5kPtXPZz45quPZPbqjuUZSya7coY+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546124;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cs4S4AFueWMRJdnxFgQMD1WAaGda78f/+6PBqoLRN3E=;
	b=O032iL6lTZQGIdWRD3KEEdGZ0yrGYyZWssGGoRQQ48nQZb8A7IWWjrGEuodmCpc0dOoq
	 8Lvv3lagCunar8DPzMVaXpLshqvCXyAl8Tt+0CyzjY4DvKoZTWyzVOmQWVT42kKu6zY7P
	 pMyPibpV/3WbASSKFNz1Ct7Qok/gL0jdlU9WFMuyii0NX/AxAzazadH7myhHhGQ6j06ht
	 kniyk0KzofcqE1CzdwJ1PuPDt0c/hMBF2euD90yEugF4FL31QFMWMeIjskumgeMpWgJ/V
	 E5l9D9sHYNdC3ZyB0HzZDtgZlvFc1rNbn3S177kr8fDI/x8VJL8hopaoVpWUpqHL5Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JG3+xIma;
	arc=none smtp.remote-ip=95.215.58.18
Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1018606A321
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 18:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1018606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JG3+xIma
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CmkSQ4CxcyR76apA7iTWwA9ibRDNgTzGuxBahYNrUVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795546121; v=1; x=1796150921;
 b=JG3+xImaz7IrACxZNVbOKlGaQciMorRBEMoZDjyVkWUmjQzQusPu9b2K1qdkzSJAFWaE9ner
 WbfeDsaprUuf7UTFq5Ibq1RQJzCC2cM+c6p7k2CsnsuofRrZV3uz+muMDD8XRKB3bpRLMAQ4Qq7
 weSBZgRU6SGL6lWFhnZPhyjQ=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 53aa10411055c488;
	Tue, 24 Nov 2026 18:48:41 +0000
X-Mizu-Trace-ID: 53aa10411055c488
X-Migadu-Flow: FLOW_OUT
Message-ID: <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
Date: Tue, 24 Nov 2026 19:48:40 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
To: =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 "luke@ljones.dev" <luke@ljones.dev>, "ddadap@nvidia.com"
 <ddadap@nvidia.com>, linux-acpi@vger.kernel.org
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/24/26 00:27, Riccardo Zanghí wrote:
> Hello,
>
> On an ASUS TUF Gaming A16 (AMD iGPU + RTX 5060 Max-Q, MUX switch) no
> single kernel command line gives working brightness control in all
> graphics modes.
>
> Laptop: ASUS TUF Gaming A16 FA608UM_FA608UM
> BIOS: FA608UM.311
> Kernel: 7.3.5-2-cachyos
> NVIDIA: nvidia-open 620.73.04 (nvidia-drm modeset=Y)
> Distro: CachyOS, KDE Plasma (Wayland)
>
> asus-nb-wmi exposes gpu_mux_mode on this machine.
>
> Observed ("type" in parentheses where recorded):
>
> 1. Integrated and hybrid, no backlight parameters:
>    /sys/class/backlight contains only nvidia_wmi_ec_backlight
>    (firmware). Brightness control works.
>
> 2. dGPU (MUX), no backlight parameters:
>    Same single device (firmware, max 200). Writes are accepted but
>    the panel does not change. The kernel log contains:
>    "nvidia-modeset: ACPI reported no NVIDIA native backlight
>    available; attempting to use ACPI backlight."
>
> 3. dGPU with acpi_backlight=native:
>    Only nvidia_0 exists (raw, max 100), and it controls the panel.
>    The message above no longer appears in the kernel log. If
>    nvidia_wmi_ec_backlight.force=1 is added as well,
>    nvidia_wmi_ec_backlight (max 200) also appears, but only
>    nvidia_0 changes the panel.
>
> 4. Integrated with acpi_backlight=native:
>    Only amdgpu_bl1 exists. It accepts writes but the panel does not
>    change.
>
> So integrated and dGPU need opposite settings: the default works in
> integrated (and hybrid), while dGPU needs acpi_backlight=native, and
> each setting breaks the other mode. I have not tested hybrid with
> acpi_backlight=native. In dGPU mode the NVIDIA driver appears to ask
> ACPI for a native backlight, get "no", and fall back to a device that
> does not control the panel.
>
> Similar reports on other A16 models:
> https://github.com/OpenGamingCollective/asusctl/issues/118
> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2134615
>
> Would a MUX-aware backlight choice be acceptable here, or is a DMI
> quirk the expected route? I can test patches and provide dmesg or
> acpidump output if that helps.

Hi Riccardo,

I have tried to check what the nvidia driver does, I am not sure but I think the
problem is that on kernel code does not return true on acpi_video_backlight_use_native()
and thus something else (that doesn't work) gets selected.

Probably because the ACPI is returning something wrong or that the kernel
is not interpreting correctly: unsure.

However this has little to do with the gpu switch as the switch itself, so IMHO
the best thing is to identify the correct people that maintain the code in
acpi_video_backlight_use_native and CC them.

I am unsure if a DMI switch can solve the problem in both configurations,
and having a check to use acpi_backlight=native in dGPU mode will surely
break a lot of other laptops, maybe a combination of the two could work...

But either way we need to hear them: I don't know enough on that to be
useful on solving this without causing more troubles than I would solve.

> Thanks,
> Riccardo
