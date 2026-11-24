Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551471;
	b=dQrw7kj81zGOcekYpFkRBLt/uVswPMjLMc6en0njJ/97Zw6vGYD7kNvX7qvzPkRwQrKX
	 bsC7WWaTaqOGcjYneZsHh2Vu6mNYTdo6GPG+HWEKcnZe0Sfo3i+fakNX6qQrkIeVapKEB
	 I1GId0AjuqKeAzo/9JoVAcBJna7U67nDtKMMWJrwxSZFKZW6Ws0paUW+9QJ+DzaITTTHE
	 IcdGysHcE3X6uLkkSY00mgm4BX+YiHhjZ+P0+thIVE53rPQMFrGICyTgs83wohW6VQF44
	 6yKtRvD3MF+EVuvt7hcrGsOHRejvcg76g6u/DQyKc5LkKPP1L9Aw/3rv6+d0ygiJlRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551471;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=bQyR2aI6+lHpLHazfh+n8/0sVYrN4rOPKLG1xgrg5Lg=;
	b=uPTXYAReqsgvVtG0GPagxVPRkfiRTgiB1+CUUQqGGbgH9pHTQXs9q4qiIYHIdePHKY6n
	 +ytdKHdw30S+MiouQlpmD7LLPNWMFLrfi8eFAj5XqcCGcdq/l8ERQWlBoxn5yBT4WueRY
	 hoW9fEJ/jvkJiSC6WXE1f9I0tOS2SRPV6DYQZklk6LEpoauNtQ6fCP4P2O6GbfrWngLjS
	 Pijfqema9IXxPrQA+w9crdI4sfSKTRtEEcLylGwTGShs02mrdNBFwBDOWw4y39IYWzJb4
	 q3R9hqSkSWosObtfunTG4CZROQoltqpZoCx2bZMOxK4JOrsqEmyaEJD/w6mqgKr6uDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VZyBwVUR;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE5606A321
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 20:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AEE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VZyBwVUR
DKIM2-Signature:  i=1; m=1; t=1795551468;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
 d=gmx.de;
 s=s31663417:rsa-sha256:IdDbwbPrE1++scvz2gzZFuE4x9Ev
   zfFrsdenuGMZcDsnnda5RSGFR1Km+r0Gi/nFFQf+zQ/h+DyixV91dcluyfS5XlrvxZIRPLV6KSI
   Fain82Y5MGAAJC4Ol3Z/+WwjV3GoaKC9hI7bKkDpPaPs15VYyt1RfCPYZnYJFNVbjJGo5eWeXyv
   RT4qrndb3ZVtVExaCVyXs5BbV4PMfR0Y6tOAyJPkAoY5ZWXPkN3kx+MCUIIpDdawPjZC9PlUNjI
   3vj3C7W59O+vMrJgO+HabodOqC4NceJLU+zf5FsNnFJ16EVmmMEm1BQz58Zj8vjg+vHnJ9UywuP
   7tDA4kvJuFbYew==;
Message-Instance:  m=1;
 h=sha256:
   GQsd9mKAw6PbJL48tC1z0YT4P8Ey4Li4aiPU/YMjQ/8=:
   2ufZioX1t1lDjDGfPBU8CSxtPTecsz7Qx4vQsarc3+0=,
  sha512:
   ucWynDStpjQPvFD3z5lSe7y76IdoFvJN7hNdkKsVutiXOcbgbTqAc6MHjt5BmqdXZVWQ3KNdd4a+tRwU/Wbv2A==:
   cC1L4UM2zX0Tvxxx3FXUJV2loZnJSghUdKM3iK9mga+3hJlGpZXaC486WgZKBGR3iCjGFPIRqAnVu1IY4xpYQg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795551448; x=1796156248; i=w_armin@gmx.de;
	bh=bQyR2aI6+lHpLHazfh+n8/0sVYrN4rOPKLG1xgrg5Lg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VZyBwVURFzHoDyTxR+nzUcFjUoR72rUNOdI1SVVfd/gOPrtdckE4XzbOPAEgGdjq
	 E3GDM7CGQr3yHOEEfgVZZ4lmIk1iPPovy+mYXVWgTVk70wZlRPUAkOERU2mNHbHe/
	 dO7OeMcaE2Xp/2cHEwG1fnIXRdVFOVJFSR6wt2Zj+aBACqkXEq3kngX22GJODns9d
	 X1QghuY9OuorZ0iovxQFGj0qktyk90otc4ucdz3orRBK/dvfg6VxgYdZsrPgpdgFx
	 5kbeKGeyN13lAnL6CfeqbDYDS3S4a4WxLuuit30/h6IML1bqzBIbc6++W1FlBAQm6
	 KOOu2MTkE+mckfkwWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1xzG3B27ML-00V2wj; Tue, 24
 Nov 2026 21:17:28 +0100
Message-ID: <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
Date: Tue, 24 Nov 2026 21:17:26 +0100
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
To: Denis Benato <denis.benato@linux.dev>,
 =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 "luke@ljones.dev" <luke@ljones.dev>, "ddadap@nvidia.com"
 <ddadap@nvidia.com>, linux-acpi@vger.kernel.org
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wgt0XG74Uv69LMs8JtTAnSVSaclvWdIoGwtaL+D3zgX4wD5051d
 NiwK1qSFMhLoTINf6ZUsydeAajVmtRXsJH0UYwkOYJQwJnTpwFXjRkoCNJk7vXUO1NJn08l
 /M/uv/CJ2p9WwGjKKJj3N+CZe7e7aYr7gwxd77y35vnnlC9DO4yfcDVQgZsNiQgu1Cmawqv
 F4oc951JsP1++grXNilsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0zYGgw6Roy4=;+gCJzTOUR1yUELuCg5Qe+/Si10M
 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
 ya/76V5tJJenfduO/Pcz0OO+Oor4wQ=

Am 24.11.26 um 19:48 schrieb Denis Benato:

> On 11/24/26 00:27, Riccardo Zangh=C3=AD wrote:
>> Hello,
>>
>> On an ASUS TUF Gaming A16 (AMD iGPU + RTX 5060 Max-Q, MUX switch) no
>> single kernel command line gives working brightness control in all
>> graphics modes.
>>
>> Laptop: ASUS TUF Gaming A16 FA608UM_FA608UM
>> BIOS: FA608UM.311
>> Kernel: 7.3.5-2-cachyos
>> NVIDIA: nvidia-open 620.73.04 (nvidia-drm modeset=3DY)
>> Distro: CachyOS, KDE Plasma (Wayland)
>>
>> asus-nb-wmi exposes gpu_mux_mode on this machine.
>>
>> Observed ("type" in parentheses where recorded):
>>
>> 1. Integrated and hybrid, no backlight parameters:
>>     /sys/class/backlight contains only nvidia_wmi_ec_backlight
>>     (firmware). Brightness control works.
>>
>> 2. dGPU (MUX), no backlight parameters:
>>     Same single device (firmware, max 200). Writes are accepted but
>>     the panel does not change. The kernel log contains:
>>     "nvidia-modeset: ACPI reported no NVIDIA native backlight
>>     available; attempting to use ACPI backlight."
>>
>> 3. dGPU with acpi_backlight=3Dnative:
>>     Only nvidia_0 exists (raw, max 100), and it controls the panel.
>>     The message above no longer appears in the kernel log. If
>>     nvidia_wmi_ec_backlight.force=3D1 is added as well,
>>     nvidia_wmi_ec_backlight (max 200) also appears, but only
>>     nvidia_0 changes the panel.
>>
>> 4. Integrated with acpi_backlight=3Dnative:
>>     Only amdgpu_bl1 exists. It accepts writes but the panel does not
>>     change.
>>
>> So integrated and dGPU need opposite settings: the default works in
>> integrated (and hybrid), while dGPU needs acpi_backlight=3Dnative, and
>> each setting breaks the other mode. I have not tested hybrid with
>> acpi_backlight=3Dnative. In dGPU mode the NVIDIA driver appears to ask
>> ACPI for a native backlight, get "no", and fall back to a device that
>> does not control the panel.
>>
>> Similar reports on other A16 models:
>> https://github.com/OpenGamingCollective/asusctl/issues/118
>> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2134615
>>
>> Would a MUX-aware backlight choice be acceptable here, or is a DMI
>> quirk the expected route? I can test patches and provide dmesg or
>> acpidump output if that helps.
> Hi Riccardo,
>
> I have tried to check what the nvidia driver does, I am not sure but I t=
hink the
> problem is that on kernel code does not return true on acpi_video_backli=
ght_use_native()
> and thus something else (that doesn't work) gets selected.
>
> Probably because the ACPI is returning something wrong or that the kerne=
l
> is not interpreting correctly: unsure.
>
> However this has little to do with the gpu switch as the switch itself, =
so IMHO
> the best thing is to identify the correct people that maintain the code =
in
> acpi_video_backlight_use_native and CC them.
>
> I am unsure if a DMI switch can solve the problem in both configurations=
,
> and having a check to use acpi_backlight=3Dnative in dGPU mode will sure=
ly
> break a lot of other laptops, maybe a combination of the two could work.=
..
>
> But either way we need to hear them: I don't know enough on that to be
> useful on solving this without causing more troubles than I would solve.

Hi,

if i understand correctly then the WMI interface is not supposed to act as=
 the
central backlight interface for the integrated panel under Windows, instea=
d a usermode
service likely listens for backlight changes and notifies the EC using sai=
d WMI
device.

AFAIK Windows will automatically fall back to the ACPI backlight interface=
 if the
driver does not provide a native backlight interface itself, so this strat=
egy differs
a lot from the strategy used in Linux. Can you share the output of "acpidu=
mp"?

Thanks,
Armin Wolf

>> Thanks,
>> Riccardo
>>
