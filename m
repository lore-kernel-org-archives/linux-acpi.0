From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Buggy BIOS on the HP TX2500-series
Date: Wed, 8 Oct 2008 21:16:37 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085803123055@orsmsx503.amr.corp.intel.com>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
 <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
 <20081009011150.GA7496@srcf.ucam.org>
 <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47531 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759878AbYJIER3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 00:17:29 -0400
In-Reply-To: <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>

I believe that our "fix" for implicit return to make it Windows compatible should resolve the issue.

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Len Brown
Sent: Wednesday, October 08, 2008 7:05 PM
To: Matthew Garrett
Cc: Zhang, Rui; Gandalf Kristensen; linux-acpi@vger.kernel.org; Rafael J. Wysocki; Lin, Ming M
Subject: Re: Buggy BIOS on the HP TX2500-series



On Thu, 9 Oct 2008, Matthew Garrett wrote:

> On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
> > On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > > A patch went into the kernel earlier this year to ignore critical trip
> > > points that were below 0.
> > well, I think this patch is wrong.
> > a critical trip point below 0 Celsius doesn't mean it's invalid.
>
> I think it's pretty clear that a critical trip point below 0 celsius
> means that the critical trip point is invalid, though I agree that
> ignoring the entire thermal zone as a result is somewhat unfortunate.
>
> > windows can work well on this laptop.
> > please look at:
> > http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> > IMO, we need to fix the ACPICA code first of all.
> >
> > Ming, what do you think of the patch in comment #15 and #16?
>
> We could quibble over the technical correctness of this approach, but it
> seems to behave in exactly the same way - ie, Linux will ignore the
> thermal zone? The existing code seems fine, other than the fact that a
> bad _CRT will result everything failing. I think we'd be better off just
> losing the return -ENODEV there and try to use as much of the thermal
> information as we can.

right, when we put in the workaround we observed that a bad _CRT
would delete an entire thermal zone, and that could be a big
problem on a box with active cooling on that thermal zone.

of course if we are successful on the implicit return front,
this becomes unnecessary.

-Len

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
