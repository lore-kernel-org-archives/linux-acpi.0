From: Simon Bridge <corwin@ihug.co.nz>
Subject: RE: reality check: dsdt.dsl -> compile -> DSDT.aml -> decompile
	->DSDT.dsl but dsdt.dsl neq DSDT.dsl
Date: Mon, 30 Jan 2006 15:53:37 +1300
Message-ID: <1138589618.31634.21.camel@localhost.localdomain>
References: <971FCB6690CD0E4898387DBF7552B90E0421863E@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from grunt11.ihug.co.nz ([203.109.254.54]:50335 "EHLO
	grunt11.ihug.co.nz") by vger.kernel.org with ESMTP id S1750847AbWA3Cya
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jan 2006 21:54:30 -0500
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0421863E@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

On Wed, 2006-01-25 at 09:55 -0800, Moore, Robert wrote:
> Well, yes, if the external cannot be resolved at runtime, it will
> generate an error -- Unless you have the update to ACPICA that allows
> unresolved references within packages, AND you enable the interpreter
> slack mode.
> 
> > I got the DSDT.aml (the result of successfully compiling dsdt.dsl
> > remember) and decompiled it - the result is expected to be the same as
> > dsdt.dsl... but it wasn't! There were substantial differences. When
> this
> > new version was compiled, it produced errors.
> 
> Any disassembler is not *guaranteed* to generate the exact source code.
> I would be interested in a bit more explanation, however.
> 

Considering this reply and others, I've made some time to actually sit
down and *carefully* watch what I'm doing.

I started from scratch, so everything is clean, and ran iASL in
compatibility mode (-oa flag enabled). I kept a log of everything I did.
I figured it would help if folk didn't have to second-guess my thought
processes. Summary below - exact commands and output available.

I have discovered that decompiling seems to remove "external"
declarations.

All other changes involve substituting for "ones" and such like with the
appropriate, explicit, form needed (0x01 or 0x0001 or whatever). This
doesn't happen if iASL is run in compatibility mode.

The missing variables were:
\_PR.CPU0._PPC
Z007

If I just stick external statements for these at the top of the code, I
get the following from the compiler:
No back ptr to Op: type 8
No back ptr to Op: type 8
dsdt.dsl   150:         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
Error    1054 -                       ^ Name already exists in scope
(CPU0)

If I put the external statement after line 150 - then there are no
compiler errors. (To what extent does this matter? Is there a better way
of accommodating this?)

The remaining kernel errors are:
[4342789.367000]     ACPI-0508: *** Error: Method execution failed
[\_SB_.BAT1._BST] (Node cbed7be0), AE_NOT_FOUND
[4342819.371000]     ACPI-0362: *** Error: Looking up [Z007] in
namespace, AE_NOT_FOUND

This would seem to suggest that the external statements are removed by
decompiling (rather than compiling - whew), and that Z007 does not exist
anywhere.[1]

Perhaps the first error is the infamous acer smart-battery issue?
(Later: I see Acer 3002WLMi in the readme for the patch-set -
http://sourceforge.net/projects/sbs-linux/ -  but not 3003LC)

Anyway - it would appear I have a dsdt suitable for including in the
archive...

[1] From previous discussions - there is a patch waiting, and I can try
the latest vanilla kernel with all the acpi patches.



