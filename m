From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: constant processor 0x80 events
Date: Tue, 31 Dec 2002 21:12:59 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021231211259.GA28810@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

This is probably a DSDT problem but I'm bewildered as to where to look
now, so would really appreciate any advice people can offer.

When the machine becomes under load for a while, or is hot already and
the processor is under load, then the CPU time in system becomes very
high, /proc/acpi/event is constantly printing:
processor CPU0 00000080 00000000
processor CPU0 00000080 00000000
processor CPU0 00000080 00000000

There are constantly starting and dying kacpidp processes -
top is almost always showing 1 or 2 zombie processes (kacpidp) and the
load average sticks around 2.0.

It used to also run the fan at it's maximum RPM which I didn't feel was
healthy so I've panicked and switched it off quickly to change kernels
back to a non-acpi version which doesn't have this problem - even under
consistent heavy load.

I added this CHTR call (it wasn't being called before) and that seems to
stave off the problem for a while.. while programs are running, there
isn't a steady rise in temperature, the temperature is seemingly all
over the place.  It will get up to 82 and then suddenly drop to 59.
Even when the load is going mad now, the fan is only on its high, not
critical level.

  5180                          Store (Local0, Local2)
  5181                          Multiply (Local0, 0x0A, Local1)
  5182                          Add (Local1, TBSE, Local0)
  5183                          Store ("Current Temperature K is
----------- ", Debug)
  5184                          Store (Local0, Debug)
  5185                          CHTR (Local2)
  5186                          Return (Local0)

I've put my dsdt, and the dsl (from iasl 021205) on my website at
http://dude.noc.clara.net/~faye/dsdt
http://dude.noc.clara.net/~faye/dsdt.dsl

I've never used the kernel debugger before but I'm happy to get my hands
dirty if it will help solve the problem.


Faye


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
