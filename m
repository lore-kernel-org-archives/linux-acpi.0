From: Federico Grau <donfede@casagrau.org>
Subject: dell inspiron 4150 acpi suspend problems (apm is ok)
Date: Wed, 19 Dec 2007 23:34:21 -0500
Message-ID: <20071220043421.GA1664@casagrau.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl093-100-179.wdc2.dsl.speakeasy.net ([66.93.100.179]:57425
	"EHLO tatooine.casagrau.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbXLTFG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Dec 2007 00:06:26 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a dell inspiron 4150 laptop.  Previously it suspended (to ram) and
resumed well, when I was using apm.  Recently I tried on my latest kernel
update to finally evolve and start using acpi.  Unfortunately when suspending
to ram with acpi (using "acpitool -s") the display comes back garbled and
cannot be corrected.  

I have the most recent bios version A06 (I doubt any more will come out as the
laptop is 2 - 3 years old).  My distro is debian unstable (relatively recent)
and my kernel versions and power management info sections are listed below.  I
have the same symptoms whether I do this from an xterm within X11 (xorg) or
from the console.  After I resume, switching between consoles and X11 does not
help.  About the only way I can "exit" the situation is to press the power
button which triggers acpi to nicely shutdown the machine.

Some google searches showed others with similar problems, but they were all 2
- 4 years ago.  What could be the problem, and what could I try to correct it?

thanks for any help,
donfede


######################################

###########
#
# working apm configuration
#
# Linux kernel version: 2.6.22.5

# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PM_DEBUG=y
# CONFIG_DISABLE_CONSOLE_SUSPEND is not set
# CONFIG_PM_TRACE is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set





###########
#
# unfortunately not working acpi configuration
#
# Linux kernel version: 2.6.23.9

# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND_UP_POSSIBLE=y
CONFIG_SUSPEND=y
CONFIG_HIBERNATION_UP_POSSIBLE=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION="/dev/hda1"
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_APM is not set



