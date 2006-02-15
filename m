From: Renato Golin <rengolin@gmail.com>
Subject: Toshiba Equium L20
Date: Wed, 15 Feb 2006 10:59:13 +0000
Message-ID: <1140001153.8856.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:7235 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751138AbWBOK5O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Feb 2006 05:57:14 -0500
Received: by wproxy.gmail.com with SMTP id i12so82712wra
        for <linux-acpi@vger.kernel.org>; Wed, 15 Feb 2006 02:57:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi folks,

I did a previous search on this mailing list archive and found no
similar problem, that's why I'm posting it now. My problem is similar to
this one:

http://bugzilla.kernel.org/show_bug.cgi?id=5751

which seems to be resolved but I got the latest kernel available
(2.6.15.4) and the problem still persists on my machine. (than I rolled
back to 2.6.12)

A brief decription:

  My notebook is having serious problems with all periferics like
network cards, keyboard, mouse and sound. Some times the network just
dies, other times the mouse. The keyboard is the worse, I can't type
five chars in a row that it miss one. (so, im sorry for many typos on
this message ;)

  I used Suse linux without ACPI and it was just fine, but when I wanted
the ACPI working I started my nightmare. Now I use Ubuntu and I can't
turn off the ACPI (by adding acpi=off on kernel's line) because when I
do it the kernel assign IRQ 102 to my wireless card and the wired card
just don't get up.

  I posted a message like this on usenet and a nice guy (Peter Breuer)
got me some answers but he was conviced that my problem was the NIC.
Unfortunatelly everything else is failing.

Now, my system:

Machine:
Toshiba Equium L20 198 (a crap, I might say)
 - ATI mainboard, sound and graphics
 - Realtek 10/100 wired NIC (yeah, I know)
 - Atheros 10/100 wireless NIC

All cards are on-board, no PCMCIA, USB etc.


$ uname -a
Linux brubeck 2.6.12-10-386 #1 Mon Jan 16 17:18:08 UTC 2006 i686
GNU/Linux


$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Celeron(R) M processor         1.50GHz
stepping        : 8
cpu MHz         : 1497.275
cache size      : 1024 KB

$ acpi -v
acpi 0.09
(...)
$ acpi -V
     Thermal 1: ok, 52.0 degrees C
  AC Adapter 1: on-line
$ acpi -b
$

(on Suse it used to give me the battery as well)


The error messages I have on /var/log/messages:

Feb 12 20:59:25 localhost kernel: [4331271.014000]     ACPI-0362: ***
Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
Feb 12 20:59:25 localhost kernel: [4331271.014000] search_node dde85920
start_node dde85920 return_node 00000000
Feb 12 20:59:25 localhost kernel: [4331271.014000]     ACPI-0508: ***
Error: Method execution failed [\_SB_.BAT1._BST] (Node dde84820),
AE_NOT_FOUND

Feb 12 20:59:30 localhost kernel: [4331275.912000]     ACPI-0362: ***
Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
Feb 12 20:59:30 localhost kernel: [4331275.912000] search_node dde85920
start_node dde85920 return_node 00000000
Feb 12 20:59:30 localhost kernel: [4331275.912000]     ACPI-0508: ***
Error: Method execution failed [\_SB_.BAT1._BST] (Node dde84820),
AE_NOT_FOUND

(as you can see, one group every 5 seconds, must be some kind of
polling)


Some detailed output such as dmesg and lspci -v are at
http://www.systemcall.com.br/rengolin/acpi/ but here I'll post some of
them I found more interesting:

  === DMESG

When using ACPI, the first lines of 'dmesg | grep -i acpi' are:
[4294671.224000] ACPI: Looking for DSDT in initrd... not found!
[4294671.409000] ACPI: bus type pci registered
[4294671.409000] ACPI: Subsystem revision 20050729
[4294671.411000]     ACPI-0362: *** Error: Looking up [Z00D] in
namespace, AE_NOT_FOUND

So, first, it wasn't updated according to the kernel bugzilla (stated
above). Then, it didn't find ay DSDT, so ow could it know how t deal
accordingly with my hardware's powermanagement ? Is it the cause of the
messages I see on ar/log/messages ?

Also, it says later:
[4294764.683000] ACPI: AC Adapter [ACAD] (on-line)
[4294764.863000] ACPI: Battery Slot [BAT1] (battery present)

So, if it's really dettecting my battery, why 'acpi -b' won't show it ?

When not using ACPI, the 'dmesg | grep -i pci' shows me:
[   20.386353] PCI->APIC IRQ transform: 0000:09:01.0[B] -> IRQ 17
[   20.386358] PCI->APIC IRQ transform: 0000:09:02.0[A] -> IRQ 0
[   20.386364] PCI->APIC IRQ transform: 0000:09:04.0[A] -> IRQ 102

Some weird IRQs for me, never saw something like that, but, is APIC the
fallback for routing IRQs when no ACPI is in use ? Why some said me to
turn off the local APIC ? (btw, noapic on kernel line gave me kernel
panic)

The board receiving the weir IRQs (0 and 102) are both NIC (see lspci
output on my site).

Also, if you do a diff on the output of 'lspci -v' with and without
ACPI, you will find:

$ diff lspci.acpi lspci.noacpi
[ this is Realtek's line ]
92c92
<       Flags: bus master, medium devsel, latency 64, IRQ 21
---
>       Flags: bus master, medium devsel, latency 64
[ and this is Atheros line ]
99c99
<       Flags: bus master, medium devsel, latency 168, IRQ 22
---
>       Flags: medium devsel, IRQ 102


One more thing I've noted, it says:
[4294671.537000] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report

Well,I did booted with 'pci=routeirq' but the problem persists.


So, on my site http://www.systemcall.com.br/rengolin/acpi/ I've put all
files mentioned here and some others related to this problem. If you
need more information, please ask me.

The filenames are: program-name.[acpi|noacpi].greped-string

Please note that I've taked a long time to write this, debgging and
rebooing lots of times and, as I stated on the beginning, the problem
might have been resolved in future versions of the kernel, but I'd like
to contriute as many as I can to ACPI development even if all my debug
information is outdated. Maybe you can use all this information for
something else.

many thanks in advance,
--rengolin

