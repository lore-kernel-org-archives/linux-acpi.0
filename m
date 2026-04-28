Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AA1A9F8C
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411705; cv=none; b=k73OIQh1w2DM3Fmhsfb6fIewlI1nariyrul053s7/UpnLqf3QBbmDWdb1QmWVCHuUj7V0e200N/E8wOzKSbdkFi/wvRJkw6U582E718FmJce6cql5lC9O+bpFtYKqO1NN8csIK2xqKMjQW6BNTCASefRHGott4X48PBxzzSC6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411705; c=relaxed/simple;
	bh=JU4ybCuZIpOlCMgMPgGMCAnZJWwBBc95J+Nqjb5uM+c=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OVaSdJi5T6SujFOj0Nx2PZp4zNyF6704HyaYuIXRJvqjMIbY1N2EBJuvLt2YldWTJ3fiqGVgeBpNTa1GiVYZb4rW/VAPFdlUW2DvOyN117+A9tkY7IfyUDzmAyiTQNeVHCfEjR4y+NDTsQU+sl1mnZ2MW5DQUE7aAHorPSyGjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MKlquYh9; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MKlquYh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777411700; x=1778016500; i=w_armin@gmx.de;
	bh=cXTe5FjZeiYyXeSfQS4JoYLd+LQDYwEWnTKsfBU38hY=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKlquYh9dvr5YlwZyDsan5mqBUpLue31095rnCvrRjfA2ZsziRskYQw4Di6gEAIe
	 CJQtT8KzUElGOAxUg+9h1CaGoJ+fv9Bb63jZXnRfqhd2fP5V5HT5/hPxCjbcq+o9g
	 55MTOFm6zn4AmYdS7ko5HOv2qVHuQVMtuPevGtkLRB5vE17pu9GnpBrTee5WsZMod
	 qa3krThdFu1stvaSsvg0DeUi03KHmsbUiv6kRsyKfethvizN/QOx5ItcyrfzlV4R0
	 qg3NkJb1raXVLNjpHaha384RtlD5yV5F68COgUur/1dTkyuV7qeFCowTyAVlmykGP
	 KdBrv9hgXkPdz2Sm4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1vZ8gd2WQ3-00gJHd; Tue, 28
 Apr 2026 23:28:20 +0200
Content-Type: multipart/mixed; boundary="------------x3UP05fEpaki3u8hL0YIV0Nt"
Message-ID: <cdc2b171-0b13-4795-a615-6f953dc4005c@gmx.de>
Date: Tue, 28 Apr 2026 23:28:20 +0200
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
 <673690f1-cdb3-400e-b11e-8490e80a23ef@gmx.de>
 <CABXn0zeBHt7CkJOBpyE5=nhj3AOxiAELZLk7PzjSUmwi4BoU3Q@mail.gmail.com>
 <CABXn0zeKbNvWHRrV-VAnffAi4a16i8T0r13sEJDmvcQe0E56UQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CABXn0zeKbNvWHRrV-VAnffAi4a16i8T0r13sEJDmvcQe0E56UQ@mail.gmail.com>
X-Provags-ID: V03:K1:oB6Nk1M23IDsa7Rf2c53/DxLuCcaShNhu21z4Ask6lOzTqJCq1g
 mGvfmKWdbHv7Rs/mc9h4yFYUQUZPUwp5kJPfraEhrhunrvw4yLus32OHhvPL59iRGg+WmzF
 ++0ot8+NwIpFMI3vSeVeU7DH+qwT+aWv51aUvOIP6b1BgjIeXiSEpI3CKf4QIjyqRsFRd2+
 k5FH0W4UzIKFcksxbhZWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XWGI7kuKL+g=;wfhGvPysUSc/0/BG8EJ8wr/xcHE
 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
 5oWz8yH3U=

This is a multi-part message in MIME format.
--------------x3UP05fEpaki3u8hL0YIV0Nt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 28.04.26 um 09:03 schrieb Alexander Zubkov:

> On Fri, Apr 10, 2026 at 10:11=E2=80=AFAM Alexander Zubkov <zubkov318@gma=
il.com> wrote:
>> On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>> Am 09.04.26 um 21:19 schrieb Alexander Zubkov:
>>>
>>>> On Thu, Apr 9, 2026 at 4:58=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>>> Am 07.04.26 um 22:53 schrieb Alexander Zubkov:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-BQ=
067
>>>>>> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
>>>>>> M1502NAQ.302.
>>>>>>
>>>>>> Linux kernels (tested with recent mainline live images of Alpine,
>>>>>> Void, NixOS and Fedora) hang immediately after bootloader when ACPI=
 is
>>>>>> enabled. No output is produced, even with earlycon/earlyprintk:
>>>>>> earlycon=3Defi,keep earlyprintk=3Defi,keep loglevel=3D8 ignore_logl=
evel
>>>>>> initcall_debug acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
>>>>>>
>>>>>> I've tried various ACPI-related options, boot works only with:
>>>>>> * acpi=3Doff (but system resets with no error several seconds after=
 the
>>>>>> boot, keyboard does not work)
>>>>>> * acpi_no_static_ssdt (system boots, keyboard does not work)
>>>>>>
>>>>>> Notebook's firmare was upgraded to the latest available version. I'=
ve
>>>>>> also tried to boot a windows installer, just to check it is not a
>>>>>> hardware issue. It boots normally.
>>>>>>
>>>>>> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
>>>>>> Although I suppose it misleaded me sometimes, it turned out to be
>>>>>> useful, because I found a DSDT patch that fixed the issue. Most of
>>>>>> debugging was done using Alpine's kernel 6.18.21-0-lts.
>>>>>>
>>>>>> The issue was traced to a namespace collision in DSDT:
>>>>>> * Method \ASMI defined in global scope
>>>>>> * Method _SB.ASMI also defined
>>>>>>
>>>>>> ChatGPT presumes that unqualified calls to ASMI appear to resolve
>>>>>> incorrectly under Linux (ACPICA), leading to a firmware-level failu=
re
>>>>>> during early ACPI initialization. I dumped ACPI tables from UEFI sh=
ell
>>>>>> and tried different overrides.
>>>>>>
>>>>>> The minimal fix I found is renaming the global method in DSDT and i=
ts
>>>>>> single call. After applying this dsdt.aml override, the kernel boot=
s
>>>>>> well without additional acpi options, does not reset after boot, an=
d
>>>>>> the keybord initializes and works well. The patch looks like this (=
and
>>>>>> I also increased the revision number):
>>>>>>
>>>>>> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
>>>>>> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
>>>>>> @@ -10138,7 +10138,7 @@
>>>>>>                 SMCM =3D Arg0
>>>>>>             }
>>>>>>
>>>>>> -        Method (ASMI, 1, Serialized)
>>>>>> +        Method (ASMX, 1, Serialized)
>>>>>>             {
>>>>>>                 AL_D =3D Arg0
>>>>>>                 SMCM =3D 0xD6
>>>>>> @@ -10151,7 +10151,7 @@
>>>>>>                 DB_2 =3D Arg1
>>>>>>                 DB_3 =3D Arg2
>>>>>>                 DB_4 =3D Arg3
>>>>>> -            ASMI (0x80)
>>>>>> +            ASMX (0x80)
>>>>>>             }
>>>>>>         }
>>>>>>
>>>>>> Is this a known ACPICA behavior difference vs Windows, or should th=
is
>>>>>> be considered a firmware bug only? I can provide full acpidump / DS=
DT
>>>>>> if needed.
>>>>> This might indeed be a Bug inside ACPICA, please provide the acpidum=
p
>>>>> so we can inspect the caller of ASMI ().
>>>> Please see the acpi dumps and override attached. I noticed that dump
>>>> from Linux slightly differs from the one I made from shell.
>>>>
>>>> acpi-shell.tar.xz - dump from UEFI shell
>>>> acpi-linux.tar.xz - dump from Linux with override applied
>>>> asus-fix.cpio.xz - early initrd with DSDT override
>>> Thanks, please use reply-all next time so other people can access the =
ACPI tables too.
> Sorry to bother. Is my debug helpful somehow? Could it be something in
> ACPICA, or I'd better try reporting it to Asus?

I hoped other people on this mailing list did spot something, but it seems=
 that no one
(including myself) has an idea why this happens.

I suggest that you create an issue with ACPICA directly: https://github.co=
m/acpica/acpica
I attached the SSDT i used for testing, it also contains some WMI devices =
that should be
usable under Windows for testing purposes.

Thanks,
Armin Wolf

>> Sure, I have this by default. And I see I replied to all, my message
>> is visible in the mailing list archive.
>>
>>> I wrote a simple ACPI table to simulate your problem (two ASMI methods=
, on at \ and one at \_SB),
>>> and it seems that ACPICA correctly uses the ASMI method inside the _SB=
 scope.
>>>
>>> Does the problem still occur when you blacklist the asus-wmi driver? A=
FAIK all the calls to ASMI()
>>> are triggered by said driver.
>> I don't think it is related to the driver, because the boot process
>> hangs with absolutely no output from the kernel, even with the
>> mentioned debugging options. And as I see, asus-wmi is built as a
>> module at least in Void and Alpine, so the kernel hangs way before it
>> starts loading any modules. I also tried to make some initramfs with a
>> reduced modules set, and it did not include asus-wmi there. And even
>> booting just a single kernel, or a kernel + acpi tables overrides also
>> hang right at the beginning with no output.
>>
>> I think the following details of my investigation might be helpful at
>> this point:
>>
>> After the success with "acpi_no_static_ssdt" option, ChatGTP suggested
>> that one of `ssdt*.dsl` might be faulty. I tried to mask them all
>> replacing them with empty bodies, it did not help.
>>
>> Then it said "acpi_no_static_ssdt" besides ignoring `ssdt*.dsl` also
>> might change something in early boot. As the boot hang very early,
>> ChatGPT suggested that something might be happening in _INI or _REG
>> methods, but that was also a dead end. Then it said that global
>> namespace (\) is used early too.
>>
>> First I tried to remove all `Scope (\)`, but there was scopes and
>> devices WMI0 and UAT2, that refered something from those global scopes
>> and the table did not compile. So I removed those sections too, and it
>> was also successful, the kernel did not hang early (dstd.dsl.2).
>>
>> Then I tried various combinations of removing WMI0 and UAT2, but I
>> kept the section with ASMI method. Once I had WMI0 and UAT2 deleted,
>> and only difference with `dstd.dsl.2` was a couple of global scopes -
>> one with ISMI and ASMI methods, and I made their bodies empty, and
>> other with H0_?, OE_? methods, also with empty bodies (dstd.dsl.12).
>> That variant also hangs. But starts booting when I remove those ISMI
>> and ASMI methods (dstd.dsl.13). At this point ChatGPT said that ASML
>> and ISML names could have some special meaning and break something and
>> suggested renaming them.
>>
>> Renaming helped, but when I was renaming ASMI, I noticed that the same
>> name is also defined in _SB. I tried renaming only this method, it was
>> also successful (dsdt.dsl.20). ChatGPT said something about that it
>> could cause the name collision, that spec forbids such ambiguous
>> naming, and Windows interpreter could have different behaviour here.
>>
>> By the way, I accidentally used the wrong fix as a final version on
>> the notebook, the one that renamed both methods. It also works, but
>> not minimal. So I'm attaching again a cpio with a better fix and a new
>> dump of acpi tables from Linux.
>>
>>> Can you also check if loading asus-wmi later in the boot process (for =
example after the users has
>>> logged in) fixes this issue?
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>>>>> Thanks,
>>>>> Armin Wolf
>>>>>
>>>>>> Thanks,
>>>>>> Alexander Zubkov
>>>>>>

--------------x3UP05fEpaki3u8hL0YIV0Nt
Content-Type: text/plain; charset=UTF-8; name="ssdt.asl"
Content-Disposition: attachment; filename="ssdt.asl"
Content-Transfer-Encoding: base64

RGVmaW5pdGlvbkJsb2NrICgiIiwgIlNTRFQiLCAyLCAiV29sZiAgIiwgIkxpbnV4IFJFIiwg
MHgxKQp7CglTY29wZSAoXCkKCXsKCQlNZXRob2QgKEFTTUksIDEsIFNlcmlhbGl6ZWQpCiAg
ICAgICAgewogICAgICAgICAgICBSZXR1cm4gKCJST09UIikKICAgICAgICB9Cgl9CgkKCVNj
b3BlIChfU0IpCgl7CgkJTWV0aG9kIChBU01JLCAxLCBTZXJpYWxpemVkKQogICAgICAgIHsK
ICAgICAgICAgICAgUmV0dXJuICgiU1lTVEVNIEJVUyIpCiAgICAgICAgfQoJfQoKCVNjb3Bl
IChcX1NCKQoJewoJCURldmljZSAoVEVTVCkKCQl7CgkJCU5hbWUgKF9ISUQsIEVpc2FJRCgi
UE5QMEMxNCIpKQoJCQlOYW1lIChfVUlELCAweDEyMzQpCgoJCQlOYW1lIChfV0RHLCBCdWZm
ZXIgKCkgewoJCQkJLy8gR1VJRCB7NjFEMkFBOUMtM0FFNy00QjAyLUJBMjctNzBERURFRDNF
MTAxfQoJCQkJMHg5YywgMHhhYSwgMHhkMiwgMHg2MSwgMHhlNywgMHgzYSwgMHgwMiwgMHg0
YiwgMHhiYSwgMHgyNywgMHg3MCwgMHhkZSwgMHhkZSwgMHhkMywgMHhlMSwgMHgwMSwKCQkJ
CTB4NDEsIDB4NDEsCS8vIE9iamVjdCBJZCAoQUEpCgkJCQkweDAxLAkJLy8gSW5zdGFuY2Ug
Q291bnQKCQkJCTB4MDAsCQkvLyBGbGFncyAoREFUQSkKCQkJCS8vIHswNTkwMTIyMS1ENTY2
LTExRDEtQjJGMC0wMEEwQzkwNjI5MTB9CgkJCQkweDIxLCAweDEyLCAweDkwLCAweDA1LCAw
eDY2LCAweGQ1LCAweGQxLCAweDExLCAweGIyLCAweGYwLCAweDAwLCAweGEwLCAweGM5LCAw
eDA2LCAweDI5LCAweDEwLAoJCQkJMHg1QSwgMHg1QSwgICAvLyBPYmplY3QgSUQgKFpaKSwg
bmVlZCB0byBtYXRjaCBXUVpaIGJlbG93LgoJCQkJMHgwMSwgICAgICAgICAvLyBJbnN0YW5j
ZSBDb3VudAoJCQkJMHgwMCAgICAgICAgICAvLyBGbGFncyAoREFUQSkKCQkJfSkKCgkJCUZ1
bmN0aW9uIChXUUFBLCBCdWZmT2JqLCBJbnRPYmopCgkJCXsKCQkJCVJldHVybiAoQVNNSSAo
MHg4MCkpCgkJCX0KCQkJCgoJCQlOYW1lIChXUVpaLCBCdWZmZXIoKSB7CgkJCQkweDQ2LAow
eDRGLAoweDRELAoweDQyLAoweDAxLAoweDAwLAoweDAwLAoweDAwLAoweDQ5LAoweDAyLAow
eDAwLAoweDAwLAoweDE4LAoweDA1LAoweDAwLAoweDAwLAoweDQ0LAoweDUzLAoweDAwLAow
eDAxLAoweDFBLAoweDdELAoweERBLAoweDU0LAoweDE4LAoweDVCLAoweDgyLAoweDAwLAow
eDAxLAoweDA2LAoweDE4LAoweDQyLAoweDIwLAoweEMyLAoweDAyLAoweDg5LAoweEMwLAow
eEQxLAoweDY4LAoweDE0LAoweDBGLAoweDA2LAoweEE1LAoweDAxLAoweDQ0LAoweDcyLAow
eDIwLAoweEU0LAoweDgyLAoweDg5LAoweDA5LAoweDEwLAoweDAxLAoweDIxLAoweEFGLAow
eDAyLAoweDZDLAoweDBBLAoweDMwLAoweDA5LAoweEEyLAoweEZFLAoweEZELAoweDIxLAow
eDRBLAoweDgyLAoweDQzLAoweDA5LAoweDgxLAoweDkwLAoweDQ0LAoweDAxLAoweEU2LAow
eDA1LAoweEU4LAoweDE2LAoweDYwLAoweDU4LAoweDgwLAoweDZELAoweDAxLAoweEE2LAow
eDA1LAoweDM4LAoweDg2LAoweEE0LAoweEQyLAoweEMwLAoweDI5LAoweDgxLAoweEE1LAow
eDQwLAoweDQ4LAoweEE4LAoweDAwLAoweEU1LAoweDAyLAoweDdDLAoweDBCLAoweEQwLAow
eDhFLAoweDI4LAoweEM5LAoweDAyLAoweDJDLAoweEMzLAoweDg4LAoweEMwLAoweEEzLAow
eDg4LAoweDZDLAoweDM0LAoweDBFLAoweDhELAoweDFELAoweDg2LAoweDY1LAoweDgyLAow
eDY5LAoweDEwLAoweDg3LAoweDUxLAoweDM2LAoweEIyLAoweDA4LAoweDNDLAoweEExLAow
eDRFLAoweDA1LAoweEM4LAoweDE1LAoweDIwLAoweDRDLAoweDgwLAoweDc4LAoweDU0LAow
eDYxLAoweDM0LAoweDA3LAoweDQ1LAoweEMyLAoweDQwLAoweEEzLAoweEM0LAoweDhDLAow
eDg5LAoweEMwLAoweDc2LAoweDhFLAoweEFELAoweDUxLAoweDlDLAoweDQ2LAoweEUxLAow
eDAyLAoweEE0LAoweDYzLAoweDY4LAoweDA0LAoweEM3LAoweDk1LAoweEEwLAoweEMzLAow
eDE5LAoweDY4LAoweDBBLAoweEQxLAoweDIyLAoweDE0LAoweDI0LAoweDQwLAoweDMzLAow
eDk0LAoweDAwLAoweDgzLAoweEM0LAoweDBCLAoweDZCLAoweDQ4LAoweDIzLAoweEY2LAow
eDBDLAoweDQ0LAoweDQ0LAoweDIzLAoweDA5LAoweEE0LAoweDYyLAoweDBDLAoweEExLAow
eEM0LAoweDNELAoweDM3LAoweEEzLAoweEI2LAoweDBFLAoweDRCLAoweDQwLAoweDYyLAow
eDQ3LAoweEM0LAoweDE4LAoweDFDLAoweDg0LAoweDg2LAoweDc3LAoweEQwLAoweDZELAow
eDBELAoweDlCLAoweDIyLAoweDlELAoweDYyLAoweEUwLAoweDgzLAoweDg5LAoweDcwLAow
eDlDLAoweDdDLAoweDJFLAoweDg3LAoweDg1LAoweDkxLAoweDAxLAoweEExLAoweDgxLAow
eDFDLAoweEMyLAoweEYxLAoweDlBLAoweEMwLAoweEVFLAoweDA1LAoweDY4LAoweDEzLAow
eDYwLAoweDZDLAoweDZBLAoweDUyLAoweDM2LAoweDA0LAoweDIxLAoweDFDLAoweEUyLAow
eDMxLAoweDFDLAoweDQyLAoweDY3LAoweDI4LAoweEIyLAoweDI4LAoweEMwLAoweDFCLAow
eDhBLAoweEM2LAoweDU5LAoweEUxLAoweDNDLAoweDA1LAoweDE3LAoweDI1LAoweDQ4LAow
eEE4LAoweDIwLAoweEExLAoweDBDLAoweDExLAoweDI5LAoweDcwLAoweEMwLAoweDEwLAow
eDBDLAoweDM2LAoweEM2LAoweDAxLAoweDQ0LAoweDBBLAoweEQxLAoweEZFLAoweEMxLAow
eDgwLAoweDM5LAoweDgwLAoweDY4LAoweDAxLAoweDQ0LAoweDkxLAoweDQ2LAoweDgzLAow
eDNBLAoweDExLAoweDI0LAoweDc4LAoweDQyLAoweEYwLAoweEI4LAoweDhFLAoweEYzLAow
eDQ4LAoweEZELAoweEZGLAoweDlGLAoweDU3LAoweDkwLAoweEIzLAoweDNFLAoweEFGLAow
eDNBLAoweDhGLAoweDA2LAoweEU0LAoweDEwLAoweEMwLAoweEIwLAoweDEyLAoweDY0LAow
eEQ3LAoweDU5LAoweDAxLAoweDgyLAoweDZCLAoweDQwLAoweDVELAoweDEyLAoweDFFLAow
eDExLAoweEQ4LAoweDM0LAoweEMzLAoweDYxLAoweDg2LAoweEU4LAoweDc5LAoweDg2LAow
eDNCLAoweDgxLAoweDQzLAoweDY0LAoweDgwLAoweDlFLAoweEQxLAoweEQzLAoweDAxLAow
eDc2LAoweDhDLAoweDI3LAoweDczLAoweEQyLAoweEE1LAoweDBBLAoweDMwLAoweDNCLAow
eDcwLAoweENELAoweDJDLAoweEMxLAoweEYxLAoweEY4LAoweDRDLAoweEUwLAoweDhCLAow
eDgwLAoweDA5LAoweDJDLAoweDdGLAoweDEwLAoweEE4LAoweDkxLAoweDE5LAoweERBLAow
eDMzLAoweDNELAoweEFELAoweDM3LAoweDAyLAoweDFGLAoweDA2LAoweDBFLAoweDhCLAow
eDg5LAoweDg1LAoweDkwLAoweDAyLAoweDA4LAoweDhELAoweDA3LAoweEZDLAoweDQ3LAow
eDg0LAoweEI3LAoweDgzLAoweDA4LAoweEVGLAoweDBGLAoweDlFLAoweEFGLAoweDA5LAow
eDhBLAoweDNCLAoweDY3LAoweDY4LAoweEUwLAoweEI4LAoweEMzLAoweDgzLAoweDRGLAow
eDEyLAoweDFFLAoweDk3LAoweEFGLAoweDExLAoweDg3LAoweDg2LAoweDk1LAoweDcxLAow
eEU0LAoweEEwLAoweEEyLAoweDQ2LAoweDRFLAoweDhGLAoweDE4LAoweEZDLAoweDc0LAow
eEMxLAoweDRFLAoweDA0LAoweDI3LAoweEYxLAoweDE0LAoweEUwLAoweEMxLAoweDlDLAow
eDkzLAoweENGLAoweDIwLAoweDk2LAoweDM1LAoweDM2LAoweEQ0LAoweDMwLAoweDhDLAow
eDE2LAoweEY0LAoweDlELAoweEUxLAoweDc4LAoweDdDLAoweDE3LAoweEYwLAoweDJDLAow
eDlFLAoweDI1LAoweDBDLAoweEVCLAoweDUzLAoweDAwLAoweDM4LAoweDAwLAoweEYxLAow
eERFLAoweEE3LAoweDQ1LAoweDI2LAoweDYwLAoweDQwLAoweDI2LAoweEYwLAoweEI0LAow
eDAxLAoweDlBLAoweDI5LAoweDNGLAoweDY4LAoweEIwLAoweDQxLAoweEM0LAoweEY4LAow
eEZGLAoweDlGLAoweDI3LAoweEVFLAoweDc0LAoweDAwLAoweDNFLAoweEMxLAoweEMwLAow
eEU4LAoweEYxLAoweERCLAoweEFGLAoweDAwLAoweDg0LAoweEUwLAoweEU3LAoweEZGLAow
eDdDLAoweDcwLAoweEZBLAoweDExLAoweDlFLAoweDEwLAoweEQ4LAoweDc4LAoweDQyLAow
eDFGLAoweEMyLAoweDIzLAoweDA3LAoweDY2LAoweDQwLAoweEZDLAoweDFDLAoweDgwLAow
eEYzLAoweDc5LAoweDUzLAoweDIwLAoweDM4LAoweEVGLAoweDIwLAoweEM3LAoweDdELAow
eDY2LAoweEE3LAoweDk5LAoweEMwLAoweDIyLAoweDA3LAoweDg5LAoweDFFLAoweDA4LAow
eDNGLAoweDVCLAoweDlDLAoweEM1LAoweDQxLAoweDlDLAoweEQ0LAoweDAxLAoweDFDLAow
eEQ2LAoweENCLAoweDg4LAoweEM3LAoweEU1LAoweEIzLAoweDhCLAoweDExLAoweDBFLAow
eEUyLAoweDkxLAoweEU1LAoweDExLAoweEM2LAoweDMzLAoweDM4LAoweDk3LAoweEM3LAow
eDkwLAoweDUzLAoweDc4LAoweEM1LAoweEYwLAoweDA4LAoweDMwLAoweDBBLAoweDZELAow
eEZBLAoweEQ0LAoweDY4LAoweEQ0LAoweEFBLAoweDQxLAoweDk5LAoweDFBLAoweDY1LAow
eDFBLAoweEQ0LAoweEVBLAoweDUzLAoweEE5LAoweDMxLAoweDYzLAoweDA3LAoweDA0LAow
eDhCLAoweDdELAoweDQ0LAoweDA4LAoweEM0LAoweDUxLAoweDQxLAoweEE4LAoweDhDLAow
eEMzLAoweDhFLAoweDQwLAoweEZDLAoweEZGLAoweDA3CgkJCX0pCgkJfQoJfQp9Cg==

--------------x3UP05fEpaki3u8hL0YIV0Nt--
