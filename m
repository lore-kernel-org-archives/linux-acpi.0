From: Dave Jones <davej@redhat.com>
Subject: Re: SMP broken on pre-ACPI machine.
Date: Thu, 19 Oct 2006 19:20:59 -0400
Message-ID: <20061019232059.GA2409@redhat.com>
References: <20061018222433.GA4770@redhat.com> <200610190133.40581.len.brown@intel.com> <20061019191644.GE26530@redhat.com> <20061019201116.GG26530@redhat.com> <1161296239.17335.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:16324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946664AbWJSXVb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 19:21:31 -0400
Content-Disposition: inline
In-Reply-To: <1161296239.17335.151.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, Oct 19, 2006 at 11:17:19PM +0100, Alan Cox wrote:
 > Ar Iau, 2006-10-19 am 16:11 -0400, ysgrifennodd Dave Jones:
 > > On Thu, Oct 19, 2006 at 03:16:44PM -0400, Dave Jones wrote:
 > > 
 > >  > Why smp_found_config isn't set in that guys configuration is a mystery to me,
 > >  > as his MPS tables look sane..
 > >  > 
 > >  > MP Table:
 > >  > #	APIC ID	Version	State		Family	Model	Step	Flags
 > >  > #	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381
 > 
 > Isn't that an "overdrive" ? if so it isn't supposed to be SMP capable

I don't think so. The only overdrive that fitted in a socket 8 board
was a PPro->PentiumII thing, which would be model 3 stepping 2 as far
as I can figure out from a lengthy archeology trip through developer.intel.com.

There were also some Socket8->Socket370 convertors, but afaik they just passed
through the family/model/stepping of whatever was plugged into them.

	Dave

-- 
http://www.codemonkey.org.uk
