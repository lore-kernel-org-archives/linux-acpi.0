From: Simon Bridge <corwin@ihug.co.nz>
Subject: reality check: dsdt.dsl -> compile -> DSDT.aml -> decompile ->
	DSDT.dsl but dsdt.dsl neq DSDT.dsl
Date: Sun, 22 Jan 2006 14:52:22 +1300
Message-ID: <1137894742.11725.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from grunt8.ihug.co.nz ([203.109.254.48]:17322 "EHLO
	grunt8.ihug.co.nz") by vger.kernel.org with ESMTP id S1751247AbWAVBxM
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 20:53:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am attempting to hack my dsdt ...
There are two puzzling things here. Comment is invited.
1. what/where is RSDT
2. if I compile dsdt.dsl to get DSDT.aml, then decompile DSDT.aml to get
DSDT.dsl ... shouldn't I expect DSDT.dsl == dsdt.dsl?

here's the gory details:


machine: acer aspire 3003LC
linux: ubuntu 5.10
kernel: 2.6.12-9-686 (ubuntu standard - via apt-get)

# iasl -g

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050930 [Nov 20 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

Could not obtain RSDT
Could not get ACPI tables, AE_NO_ACPI_TABLES

... Well, OK.
/proc/acpi exists and contains a file called dsdt.

# cp /proc/acpi/dsdt dsdt.dat
# iasl -d dsdt.dat
# iasl -ta dsdt.dsl

generates a bunch of errors - I googled them, and applied the
recommended hacks until the following result:

# iasl -ta dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050930 [Nov 20 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

ASL Input:  dsdt.dsl - 3471 lines, 121247 bytes, 1565 keywords
AML Output: DSDT.aml - 13975 bytes 377 named objects 1188 executable
opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 542 Optimizations

... which seems fine so far.

# cp DSDT.amp /etc/mkinitramfs/DSDT.aml

reboot.
I see a syslog saying that this DSDT.aml is detected and loaded.
However, I get errors as follows:

ACPI-0508: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node
cbed7be0), AE_NOT_FOUND
ACPI-0362: *** Error: Looking up [Z007] in namespace, AE_NOT_FOUND

... ad infinitum.

Puzzled - especially since Z007 does not appear in dsdt.dsl (replaced by
"ones" on advice from this forum - a la acer laptops and Z007 being
nonexistant anywhere.)

OK - so I try:

# acpi -dc DSDT.aml

which provides the following error:
Error 1061 - Object does not exist (\_PR.CPU0._PPC)

This appears six times overall, across methods:
_Q8A, _Q8D, _Q8D ... which seem unhelpful.

I see /proc/acpi/processor/CPU0 contains files; 
info  limit  power  throttling

I see that _PPC is a reserved method name:
_PPC    Method with 0 arguments, must return a value

CPU0 is AMD Mobile Sempron.

So I'm starting to feel a little out to sea.
I could attempt to hack a fix for these new errors, but there's no point
if they are an artifact of the decompilation process. I've tried to test
this by compiling in compatability mode - the same error crop up,
suggesting this is no artifact. However, if I decompile an aml file with
the same compiler it was compiled with, shouldn't I end up with the same
dsl file I started out with?

I thought it may be that the computer alters the DSDT.aml it uses, but
the same result is available from a copy the computer hasn't access to.

Any comments on anything here would be appreciated.
Thanks.




