From: Stefan Tomanek <stefan-Q4Z/ui9EqVxM7kwft8N7nw@public.gmane.org>
Subject: Battery rate on Acer TM 292
Date: Sun, 12 Sep 2004 12:47:45 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20040912T144218-763@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,
I've got an Acer Travelmate 292 (It's been sold under the name Extensa 2902, but
it's essentially an TM292), and there are 3 issues with its ACPI implementation:

1) ACPI only reports 2 frequencies (600 and 1500 Mhz) for the Dothan, I already
adressed this to the cpufreq guys

2) the ac adapter does not send any events, but's that's not much trouble since
it's status is reported properly, and battery events are sent instead

3) the rate of charging or discharging is always 0, makes it hard to guess when
we are running out of power :-)

stefan@nano:~$ acpi
     Battery 1: discharging, 99%, charging at zero rate
  - will never fully charge.
stefan@nano:~$ cat /proc/acpi/battery/BAT1/state 
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      3960 mAh
present voltage:         16376 mV

I disassebled the dsdt, perhaps someone experienced can take a look at it:

http://localhost.ruhr.de/~stefan/acer_tm292_dsdt.txt

Thanks in advance...



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
