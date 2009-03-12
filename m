From: Robert Szalai <krumpirluk@gmail.com>
Subject: Re: [Help] I can't get Intel Speedstep working
Date: Thu, 12 Mar 2009 10:43:28 +0100
Message-ID: <cd5c26b90903120243sc8707efj54b621f4067cb6ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:60103 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbZCLJnb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2009 05:43:31 -0400
Received: by fg-out-1718.google.com with SMTP id 16so90252fgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2009 02:43:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Could somebody check what's wrong with my DSDT table please?
CPU throttling works on Windows, but I can't get it work on Linux :(((

Here is my dsdt.dsl:
http://www.easy-share.com/1903982677/dsdt.dsl

> Hello everybody,
>
> I have a Shuttle K48 Barebone PC (Intel 945GC + ICH7 chipset) and a
> Core 2 Duo E7300 CPU. I'm using Ubuntu 8.04 with 2.6.24-23-generic
> kernel on my box. Everything works fine except Speedstep. When I try
> to load acpi_cpufreq module, I get the following error:
>
> $ sudo modprobe acpi_cpufreq
> FATAL: Error inserting acpi_cpufreq
> (/lib/modules/2.6.24-23-generic/kernel/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.ko):
> No such device
>
> I've tried everything (other kernel versions, various patches) but the
> result is the same.
> I don't know if it is related to EIST or not but I've found these two
> Exceptions in my dmesg:
>
> [   20.675593] ACPI Exception (processor_core-0822): AE_NOT_FOUND,
> Processor Device is not present [20070126]
> [   20.675599] ACPI Exception (processor_core-0822): AE_NOT_FOUND,
> Processor Device is not present [20070126]
>
> After some research I've found that maybe a broken DSDT table is the
> couse of my problem. I'm not an ACPI expert and I dont't know how to
> locate and fix the problem in my DSDT. I've uploaded my dsdt.dsl to
>
> http://www.easy-share.com/1903982677/dsdt.dsl
>
> Any suggestions? I'd really like to use Speedstep on my Box.
> You are my last hope Guys.
>
> Thanks so much
> Robert Szalai
>
