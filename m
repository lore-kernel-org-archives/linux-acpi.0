From: "Patrick J. LoPresti" <patl-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Problem with ACPI on IBM T22 (Linux 2.6.5)
Date: 25 Apr 2004 13:11:48 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <s5gfzas0z8d.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.  I use Linux 2.6.5 as the kernel for my network boot disk (see
http://unattended.sourceforge.net/).  One of my users is complaining
that my boot disk does not work on his nVidia motherboard because I
built the kernel without ACPI support.  (Why the nVidia motherboard
requires ACPI, I have no idea.)  So I am experimenting with a kernel
in which I have enabled ACPI.

This kernel also has local APIC and IO-APIC support enabled, and APM
support disabled, if that matters.  I can send the full .config if
that would be helpful.

My problem is this.  On one of my test systems (IBM Thinkpad T22), the
network driver fails to work unless I specify "acpi=off" on the kernel
command line.  Since this is supposed to be an automated and
system-independent boot disk, I want to avoid the need to pass kernel
parameters if I can.

I get this error message while loading the 3c59x driver:

  ***WARNING*** No MII transceivers found!

Then, when my boot disk attempts to grab a DHCP lease, it fails with
messages like these:


  eth0: Command 0x5800 did not complete!  Status=0xffff
  eth0: Command 0x2804 did not complete!  Status=0xffff
  eth0: Command 0x3002 did not complete!  Status=0xffff
  eth0: Command 0x3002 did not complete!  Status=0xffff
  ...

I suppose this is not surprising given the 3c59x driver's warning
message.

All of these problems vanish if I specify "acpi=off".

I am open to suggestions for how to proceed.  Thanks!

 - Pat


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
