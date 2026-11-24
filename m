Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552292;
	b=h4EBGSCnJd3/ojlK+ziO5JWxtMgfFHGhTD7gyMtHr1cMzpW7vgKZ61N+hpU652yapRLO
	 fTlzVG/UOp+cNEUDQdIMO7fzpwqoRDrM09B+b0K8NbjcD8T22yd35LPtw2AFMEYXTMByp
	 ZQza/mhtSFcswc6COytuIElvvECVy9G2yULLBGY2et4YQc5Ex+mxfhgyEghqmVQ5JXEci
	 V338e0T8X1hpaX++tkWY3LpbYJNSxfpwjb/aSfkLBsqpCYamtl3KJ7SpYtH9x9oPfKHhd
	 87J5Fi7kMMcEUOubG8W+cdm05ZTzALzO0nNMKZYWOmi8mQ/NGlfqjXebc7x5TNp5U8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552292;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2PtkxOAKluWgSgDTPyboyHUsn6J2okExmVechF2fuoc=;
	b=Qow8IBG/jkoEcsfdSGvbtXs/wnJl4owV3dzFyUpdrYoAFJiRGfnYuuGCBpKBNDZDrwf0
	 32Gy+ujJd9zcElOXgvb3ec9uf08a+MwXL2GWs9ueSA3lxsPnRBS4PuXNGoT9cqXrQKd77
	 0bo9HpaCGLFnXAOrLpISQ/SUUaO1M83rY4Kf42DqsrgGLItthk9gpaNvS6GJp5Om/1ged
	 jwrBqNS4RJEJeP1P2iLmKu+mbjZ0eAWGC/cDcySCLwYOR4HbG9NcteIl9F3YpdajLA6s2
	 vqxmMX+Q8Wh9JQp3m7ikkPobF2NotCjrkU+0QUpw4K3dIWKwah14452lzeClUBYL45Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sf1+yqUF;
	arc=none smtp.remote-ip=95.215.58.210
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD91606A321
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 20:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD91606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sf1+yqUF
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2PtkxOAKluWgSgDTPyboyHUsn6J2okExmVechF2fuoc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795552288; v=1; x=1796157088;
 b=Sf1+yqUFfpFSLB48GiANbB3mtsfdl/9tX8jc8SB0EoO3mcPwJ9G111b8+CDdSK1i8NcjVDms
 R+ZsjLkNqPOGOUGg8VsOVcLmpbFOFXjFq7MD/or3fo/zPbf6ZKGm2ifDI2IcL78zjgfec5t/81c
 xVT9F2fOOONTF6zqw3tUVQuk=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b0e58a19869e7ffa;
	Tue, 24 Nov 2026 20:31:28 +0000
X-Mizu-Trace-ID: b0e58a19869e7ffa
X-Migadu-Flow: FLOW_OUT
Message-ID: <d1b177a9-5891-4c6e-b43f-3af674f804b0@linux.dev>
Date: Tue, 24 Nov 2026 21:31:27 +0100
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
To: Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Riccardo_Zangh=C3=AD?=
 <riccardo.z.dev@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 "luke@ljones.dev" <luke@ljones.dev>, "ddadap@nvidia.com"
 <ddadap@nvidia.com>, linux-acpi@vger.kernel.org
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
 <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/24/26 21:17, Armin Wolf wrote:
> Am 24.11.26 um 19:48 schrieb Denis Benato:
>
>> On 11/24/26 00:27, Riccardo Zanghí wrote:
>>> Hello,
>>>
>>> On an ASUS TUF Gaming A16 (AMD iGPU + RTX 5060 Max-Q, MUX switch) no
>>> single kernel command line gives working brightness control in all
>>> graphics modes.
>>>
>>> Laptop: ASUS TUF Gaming A16 FA608UM_FA608UM
>>> BIOS: FA608UM.311
>>> Kernel: 7.3.5-2-cachyos
>>> NVIDIA: nvidia-open 620.73.04 (nvidia-drm modeset=Y)
>>> Distro: CachyOS, KDE Plasma (Wayland)
>>>
>>> asus-nb-wmi exposes gpu_mux_mode on this machine.
>>>
>>> Observed ("type" in parentheses where recorded):
>>>
>>> 1. Integrated and hybrid, no backlight parameters:
>>>     /sys/class/backlight contains only nvidia_wmi_ec_backlight
>>>     (firmware). Brightness control works.
>>>
>>> 2. dGPU (MUX), no backlight parameters:
>>>     Same single device (firmware, max 200). Writes are accepted but
>>>     the panel does not change. The kernel log contains:
>>>     "nvidia-modeset: ACPI reported no NVIDIA native backlight
>>>     available; attempting to use ACPI backlight."
>>>
>>> 3. dGPU with acpi_backlight=native:
>>>     Only nvidia_0 exists (raw, max 100), and it controls the panel.
>>>     The message above no longer appears in the kernel log. If
>>>     nvidia_wmi_ec_backlight.force=1 is added as well,
>>>     nvidia_wmi_ec_backlight (max 200) also appears, but only
>>>     nvidia_0 changes the panel.
>>>
>>> 4. Integrated with acpi_backlight=native:
>>>     Only amdgpu_bl1 exists. It accepts writes but the panel does not
>>>     change.
>>>
>>> So integrated and dGPU need opposite settings: the default works in
>>> integrated (and hybrid), while dGPU needs acpi_backlight=native, and
>>> each setting breaks the other mode. I have not tested hybrid with
>>> acpi_backlight=native. In dGPU mode the NVIDIA driver appears to ask
>>> ACPI for a native backlight, get "no", and fall back to a device that
>>> does not control the panel.
>>>
>>> Similar reports on other A16 models:
>>> https://github.com/OpenGamingCollective/asusctl/issues/118
>>> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2134615
>>>
>>> Would a MUX-aware backlight choice be acceptable here, or is a DMI
>>> quirk the expected route? I can test patches and provide dmesg or
>>> acpidump output if that helps.
>> Hi Riccardo,
>>
>> I have tried to check what the nvidia driver does, I am not sure but I think the
>> problem is that on kernel code does not return true on acpi_video_backlight_use_native()
>> and thus something else (that doesn't work) gets selected.
>>
>> Probably because the ACPI is returning something wrong or that the kernel
>> is not interpreting correctly: unsure.
>>
>> However this has little to do with the gpu switch as the switch itself, so IMHO
>> the best thing is to identify the correct people that maintain the code in
>> acpi_video_backlight_use_native and CC them.
>>
>> I am unsure if a DMI switch can solve the problem in both configurations,
>> and having a check to use acpi_backlight=native in dGPU mode will surely
>> break a lot of other laptops, maybe a combination of the two could work...
>>
>> But either way we need to hear them: I don't know enough on that to be
>> useful on solving this without causing more troubles than I would solve.
>
> Hi,
>

I will add some more asus-specific context.

The vast majority or ROG laptops (and some TUFs) have a dGPU switch and a
MUX switch. The MUX decides what device is connected to the screen and is
setup once at boot so a reboot is always needed to apply the setting.

The dGPU switch can be implemented in many ways: there are laptops that
apply it at reboot, while others can toggle it off while the GPU is fully off, in fact
we have added a wmi method to check that too to asus-armoury.

Those two switch can (depending on the model) change what the ACPI does
and what is exposed to the system.

Hopefully this is useful to solve the issue, I think it's the most I can do at least
for now.

> if i understand correctly then the WMI interface is not supposed to act as the
> central backlight interface for the integrated panel under Windows, instead a usermode
> service likely listens for backlight changes and notifies the EC using said WMI
> device.
>
> AFAIK Windows will automatically fall back to the ACPI backlight interface if the
> driver does not provide a native backlight interface itself, so this strategy differs
> a lot from the strategy used in Linux. Can you share the output of "acpidump"?
>
> Thanks,
> Armin Wolf
>
>>> Thanks,
>>> Riccardo
>>>
