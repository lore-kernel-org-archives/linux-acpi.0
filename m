From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: Re: System no longer responds to magic packets after power
 down.
Date: Sun, 7 Dec 2003 11:44:22 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0312071137190.18719-100000@elektron.its.tudelft.nl>
References: <20031203182456.GB28870@tate.loria.fr>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031203182456.GB28870-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This email is an acknowledgement, because bugzilla.kernel.org refuses to
Cc: this list. Read the entire report at bugzilla.kernel.org if
interested:

http://bugme.osdl.org/show_bug.cgi?id=1636

I have good news and bad news. The good news is that I now have a working
solution for enabling Wake-on-LAN after Power down. from Linux and it
works with all 2.4.22-nvidia, 2.4.23-forcedeth and 2.6.0-test11-forcedeth.
The bad news is that is really ugly and then some...

My box runs Debian sid. On the scyld page I found a nice little program
that can force D3 power state:
http://www.scyld.com/diag/index.html
ftp://ftp.scyld.com/pub/diag/pci-config.c

NOTE: pci-config does NOT compile with gcc-3.3.2 on Debian sid. It does
compile with gcc-2.95. Compile it with:
gcc-2.95 -O pci-config.c -o pci-config

I was fiddling with two consoles, where I entered halt in one, and after
an arbitrary delay pci-config -S -#12. I swear that it worked at least 1
out of 12 times ;) The biggest downside is that sometimes the system
hangs, and most of the time will not respond to Wake-on-LAN magic packets.

I figured out that with the network up and the nic-module in the kernel,
the box would hang. After ifdown eth0 I could just do as I please, putting
the chip to sleep and waking it up again. Same for no module inserted at
all. None of these situations enabled me to wake the box up again however.

Still, I was convinced that it had worked at least one time. I decided to
add a job to /etc/rc0.d so I could systematically find the sweetspot. The
sweetspot is between S20sendsigs (where all processes are send the TERM
and then the KILL signal by killall5) and S35networking (as far as I can
tell only ifdown -a happens here). Before S20sendsigs the box will just
hang and after S35networking the box does not respond to magic packets.

barton:/etc/rc0.d# cat S21D3NIC
#! /bin/sh
echo "Putting NIC to D3 state -- FIXME!!!"
/home/sphere/media/pci-config -S -#12 | grep Power
/home/sphere/media/pci-config -a -#12 | grep Power

With the help of lspci, cat /proc/pci and ./pci-config -a -#<#> for every
device number listed by ./pci-config -a I figured out that device 12 was
my nic.

I hope this information can be useful to you in trying to figure out how
to solve this problem in a clean way. Maybe the forcedeth driver could set
the D3 state? I have no idea how the ACPI standard prescribes this should
be implemented. The only puzzling thing to me at this moment is how the
driver is connected to my solution. I will look into that some more, but
this will probably be after the weekend.

Best regards,

Arjen



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
