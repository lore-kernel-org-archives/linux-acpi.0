From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: HELP! Compaq TC1000 ACPI - Disable IRQ #9
Date: Fri, 19 Dec 2003 11:02:53 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8930@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Carlos Noguera <carlos.noguera-mwuG6knsBJfQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Has any other distribution or kernel version successfully run on this
box?

If it fails with and without acpi=3Doff, then ACPI can't be causing the
problem (unless acpi=3Doff is broken).  Though it it conceivable that =
ACPI
can be part of the solution.

Do you have a windows disk for it?  Might be helpful to use it to see if
the hardware is working and examine the IRQ assignments.

Tough to debug this one if you can't get in via console or network.
I don't suppose there is a serial port on this box you can use
For a serial console to capture the dmesg and /proc/interrupts?

I assume that this is a PIC-mode box and it doesn't have an IOAPIC?
Sometimes "nolapic" is needed to make such boxes work (stab in dark)
Or you can build the kernel w/o LOCAL APIC support.

IRQs get disabled if the kernel gets a bunch of interrupts on an IRQ but
doesn't find an interrupt handler to handle them.  This can be caused by
just about any mis-configuration, including reversing the polarity of
the interrupt, or assigning the device to an IRQ it isn't physically
attched to.  You might be able to get the system up for further
debugging if disable the disabling of the IRQ and just weather the
interrupt storm so that you can get some packets through your ethernet.

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Carlos Noguera
> Sent: Thursday, December 18, 2003 6:07 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] HELP! Compaq TC1000 ACPI - Disable IRQ #9
>=20
>=20
> I own a Compaq TC1000 Tablet PC and have been trying to get Gentoo
> running on it, using the love-sources 2.6.0-test11-love 4 + ACPI patch
> set (from
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patche
s/test/2.6.0-test11/ ).

No matter what I do, nor what kernel options I throw at it (including
acpi=3Doff), if the keyboard/mouse combo don't sense activity (i.e.
keypress) I get a message of "Disable IRQ #9" during bootup. This
usually occurs around the enabling hotplug stage.

The worse part is that this IRQ is shared among my OHCI controller AND
my eth0, so if it's disabled I have no way to log into the machine.

I've looked and looked all over the mailing lists and applied all sorts
of pathes, to no avail. If I don't press keys during bootup, I get no
keyboard or ethernet. :-/

Thanks in advance for your help...
[C]arlos



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for
IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys
admin.
Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
