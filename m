From: Mark Ter Morshuizen <mark-jjvxw/mUKgPYkQIYctQFYw@public.gmane.org>
Subject: ACPI / hardware bug
Date: Mon, 19 Sep 2005 09:25:17 +0200
Message-ID: <200509190925.17700.mark@itbox.co.za>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I'm having a problem with saving settings to the RTC alarm on an Intel desktop 
board D865GLCL. It appears to work fine but after a reboot the day of the 
month field is returned as "00". 

The board has the latest available BIOS, I'm running debian testing with 
debian kernel 2.6.11-1-686.

ACPI related packages are as follows (dpkg -l | grep acpi):
ii   acpi           0.09-1         displays information on ACPI devices
ii   acpid          1.0.4-2        Utilities for using ACPI power management

Can anyone give me any clues as to how to debug this?

vcr:~# echo 2005-09-26 16:30:00 > /proc/acpi/alarm
vcr:~# cat /proc/acpi/alarm
2005-09-26 16:30:00
<reboot>
vcr:~# cat /proc/acpi/alarm
2005-09-00 16:30:00
________^^_________

Thanks,
-- 
Mark Ter Morshuizen


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
