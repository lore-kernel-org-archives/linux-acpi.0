From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Re: DSDT in initrd
Date: Thu, 22 May 2003 00:48:01 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2B3@orsmsx401.jf.intel.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If I may step on my soapbox...

I think the whole notion of initrd is a hack to work around the fact
that Linux traditionally has not relied on the fact that the boot loader
can load individual modules. The limitations of lilo should not be taken
to be the limitations of all boot loaders. lilo is the lowest common
denominator loader, and while we want Linux to work with it, Linux could
work *better* if we took advantage of grub's additional capabilities.

What this enables is not only an elimination of the hassle of initrd, it
enables previously unmodularizable things like ACPI, or PCI, or all the
special code needed for x86 subarchs, or whatever other code that one
machine needs (highmem?) but that most do not to now be modularized.
Linux distributions seem to need more and more kernel images for all
these weird cases that initrd doesn't solve, and this could allow them
to have *one* smaller kernel with the stuff that everyone needs, and the
installer configures the loader to load the additional pieces that the
system happens to need.

Having the modules specified individually to the bootloader makes things
simpler.
Having an in-kernel linker lets previously unmodularizable code be
modularized.

(This is only tangentially related to ACPI, but I mention it because I
see ACPI worsening the problem. What if I'm not installing on an ACPI
system? Now either a) My distro has an ACPI and non-ACPI kernel image
and installed the right one or b) I've got unused code sitting in RAM,
useless. But it's not just ACPI. I can think of a ton of different
kernel options that may cause distros to generate a combinatorial number
of kernel images. Yuck.)

OK I'm done...

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
