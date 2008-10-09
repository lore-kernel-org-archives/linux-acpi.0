From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: Buggy BIOS on the HP TX2500-series
Date: Thu, 09 Oct 2008 14:43:43 +0800
Message-ID: <1223534623.22227.17.camel@minggr.sh.intel.com>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
	 <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
	 <20081009011150.GA7496@srcf.ucam.org>
	 <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain>
	 <4911F71203A09E4D9981D27F9D83085803123055@orsmsx503.amr.corp.intel.com>
	 <1223534376.2735.111.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53585 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbYJIGqI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 02:46:08 -0400
In-Reply-To: <1223534376.2735.111.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 2008-10-08 at 23:39 -0700, Zhang, Rui wrote:
> On Wed, 2008-10-08 at 21:16 -0700, Moore, Robert wrote:
> > I believe that our "fix" for implicit return to make it Windows compatible should resolve the issue.
> >
> hmm, what's the fix?
> what's the return value of acpi_evaluate_integer("_CRT"), 0 or an error
> code?

Take below _CRT as example, it returns 0(predicate value of
LLess) with the latest CA code.

       Method (_CRT, 0, Serialized)
       {
           If (LLess (OSYS, 0x07D6))
           {
               If (LEqual (\_SB.TJ85, Zero))
               {
                   Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
               }
               Else
               {
                   Return (Add (0x0AAC, Multiply (TP85, 0x0A)))
               }
           }
       }

Lin Ming

> 
> thanks,
> rui
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Len Brown
> > Sent: Wednesday, October 08, 2008 7:05 PM
> > To: Matthew Garrett
> > Cc: Zhang, Rui; Gandalf Kristensen; linux-acpi@vger.kernel.org; Rafael J. Wysocki; Lin, Ming M
> > Subject: Re: Buggy BIOS on the HP TX2500-series
> >
> >
> >
> > On Thu, 9 Oct 2008, Matthew Garrett wrote:
> >
> > > On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
> > > > On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > > > > A patch went into the kernel earlier this year to ignore critical trip
> > > > > points that were below 0.
> > > > well, I think this patch is wrong.
> > > > a critical trip point below 0 Celsius doesn't mean it's invalid.
> > >
> > > I think it's pretty clear that a critical trip point below 0 celsius
> > > means that the critical trip point is invalid, though I agree that
> > > ignoring the entire thermal zone as a result is somewhat unfortunate.
> > >
> > > > windows can work well on this laptop.
> > > > please look at:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> > > > IMO, we need to fix the ACPICA code first of all.
> > > >
> > > > Ming, what do you think of the patch in comment #15 and #16?
> > >
> > > We could quibble over the technical correctness of this approach, but it
> > > seems to behave in exactly the same way - ie, Linux will ignore the
> > > thermal zone? The existing code seems fine, other than the fact that a
> > > bad _CRT will result everything failing. I think we'd be better off just
> > > losing the return -ENODEV there and try to use as much of the thermal
> > > information as we can.
> >
> > right, when we put in the workaround we observed that a bad _CRT
> > would delete an entire thermal zone, and that could be a big
> > problem on a box with active cooling on that thermal zone.
> >
> > of course if we are successful on the implicit return front,
> > this becomes unnecessary.
> >
> > -Len
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

