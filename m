From: Theodore Morse <ender5175-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Ocasional hangs
Date: Sat, 21 Dec 2002 21:51:54 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021222055154.47245.qmail@web13705.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Vicente Aguilar <bisente-1mvy7kH9/DBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I too have been experiencing what Vicente Aguilar is
going through with his battery problems. I upgraded to
the 2.4.20 kernel, and every 4-5 hours my system hangs
because batt-stat can't get the battery information.
Once I triggered it myself as I manually did a cat on
/proc/acpi/battery... 

If anyone has any clue as how to fix this, it would be
most helpful. My laptop is a Toshiba Satellite
1905-S303. I was running kernel 2.4.20 with the latest
acpi patch.

Thanks,
Ted Morse

------ original message by Vicente ------
Hi lists
 
I've been experiencing ocasional system hangs for some
time now, with
kernels 2.4.19 and 20 and the latests ACPI patches of
the moment. After
 using the computer for a few hours (2-3 maybe) it
just hangs, the system
 doesn't even responds to pings over the network, and
you can hear de
 fans go full speed as if the CPU has gone to 100%
capacity (this is on a
 laptop, a Compaq Presario 905EA).
 
 I think it is related to ACPI, here's why: with
acpi-20021205 these
 hangs were really easy to reproduce by just doing a
simple cat of
 /proc/acpi/battery/stat. You read the proc file, then
the system hanged,
 as simple as that. With all the others acpi patches
the hangs have been
 and are (now with 2.4.20 and acpi-20021212) *very*
ocasional, but I've
 done the following experiment: I usually use Gnome
and have the
 battstat-applet loaded. I find weird that such a
simple program (it just
 reads the battery stats every now and then) uses 3%
of the CPU (a Mobile
 Athlon XP 1500+). I've tried unloading the applet,
and right now I've
 got an uptime of almost 9 hours, while before the
system should have
 already crashed.
 
 I know that the battstat applet eating 3% of the CPU
is maybe only
 battstat's fault, but I think that the system hangs
may be related and
 being caused by ACPI when someone reads the battery
status. Anyway if
 this theory was true, it only hangs *sometimes* when
you read the batt
 stats, as the applet is running and checking them
often and the system
 only crashes after a couple of hours, so it's hard to
reproduce the
 situation.
 
 I would also like to note that maybe this isn't
really ACPI's fault, as
 the hardware in this laptop isn't still fully
supported by Linux. Maybe
 the bug is somewhere else but it is ACPI who triggers
it.
 
 Anyway, I know all this info is very vague for a bug
report, but if
 maybe someone else could reproduce the situation with
the same laptop or
 even another system...
-------- end -----------

=====
Ted Morse
Student/Programmer
University of Evansville/Ciholas Enterprises

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
