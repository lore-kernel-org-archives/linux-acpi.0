From: =?iso-8859-2?q?=A3ukasz_Jachymczyk?= <lfx@tlen.pl>
Subject: Linux kernel rebooting
Date: Wed, 19 Jul 2006 12:52:49 +0200
Message-ID: <pan.2006.07.19.10.52.49.399303@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:3233 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030198AbWGSQzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jul 2006 12:55:17 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G3FKA-0001qi-1e
	for linux-acpi@vger.kernel.org; Wed, 19 Jul 2006 18:55:02 +0200
Received: from awj146.internetdsl.tpnet.pl ([83.18.61.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2006 18:55:02 +0200
Received: from lfx by awj146.internetdsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2006 18:55:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello

I've got a problem with rebooting my linux on laptop hp nx6310 (centrin=
o
core duo). After restarting, bios hangs for a while and it runs slower
then usual (up to 15 seconds until grub loads). After that, my linux wo=
rks
quite fine, however I'm not able to achieve maximym cpu speed with cpuf=
req
and acpi doesn't show actual information about battery left (it shows a=
ll
the time 2:30 hours left) - simply, acpi hangs in the moment of booting=
=2E

But there is also ms windows on the same laptop. It reboots smoothly an=
d
quickly. There is no bios hanging effect. And after such reboot from
windows, when I boot linux, everything works fine!

I guess it's the problem of the way how linux' kernel with acpi reboots=
=2E
Can somebody tell me what can I do with it? Maybe it's some kind of a b=
ug
in acpi or kernel?

Piece of my kernel (2.6.17.4) .config:
#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
# CONFIG_ACPI_CONTAINER is not set


// without APM it also fails.
#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dy
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=3Dy
CONFIG_X86_SPEEDSTEP_ICH=3Dy
CONFIG_X86_SPEEDSTEP_SMI=3Dy
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=3Dy
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

--=20
=A3ukasz Jachymczyk
http://fatcat.ftj.agh.edu.pl/~lfx/


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
