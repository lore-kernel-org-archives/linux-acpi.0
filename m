From: Robert Szalai <krumpirluk@gmail.com>
Subject: Re: [Help] I can't get Intel Speedstep working
Date: Mon, 27 Apr 2009 07:51:57 +0200
Message-ID: <cd5c26b90904262251x37ea5bb2q4885cec9b3e56695@mail.gmail.com>
References: <cd5c26b90903110528x6762c035xb5bc26aa31f22c26@mail.gmail.com>
	 <cd5c26b90903110540l19a721d1k1b7102f6f5c71d29@mail.gmail.com>
	 <49DFE813.3020705@gmail.com>
	 <alpine.LFD.2.00.0904102242160.8559@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:54419 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbZD0Fv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 01:51:58 -0400
Received: by ewy24 with SMTP id 24so1943614ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2009 22:51:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904102242160.8559@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-acpi@vger.kernel.org

Thank you for your reply.

I'm using the latest kernel now (2.6.30 rc3) but the situation hasn't c=
hanged.
Actually I have no Speedstep option in my BIOS at all, but according to=
 the
manufacturer it should work out of box (and it really works in Windows)=
=2E
I've flashed the latest BIOS of course and my CPU is supported by the
manufacturer
according to their website. (It's a Shuttle K48 by the way).

Here is my dmesg and full acpidump:

http://www.easy-share.com/1904779435/dmesg.txt
http://www.easy-share.com/1904779378/acpidump.txt

It is strange that I can't find any FADT table after extracting my
acpidump (with acpixtract -a).
Is there any hope for fixing Speedstep on my box?

Thank you very much
Robert Szalai

2009/4/11 Len Brown <lenb@kernel.org>:
>
>
> On Fri, 10 Apr 2009, Robert Hancock wrote:
>
>> Robert Szalai wrote:
>> > Hello everybody,
>> >
>> > I have a Shuttle K48 Barebone PC (Intel 945GC + ICH7 chipset) and =
a
>> > Core 2 Duo E7300 CPU. I'm using Ubuntu 8.04 with 2.6.24-23-generic
>> > kernel on my box. Everything works fine except Speedstep. When I t=
ry
>> > to load acpi_cpufreq module, I get the following error:
>
> Please try 2.6.29.
>
>> > $ sudo modprobe acpi_cpufreq
>> > FATAL: Error inserting acpi_cpufreq
>> > (/lib/modules/2.6.24-23-generic/kernel/arch/x86/kernel/cpu/cpufreq=
/acpi-cpufreq.ko):
>> > No such device
>> >
>> > I've tried everything (other kernel versions, various patches) but=
 the
>> > result is the same.
>> > I don't know if it is related to EIST or not but I've found these =
two
>> > Exceptions in my dmesg:
>> >
>> > [ =A0 20.675593] ACPI Exception (processor_core-0822): AE_NOT_FOUN=
D,
>> > Processor Device is not present [20070126]
>> > [ =A0 20.675599] ACPI Exception (processor_core-0822): AE_NOT_FOUN=
D,
>> > Processor Device is not present [20070126]
>
> This is actually sort of curious, but I'm too lazy to see why 2.6.24
> blurts this. =A0Let me know if 2.6.29 still does.
>
>> > After some research I've found that maybe a broken DSDT table is t=
he
>> > couse of my problem. I'm not an ACPI expert and I dont't know how =
to
>> > locate and fix the problem in my DSDT. I've uploaded my dsdt.dsl t=
o
>> >
>> > http://www.easy-share.com/1903982677/dsdt.dsl
>> >
>> > Any suggestions? I'd really like to use Speedstep on my Box.
>> > You are my last hope Guys.
>>
>> Your system doesn't seem to have anything interesting regarding CPU =
frequency
>> scaling in the DSDT, but it's often in the FADT instead. Posting a f=
ull
>> acpidump might be more useful..
>
> yes, and the full dmesg please.
> It is common for _PSS etc. to be dynamically loaded (though your DSDT=
 has
> no Load's in it, so not in this case), or it could be included in an =
SSDT
> that we'd see in the acpidump.
>
>> Also make sure that any BIOS settings to allow CPU frequency scaling=
 are
>> enabled.
>
> As it is a bare-bones system, you might also want to verify that you'=
ve
> got the latest BIOS for the board. =A0It is possible that the BIOS
> you have doesn't know about the processor you have.
>
> thanks,
> -Len Brown, Intel Open Source Technology Center
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
