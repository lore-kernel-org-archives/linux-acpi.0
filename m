From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Problems with the Intel IASL Compiler
Date: Wed, 4 Oct 2006 14:36:55 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40111D32F@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48186 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751154AbWJDVg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Oct 2006 17:36:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dennis Buehler <dennisbuehler@gmx.de>, linux-acpi@vger.kernel.org

Try adding
External (\_SB.PCI0.SBRG.EC0.ACIN)

Newer versions of the disassembler will automatically emit this
external.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Dennis Buehler
> Sent: Tuesday, October 03, 2006 1:14 PM
> To: linux-acpi@vger.kernel.org
> Subject: Problems with the Intel IASL Compiler
> 
> Hello members of the ACPI-devel-mailing-list,
> 
> in hope to connect to the right point of contact i send this message.
> 
> When i try to compile my dsdt.dsl i get the error message 1061.
> 
> 
> $ sudo iasl -sa dsdt.dsl
> $
> $ Intel ACPI Component Architecture
> $ ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> $ Copyright (C) 2000 - 2005 Intel Corporation
> $ Supports ACPI Specification Revision 3.0
> $
> $ dsdt.dsl  1742:                                     Store
> $ (\_SB.PCI0.SBRG.EC0.ACIN, Local0)
> $ Error    1061 - Object does not exist ^  (\_SB.PCI0.SBRG.EC0.ACIN)
> $
> $ ASL Input:  dsdt.dsl - 3456 lines, 120805 bytes, 1551 keywords
> $ Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 473
> $ Optimizations
> 
> After many hours of searching i could not find a solution for this
> problem.
> Is there anybody who knows this error and can tell me what to do to
fix
> it?
> 
> I used:
> 
> kernel
> linux 2.6.17-5-386
> 
> compiler
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
> 
> bison is installed and there was a test with flex even then flex-old
> which should be recommended/needed (says the ubuntu wiki)
> 
> hopefully
> 
> dennis from berlin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
