From: ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org
Subject: Re: CALL FOR TESTING
Date: Sat, 21 Sep 2002 13:13:22 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D8C7072.4080600@mindspring.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My system is as follows:

ASUS CUBX-E (440BX) on 300W ATX PSU
Intel Celeron 600E running at ~600MHz
320MB of PC100 memory running at 66MHz (due to bus speed of CPU)
Creative SBLive! 5.1 using digital out
Hauppauge WinTV (bt878)
ATI Radeon VE using the VGA out
Kingston KNE111TX NIC
generic PS/2 keyboard and MS IntelliMouse USB
13GB 7200RPM ATA66 WDC on Promise ATA100 port

> - DOES IT BOOT?
Yup...

ahaning@desktop:~$ uname -a
Linux desktop 2.4.20-pre7 #1 SMP Sat Sep 21 12:15:41 /etc/localtime 2002 
i686 unknown

No, it's not an SMP board, I just forgot to deselect that when preparing 
the kernel config.

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Sound, X, TV, usb mouse, DRI, etc all seem to work fine, so I'll assume 
that the IRQs are okay. How can I tell if they are not? Maybe by 
comparing against a stable kernel?

I've also tried putting the machine into some of the ACPI sleep modes 
with less-than-impressive results (though, I guess, nothing that I 
shouldn't expect):

Sleep Mode.....Result
----------.....------
0..............Nothing. Machine continued to work at full power.
1..............Machine seemed "locked" at full power until power was
                depressed momentarily. The machine then continued to
                work.
2..............Nothing. Machine continued to work at full power. This is
                not listed as a supported mode, though.
3..............Nothing. Machine continued to work at full power.
4..............Nothing. Machine continued to work at full power.
5..............Machine shut off abruptly and fsck ran at next boot.

To do these tests, I did:

echo "#" > /proc/acpi/sleep

where # is 0-5. Perhaps this was wrong. I've had little luck finding 
tools to control ACPI on linux whereas I've found several (pmutils and 
apm) for APM.

I should mention that Windows2000 is able to suspend this machine (the 
only difference being the hard drive.. other than that, all cards and 
cords are in the same place) very well. HDD turns off, video goes to 
"off", optical USB mouse goes off, and all fans (CPU, case, PSU) turn 
off. I can wake it up by pressing the power button momentarily. It can 
also do "hibernation" quite well. I've had limited luck with the swsusp 
option. I cannot do a "swsusp" from X, as X comes back garbled, so it's 
usefulness is limited. So, I'm sure that this should work on linux, and 
that there are no strange hardware issues.

Thanks

ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
