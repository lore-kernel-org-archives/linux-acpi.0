From: Len Brown <lenb@kernel.org>
Subject: Re: new pmtools available for testing
Date: Mon, 11 Dec 2006 13:20:18 -0500
Message-ID: <200612111320.19183.lenb@kernel.org>
References: <45634459.8040404@linux.intel.com> <20061210155015.GA13555@inferi.kami.home> <457C3FC4.8070804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49555 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762986AbWLKSRd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Dec 2006 13:17:33 -0500
In-Reply-To: <457C3FC4.8070804@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, robert.moore@intel.com
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

Bob,
Any chance you could tweak the C acpixtract so it can handle
the parameter format of the old perl script?

I like the newer way better, but it looks like  backwards compatibility
is within our grasp without mucking it up, so I think we should do it.

On Sunday 10 December 2006 12:11, Alexey Starikovskiy wrote:
> Mattia Dongili wrote:
> > On Tue, Nov 21, 2006 at 09:24:25PM +0300, Alexey Starikovskiy wrote:
> >   
> >> Hi,
> >>
> >> acpixtract perl-script is being replaced by C xtract utility. Please test.
> >>     
> >
> > Hello, I'm considering an update to the acpidump Debian package, so is
> > this version (20061121) available online somewhere?
> > Should it just appear in Len's kernel.org FTP when it's ready?
> >
> > Thanks
> >   
> Len is about to put 20061130 version out, with acpixtract from ACPI CA 
> package.

Well, I pushed this up to the ftp site, and it is functional, but the problem
is that the new acpixtract from ACPICA has different parameters, so it
isn't backwards compatible with the old per acpixtract.

the examples in pmtools/README include invocations like this:
    $ cat email | ./acpixtract DSDT > DSDT
    $ cat email | ./acpixtract FACP | ./acpitbl
    $ ./acpixtract FACP acpidump.out > FACP.bin
    $ ./acpixtract -n 3 SSDT acpidump.out > SSDT3.bin

but the new acpixtract looks like this:

# ./acpixtract FACP acpidump.out > FACP.bin
# cat FACP.bin
Could not open FACP
#
# ./acpixtract -n 3 SSDT acpidump.out > SSDT3.bin
# cat SSDT3.bin
Usage: acpixtract [option] <InputFile>

Extract binary ACPI tables from text acpidump output
Default invocation extracts all DSDTs and SSDTs
Version 20060324

Options:
 -a                    Extract all tables, not just DSDT/SSDT
 -l                    List table summaries, do not extract
 -s<Signature>         Extract all tables named <Signature>

