From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: Toshiba ACPI battery status - ACPI errors
Date: Tue, 25 Nov 2003 13:13:40 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF9E@orsmsx401.jf.intel.com>
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
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Michael Holzt <kju-+hGXy1KyAyQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Ducrot Bruno
> > Looks good, many thanks. Now one question: Is this a bug in=20
> the kernel acpi
> > code, or in the dsdt?
> >=20
>=20
> ECDT problem (it is another acpi table, have nothing to do with DSDT).
> The manufacturer just "forgot" to create one (and therefore break
> an ACPI requirement).

Well you don't *need* an ECDT. It can make things easier since you can
access the EC before finding it in the namespace, but it's not required.

>From looking at the disassembly, it looks properly written to handle the
case where the EC device has not yet been enumerated. If DFEC is 0 then
it thinks the EC has been found. I believe the problem is that the value
defaults to 0, when it should default to 1 (not found) so control
methods properly fail (or return data that does not touch HW) before the
EC driver is loaded.

There *is* a bug in the AML, I think:
Name (\DFEC, 0x00) should be Name (\DFEC, 0x01) - i.e. the EC should
default to "not working" until the EC device is found.

The other bug this highlights is that ACPI expects the OS to call _PSx
control methods. Someone (the ACPI bus driver?) should be calling _PS0
on EC0 when the EC device is found and its driver is loaded. I don't
believe Linux is doing this yet, although it should be (and also calling
_PS3 when entering sleep states etc.) Not doing this could be the source
of lots of other bugs besides just this one.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
