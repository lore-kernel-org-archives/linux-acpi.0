From: "Joshua C." <joshuacov@googlemail.com>
Subject: Re: Linux acpi compatibility / iasl compiler
Date: Fri, 25 Sep 2009 15:04:54 +0200
Message-ID: <5f6f8c5f0909250604u3a48c150yeca0e77a0a966541@mail.gmail.com>
References: <7AF83C134DEA3240992E8EF512F61B7903C21AC51E@pdsmsx502.ccr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D8308583AE9A6C6@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:59934 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZIYNEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2009 09:04:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so2103235and.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2009 06:04:54 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D8308583AE9A6C6@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2009/9/25 Moore, Robert <robert.moore@intel.com>:
>
>> 1. Can I substitute the original dsdt (compiled with ms asl 2) with
>> the one compiled and optimazed with Intel iasl?
>>
>
> Yes. It should work the same as the original.
>
>> 2. Is there such a "big" diffference between the code produced by
>> these apps?
>
> iASL is an optimizing compiler. It will optimize all namepaths to their minimum lengths, it will minimize integer sizes, and will perform constant folding. These optimizations can shrink the code considerably.
>
>
>> 3. How should windows react to the new dsdt recompiled with intel's
>> iasl?
>
> The DSDT should perform identically. It has simply been optimized by iASL.
> I can't speak to the other ACPI tables on your machine (although, usually any other ASL/AML tables are SSDTs)
>
>
> 4) You should let the kernel override the DSDT with your DSDT before you even think about flashing the bios.
>
 I tried it. Linux works perfectly. As for windows:
-win7 doesn't show any visible signs of problems. I did my best to
load the table in the registry. I even tried it without UAC.It looks
like it works with the optimazed dsdt.
However this is closed-source acpi driver and maybe it still reads
(from the bios) the original dsdt (the ms one). Therefore I'm not that
sure about it.
-winXP: after loading the new optimized dsdt in the registry and
restarting the pc almost nothing works. random shutdowns with bsod and
some of the hardware isn't even seen! Only a new install is the
solution.
I know that the winxp acpi driver should be rather old but I didn't
expect such a downturn.

To sum up:

Linux works great, but from what i saw I can't say that windows (at
least xp, not sure for 7) likes the iasl compiled code. This once
again proved the "obvious" luck of standards in windows.

Thanx to Robert Moore for the reply. I'll test some more times with
different iasl options before finally flashing the modded bios.
