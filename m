From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: smpenum patch updated to 2.6.9-rc2
Date: Mon, 20 Sep 2004 11:29:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847078E2B48@orsmsx401.amr.corp.intel.com>
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
To: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org]=20
> > > 2) With acpi=3Doff and CONFIG_X86_MPS the boot hangs at=20
> "ENABLING IO-
> > > APIC's"

> > > 4) Without your patch and acpi=3Doff the boot hangs at:
> > >=20
> > > ENABLING IO-APIC IRQs
> > > Setting 2 in the phys_id_present_map
> > > ...changing IO-APIC Physical APIC ID to 2 ... ok.
>=20
> Why do I get two more lines without your patch? With your patch I only
> get the first line before it hangs...

The patch redoes arch/i386/kernel/io_apic.c setup_ioapic_ids_from_mpc.
(Its name loses the "from_mpc" part because it is used by both MPS and
ACPI in the smpenum patch.) The function is completely different and
some of the error messages changed verbosity.

If you'd like to really figure out why this system isn't working via
MPS, here are some things to try:

1) Is it hanging in that function? insert a printk at the very end, to
see.
2) Find the line that says "#define Dprintk (x...)" in
include/asm-i386/apic.h and change it to "#define Dprintk (x...) printk
(x...)". That should print out everything that's going on, so we can
compare the working ACPI case with the non-working MPS case.

Regards -- Andy


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
