From: Ari Pollak <aripollak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: S1 and S3 on IBM Thinkpad don't work
Date: Thu, 11 Nov 2004 01:18:36 -0500
Message-ID: <cmv06r$as3$1@sea.gmane.org>
References: <200411100001.15678.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411100001.15678.bernd-schubert-S0/GAf8tV78@public.gmane.org>
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

I'm having the same problem on my T41 on nearly identical hardware. I 
haven't had time to do any extensive testing, but even APM 
suspend/resume seems to be broken on 2.6.10-rc1-mm4 :(

Bernd Schubert wrote:
> Hello, 
> 
> I just submitted a bugzilla bugreport 
> (http://bugme.osdl.org/show_bug.cgi?id=3723) since the S1 mode doesn't work 
> *anymore*, see below for more details. Unfortunately S3 is also not working, 
> when it wakes up, it spins up the drive, neither the display nor the network 
> come up. Any help getting one of the modes working is highly appreciated. I'm 
> willing to add any wakeup, sounds, reading documentation, etc. from next 
> Monday on (not earlier as I'm on a conference from Thursday to Sunday).
> 
> Thanks a lot in advance,
>  Bernd
> 
> 
> 
> 
> Details about the S1 mode problem reported in Bugzilla:
> 
> 
> Distribution: Debian
> Hardware Environment: IBM Thinkpad R31
> Software Environment: 
> Problem Description:
> 
> Before and with 2.6.2-rc2 S1 was (almost) working fine, only the display 
> didn't switch off. The next kernel I used was 2.6.5 and since this or a 
> version between 2.6.2-rc2 and 2.6.5 waking up from the S1 sleeping mode just 
> doesn't work anymore. 
> Sending it to sleep mode with "echo 1 >/proc/acpi/sleep" works as usual 
> (the display doesn't switch off as usual), but when it wakes up, the last line 
> it prints is:
> 
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> 
> Afterwards no further keyboard input is possible and only a hard reset by 
> pressing the power button for 5 seconds works. 
> Possibly the other wakeup messages are also important, so I uploaded a digicam 
> screenshot 
> 
> http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/R31_S1_wake_up.jpg
> 
> 
> It might be also interesting that this doens't happen, if I enable full 
> debugging via /proc/acpi/debug_level. Well, my whole screen is then 
> overwritten with lots of debugging messages, but after S1 sleeping, it wakes 
> up fine.
> 
> 
> Steps to reproduce:
> echo 1 >/proc/acpi/sleep
> 
> 
> The dmesg, dmidecode, acpidmp, lspci and interrups files can be found at 
> http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
