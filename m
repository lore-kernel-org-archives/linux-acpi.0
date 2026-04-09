Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B583446BC
	for <linux-acpi@vger.kernel.org>; Thu,  9 Apr 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768406; cv=none; b=l3mjOeYzMRIafELQ4+iU8gaBkwpnv/aDaM/cQWuywAZ3Zw3Ql3Sfcmix9jZmS89zyh0+X0K64Ofy2KLe/2cJEEpX6k863OqOhoy2MASJOht2fLs4zryp7MmwQ6QPcw9riWbXyyMQx2qX88Ayr6WqbH+IRiZ1al5gKi3PCbWbHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768406; c=relaxed/simple;
	bh=mnGVnvxmKh71195gJBvPzQUOqAJ03JdsCYtAigFabho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpDsCBtNyAZhxFcr81KISb5meNRzXIuUjlmUuOoKeXN5p02nNDUYoYVyk9Yzm/AD94Iy68YDlbDEDoXAeeXcpAepU59pD8f32T0Tfr0IxQozu0HkQumPJy6rzHY2Pc2vK+SEXma+nitNGm5viMVfOSP5zT+En7FG4LSY+JU/tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VZdEJIwn; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VZdEJIwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775768400; x=1776373200; i=w_armin@gmx.de;
	bh=rUQ0HbwkOYFcKH1Qny5KuRgdpUFfSyqRggo8XqeVj6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VZdEJIwnf7gMLOEaTkxv05up2kjfl75JjOrcW7DLB49DiX3DUncjmfd5iFP/FSwy
	 E1rv220l5ikGv4Cv7mjeucvT+6loP1pMGlPjp8ukpfAw5umbRRRUhD9kkmmcSRlzz
	 6piNbTIGvmGsVJfn4DSODfdHNrYfphWFyIOkq3e770C1MNm404LeMYIdy94CeRQa5
	 NnxzcbAde3PG6tU915L0U1PjL6OGtFhX+WiUtS03eJ5vFB/+fHyAiUW5EMaLPWvNz
	 XMdS8PecZYSz7PwXVlnCM1wbC/FPpue7KHjcyZoVGd0zeNH4DT8NDv2ZYed+E9bZ3
	 2ILym/Y+AawN091Gqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf4S-1vlGRm2XkA-00kFVK; Thu, 09
 Apr 2026 23:00:00 +0200
Message-ID: <673690f1-cdb3-400e-b11e-8490e80a23ef@gmx.de>
Date: Thu, 9 Apr 2026 23:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision
 (ASMI) causes early boot hang
To: Alexander Zubkov <zubkov318@gmail.com>
Cc: linux-acpi@vger.kernel.org
References: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
 <4380e659-c807-43c4-9fe3-97e1403cc8a7@gmx.de>
 <CABXn0zdTmaR_pXR1Q73uHWFL=62V-VdGt3+M1Kig6LBpCnXZrA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CABXn0zdTmaR_pXR1Q73uHWFL=62V-VdGt3+M1Kig6LBpCnXZrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mo0Nrb8lYUbLlhf4aGbBu2gJnhtIStKPbkMXC+od9W9+m1yWwN+
 nW0TatfBPuZftcFUPbXKNyEeIdBGXwWAR+raJmuchJZTthqSzT+dHJ3sfWNW/l2YuLyDVHo
 eXcgEub3VL6si0lpuX4u42pRf803J+6HICo7Dxmu2IRFwYQAVo48JlGje48XSj33afoLaBv
 SG1ZgbvJwzvNhfbL2Gutw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mGTPOh17SJs=;KN2/+Vix/nCppzyMDUBrT8n5k44
 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
 L/NnaQnwobmQTTaV9HSdM9Zl9GhggzZ6fZDo=

Am 09.04.26 um 21:19 schrieb Alexander Zubkov:

> On Thu, Apr 9, 2026 at 4:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 07.04.26 um 22:53 schrieb Alexander Zubkov:
>>
>>> Hello,
>>>
>>> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-BQ067
>>> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
>>> M1502NAQ.302.
>>>
>>> Linux kernels (tested with recent mainline live images of Alpine,
>>> Void, NixOS and Fedora) hang immediately after bootloader when ACPI is
>>> enabled. No output is produced, even with earlycon/earlyprintk:
>>> earlycon=3Defi,keep earlyprintk=3Defi,keep loglevel=3D8 ignore_logleve=
l
>>> initcall_debug acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
>>>
>>> I've tried various ACPI-related options, boot works only with:
>>> * acpi=3Doff (but system resets with no error several seconds after th=
e
>>> boot, keyboard does not work)
>>> * acpi_no_static_ssdt (system boots, keyboard does not work)
>>>
>>> Notebook's firmare was upgraded to the latest available version. I've
>>> also tried to boot a windows installer, just to check it is not a
>>> hardware issue. It boots normally.
>>>
>>> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
>>> Although I suppose it misleaded me sometimes, it turned out to be
>>> useful, because I found a DSDT patch that fixed the issue. Most of
>>> debugging was done using Alpine's kernel 6.18.21-0-lts.
>>>
>>> The issue was traced to a namespace collision in DSDT:
>>> * Method \ASMI defined in global scope
>>> * Method _SB.ASMI also defined
>>>
>>> ChatGPT presumes that unqualified calls to ASMI appear to resolve
>>> incorrectly under Linux (ACPICA), leading to a firmware-level failure
>>> during early ACPI initialization. I dumped ACPI tables from UEFI shell
>>> and tried different overrides.
>>>
>>> The minimal fix I found is renaming the global method in DSDT and its
>>> single call. After applying this dsdt.aml override, the kernel boots
>>> well without additional acpi options, does not reset after boot, and
>>> the keybord initializes and works well. The patch looks like this (and
>>> I also increased the revision number):
>>>
>>> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
>>> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
>>> @@ -10138,7 +10138,7 @@
>>>                SMCM =3D Arg0
>>>            }
>>>
>>> -        Method (ASMI, 1, Serialized)
>>> +        Method (ASMX, 1, Serialized)
>>>            {
>>>                AL_D =3D Arg0
>>>                SMCM =3D 0xD6
>>> @@ -10151,7 +10151,7 @@
>>>                DB_2 =3D Arg1
>>>                DB_3 =3D Arg2
>>>                DB_4 =3D Arg3
>>> -            ASMI (0x80)
>>> +            ASMX (0x80)
>>>            }
>>>        }
>>>
>>> Is this a known ACPICA behavior difference vs Windows, or should this
>>> be considered a firmware bug only? I can provide full acpidump / DSDT
>>> if needed.
>> This might indeed be a Bug inside ACPICA, please provide the acpidump
>> so we can inspect the caller of ASMI ().
> Please see the acpi dumps and override attached. I noticed that dump
> from Linux slightly differs from the one I made from shell.
>
> acpi-shell.tar.xz - dump from UEFI shell
> acpi-linux.tar.xz - dump from Linux with override applied
> asus-fix.cpio.xz - early initrd with DSDT override

Thanks, please use reply-all next time so other people can access the ACPI=
 tables too.
I wrote a simple ACPI table to simulate your problem (two ASMI methods, on=
 at \ and one at \_SB),
and it seems that ACPICA correctly uses the ASMI method inside the _SB sco=
pe.

Does the problem still occur when you blacklist the asus-wmi driver? AFAIK=
 all the calls to ASMI()
are triggered by said driver.

Can you also check if loading asus-wmi later in the boot process (for exam=
ple after the users has
logged in) fixes this issue?

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> Thanks,
>>> Alexander Zubkov
>>>
