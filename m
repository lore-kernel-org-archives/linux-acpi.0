From: Oliver Eichler <oliver.eichler@dspsolutions.de>
Subject: Re: Shutdown without poweroff (notebook)
Date: Wed, 18 Jan 2006 09:32:40 +0100
Message-ID: <200601180932.41124.oliver.eichler@dspsolutions.de>
References: <200601171121.49406.oliver.eichler@dspsolutions.de> <200601171658.25027.oliver.eichler@dspsolutions.de> <loom.20060117T222431-215@post.gmane.org>
Reply-To: oliver.eichler@dspsolutions.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rw08.de ([213.131.244.2]:63136 "EHLO rw08.de")
	by vger.kernel.org with ESMTP id S1030188AbWARIc6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 03:32:58 -0500
Received: from gateway.dspsolutions.de (p54927A88.dip.t-dialin.net [84.146.122.136])
	by rw08.de (rw08.de) with ESMTP id AE43DE341D0
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 09:32:39 +0100 (CET)
Received: from [192.168.0.1] (helo=caleb1.dspsolutions)
	by gateway.dspsolutions.de with esmtp (Exim 4.43)
	id 1Ez8kF-0005ij-4X
	for linux-acpi@vger.kernel.org; Wed, 18 Jan 2006 09:32:45 +0100
Received: from frog.dspsolutions (unknown [192.168.1.1])
	by caleb1.dspsolutions (Postfix) with ESMTP id 29CBC15B7A
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 09:32:42 +0100 (CET)
In-Reply-To: <loom.20060117T222431-215@post.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Tuesday, 17. January 2006 22:27, you wrote:
> I had similar problems, I noticed that knoppix v4.0 powered of just fine.
> So I copied the kernel .config, made a few changes pertaining to drivers
> that get compiled it, and it works.  I really do not know which option(s)
> made the difference though....

SuSE YOU and kernel hacking are bad friends. I looked into .config but 
couldn't find anything suspicious. (see extract at the end of this mail)

I wonder how much this could be related to a bad DSDT. I searched the DSDT 
database. There is one for the ACER 5024, however it is marked as "1.13 
original", thus I guess it is the plain original DSDT of the notebook.

I found this at the end of dmesg:

Call Trace: <IRQ> <ffffffff801581b5>{__report_bad_irq+53} 
<ffffffff801583c7>{note_interrupt+439}
       <ffffffff80157d2f>{__do_IRQ+207} <ffffffff801113d8>{do_IRQ+72}
       <ffffffff8010eebc>{ret_from_intr+0} 
<ffffffff80245ae9>{acpi_os_read_port+44}
       <ffffffff80253453>{acpi_hw_low_level_read+123} 
<ffffffff80253547>{acpi_hw_register_read+190}
       <ffffffff80253453>{acpi_hw_low_level_read+123} 
<ffffffff8024a6ee>{acpi_ev_fixed_event_detect+47}
       <ffffffff8024b000>{acpi_ev_sci_xrupt_handler+12} 
<ffffffff80245975>{acpi_irq+15}
       <ffffffff80157c2c>{handle_IRQ_event+44} 
<ffffffff80157d16>{__do_IRQ+182}
       <ffffffff801113d8>{do_IRQ+72} <ffffffff8010eebc>{ret_from_intr+0}
        <EOI> <ffffffff80253453>{acpi_hw_low_level_read+123}
       <ffffffff8025373b>{acpi_hw_low_level_write+117} 
<ffffffff88032605>{:processor:acpi_processor_idle+324}
       <ffffffff8010d311>{cpu_idle+49} <ffffffff804a87aa>{start_kernel+458}
       <ffffffff804a81f4>{_sinittext+500}
handlers:
[<ffffffff880fe110>] (ndis_irq_th+0x0/0x150 [ndiswrapper])


Looks like the ndiswrapper for my Broadcom Wireless LAN Card messes around 
with the acpi stuff. I don't know if this is related to my problem.

Any ideas for further investigations?

Oliver



Kernel 2.6.13-15.7
...
#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_SONY=m
CONFIG_ACPI_PCC=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_DEBUG_LITE=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_INITRD=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=m


-- 
Ingenieure Kellermann, Voigt, Hoepfl, Eichler und Weidner, Partnerschaft 

DSP Solutions                                 http://www.dspsolutions.de

