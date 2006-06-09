From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.17-rc6-mm1 -- acpi_processor-0731 [00]processor_preregister_: Error while parsing _PSD domain information.Assuming no coordination
Date: Fri, 9 Jun 2006 13:31:13 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A46CD915@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29499 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932328AbWFIUeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2006 16:34:31 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, trenn@suse.de, "Brown, Len" <len.brown@intel.com>
Cc: Miles Lane <miles.lane@gmail.com>, linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

In this case, the raw SSDT is indeed either corrupted or ill-formed.

The internal package length of the _PSD is incorrect in both cases. The
AML parser must terminate a "package" at the end specified in the AML.
In this case, the length is wrong (too small) and parsing continues in
the middle of the data of the actual package object, causing the errors.

Bob


> -----Original Message-----
> From: Moore, Robert
> Sent: Friday, June 09, 2006 10:28 AM
> To: 'trenn@suse.de'; Brown, Len
> Cc: Andrew Morton; Miles Lane; linux-acpi@vger.kernel.org; Pallipadi,
> Venkatesh
> Subject: RE: 2.6.17-rc6-mm1 -- acpi_processor-0731
> [00]processor_preregister_: Error while parsing _PSD domain
> information.Assuming no coordination
> 
> 
> Disassembly errors:
> 
> ACPI Error (psloop-0268): Found unknown opcode FD at AML address
004C029B
> offset C7, ignoring [20060608]
> ACPI Error (psloop-0268): Found unknown opcode FD at AML address
004C036B
> offset 197, ignoring [20060608]
> ACPI Error (psloop-0268): Found unknown opcode FD at AML address
004C029B
> offset C7, ignoring [20060608]
> ACPI Error (psloop-0268): Found unknown opcode FD at AML address
004C036B
> offset 197, ignoring [20060608]
> 
> This looks very interesting, I'll look into it.
> 
> Any issues like this, please forward to me.
> 
> Thanks,
> Bob
> 
> 
> > -----Original Message-----
> > From: Thomas Renninger [mailto:trenn@suse.de]
> > Sent: Friday, June 09, 2006 7:48 AM
> > To: Brown, Len
> > Cc: Andrew Morton; Miles Lane; linux-acpi@vger.kernel.org;
Pallipadi,
> > Venkatesh; Moore, Robert
> > Subject: RE: 2.6.17-rc6-mm1 -- acpi_processor-0731
> > [00]processor_preregister_: Error while parsing _PSD domain
> > information.Assuming no coordination
> >
> > On Thu, 2006-06-08 at 02:27 -0400, Brown, Len wrote:
> > > This is -mm only (there is no _PSD parsing in Linus' tree)
> > > It is benign.
> > > We'll fix it before 2.6.18.
> >
> > This is probably the same I saw recently when trying to disassemble
an
> > SSDT (with ACPICA 27-01-2006).
> >
> > Here is the plain table, hopefully it helps to fix that.
> > You should already get errors in the beginning of .dsl output file
when
> > trying to disassemble it.
> >
> >   Thomas
