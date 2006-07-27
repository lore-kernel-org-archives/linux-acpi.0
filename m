From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI Errors for Dimension 8250
Date: Thu, 27 Jul 2006 08:09:20 +0200
Message-ID: <1153980560.4302.138.camel@queen.suse.de>
References: <4be0d0b30607251754t1bd64bbs65b344023b34997f@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:37849 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932515AbWG0GG3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 02:06:29 -0400
In-Reply-To: <4be0d0b30607251754t1bd64bbs65b344023b34997f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Altobelli <acocaracha@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2006-07-25 at 20:54 -0400, John Altobelli wrote:
> Hello,
> 
> I have a dell dimension 8250 and after compiling the dsdt.dsl file I
> get the following errors:
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20060512 [Jul 15 2006]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
> 
> dsdt.dsl   356:         Notify (\_SB.PCI0.ISA.KBD, 0x02)
> Error    4062 -           Object does not exist ^  (\_SB.PCI0.ISA.KBD)
These are probably all declared in a SSDT.
> 
> dsdt.dsl   666:                 Method (_S5D, 0, NotSerialized)
> Warning  1097 -      Unknown reserved name ^  (_S5D)
Uncritical
> 
> dsdt.dsl  1331:                 Device (DMA)
> Error    4094 -                           ^ syntax error, unexpected
> PARSEOP_DMA, expecting PARSEOP_NAMESEG or PARSEOP_NAMESTRING
iasl error... somewhat ugly, I reask whether these nameclashes can be
fixed somewhat more generic than adding fixed string tokens to device
method declarations in yacc.
Renaming all DMA to e.g. _DMA_ (beside the ones where the DMA keyword
should be used, not sure if there is case in your DSDT) should work
around that.
> 
> dsdt.dsl  1504:                 Field (\_SB.PCI0.ISA.COM, ByteAcc,
> NoLock, Preserve)
> Error    4062 -                  Object does not exist ^  (\_SB.PCI0.ISA.COM)
see above
...
> dsdt.dsl  2906: }
> Error    4094 - ^ syntax error, unexpected '}', expecting $end
Don't know, follow up error from above?

Better get the latest acpica-unix from:
http://developer.intel.com/technology/iapc/acpi/downloads.htm

Use acpidump, do not cp /proc/acpi/dsdt (this one is going to vanish
sooner or later).
Then use the compiled acpixtract from acpica-unix (not the perl one from
pmtools, that one gets obsolete). You now should get several tables
DSDT.dat SSDT1.dat SSDT2.dat ...

If you cut of the header (and closing '}' at the end of the table) of
the SSDTs and C&P them to the end of the DSDT (inside the last closing
'}') everything should compile fine.

The latest iasl compiler should add External statements at the beginning
of the disassembled table, but this does not work perfectly yet.
You can:
iasl -e TABLE_WITH_EXTERNAL_DECLARATIONS.aml -d TABLE_TO_DISASSEMBLE.aml
to let iasl resolve External symbols correctly.
But this is also not fully (not at all..) implemented.

I am currently playing with that, can you send me your acpidump output,
please.

Thanks,

     Thomas

