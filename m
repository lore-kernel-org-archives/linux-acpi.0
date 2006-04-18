From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [1/2] ACPI: make _OSI strings static
Date: Tue, 18 Apr 2006 15:41:43 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4200585@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52771 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750747AbWDRWlp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2006 18:41:45 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

It would help if you could point out any instances that could benefit
from this.

> Yup, that sounds reasonable.  I confess I don't really know where
> options like that live.  include/acpi/platform/aclinux.h?  I can

Yes, that's the place. I'll add this support.

Bob

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Tuesday, April 18, 2006 3:38 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton
> Subject: Re: [1/2] ACPI: make _OSI strings static
> 
> On Tuesday 18 April 2006 16:29, Moore, Robert wrote:
> > While I'm certainly all for letting the compiler do such things, if
we
> > are going to do something like this, I would like to convert all
similar
> > instances all at once, not just onesey-twosey -- just to keep
everything
> > consistent.
> 
> Sure, that sounds fine.  I don't want to get involved in that effort
> though, because any patches I would come up with would be against the
> Linux-ized source and hence less useful to you.
> 
> > As far as the "Module Device" string, would this support not be
> > appropriate for any OS that implements this feature? If so, it
should be
> > an OS-specific header configuration option.
> 
> Yup, that sounds reasonable.  I confess I don't really know where
> options like that live.  include/acpi/platform/aclinux.h?  I can
> dream up a patch for that if you want, but it would probably depend
> on something like my first patch and it'd probably be more work for
> you to integrate than for you to just do it yourself.
> 
> > Actually, I find this even more readable:
> > #define ACPI_NUM_OSI_STRINGS    ACPI_ARRAY_SIZE
(acpi_valid_osi_strings)
> >
> > and leave the existing code as:
> > for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> 
> OK.
