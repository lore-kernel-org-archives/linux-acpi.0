From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT compilation issues
Date: Fri, 18 May 2007 22:13:47 -0500
Message-ID: <1179544427.16465.46.camel@sublime.suse.de>
References: <loom.20070518T040303-255@post.gmane.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:43926 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356AbXESDNc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 May 2007 23:13:32 -0400
In-Reply-To: <loom.20070518T040303-255@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martian67 <Martian67@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 2007-05-18 at 02:17 +0000, Martian67 wrote:
> Hi, when i attempt to recompile a buggy DSDT table for my 	
> PSPA3C-MA502C, I get some compiletime errors, and i am not sure how to adress
> them properly.
> 
> I am running through this procedure as outlined @
> http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems
> 
> **************************************************************************
> 
> cat /proc/acpi/dsdt > dsdt.dat
> 
> iasl -d dsdt.dat
> 
> iasl -tc dsdt.dsl
> 
> **************************************************************************
> 
> When I attempt to  do this it results in these errors
> 
> ***************************************************************************
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20061109 [May 15 2007]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
> 
> dsdt.dsl  1773:                                 Name (_T_0, 0x00)
> Error    4081 -                     Use of reserved word ^  (_T_0)
> 
> dsdt.dsl  1851:                                 Name (_T_0, 0x00)
> Error    4081 -                     Use of reserved word ^  (_T_0)
> 
> dsdt.dsl  2145:                             Name (_T_0, 0x00)
> Error    4081 -                 Use of reserved word ^  (_T_0)
> 
> dsdt.dsl  2223:                             Name (_T_0, 0x00)
> Error    4081 -                 Use of reserved word ^  (_T_0)
Hmm, I wonder why this is reserved, but renaming all instances of _T_0
to e.g. _TX0 or whatever should solve this?
Looks like a minor bug in the ACPI disassembler for me.

> 
> dsdt.dsl  6516:             Method (BTST, 0, NotSerialized)
> Warning  1086 -                        ^ Not all control paths return a 
> value (BTST)
> 
> dsdt.dsl  6543:             Name (_HID, "*PNP0C14")
> Error    4001 -                                  ^ String must be entirely
> alphanumeric (*PNP0C14)
Remove the "*".

Could you explain why your DSDT is broken and what kind of bug you like
to fix.
To workaround ACPICA or DSDT bugs by simply overriding it is not a good
idea
as others might also slip into this. If possible, let's better try to
find a
general solution in the kernel/ACPICA code...

You also might want to open a bug report for your problem:
http://bugzilla.kernel.org

    Thomas

