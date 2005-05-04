From: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
Subject: weird ACPI problem
Date: Wed, 04 May 2005 21:44:08 +0200
Message-ID: <42792608.8040707@heiko-gerstung.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi ACPI Gurus ...

I have a weird ACPI related problem with my ACER C100 Laptop/TabletPC.

I'd like to install Gentoo Linux on it and everything seems to work
flawlessy except power management, namely ACPI. I tried a number of
different kernel versions (including 2.6.11.7 and 2.6.12-rc3 with ACPI
patches from acpi.sourceforge.net), configs and parameters but nothing
helped, the dmesg output always says "ACPI: Interpreter disabled", no
matter what I tried.

The strange thing is that ACPI works like a charm if I boot KNOPPIX from
my external DVD drive. I compiled the same kernel version Knoppix is
using and I used the same config (only added ReiserFS and the RTL8139
driver for my NIC) but still no improvement. Klaus Knopper (creator of
Knoppix) told me that he is using a vanilla kernel version 2.6.11 from
kernel.org and I even tried that one, nothing seems to help. A small
number of other Acer C100 Linux users joined me, as no one has a working
ACPI enabled kernel up and running, despite the fact that Knoppix runs fine.

It would be really appreciated if you could join the numerous people
trying to help me, I opened a thread in the Gentoo forum where all my
tries and log files etc. can be reviewed
(http://forums.gentoo.org/viewtopic-t-331266.html).

Of course I can prepare a report of what I tried and what the results
were here on the list, if you prefer that.

Thanks in advance for any hints or tips,

kind regards,
Heiko


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
