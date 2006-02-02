From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI dsdt.dsl Compilation Parse Error
Date: Thu, 2 Feb 2006 14:32:12 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E043A064B@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:15084 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932362AbWBBWcQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 17:32:16 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Andy <winxp_escapee@btinternet.com>
Cc: linux-acpi@vger.kernel.org

FYI,

We changed the compiler to support this syntax in version 20050526:


Implemented support to allow Type 1 and Type 2 ASL operators to appear
at the module level (not within a control method.) These operators will
be executed once at the time the table is loaded. This type of code was
legal up until the release of ACPI 2.0B (2002) and is now supported by
the iASL compiler in order to provide backwards compatibility with
earlier BIOS ASL code.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
> Sent: Tuesday, January 31, 2006 8:18 AM
> To: Andy
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: ACPI dsdt.dsl Compilation Parse Error
> 
> Andy wrote:
> > I'm trying to debug ACPI on an emachines 2220, D845GVSR motherboard,
> > SR84510B.44T.009.PO3 system BIOS running Suse 9.3 Pro' Linux.
> >
> > When I attempt to recompile the dsdt.dsl file I get a Parse error,
> >
> > Suse:~ # iasl -tc dsdt.dsl
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19
20
> > 05]
> > Copyright (C) 2000 - 2005 Intel Corporation
> > Supports ACPI Specification Revision 3.0
> >
> > dsdt.dsl  3531:     If (SS1)
> > Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
> >
> > ASL Input:  dsdt.dsl - 3797 lines, 118111 bytes, 1730 keywords
> > Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0
Optimizations
> > Suse:~ #
> 
> iasl barks on 'if' statements in global scope. In your case you can
> safely remove this 'if' (but leave everything inside braces), just
> because it's evaluated to true (you don't disable S1 sleep in BIOS, do
> you?).
> 
> Regards,
> 	Alex.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
