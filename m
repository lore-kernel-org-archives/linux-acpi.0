From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: DSDT on Averatec 1050
Date: Thu, 11 May 2006 10:56:30 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A44245D8@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3470 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030405AbWEKR7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2006 13:59:35 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, Paul Wagner <paul_spam@gmx.at>
Cc: linux-acpi@vger.kernel.org

May have gotten lost in the noise, please send to me.
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Thomas Renninger
> Sent: Thursday, May 11, 2006 9:43 AM
> To: Paul Wagner
> Cc: linux-acpi@vger.kernel.org; Moore, Robert
> Subject: Re: DSDT on Averatec 1050
> 
> On Thu, 2006-05-11 at 17:55 +0200, Paul Wagner wrote:
> > Hi Folks,
> >
> > tried to get Linux (Slackware 10.1 with Kernel 2.6.13) to run on my
> > Averatec 1050. Unfortunately, ACPI doesn't work as supposed: No
thermal
> > zones, no fan, no CPU temperature, kernel error messages (see
below).
> >
> > I disassembled the DSDT, and recompiled it using Intels iasl, and
got a
> > bunch of error and warnings (see below). Unfortunately, I do not
> > understand a single bit of this ASL code, and the manual doesn't
really
> > help me much. I figured out how to get rid of one error (the field
> > thing), but I do not have the slightest idea how to handle the
others.
> >
> > Can anybody please help or point me to some source of help with this
> > damn DSDT thing? I googled a lot last night, but weren't too
successful.
> >
> > dsdt.dsl  1649:                         OperationRegion (IO,
SystemIO,
> > DPRT, 0x05)
> > Error    4094 -                                           ^ parse
error,
> > unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or
> > PARSEOP_NAMESTRING
> >
> > dsdt.dsl  1650:                         Field (IO, ByteAcc, Lock,
> Preserve)
> > Error    4094 -                                 ^ parse error,
> > unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or
> > PARSEOP_NAMESTRING
> >
> > dsdt.dsl  1657:                         Field (IO, ByteAcc, Lock,
> Preserve)
> > Error    4094 -                                 ^ parse error,
> > unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or
> > PARSEOP_NAMESTRING
> 
> You can workaround by renaming the field to XIO...
> 
> I send a patch to fix that long time ago... cannot find it anymore.
> The problem is that IO is a keyword and the compiler does not notice
> that it should be taken as a new Field definition here (same for REG
and
> DMA keywords?).
> 
> I thought this was added to acpica? Hopefully someone still has it
lying
> around or I can redo if it will be picked up.
> 
> 
> ---------------------------------------------------------------
> 
> For these object not exist messages:
> dsdt.dsl  1929:                                     Store (Arg0, DAT0)
> Error    4062 -                               Object does not exist ^
> (DAT0)
> 
> You need to add addtional external (DAT0) statements at the beginning
of
> your DSDT.
> These variables are probably defined in SSDT. I think you have to
> replace DAT0 with the whole path e.g. \_SB.xy.DAT0.
> 
> ---------------------------------------------------------------
> 
> You probably have to increase the Operation Region size of the
Operation
> Region that corresponds to that field.
> 
> dsdt.dsl   513:                         C0E0,   8,
> Error    4027 -                            ^ Access width of Field
Unit
> extends beyond region limit
> 
> Correct Example (Operation Region size is 0x1 byte (this is the one
you
> have to increase) and Field \DEBG is one byte (DBGP has 8 bit):
>    OperationRegion (\DEBG, SystemIO, 0x1080, 0x01)
>     Field (\DEBG, ByteAcc, NoLock, Preserve)
>     {
>         DBGP,   8
>     }
> 
> Incorrect Example (Operation Region size is 1 byte and Field \DEBG has
> two bytes):
>    OperationRegion (\DEBG, SystemIO, 0x1080, 0x01)
>     Field (\DEBG, ByteAcc, NoLock, Preserve)
>     {
>         DBGP,   8
>         DBXY,   8
>     }
> 
> ---------------------------------------------------------------
> 
> The kernel sometimes (at boot and during operation) says:
> 
>      ACPI-0142: *** Error: Store into Alias - should never happen
>      ACPI-1172: *** Error: Method execution failed
> [\_SB_.PCI0.SBRG.EC0_._Q0C] (Node c14b4c20), AE_AML_INTERNAL
> 
> This sounds unrelated to your DSDT errors, but sever. Robert extended
> the Alias stuff some months ago, maybe something slipped in...
> 
> Best is you point us to the whole acpidump and whole dmesg output.
> 
>        Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
