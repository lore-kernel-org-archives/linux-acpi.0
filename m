From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: ACPI dsdt.dsl Compilation Parse Error
Date: Tue, 31 Jan 2006 19:17:56 +0300
Message-ID: <43DF8DB4.3060404@linux.intel.com>
References: <loom.20060130T170445-625@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:33977 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751113AbWAaQSD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2006 11:18:03 -0500
In-Reply-To: <loom.20060130T170445-625@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy <winxp_escapee@btinternet.com>
Cc: linux-acpi@vger.kernel.org

Andy wrote:
> I'm trying to debug ACPI on an emachines 2220, D845GVSR motherboard,   
> SR84510B.44T.009.PO3 system BIOS running Suse 9.3 Pro' Linux.  
>   
> When I attempt to recompile the dsdt.dsl file I get a Parse error,  
>   
> Suse:~ # iasl -tc dsdt.dsl  
>   
> Intel ACPI Component Architecture  
> ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19 20  
> 05]  
> Copyright (C) 2000 - 2005 Intel Corporation  
> Supports ACPI Specification Revision 3.0  
>   
> dsdt.dsl  3531:     If (SS1)  
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF  
>   
> ASL Input:  dsdt.dsl - 3797 lines, 118111 bytes, 1730 keywords  
> Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations  
> Suse:~ #

iasl barks on 'if' statements in global scope. In your case you can 
safely remove this 'if' (but leave everything inside braces), just 
because it's evaluated to true (you don't disable S1 sleep in BIOS, do 
you?).

Regards,
	Alex.

