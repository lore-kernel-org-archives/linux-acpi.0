From: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Subject: Resume from Suspend to RAM
Date: Sun, 5 Jun 2005 14:56:44 +0200
Message-ID: <200506051456.44810.hugelmopf@web.de>
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

Hi List,

my laptop won't resume after it suspended to RAM. 
I tried various boot options, but none was successful, so this list is my last hope ;-)

What happens:
To minimize the influence of any driver, I always booted with the option 
"init=/bin/bash", which left me with a single console and no modules loaded at all.
Then I mounted /proc and /sys, so I could try suspending:

echo mem > /sys/power/state

This works fine, it says for a second "Stopping tasks... " and then the laptop turns 
off (fan, display) and the "sleeping" LED blinks.
But there is no way to wake the system back up. The only key that shows reactions 
is the power button and if I push it, the fan spins up, but nothing else happens: 
no LCD, no ping response, no response to keyboard.

The boot parameters that I have tried include: 
acpi_sleep=s3_{bios,mode}, pci=noacpi, noapic, acpi=noirq 
all without any change.

Do you have any idea, how I might further diagnose this?

Mostly everything else concerning ACPI works fine, except for problems with reading 
the battery status once in a while, resulting in kernel messages of the following kind:

[ACPI Debug] String: [0x09] "BST Start"
evregion-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
 dswexec-0446 [155] ds_exec_end_op        : [Store]: Could not resolve operands, AE_TIME
 psparse-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BST] (Node ffff8100016b71b0), AE_TIME
acpi_battery-0208 [147] acpi_battery_get_statu: Error evaluating _BST

The system: Maxdata Eco 4500A notebook, Debian Sarge AMD64 with vanilla kernel 2.6.11.9

Thanks, Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
