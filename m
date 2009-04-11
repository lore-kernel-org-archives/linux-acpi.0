From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [Help] I can't get Intel Speedstep working
Date: Fri, 10 Apr 2009 18:45:07 -0600
Message-ID: <49DFE813.3020705@gmail.com>
References: <cd5c26b90903110528x6762c035xb5bc26aa31f22c26@mail.gmail.com> <cd5c26b90903110540l19a721d1k1b7102f6f5c71d29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:53944 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZDKArF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2009 20:47:05 -0400
Received: by gxk4 with SMTP id 4so2975654gxk.13
        for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2009 17:47:03 -0700 (PDT)
In-Reply-To: <cd5c26b90903110540l19a721d1k1b7102f6f5c71d29@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Szalai <krumpirluk@gmail.com>
Cc: linux-acpi@vger.kernel.org

Robert Szalai wrote:
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

Your system doesn't seem to have anything interesting regarding CPU 
frequency scaling in the DSDT, but it's often in the FADT instead. 
Posting a full acpidump might be more useful..

Also make sure that any BIOS settings to allow CPU frequency scaling are 
enabled.

