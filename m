From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Re: Processor frequency control on ASUS laptops. And, how to switch video outputs?
Date: Sat, 26 Jul 2003 10:28:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030726082807.GA7261@casa.fluido.as>
References: <20030725181031.GA19588@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725181031.GA19588-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
Cc: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Subject: Processor frequency control on ASUS laptops
	Date: ven, lug 25, 2003 at 08:10:31 +0200

Quoting Karol Kozimor (sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org):

> I've been recently reminded about the GFRQ/SFRQ methods in some ASUS
> notebooks DSDT's, which apparently are used by the Windows ASUS driver to
> manage processor performance. Before adding "just another cool way to
> control processor performance", I'd like to ask if there is _anybody_
> running an ASUS laptop, for whom the processor performance control doesn't
> work either with ACPI performance driver, or the updated ports of speedstep
> driver (the one that supports K7 and is said to support Pentium-M)?

Your mail gave me the motivation to have a look at the cpu-freq stuff
that is present on the 2.6.0test kernel. This also required that I
make contact with this 'sysfs' virtual filesystem, that I had earlier
never heard about. I do happily announce that on my Asus M3700N
(centrino-based) the /sys/class/cpu/cpu0/cpufreq interface indeed
works, and I can set the CPU frequency to any frequency between 600000
and 1500000 Hz (at least, /proc/cpuinfo shows appropriately modified
speed and bogomips fields).

The acpi interface is a bit more obscure for me. I can echo a number
between 0 and 7 to /proc/acpi/processor/CPU1/throttling, and the
setting apparently changes accordingly, although I have no idea about
how to verify what really is happening. The 'power' file contains the
following:

active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000] usage[00000000]
    C2:                  promotion[C3] demotion[C1] latency[001] usage[00000000]
    C3:                  promotion[--] demotion[C2] latency[101] usage[00000000]

but it is a read-only file, and I could not modify the active
state. And the info file contains this:

processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  no
limit interface:         yes

which seems to indicate to me that I cannot do performance management
through acpi.

I don't know if this is of help to you. Ask me if you need that I do
some specific check.

I do have another asus-related question, though. I read somewhere that
the method to switch video output between LCD and an external CRT was
to send specific numbers to /proc/acpi/asus/disp. Well, in my case the
content of this file is always 65535, and nothing happens whatever
number I send to the file. There is another file in the directory,
called lcd. It contains 1, and if I try to send other numbers to it,
the number does not change, and I find the following message:

Asus ACPI: Error switching LCD

in the log file. I am afraid the problem has to be traced to the
framebuffer driver: the person who developed the driver for Linux 2.4
(David Dawes) told me that he has no plans to do the conversion to the
new fb architecture in 2.6, and I am thus using the sub-optimal vesa
driver (and in 2.4 Dawes' driver did not work with the Intel 855GM
chip that is included in my laptop (freezing at boot when it should
have switched to framebuffer usage)).

But maybe there is some acpi magic that can perform the output
switch... 

In all cases, have a good day. There is nothing urgent here. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
