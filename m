From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Error in dsdt from asus a3527nuh
Date: Tue, 9 Nov 2004 12:54:48 -0800
Message-ID: <37F890616C995246BE76B3E6B2DBE0550294974F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's not part of the ASL grammar, and iASL does not support it.

More than that, this requires interpreter support to execute this type
of orphan code during table load.

I'm sure this is something that will eventually be requested as a
workaround.

In the meantime, all such code like this should be moved under the
_SB_._INI method.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nate Lawson
> Sent: Tuesday, November 09, 2004 12:50 PM
> To: Valerio Felici
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Error in dsdt from asus a3527nuh
>=20
> Valerio Felici wrote:
> > Sorry in advance if this is the wrong ml for my question, or if this
one
> is
> > bad formed.
> >
> > I've a new asus a3527nuh. I've decompiled my dsdt and trying to
compile
> it
> > with iasl I can observe there is an error, it seems a stupid error,
but
> I'm
> > not able to solve it.
> >
> > So I've decide to post it here in attachment (tar-gzipped) so
someone
> can,
> > perhaps, debug it better than me.
> >
> > Notebook is ASUS A3N family
> > Bios is 0205 version
> >
> > Iasl Report:
> > -----
> > # iasl -tc dsdt.dsl
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20040527 [May 27
> 2004]
> > Copyright (C) 2000 - 2004 Intel Corporation
> > Supports ACPI Specification Revision 2.0c
> >
> > dsdt.dsl  7818:     If (SS1)
> > Error    1037 -      ^ parse error
> >
> > ASL Input:  dsdt.dsl - 7924 lines, 271634 bytes, 3603 keywords
> > Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0
Optimizations
>=20
> I don't know if this is the same problem but I've noticed a lot of
> systems with AML opcodes outside any method.  This is technically
> illegal but iasl should still be able to handle it.
>=20
> --
> Nate
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
