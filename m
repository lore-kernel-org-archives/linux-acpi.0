From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Core 2 Duo and power states
Date: Wed, 23 May 2007 06:29:22 +0200
Message-ID: <20070523042922.GA32257@tangens.sinus.cz>
References: <BAY20-F69C884E2742B1B312C8F7F9360@phx.gbl>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:57425 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbXEWEp1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 00:45:27 -0400
Content-Disposition: inline
In-Reply-To: <BAY20-F69C884E2742B1B312C8F7F9360@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paa Paa <paapaa125@hotmail.com>
Cc: linux-acpi@vger.kernel.org

Hi!
> For some reason I'm not able to enable processor power states (c1, c2 etc.)
> for my Core 2 Duo. This is what I get::
 
  I have a very similar setup and exactly the same results:
  
> cat /proc/acpi/processor/CPU1/info
> processor id:            0
> acpi id:                 1
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
> 
> cat /proc/acpi/processor/CPU1/power
> active state:            C0
> max_cstate:              C8
> bus master activity:     00000000
> maximum allowed latency: 2000 usec
> states:
> 
> "dmesg | grep -i power" also gives nothing. I have ACPI enabled in BIOS and
> in kernel I have these set ("grep -i acpi .config | grep =y"):
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_PNPACPI=y
> CONFIG_SATA_ACPI=y
> 
> I'm probably missing something crucial here. So how do I enable power
> states or how do I debug the cause of them missing?

You are not missing anything. Our ACPI BIOS doesn't want to use these states.
> 
> Kernel: 2.6.21.1
> CPU: Intel E6400

E6600 here.

> Mobo: Asus P5B Deluxe (latest BIOS)

The same mobo.

> Distro: 64-bit Gentoo

Distro is unimportant, but it's vanilla 2.6.21.1.

> I have EIST and ACPI2 enabled in BIOS.

Me too :-).

The reason is the following:

1) In the DSDT, there is no _CST method, which is the more modern method of
   determining C-state capabilities.
2) In the FADT, the following is there:
   ...
   P_LVL2_LAT:	101
   P_LVL3_LAT:  1001

   These two values mean "Disable C2 / C3 functionality" - the spec says that
C2 latency should be below 100 and C3 below 1000, so you can see that these
values are especially formed to disable the feature.

However, after updating the BIOS and enabling something like "C1E" in its
setup, the CPU is now really cold - it has 37C now with fan at minimum speed,
so I believe that the obvious "deep sleep" states from C2 up are not necessary
for Core2 Duo.
               With regards, Pavel Troller

