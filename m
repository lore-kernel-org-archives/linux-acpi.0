From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [2.6.27.7] processor.ko messes up ACPI resume
Date: Fri, 17 Jul 2009 13:59:18 +0200
Message-ID: <71cd59b00907170459q24e22ebbrc74702b34788a7b2@mail.gmail.com>
References: <20090711131152.GE2750@acerrimo> <20090717085023.GB2016@acerrimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:53823 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934454AbZGQL7U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2009 07:59:20 -0400
Received: by bwz28 with SMTP id 28so683063bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2009 04:59:18 -0700 (PDT)
In-Reply-To: <20090717085023.GB2016@acerrimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Andrea R." <7252d9@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Jul 17, 2009 at 10:50 AM, Andrea R.<7252d9@gmail.com> wrote:
> Il 11/07/2009 alle 15:11, Andrea R. ha scritto:
>
>> Hi all,
>>
>> I was having problems resuming my Acer laptop from suspend-to-RAM, where
>> upon waking up the screen was flashing madly (think detuned TV). This
>> laptop had no problems waking up using previous kernel releases, the
>> latest I had tried before 2.6.27 being 2.6.18.
>>
>> After long trials, I traced the issue to the "processor.ko" kernel
>> module: if I unload it - even while the screen is being crazy - all goes
>> back to normal.
>>
>> Problem is, that module is needed to probe the CPU's temperature and - I
>> think - for clock frequency stepping.
>>
>> Does anyone know how do I get to keep it *and* get working resume
>> functionality?
>>
>> I'm using 32-bit Slackware 12.2 at the moment, but the exact same
>> symptoms were shown by Fedora 11 x86_64.
>>
>> My laptop has an AMD Turion64 processor and an ATI Radeon Xpress1100
>> graphics card driven by X.Org's "ati" driver. Please write if you need
>> lspci's output or more detailed info or tests.
>>
>> Thanks in advance for your comments.
>
>
> Good thing I thanked in advance...
>

Hi,
Can you try with the latest git version ?
Maybe this is already fixed.
Thanks,


-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
