From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Why ACPI is in the kernel, notes from 2001
Date: Thu, 28 Oct 2004 17:17:27 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Theodore Ts'o <tytso-3s7WtUTddSA@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Here's some notes from 2001:

Why ACPI is in the kernel

ACPI and the AML interpreter are required very early during kernel
initialization, before the device drivers are loaded.  Control methods
are executed by the interpreter at this time (such as all device _INI
methods).

ACPI owns the ACPI hardware and ACPI interrupt (SCI), and therefore this
part of the ACPI subsystem is similar to a device driver.

Control methods that are executed via the AML interpreter are allowed
direct access to all of physical memory, all I/O space, and all PCI
configuration space (via Operation Regions.)

Device drivers such as the Embedded Controller, Battery, and Thermal use
ACPI services and execute AML control methods during their operation.

Device driver callback routines are invoked directly from the AML
interpreter when the ASL Notify operation is executed.

ACPI and the AML interpreter cannot be paged out.  How do you wake up
the disk used for paging?  Not a good idea for other device drivers to
depend on code that may be paged out.

Also,

As of May 2000, the AML interpreter was in acpid! Shortly after that, we
made a conscious decision to move it into the driver for the reasons
above.  The code may be large (for Linux), but it is necessary and must
remain resident (it is non-pageable).

Bob

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Robert
> Sent: Thursday, October 28, 2004 2:42 PM
> To: Theodore Ts'o; Brown, Len; Grover, Andrew; Therien, Guy
> Cc: Yu, Luming; Bjorn Helgaas; Alex Williamson; linux-kernel; acpi-
> devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] RE: Userspace ACPI interpreter
>=20
>=20
> I've been working on the ACPI CA project for over 6 years, and trust
me,
> this has been tried before.  There are significant reasons for having
> the interpreter in the kernel.
>=20
> You don't really want to page out the interpreter when you are using
it
> for things like suspend/resume, thermal control, and many other
things.
>=20
> I think we have a list around somewhere with many of the reasons, I
will
> look for it.
>=20
> Bob
>=20
>=20
> > -----Original Message-----
> > From: Theodore Ts'o [mailto:tytso-AKGzg7BKzIDYtjvyW6yDsg@public.gmane.org] On Behalf Of Theodore
> Ts'o
> > Sent: Thursday, October 28, 2004 8:24 AM
> > To: Brown, Len
> > Cc: Yu, Luming; Bjorn Helgaas; Moore, Robert; Alex Williamson;
linux-
> > kernel; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC]
> dev_acpi:
> > support for userspace access to acpi)
> >
> > On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
> > > One way to experiment with a user-mode ACPI interpreter would be
to
> > > continue to use the kernel-mode interpreter for boot up , and cut
> over
> > > to the user-mode interpreter at /sbin/init.  The kernel-mode
> interpreter
> > > could be sent the way of free_initmem() which is called just
before
> > > /sbin/init is invoked.
> >
> > Is there a significant advantage to doing having a user-mode ACPI
> > interpreter?  The only advantage I can think of is that the ACPI
> > interpreter could now live in pageable memory.  Are there any
others?
> >
> > 					- Ted
>=20
>=20
> -------------------------------------------------------
> This Newsletter Sponsored by: Macrovision
> For reliable Linux application installations, use the industry's
leading
> setup authoring tool, InstallShield X. Learn more and evaluate
> today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
