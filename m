From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT on Averatec 1050
Date: Thu, 11 May 2006 18:42:44 +0200
Message-ID: <1147365765.9319.271.camel@queen.suse.de>
References: <44635E8A.406@gmx.at>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39610 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030324AbWEKQkz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 12:40:55 -0400
In-Reply-To: <44635E8A.406@gmx.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Wagner <paul_spam@gmx.at>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com

On Thu, 2006-05-11 at 17:55 +0200, Paul Wagner wrote:
> Hi Folks,
> 
> tried to get Linux (Slackware 10.1 with Kernel 2.6.13) to run on my 
> Averatec 1050. Unfortunately, ACPI doesn't work as supposed: No thermal 
> zones, no fan, no CPU temperature, kernel error messages (see below).
> 
> I disassembled the DSDT, and recompiled it using Intels iasl, and got a 
> bunch of error and warnings (see below). Unfortunately, I do not 
> understand a single bit of this ASL code, and the manual doesn't really 
> help me much. I figured out how to get rid of one error (the field 
> thing), but I do not have the slightest idea how to handle the others.
> 
> Can anybody please help or point me to some source of help with this 
> damn DSDT thing? I googled a lot last night, but weren't too successful.
> 
> dsdt.dsl  1649:                         OperationRegion (IO, SystemIO, 
> DPRT, 0x05)
> Error    4094 -                                           ^ parse error, 
> unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
> PARSEOP_NAMESTRING
> 
> dsdt.dsl  1650:                         Field (IO, ByteAcc, Lock, Preserve)
> Error    4094 -                                 ^ parse error, 
> unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
> PARSEOP_NAMESTRING
> 
> dsdt.dsl  1657:                         Field (IO, ByteAcc, Lock, Preserve)
> Error    4094 -                                 ^ parse error, 
> unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
> PARSEOP_NAMESTRING

You can workaround by renaming the field to XIO...

I send a patch to fix that long time ago... cannot find it anymore.
The problem is that IO is a keyword and the compiler does not notice
that it should be taken as a new Field definition here (same for REG and
DMA keywords?).

I thought this was added to acpica? Hopefully someone still has it lying
around or I can redo if it will be picked up.


---------------------------------------------------------------

For these object not exist messages:
dsdt.dsl  1929:                                     Store (Arg0, DAT0)
Error    4062 -                               Object does not exist ^ 
(DAT0)

You need to add addtional external (DAT0) statements at the beginning of
your DSDT.
These variables are probably defined in SSDT. I think you have to
replace DAT0 with the whole path e.g. \_SB.xy.DAT0.

---------------------------------------------------------------

You probably have to increase the Operation Region size of the Operation
Region that corresponds to that field.

dsdt.dsl   513:                         C0E0,   8,
Error    4027 -                            ^ Access width of Field Unit 
extends beyond region limit

Correct Example (Operation Region size is 0x1 byte (this is the one you
have to increase) and Field \DEBG is one byte (DBGP has 8 bit):
   OperationRegion (\DEBG, SystemIO, 0x1080, 0x01)
    Field (\DEBG, ByteAcc, NoLock, Preserve)
    {
        DBGP,   8
    }

Incorrect Example (Operation Region size is 1 byte and Field \DEBG has
two bytes):
   OperationRegion (\DEBG, SystemIO, 0x1080, 0x01)
    Field (\DEBG, ByteAcc, NoLock, Preserve)
    {
        DBGP,   8
        DBXY,   8
    }

---------------------------------------------------------------

The kernel sometimes (at boot and during operation) says:

     ACPI-0142: *** Error: Store into Alias - should never happen
     ACPI-1172: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_._Q0C] (Node c14b4c20), AE_AML_INTERNAL

This sounds unrelated to your DSDT errors, but sever. Robert extended
the Alias stuff some months ago, maybe something slipped in...

Best is you point us to the whole acpidump and whole dmesg output.

       Thomas

