From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BUG] test9 ACPI bad: scheduling while atomic!
Date: Tue, 28 Oct 2003 10:52:48 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBB@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

Pl. sees comments below.

> I can't figure out why that patch fixed the oops in bug 1171.  It was
a
> hook
> into the ec address space handler, not the gpe handler, that led to
the
> oops,
> yet the patch seems to only modify gpe-related code.  Perhaps you
could
> explain,

> The errant patch does address what seems to be a race condition that
could
> play
> out as follows:
>=20
> 1) The early ECDT probe locates an ECDT and registers a handler for
the
> relevant
> GPE and address space.
>=20
> 2) An IRQ triggers acpi_ec_gpe_handler, which schedules
acpi_ec_gpe_query.
>=20
> 3) ACPI scans for devices and adds the "real" embedded controller
device,
> freeing the (temporary) context of the old GPE query handler.
>=20
> 4) Queue runs acpi_ec_gpe_query with a context that has already been
> kfree'd,
> causing it to fail.

The reason is just what you said. It's a race condition.


> I'd guess the T40 oops results from the ACPI_MEM_FREE on line 305 of
> drivers/acpi/events/evregion.c freeing already-freed memory.  I'm
actually
> not
> sure why that free is even there.  I also can't figure why only SMP-
> configured
> kernels exhibited the problem.  If someone has the problem hardware, I
am
> willing to debug it, however.

In UP, the problem occurs also. But it can't cause anything, because
spinlock does nothing in UP.
In some machines which have the problem in UP, you will see some info
like this:
Hwregs-0760[35] hw_low_level_read: Unsupported address space:C8

>=20
> It seems rather theoretical, but perhaps we could fix it with a patch
like
> the
> following.  I tested it for kicks and didn't hit any problems, but I'm
> afraid it
> risks more problems than it solves.  Thoughts?

Did just discarding the events cause problem?


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
