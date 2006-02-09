From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [discuss] Re: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Date: Thu, 09 Feb 2006 19:56:48 +0900
Message-ID: <20060209195345.6D06.Y-GOTO@jp.fujitsu.com>
References: <20060209164036.6CFC.Y-GOTO@jp.fujitsu.com> <200602091141.44456.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:11230 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422652AbWBIK5l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 05:57:41 -0500
In-Reply-To: <200602091141.44456.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: discuss@x86-64.org, "Brown, Len" <len.brown@intel.com>, naveen.b.s@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>

> On Thursday 09 February 2006 10:50, Yasunori Goto wrote:
> 
> > Current code adds memory to ZONE_NORMAL like this.
> > But, ZONE_DMA32 is available on 2.6.15. So, I'm afraid there are
> > 2 types trouble.
> > 
> >   a) When new memory is added to < 4GB, this should be added to 
> >      Zone_DMA32.
> >      Are there any real machine which allow to add memory under
> >      4GB?
> 
> x86-64 machines usually use a continuous memory map 
> because Windows gets unhappy with too big memory holes (and even
> Linux is not completely troublefree for UP install kernels)  And for a small
> system this implies memory < 4GB.

Ah, Ok. Then, it is bug. :-P

> 
> >   b) If machine boots up with under 4GB memory, and new memory 
> >      is added to over 4GB, then kernel might panic due to Zone Normal's
> >      initialization is imcomplete.
> >   
> > Q2) 
> >   Are there any real machine which can add memory with NUMA feature?
> 
> There are and will be.

I see. I'll continue my job with x86_64 too. :-)

Thanks.

-- 
Yasunori Goto 


