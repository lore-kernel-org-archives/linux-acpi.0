From: "Joshua C." <joshuacov@googlemail.com>
Subject: Re: Linux acpi compatibility / iasl compiler
Date: Sat, 3 Oct 2009 17:03:05 +0200
Message-ID: <5f6f8c5f0910030803o5113627eha3e7c796d9431367@mail.gmail.com>
References: <7AF83C134DEA3240992E8EF512F61B7903C21AC51E@pdsmsx502.ccr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D8308583AE9A6C6@orsmsx503.amr.corp.intel.com>
	 <5f6f8c5f0909250604u3a48c150yeca0e77a0a966541@mail.gmail.com>
	 <5f6f8c5f0909300608m39b8e6en560cef043980f145@mail.gmail.com>
	 <4911F71203A09E4D9981D27F9D8308583B0212E0@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:55761 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZJCPDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Oct 2009 11:03:42 -0400
Received: by gxk4 with SMTP id 4so2443323gxk.8
        for <linux-acpi@vger.kernel.org>; Sat, 03 Oct 2009 08:03:06 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D8308583B0212E0@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2009/9/30 Moore, Robert <robert.moore@intel.com>:
> What exactly was the repair/change that you made to the DSDT?
>
>
> -----Original Message-----
> From: Joshua C. [mailto:joshuacov@googlemail.com]
> Sent: Wednesday, September 30, 2009 6:09 AM
> To: Moore, Robert
> Cc: Lin, Ming M; linux-acpi@vger.kernel.org
> Subject: Re: Linux acpi compatibility / iasl compiler
>
> 2009/9/25 Joshua C. <joshuacov@googlemail.com>:
>> 2009/9/25 Moore, Robert <robert.moore@intel.com>:
>>>
>>>> 1. Can I substitute the original dsdt (compiled with ms asl 2) wit=
h
>>>> the one compiled and optimazed with Intel iasl?
>>>>
>>>
>>> Yes. It should work the same as the original.
>>>
>>>> 2. Is there such a "big" diffference between the code produced by
>>>> these apps?
>>>
>>> iASL is an optimizing compiler. It will optimize all namepaths to t=
heir minimum lengths, it will minimize integer sizes, and will perform =
constant folding. These optimizations can shrink the code considerably.
>>>
>>>
>>>> 3. How should windows react to the new dsdt recompiled with intel'=
s
>>>> iasl?
>>>
>>> The DSDT should perform identically. It has simply been optimized b=
y iASL.
>>> I can't speak to the other ACPI tables on your machine (although, u=
sually any other ASL/AML tables are SSDTs)
>>>
>>>
>>> 4) You should let the kernel override the DSDT with your DSDT befor=
e you even think about flashing the bios.
>>>
>> =A0I tried it. Linux works perfectly. As for windows:
>> -win7 doesn't show any visible signs of problems. I did my best to
>> load the table in the registry. I even tried it without UAC.It looks
>> like it works with the optimazed dsdt.
>> However this is closed-source acpi driver and maybe it still reads
>> (from the bios) the original dsdt (the ms one). Therefore I'm not th=
at
>> sure about it.
>> -winXP: after loading the new optimized dsdt in the registry and
>> restarting the pc almost nothing works. random shutdowns with bsod a=
nd
>> some of the hardware isn't even seen! Only a new install is the
>> solution.
>> I know that the winxp acpi driver should be rather old but I didn't
>> expect such a downturn.
>>
>> To sum up:
>>
>> Linux works great, but from what i saw I can't say that windows (at
>> least xp, not sure for 7) likes the iasl compiled code. This once
>> again proved the "obvious" luck of standards in windows.
>>
>> Thanx to Robert Moore for the reply. I'll test some more times with
>> different iasl options before finally flashing the modded bios.
>>
>
> I flashed the bios with the recompiled DSDT (with iasl-20090903,
> optimized) table some days ago. Here are the results:
>
> Linux: =A0No problems at all.Works great and nothing extra should be =
done. Great.
>
> Windows7: It didn't like it the first time. After flashing the bios
> wouldn't boot so I needed to reinstall it. After this it works fine.
> The whole story makes me think that windows caches the dsdt in the
> registry and compares it with the one provided by the bios during
> boot. On mismatch it won't boot.
>
> WindowsXPSP3: It doesn't like intel compiler's optimazations. I tried
> all options (-of -oi -on) but I wouldn't boot. It coulnd't be
> installed either. Neither does it like the MS asl v.3. Obviously thei=
r
> acpi driver is quite old. I coundn't test the compatibility mode of
> iasl because the compiled dsdt was 13 bytes bigger than the available
> space (in the bios file). Therefore I cannot comment on this but I be=
t
> it wouldn't like it either.
>
> Anyway, I'm back to linux and it has no problems with my new (repaire=
d) DSDT.
>

There is a broken/missing object in the original dsdt (\SB_.PSHR).
Take a look at kernel bug #10237. There you'll find 2 dsdt tables. The
first on is from ykzhao (uploaded on 2008-05-09 03:09) and the second
one is the one I'm using right now ("my custom DSDT" uploaded on
2008-05-12 07:06). I just added the missing PSHR object
(\SB_.PCI0.LPC0.PHSR (0x0D, 0x00), TJ85) and fixed the warnungs.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
