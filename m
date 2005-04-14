From: klug <klug-90T4dkFmkpLYtjvyW6yDsg@public.gmane.org>
Subject: Toshiba backlight control
Date: Thu, 14 Apr 2005 18:06:13 -0400
Message-ID: <425EE955.7020400@blarg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Previous to the 2.6.10 release I was able to control the lcd backlight 
on my toshiba satellite S507-5005 via the commands "echo lcd_out:0 > 
/proc/acpi/toshiba/video" (off) & "echo lcd_out:1 > 
/proc/acpi/toshiba/video" (on). The DPMS commands have never worked for 
this system. I have tested the new backlight module by passing commands 
to the /sys/module/backlight files with no luck. Also, there has never 
been a /proc/acpi/video to test. I posted a complete bug report 
(http://bugme.osdl.org/show_bug.cgi?id=4468) and was advised by the 
fbdev list my problem looks to be acpi related. I have tested 2.6.10, 
2.6.11, 2.6.11.4->7, 2.6.12-rc1, and 2.6.12-rc2 all with the same 
result. The "Toshiba Laptop ACPI Extras" version (0.18) is the same in 
every tested version, including the working 2.6.0->2.6.9. So the 
change/problem doesn't appear to be in the toshiba features. Below is my 
acpi / toshiba config options. My complete hardware setup can be seen in 
the bug report (http://bugme.osdl.org/show_bug.cgi?id=4468).

-klug

CONFIG_TOSHIBA=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
