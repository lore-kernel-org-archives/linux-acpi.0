From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acpica problem?
Date: Sun, 13 Jul 2003 16:49:22 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E9701E@orsmsx401.jf.intel.com>
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
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]=20
> > [root@xxx acpi]# ./acpica-unix-20030619/compiler/iasl -g
> >=20
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20030619=20
> [Jun 30 2003]
> > Copyright (C) 2000 - 2003 Intel Corporation
> > Supports ACPI Specification Revision 2.0b
> >=20
> > Core dump
> >=20
> > I'm dooing something wrong?
> >=20
>=20
> No.  Just that '-g' is broken for age.  Apparently, nobody care to
> fix it..

A patch for this will be in the next acpica-unix release. It no longer
segfaults but -g still doesn't work. If someone wanted to do this, it
would simply be a matter of using the table-getting code from acpidmp in
osunixxf.c AcpiOsTableOverride.

Regards -- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
