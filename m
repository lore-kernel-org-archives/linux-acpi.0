From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Battery rate on Acer TM 292
Date: Mon, 13 Sep 2004 09:20:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305751B66D5@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Tomanek <stefan-Q4Z/ui9EqVxM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan Tomanek wrote:
>Hello,
>I've got an Acer Travelmate 292 (It's been sold under the name Extensa
2902,
>but
>it's essentially an TM292), and there are 3 issues with its ACPI
>implementation:
>
>1) ACPI only reports 2 frequencies (600 and 1500 Mhz) for the Dothan, I
>already
>adressed this to the cpufreq guys
>
>2) the ac adapter does not send any events, but's that's not much
trouble
>since
>it's status is reported properly, and battery events are sent instead
It's possibly a BIOS issue.

>
>3) the rate of charging or discharging is always 0, makes it hard to
guess
>when
>we are running out of power :-)
>
>stefan@nano:~$ acpi
>     Battery 1: discharging, 99%, charging at zero rate
>  - will never fully charge.
>stefan@nano:~$ cat /proc/acpi/battery/BAT1/state
>present:                 yes
>capacity state:          ok
>charging state:          discharging
>present rate:            0 mA
>remaining capacity:      3960 mAh
>present voltage:         16376 mV
Please don't trust 'present rate'. In many systems, 'present rate' are
always 0. If you want to estimate the power of the battery, please use
remaining capacity. I'd like the user daemon use 'remaining capacity' to
calculate the rate.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
