From: =?iso-8859-1?q?Jouni=20Laakso?= <jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Subject: RTC alarm wake from mechanical power off
Date: Mon, 17 Nov 2003 20:21:52 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117202152.3703.qmail@web25005.mail.ukl.yahoo.com>
Reply-To: jounijl-/E1597aS9LT10XsdtD+oqA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I'm a desktop computer user and using apic. Because of
this my problem is different as many others. I want my
computer to somehow wake up from mechanical off.

Acpi specification says at page 75 that Real time
clock alarm is required, but it's optional as fixed
hardware event. I think this means that computer can
optionally be woken up from "Mechanical Off" G3? Am I
right? (I haven't read it all.)

I'm using Abit ZM6 motherboard witch includes Intels
82471eb -chip witch includes this feature (to wake
from mechanical off).

It seems that it's impossible to save alarm time and
date from operating system. From bios settings it's
possible. I don't know why. Does anyone have
experience about this?

Wake time can be setted in bios settings but maby not
from operating system. I have tried with [cat
"2003-11-17 01:00:00" > /proc/acpi/alarm] and made a
kernel module to test writes to alarm register
addresses defined in 82471eb -documents. Anyway, both
cases return the previous values that were setted in
bios settings if machine is rebooted and read from
bios or directly from registry addresses. Anyway if
/proc/acpi/alarm is different than before, computer
does not wake from mechanical off. (I'm not sure, but
/proc/acpi/alarm values might be the same that were
inserted in operating system after reboot.) When
reading and writing and reading again from chips
addresses, the write has no effect.

Isn't it supposed to be, that both time and alarm time
values are in battery backed ram? So they could be
used in programs or kernel modules or in acpi modules?
Why it does not work?

Do you have any pointers what could be done? Is wake
from mechanical off possible in Acpi Linux
implementation? Where should I look? And if some
recoding for this motherboard is necessary, what or
where? Does new DSDT fix the problem? Or did I get it
all wrong? 

Chips document says that alarm time address locations
are standard. It seems promising.

regards,

Jouni L.

________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
