From: Petri Koistinen <petri.koistinen-X3B1VOXEql0@public.gmane.org>
Subject: 2.6 kernel jam: acpi_processor_set_thermal_limit problem?
Date: Sun, 18 Jan 2004 01:45:46 +0200 (EET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401180115160.1008@dsl-hkigw4j21.dial.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

My computer hanged today when running latest linux 2.6 kernel (synced
today, from rsync/cvs). I noticed this from /var/log/kern.log after I had
rebooted machine by hand.

kernel: Warning: kfree_skb on hard IRQ c0396684
kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [<c0119893>] schedule+0x563/0x570
kernel:  [acpi_processor_set_thermal_limit+1022229/1118449] tcp_poll+0x34/0x160
kernel:  [<c0124fc5>] schedule_timeout+0xb5/0xc0
kernel:  [acpi_processor_set_thermal_limit+893242/1118449] sock_poll+0x29/0x40
kernel:  [<c016079f>] do_pollfd+0x4f/0x90
kernel:  [<c016088a>] do_poll+0xaa/0xd0
kernel:  [<c0160a46>] sys_poll+0x196/0x290
kernel:  [<c015fdb0>] __pollwait+0x0/0xd0
kernel:  [<c0108f47>] syscall_call+0x7/0xb

and this repeated many times on log. More info, too much to be include
here, is available at http://juu.ath.cx/~petri/kernel-jam-2004-01-17/
including System.map, config, kern.log, info about machine and kernel
image. I am happy to help more, if I can.

Best regards,
Petri Koistinen


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
