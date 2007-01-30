From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Missing "alarm"
Date: Tue, 30 Jan 2007 21:58:31 +0300
Message-ID: <45BF9557.3050001@linux.intel.com>
References: <135ab3ff0701300907v6bd931b0o7a0a291621d2d962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:47157 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750919AbXA3S6g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jan 2007 13:58:36 -0500
In-Reply-To: <135ab3ff0701300907v6bd931b0o7a0a291621d2d962@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Morten Friesgaard <friesgaard@gmail.com>
Cc: linux-acpi@vger.kernel.org

Please attach your config file.

Regards,
    Alex.

Morten Friesgaard wrote:
> Hey.
> I have searched various sites, but cannot find a solution to my problem.
> I'm running a mythtv media center, and I need automatic startup - so
> of course I use ACPI. (it works with speed stepping
> CONFIG_X86_POWERNOW_K8_ACPI=y)
> I have an asus k8n-vm motherboard that support acpi 2.0
>
> # uname -a
> Linux mythbox 2.6.18-gentoo-r6 #1 SMP Mon Jan 29 20:38:18 CET 2007
> i686 AMD Sempron(tm) Processor 3000+ AuthenticAMD GNU/Linux
>
>
>
> However I have one big problem (trying to solve it the last 2-3 months)
>
> /proc/acpi/alarm is missing
>
> so I tried to configure this in my kernel adding the following to my 
> ".config":
>
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
>
> (i found the following site
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg04284.html
> but haven't had any luck with that either, e.g. adding 
> CONFIG_ACPI_PROCFS)
>
> but each time I run "make menuconfig" or "genkernel --menuconfig all"
> ... the configure is not visible in the menu system or in the .config
> file. Somehow the system does not accept the configuration.
>
> I really do not understand this since the system,
> at http://www.mythtv.org/wiki/index.php/ACPI_Wakeup
> i found that my system should be able to use this function
>
> grep -r CONFIG_ACPI_SLEEP_PROC_FS arch/*
> arch/x86_64/defconfig:CONFIG_ACPI_SLEEP_PROC_FS=y
>
>
> Anyone might know what is wrong?
> Regards, Morten
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
