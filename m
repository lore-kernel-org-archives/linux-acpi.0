From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: DSDT table help
Date: Tue, 30 Sep 2003 10:02:12 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930095810.H81128@root.org>
References: <1064869815.28949.45.camel@loke> <20030930090253.GZ11391@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030930090253.GZ11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Martin List-Petersen <martin-4su4RWpjsplNbBYsakfBHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Sep 2003, Ducrot Bruno wrote:
> On Mon, Sep 29, 2003 at 11:10:15PM +0200, Martin List-Petersen wrote:
> > Hi,
> > i would like to have some help with some DSDT table errors, if anybody
> > cares:
> >
> > --------------------------------
> > This is the first machine:
> > ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
> > 2003]
> > Copyright (C) 2000 - 2003 Intel Corporation
> > Supports ACPI Specification Revision 2.0b
> >
> > dsdt.asl   379:             If(\_OSI) {
> > Error    1028 -  Too few arguments ^  (\_OSI requires 1)
> >
> > dsdt.asl   380:                 "Windows 2001"
> > Error    1037 -                              ^ parse error, unexpected
> > PARSEOP_STRING_LITERAL
>
> known issue with acpidump from FreeBSD (and all backport to others OS).
> I don't think the maintainer of this tool will update it.  Use iasl -d instead.

This is wrong.  acpidump(8) on FreeBSD uses iasl(8) as the backend.
acpidump does the physmem table accesses and iasl does the parsing of the
DSDT.  I maintain it and commit updates to it regularly.

For an example of our output, see:
  http://root.org/~nate/acpi/ibm-acpidump.asl.gz

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
