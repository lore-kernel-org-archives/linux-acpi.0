From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IO-APIC on MS-6163 (2.4.23). ACPI?
Date: Wed, 10 Dec 2003 10:56:55 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I found " evxfevnt-0093 [04] acpi_enable           : Transition to ACPI =
mode successful". So ACPI seems to work on your machine.=20
Since you previous email complain transition to acpi mode failed, could =
you please tell me what kind of kernel could result in acp mode =
transition failure on your box?

Regarding IO-APIC issue, I didn't find MADT. Please try acpi=3Doff to =
verify IO-APCI can work on your box.

Thanks=20
Luming

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Ryan =
Underwood
Sent: 2003?12?9? 17:07
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?



Hello,

Not sure if this is appropriate for ACPI or kernel list so I Cc: both.

On my MS-6163 v3.0 (BX Master) board, the IO-APIC was previously being
used before a blacklist was incorrectly added last year.  Now that the
blacklist is removed when I upgraded to 2.4.23, ACPI doesn't seem to
want to enable IO-APIC usage (dmesg attached).  I don't remember whether
or not I had ACPI enabled when the IO-APIC was working a long time ago.

I added some debug statements to =
arch/i386/kernel/acpi.c/acpi_boot_init()
to try to diagnose the code flow.  However, when recompiling, almost the =
entire
kernel must be rebuilt for dependencies, which takes forever on my poor
machine... :(  So I didn't want to spend much more time without some =
outside
opinion of the situation.

But, as you can see from dmesg, it gets here:
|
=3D=3D=3D>        printk(KERN_INFO PREFIX "past blacklist\n");

#ifdef CONFIG_X86_LOCAL_APIC

        /*=20
         * MADT
         * ----
         * Parse the Multiple APIC Description Table (MADT), if exists.
         * Note that this table provides platform SMP configuration=20
         * information -- the successor to MPS tables.
         */

XXX     result =3D acpi_table_parse(ACPI_APIC, acpi_parse_madt);
        if (!result) {
                return 0;
        }
        else if (result < 0) {
                printk(KERN_ERR PREFIX "Error parsing MADT\n");
                return result;
        }
        else if (result > 1)
                printk(KERN_WARNING PREFIX "Multiple MADT tables =
exist\n");

=3D=3D=3D>        printk(KERN_INFO PREFIX "past MADT\n")
|
but not here.  There are no other kernel messages printed, so I think =
XXX is the
failing part.  Why would that happen?  Is it because this is a UP =
machine and
the call only works for SMP?  (CONFIG_X86_LOCAL_APIC is definitely =
enabled)

Is it possible that IO-APIC and ACPI can work individually but be =
mutually
exclusive on a system if the ACPI tables don't correctly describe the =
IO-APIC?

I have only a shallow understanding of how this works (from reading =
www.acpi.info
and kernel source) so please bear with me if I am overlooking something =
obvious.

thanks,

--=20
Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
