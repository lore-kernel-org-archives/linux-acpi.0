From: Andre Masella <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Subject: Re: Vaio PGC-FXA47 Troubles
Date: Wed, 21 Aug 2002 14:22:53 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208211422.53855.andre@masella.dynodns.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDBB@orsmsx119.jf.intel.com>
Reply-To: andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDBB-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On August 21, 2002 01:08 pm, Grover, Andrew wrote:
> > PCI: Using configuration type 1
> >    tbget-0133: *** Error: Could not map memory at 0fef9a51
> > for length 0
> >   tbrsdt-0257 [04] Tb_get_table_rsdt     : Could not get the
> > RSDT/XSDT,
> > AE_NO_MEMORY
> >  tbxface-0086: *** Error: Acpi_load_tables: Could not load
> > RSDT: AE_NO_MEMORY
> >  tbxface-0116: *** Error: Acpi_load_tables: Could not load tables:
> > AE_NO_MEMORY
> > ACPI: Unable to load the System Description Tables
>
> [snip]
>
> > What could be wrong?
>
> Well, why is the error at tbget.c line 133 happening?
> Why is it trying to map something of length 0?
>
> The other error messages are just the fallout of that problem.
>
> Regards -- Andy

I have no idea why it is trying to map something of length 0. I have fool=
ed=20
around the with the PCI configuration (using direct and BIOS access) and=20
changed the few settings in the BIOS (32-bit disk access, PnP OS).  That'=
s=20
all there is in the bios. That memory range is clearly inside the region=20
marked as ACPI data. I've been trying to get this system working and havi=
ng a=20
very hard time. I install Gentoo with a 2.4.18 kernel and ACPI worked. I =
then=20
started to prepare my LinuxFromScratch distro. I am using the some kernel=
=20
version and acpi-diff file that I used to make the kernel for Gentoo, but=
=20
once I switched, ACPI didn't work. They came from the same sources. The G=
CC=20
version has changed (3.1), but I tested with an old one (2.96.3) with no=20
change. In either case I recompiled the kernel several times, usually wit=
h a=20
make dist-clean first. Could there be some assembler or linker that chang=
ed=20
from Gentoo to LFS that's breaking ACPI? That seems unlikely, right?
--=20
--Andre Masella (andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org)
I don't suffer from insanity. I enjoy every minute of it.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
