From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI Interpreter
Date: 26 Mar 2004 19:20:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080346823.16211.21.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
	 <1080278805.755.157.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080278805.755.157.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc-Christian Petersen <m.c.p-dPKWvz6skTq4xZncNx1fdg@public.gmane.org>, 15444-hqaBeiJFMhqzQB+pC5nmwQ@public.gmane.org, gigerstyle-OI3hZJvNYWs@public.gmane.org, trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Rik van Ballegooijen <sleightofmind-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-03-26 at 00:26, Len Brown wrote:
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> > 
> > > ACPI: SCI (IRQ22) allocation failed
> > >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> > Handler, AE_NOT_ACQUIRED
> > > ACPI: Unable to start the ACPI Interpreter

If you encounter this issue on your hardware, can you help me fix it by
testing the latest patch at the URL below?  Either attach your dmesg and
/proc/interrupts to the bug report or send it to me, and let me know if
your power button works?

thanks,
-Len

> > http://bugzilla.kernel.org/show_bug.cgi?id=2366




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
