From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
Date: Thu, 27 Mar 2008 09:28:41 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A404800C83@orsmsx415.amr.corp.intel.com>
References: <200803261400.22662.lenb@kernel.org> <B28E9812BAF6E2498B7EC5C427F293A4048009DF@orsmsx415.amr.corp.intel.com> <200803270128.33013.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51856 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100AbYC0QcI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2008 12:32:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803270128.33013.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: aystarik@gmail.com, "Lin, Ming M" <ming.m.lin@intel.com>, "Therien, Guy" <guy.therien@intel.com>

The disassembler dumps out the actual code -- including namesegs and
namepaths -- as they appear in the AML. I don't want the disassembler
changing or embellishing anything, I want to see the original ASL.

Bob


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Wednesday, March 26, 2008 10:29 PM
>To: Moore, Robert; linux-acpi@vger.kernel.org
>Cc: aystarik@gmail.com; Lin, Ming M
>Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
>
>Bob,
>Wouldn't it be less confusing if the dis-assembler
>also adding the trailing underscores to match what
>is actually done by the interpreter?
>
>thanks,
>-Len
>
>On Wednesday 26 March 2008, Moore, Robert wrote:
>> References, ACPI specification 3.0b:
>>
>>
>> 5.3  ACPI Namespace
>>
>> By convention, when an ASL compiler pads a name shorter than 4
>> characters, it is done so with trailing underscores ('_'). See the
>> language definition for AML NameSeg in Section 16, "ACPI Source
Language
>> Reference."
>>
>> (Reference should point to section 18, AML reference)
>>
>>
>>
>> 18.2.2   Name Objects Encoding
>>
>> NameSeg            := <LeadNameChar NameChar NameChar NameChar>
>> // Notice that NameSegs shorter than 4 characters are filled with
>> // trailing underscores ('_'s).
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Moore, Robert
>> Sent: Wednesday, March 26, 2008 6:59 PM
>> To: 'Len Brown'
>> Cc: 'aystarik@gmail.com'; Lin, Ming M
>> Subject: RE: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
>> 2.6.25-rc6)
>>
>> Whenever an ACPI namepath is parsed (each 4 character name within a
>> namepath is called a "nameseg"), each nameseg is padded out with
>> underscores if it is shorter than 4 characters. This happens whenever
a
>> named object is created and whenever a reference to a name is
>> encountered.
>>
>> Thus, internally, ALL namesegs are exactly 4 characters, no need to
add
>> code to handle variable-length namesegs.
>>
>> Thus, smaller code and fewer bugs. This is also mentioned in the ACPI
>> spec somewhere.
>>
>> Bob
>>
>>
>> Example:
>>
>> Name (I, 0x1234)
>>
>> Will be entered into the namespace as
>>
>> I___
>>
>> A reference to I such as
>>
>> Store (\DEV0\I, Local0)
>>
>> Will convert "I" to "I___" during AML parsing.
>>
>>
>>
>> -----Original Message-----
>> From: Len Brown [mailto:lenb@kernel.org]
>> Sent: Wednesday, March 26, 2008 11:00 AM
>> To: Moore, Robert
>> Subject: Fwd: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
>> 2.6.25-rc6)
>>
>> Bob,
>> can you comment on this thread?
>>
>> thanks,
>> -Len
>>
>> ----------  Forwarded Message  ----------
>>
>> Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for
2.6.25-rc6)
>> Date: Wednesday 26 March 2008
>> From: Alexey Starikovskiy < aystarik@gmail.com >
>> To: Bjorn Helgaas <bjorn.helgaas@hp.com>
>>
>> Bjorn Helgaas wrote:
>> > I'm curious about how this works.  I disassembled the DSDT from
>> > http://bugzilla.kernel.org/show_bug.cgi?id=4773 (I attached the
>> disassembly
>> > at http://bugzilla.kernel.org/attachment.cgi?id=15448&action=view),
>> and
>> > the _PRT contains "_SB" and "ISA" (no trailing underscores):
>> >
>> >                 Package (0x04)
>> >                 {
>> >                     0x000DFFFF,
>> >                     0x00,
>> >                     \_SB.PCI0.ISA.LNKA,
>> >                     0x00
>> >                 }
>> >
>> > But by the time we get to acpi_pci_irq_add_entry(), we've added the
>> > underscores somewhere (see
>> > http://bugzilla.kernel.org/attachment.cgi?id=15423&action=view):
>> >
>> >   0000:00:0d[A] -> \_SB_.PCI0.ISA_.LNKA
>> >
>> > I don't know where this happens, but it certainly confused me, and
>> > it seems like it could lead to other bugs.
>> >
>> ACPI is supposed to add trailing underscore for pad all names to 4
>> bytes.
>> So ISA will be padded to ISA_.
>>
>> Regards,
>> Alex.
>>
>> -------------------------------------------------------
>>
>

