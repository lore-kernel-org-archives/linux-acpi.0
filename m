From: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Subject: RE: does cpu_idle() halt CPU?
Date: Sat, 29 Mar 2003 11:10:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16005.28938.409919.994510@hotzenplotz.chateau-neukoelln.de>
References: <F760B14C9561B941B89469F59BA3A84725A23A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A23A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

> > From: Jun Sun [mailto:jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org] 
> > I am new to acpi, but I figure this question is probably
> > beyond acpi-support list.
> > 
> > I instrumented acpi_processor_idle() routine to see
> > what states the CPU is in.  It turns out it spent most
> > of the time in C2 state and some times in C1, but never
> > in C3.

I recently discovered that on my notebook the CPU state (and therefore
power consumption) is highly dependent on the drivers loaded. There
are at least 2 drivers, which practically seem to inhibit the CPU from
entering C3: The usb-ohci module (must only be loaded, no USB devices
need to be attached) and DRI (direct rendering for XFree86).

When these are enabled the CPU never enters C3. If I disable them, the
CPU is in C3 most of the time, which can easily be monitored by
something like:

watch --interval=1 cat /proc/acpi/processor/C000/power

Apart from ACPI itself, there is also quite a lot of work required to
make individual drivers more power management aware.

Depending on your hardware and setup you might consider disabling some
drivers for hardware you don't actually need. This might greatly
increase your battery life.

Regards,

Stephan


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
