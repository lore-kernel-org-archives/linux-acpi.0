From: Janek Kozicki <janek_listy-5tc4TXWwyLM@public.gmane.org>
Subject: SMP, "noapic", usb, interrupts : problem solved !
Date: Sat, 29 Nov 2003 19:44:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031129194413.2060bc01.janek_listy@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

hello, 

I'm using SMP (Abit VP6, 2 x PIII 600MHz) motherboard.

I've been using for a long time 2.4.19 kernel, and everything was
working good. 2.4.18 also was working good.

Once I tried to upgrade to 2.4.20 but usb mouse stopped working, so 
I went back to 2.4.19. Next time, when 2.4.21 was released I tried 
new kernel, but once again usb mouse was not working in the new 
kernel. Needless to say that 2.4.22 and 22.4.23 are also broken.

Two weeks ago I upgraded from debian/woody to debian/sarge, and I
discovered that kernels older than 2.4.21-pre5 do not compile in
debian/sarge (problem with gcc 3). So I decided that this time I MUST
get a working kernel.

I was fighting for two weeks with this problem, each day compiling new
kernel two or three times. I tried everything possible configuration,
every possible patches, I was even hacking kernel myself (but very
little ;)). I was also searching google for the solution while waiting
for new kernel to compile.

One of these patches was from acpi-devel but that also didn't help.

I've read somehere that passing an option "noapic" to the kernel solves
that problem. Indeed usb started working. But another problem occured:
second CPU stopped handling interrups. Too bad I thought.

But "noapic" is closely related to acpi-devel subject so I subscribed to
this group to post a question here: "what to do?".

Suddenly, today, while searching google once again I've found a solution
(on the kernel-devel forum of *BSD* users (!)).

I had to switch handling SMP in BIOS from MPS 1.4 to older one MPS 1.1.
And now, when my motherboard uses MPS 1.1 I don't need "noapic" option,
and usb works, and both CPUs handle interrupts correctly. Moreover even
my usb digital camera, and usb cellular phone (nokia 5510) are working
correctly as external usb-scsi hard drives.

So instead of posting "what-to-do?" post, I would rather post "hey I've
found a solution" so everyone elese using google can find it and solve
this strange problem.



On the other hand: what is wrong with kernels older than 2.4.19 
(2.4.20 to 23) that they stopped handling correctly MPS 1.4 ?

I think it's a bug, and I think that this bug is related to acpi-devel
since "noapic" option _partly_ solves that problem.

In case anyone wants my help with solving this bug I can provide: The
output from dmesg -s40000, The output from dmidecode, The output from
acpidmp, the output from lspci -vv and cat /proc/interrupts. I will also
help in checking patches, or whatever else you may need.

my current kernel configuration (the one that works): 
- acpi in kernel disabled (enabling it didn't help at all) 
- kernel boot options: "hdd=ide-scsi hdc=ide-scsi " (because I have 
  a CD writer), 
- NO "noapic" kernel boot option. 
- kernel 2.4.23 unpatched (directly from kernel.org) 
- motherboard set MPS to 1.1 
- /dev/hiddev in kernel config disabled (when enabled - usb didn't 
  work, but I haven't checked how about MPS 1.1 + /dev/hiddev. If 
  you want me to check please let me know) 
- both UHCI compiled as modules, so that program hotplug (on debian 
  apt-get install hotplug) can select whichever it prefers. 
- usb mouse compiled into kernel 
- hotplug enabled 
- make sure graphic card has non-shared IRQ 9 or 10 or 11 (this is _not_
  related to usb I think. It's rather related to "noapic" since bad
  hadling of irqs (only one kernel) caused graphic card to misbehave (GLX
  stops working after some peroid of time) I just had problems with my
  just-bought matrox graphic card. and here is the "I-hope" solution) 



In case you feel this MPS 1.4 bug is not related to acpi-devel please
let me know and point somewhere else where I can offer my help and
willingness to solve this problem.

I'm unfortunately not a kernel hacker (hacking a little doesn't mean I'm
a hacker ;)), and I hadn't report this bug anywhere else. If you know
where it should be reported I will gladly do it.


-- 
# Janek Kozicki


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
