From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: new pmtools available for testing
Date: Tue, 12 Dec 2006 14:35:21 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40186A930@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41401 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932509AbWLLWlU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2006 17:41:20 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

I can take a look at it early next year.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Len Brown
> Sent: Monday, December 11, 2006 10:20 AM
> To: Alexey Starikovskiy; Moore, Robert
> Cc: Mattia Dongili; linux-acpi@vger.kernel.org
> Subject: Re: new pmtools available for testing
> 
> Bob,
> Any chance you could tweak the C acpixtract so it can handle
> the parameter format of the old perl script?
> 
> I like the newer way better, but it looks like  backwards
compatibility
> is within our grasp without mucking it up, so I think we should do it.
> 
> On Sunday 10 December 2006 12:11, Alexey Starikovskiy wrote:
> > Mattia Dongili wrote:
> > > On Tue, Nov 21, 2006 at 09:24:25PM +0300, Alexey Starikovskiy
wrote:
> > >
> > >> Hi,
> > >>
> > >> acpixtract perl-script is being replaced by C xtract utility.
Please
> test.
> > >>
> > >
> > > Hello, I'm considering an update to the acpidump Debian package,
so is
> > > this version (20061121) available online somewhere?
> > > Should it just appear in Len's kernel.org FTP when it's ready?
> > >
> > > Thanks
> > >
> > Len is about to put 20061130 version out, with acpixtract from ACPI
CA
> > package.
> 
> Well, I pushed this up to the ftp site, and it is functional, but the
> problem
> is that the new acpixtract from ACPICA has different parameters, so it
> isn't backwards compatible with the old per acpixtract.
> 
> the examples in pmtools/README include invocations like this:
>     $ cat email | ./acpixtract DSDT > DSDT
>     $ cat email | ./acpixtract FACP | ./acpitbl
>     $ ./acpixtract FACP acpidump.out > FACP.bin
>     $ ./acpixtract -n 3 SSDT acpidump.out > SSDT3.bin
> 
> but the new acpixtract looks like this:
> 
> # ./acpixtract FACP acpidump.out > FACP.bin
> # cat FACP.bin
> Could not open FACP
> #
> # ./acpixtract -n 3 SSDT acpidump.out > SSDT3.bin
> # cat SSDT3.bin
> Usage: acpixtract [option] <InputFile>
> 
> Extract binary ACPI tables from text acpidump output
> Default invocation extracts all DSDTs and SSDTs
> Version 20060324
> 
> Options:
>  -a                    Extract all tables, not just DSDT/SSDT
>  -l                    List table summaries, do not extract
>  -s<Signature>         Extract all tables named <Signature>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
