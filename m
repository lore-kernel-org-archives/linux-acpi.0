From: Myron Stowe <mstowe@redhat.com>
Subject: RE: kernel oops and panic in acpi_atomic_read under 2.6.32
Date: Mon, 05 Mar 2012 21:06:07 -0700
Message-ID: <1331006767.2411.69.camel@zim.stowe>
References: <1330993165.2411.64.camel@zim.stowe>
	 <CA2E3DE2DD06CA4FA11644750E4E292F0FE45B43@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757890Ab2CFEGa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2012 23:06:30 -0500
In-Reply-To: <CA2E3DE2DD06CA4FA11644750E4E292F0FE45B43@SHSMSX102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Tue, 2012-03-06 at 01:53 +0000, Huang, Ying wrote:
> Hi, Myron,
> 
> Thanks for your work and analysis.
> 
> > This leads me to believe that the mapping for the error status register,
> > which is put in place by ghes_new(), is silently failing.  The other
> > possibility is that the mapping was un-mapped at some point.
> 
> > My current guess is that the mapping is failing due to the GAR in
> > question residing within ACPI's NVS.
> 
> The ACPI's NVS works for ioremap when used by ACPI itself.

Could you elaborate a little more.  I'm guessing by "works when used by
ACPI itself" you mean when not used in conjunction with error injection?

>   So I guess it may be unmapped some place.  One way to check that is
> to print out current mappings when we do mapping and unmapping in
> atomicio.c.  But now I am in travelling, so I can only write the debug
> patch after returning to office in about 1 week.  Do you have time to
> do that?

No problem, I can handle that.  Hope you trip goes well.

Thanks,
 Myron
> 
> Best Regards,
> Huang Ying
> 


