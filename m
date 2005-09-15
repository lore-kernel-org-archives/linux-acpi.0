From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: wrong documentation for /proc/acpi/sleep?
Date: Thu, 15 Sep 2005 17:42:17 -0400
Message-ID: <1126820537.31252.5.camel@toshiba>
References: <87mzme3xv8.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87mzme3xv8.fsf-p0EyZM+cOqMBU3qZLEr2Wx2eb7JE58TQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jochen Hein <jochen-AVN6mSxK9lsdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-09-15 at 16:00 -0400, Jochen Hein wrote:
> 
> The documentation in Documentation/power/swsusp.txt reads:
> 
> ,----
> | Sleep states summary
> | ====================
> |
> | There are three different interfaces you can use, /proc/acpi should
> | work like this:
> |
> | In a really perfect world:
> | echo 1 > /proc/acpi/sleep       # for standby
> | echo 2 > /proc/acpi/sleep       # for suspend to ram
> | echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more
> | power conservative
> | echo 4 > /proc/acpi/sleep       # for suspend to disk
> | echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
> |
> | and perhaps
> | echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
> `----

You're right, swsusp.txt is out of date.
/proc/acpi/sleep is deprecated -- and the S2 comment was nonsense from
the start.

> I do get:
> root@hermes:~# echo 2 > /proc/acpi/sleep
> bash: /proc/acpi/sleep: No such file or directory
> 
> Kernel release is 2.6.14-rc1, ACPI/Power-related-config:
> ,----
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep ACPI .config
> | # Power management options (ACPI, APM)
> | # ACPI (Advanced Configuration and Power Interface) Support
> | CONFIG_ACPI=y
> | CONFIG_ACPI_AC=y
> | CONFIG_ACPI_BATTERY=y
> | CONFIG_ACPI_BUTTON=y
> | CONFIG_ACPI_VIDEO=y
> | CONFIG_ACPI_HOTKEY=y
> | CONFIG_ACPI_FAN=y
> | CONFIG_ACPI_PROCESSOR=y
> | CONFIG_ACPI_THERMAL=y
> | # CONFIG_ACPI_ASUS is not set
> | CONFIG_ACPI_IBM=y
> | # CONFIG_ACPI_TOSHIBA is not set
> | CONFIG_ACPI_BLACKLIST_YEAR=0
> | CONFIG_ACPI_DEBUG=y
> | CONFIG_ACPI_EC=y
> | CONFIG_ACPI_POWER=y
> | CONFIG_ACPI_SYSTEM=y
> | # CONFIG_ACPI_CONTAINER is not set
> | CONFIG_X86_ACPI_CPUFREQ=y
> | CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
> | # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> | # CONFIG_HOTPLUG_PCI_ACPI is not set
> | CONFIG_PNPACPI=y
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep POWER .config
> | CONFIG_ACPI_POWER=y
> | # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> | CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> | # CONFIG_X86_POWERNOW_K6 is not set
> | # CONFIG_X86_POWERNOW_K7 is not set
> | # CONFIG_X86_POWERNOW_K8 is not set
> | # CONFIG_USB_POWERMATE is not set
> | root@hermes:/usr/src/linux-2.6.14-rc1# grep SWSU .config
> | CONFIG_SWSUSP_ENCRYPT=y
> `----
> 
> System is a Thinkpad R40, Debian/sarge with kernel 2.6.14-rc1. Did I
> miss something obvious?

Enable CONFIG_ACPI_SLEEP

for /proc/acpi/sleep, you'll need
CONFIG_ACPI_SLEEP_PROC_FS
which will allow
CONFIG_ACPI_SLEEP_PROC_SLEEP

cheers,
-Len




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
