From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: DSDT table help
Date: Tue, 30 Sep 2003 11:02:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930090253.GZ11391@poupinou.org>
References: <1064869815.28949.45.camel@loke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1064869815.28949.45.camel-jtDuu3CdNeQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin List-Petersen <martin-4su4RWpjsplNbBYsakfBHQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 29, 2003 at 11:10:15PM +0200, Martin List-Petersen wrote:
> Hi,
> i would like to have some help with some DSDT table errors, if anybody
> cares:
> 
> --------------------------------
> This is the first machine:
> ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
> 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt.asl   379:             If(\_OSI) {
> Error    1028 -  Too few arguments ^  (\_OSI requires 1)
>  
> dsdt.asl   380:                 "Windows 2001"
> Error    1037 -                              ^ parse error, unexpected
> PARSEOP_STRING_LITERAL

known issue with acpidump from FreeBSD (and all backport to others OS).
I don't think the maintainer of this tool will update it.  Use iasl -d instead.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
