From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [EXTRA] Regression in 2.4.23 w.r.t. 2.4.22 on i840
Date: Sun, 30 Nov 2003 01:26:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC887F@hdsmsx402.hd.intel.com>
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
To: Chris Rankin <rankincj-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hmmm, my copy of iasl couldn't parse this DSDT;-(

Can you attach the /proc/interrupts with these dmesg logs and acpidmp to
a bug report?
acpi=3Dforce cases generally aren't the highest priority, but the fact
that it used to work and then broke makes it interesting.

Also, if you get a chance, it would be good to know if 2.6.0 works
differently, and if in 2.4.23 the cmdline "acpi_irq_nobalance" makes any
difference.

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:=20
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Chris Rankin
> Sent: Friday, November 28, 2003 10:06 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] [EXTRA] Regression in 2.4.23 w.r.t. 2.4.22 on i840
>=20
>=20
> Ref: 2.4.23 PCI devices go nuts unless "pci=3Dnoacpi".
>=20
> Here's the output from acpidmp for my machine. Come to
> think of it, you'd probably want this.
>=20
> Cheers,
> Chris
>=20
> ______________________________________________________________
> __________
> Download Yahoo! Messenger now for a chance to win Live At=20
> Knebworth DVDs
> http://www.yahoo.co.uk/robbiewilliams
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
