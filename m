From: Florian =?ISO-8859-15?Q?H=FChn?= <acpi-14TN6mYQPXr1AXQ8ov2VOh2eb7JE58TQ@public.gmane.org>
Subject: resume from S3 on sony vaio fx-series
Date: Tue, 6 Apr 2004 20:00:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040406200047.24cfb314.acpi@trafficmanager.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I have some trouble with S3 resume with my sony vaio fx505. As one can read on serveral pages it seems to be a common problem of all sony vaio fx-series. (They all say it won't resume but i think they just didn't wait some minutes for the ssh login to finally succed or had an older kernel)
I'm not really shure if this is the right ML for my problem but "Development + Support" sounds good.

So here is a list of the problems i have:
After resuming
o the LCD stays off
o the kernel has to reset the ide bus
o acpi seems to cause kernel-hangups (see 2)
o it doesn't power off after shutdown (see 5)

Now i want to get it running. Anybody who knows how?

I use the unpached Kernel v2.6.5 (i couldn't find any acpi-patch for it) without apic. For my tests i don't run X and nothing pluged into USB/FireWire or other ports.
I enter the S3 with: echo -n "3" > /proc/acpi/sleep, which seems to do exactly the same like echo -n "ram" > /sys/power/state
I put noapic to the kernel-parameters and also tested pci=noapic.

Because i don't want to flood the ML with a mail thats biger than 1MB I placed the logs and configfiles mentioned later on http://trafficmanager.org/vaio/
There you'll also find a lspci and some information from hdparm. If you need further information just ask.


At first a detailed list of what happens if i do a echo -n "3" > /proc/acpi/sleep
o The laptop goes into suspend-mode as expected
o On a keypres the HD spins up and everything seems to get powered up
o The LCD-Panel gets powered on and immediately it goes off again (Only the LCD-Panel itself, the backlight unit stays off the whole time and forever)
o Pinging the Laptop succeeds again
o HD-LED goes on and stays on
o Several seconds/minutes later: The kernel resets the IDE-bus and turns off DMA
o Now the HD is operating normal and I'm able to login via ssh


Some things i noted after resume:
1) Everytime i try to reactive DMA the HD-LED goes on and i can't access the HD until the kernel resets it again.

2) If I press Fn+F7 to switch between LCD and the external Monitor my ssh-session stops responding, ping fails and the laptop doen't do a beep. Seems as if the kernel hangs.

3) An external Monitor also stays off after a resume.

4) If X is running the same happens and if I try to switch to a text-console after resume it hangs like in 2)

5) After resuming I'm able to restart as usual but if I try to shut down it closes my ssh connection as usual but it won't turn of. Because of this I think the ACPI doesn't work properly after resume. (But reading the BAT-stats or other stats is possible)


Some tests i did:

a)
Normal run. For kernel .config see b). It's the same ony, only ACPI Debug is off.
The resulting syslog: a-syslog

b)
I enabled ACPI Debug in the kernel and rebuilded it. So here is my .config that i used for the following tests.
I couldn't find anything very interesting. If you want to see it by yourself: b-syslog

c)
I read that some people solved a similar problem on their desktop-pc's with using CL2 RAM instead of CL3. In my laptop there is only one CL2 256MB module. (And there is no other RAM included on the Mainboard.)
So I thought perhaps it has something to do with cpufreq-stuff. I put my cpu in fullspeed mode (1200MHz) and send it again into S3.
Results: Nothing. Just the same like b)
[Note: I compiled completely without cpu-frequency-scaling in g)]

-----
At this point i edited my dsdt table as discribed on http://forums.gentoo.org/viewtopic.php?t=122145
I had to insert a Return(Package... and deleted some Store(Local0, Local0) because the iasl complained about uninitialized variable Local0. (Why the hell do they copy Local0 into Local0?!?!)
After this I used static DSDT override with the patch from http://bugzilla.kernel.org/attachment.cgi?id=1810&action=view
I also tried the additional patch from http://bugzilla.kernel.org/attachment.cgi?id=1690&action=view
Everything without any result except the kernel message at statup that the dsdt tables got replaced.
The trick with acpi_os_name also produced no change.
On the page mentioned at the beginning you can find my original raw dsdt table, my changed dsdt.dsl and dsdt.hex

All the following tests were made with my changed dsdt table.
-----

d)
Perhaps something interesting with multiple suspend/resumes?
Well, the second suspend failed:
Apr  5 23:29:26 localhost kernel: ide0: reset: success
Apr  5 23:29:26 localhost kernel: ==<7>PM: Preparing system for suspend
Apr  5 23:29:26 localhost kernel: Stopping tasks: =============================
Apr  5 23:29:26 localhost kernel:  stopping tasks failed (1 tasks remaining)
Apr  5 23:29:26 localhost kernel: Restarting tasks...<6> Strange, syslogd not stopped
Apr  5 23:29:26 localhost kernel:  done
The third was just like every other suspend.
The full log: d-syslog

e)
Now i wanted to see more ACPI-Debug messages. So i thought: What happens if i do a echo -n "0xffffffff" > /proc/acpi/debug_level (In the log at 00:07:03)
Then I did a I cat /proc/acpi/ac_adapter/ACAD/state to see what happens.
My screen got flooded with approximately 500 messages per second. After some minuts I did a cold reset.
e-syslog shows some debug messages and obviously something crashed after a few messages.

f)
Next i played a little bit with echo -n "0x000000ff" > /proc/acpi/debug_level and echo -n "0x0000007f" > /proc/acpi/debug_level
There are a lot of messages that perhaps could be interisting, but I don't understand very much of them.
See f1-syslog and f-syslog. I don't know why f1-syslog suddenly stopped. f-syslog was cut by me at the end to keep it "short".

g)
I read some tips to disable as much as possible in the kernel .config.
I tried serveral configurations and nothing became better. My last .config the is g-config and the syslog g-syslog. See g-ps for running processes
Just to be shure i used vga=normal in my lilo.conf

h)
In the hope to find anything I cated /proc/bus/pci/01/00.0 (should be my graphics-chip) to a file, did a suspend/resume and compared the contens of the file with /proc/bus/pci/01/00.0. No differences.

i)
I read about a trick to disable the USB on another sony vaio with pciset. It only resulted in serveral messages like:
Apr  4 20:30:44 localhost kernel: hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
Apr  4 20:30:44 localhost kernel: hub 2-0:1.0: over-current change on port 1
Apr  4 20:30:45 localhost kernel: hub 2-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
Apr  4 20:30:45 localhost kernel: hub 2-0:1.0: over-current change on port 2



Until now i never got my LCD to switch on again without a reboot. If anybody knows something i could try or if you need more information that I can give you let me know about it.

Thanks

PS: Help me! I'm too stupid


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
