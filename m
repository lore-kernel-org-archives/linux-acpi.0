From: Greg KH <greg@kroah.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Fri, 30 Mar 2007 00:51:11 -0700
Message-ID: <20070330075111.GA12031@kroah.com>
References: <20070328045124.GA8156@kroah.com> <1175058836.10661.6.camel@sli10-conroe.sh.intel.com> <20070328052706.GA9459@kroah.com> <1175060366.10661.13.camel@sli10-conroe.sh.intel.com> <20070328055825.GA10064@kroah.com> <1175064552.10661.17.camel@sli10-conroe.sh.intel.com> <20070330051825.GB26194@kroah.com> <1175236424.19154.7.camel@sli10-conroe.sh.intel.com> <20070330070547.GA5469@kroah.com> <1175238483.22293.0.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:55489 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945942AbXC3HzM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2007 03:55:12 -0400
Content-Disposition: inline
In-Reply-To: <1175238483.22293.0.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Fri, Mar 30, 2007 at 03:08:03PM +0800, Shaohua Li wrote:
> On Fri, 2007-03-30 at 00:05 -0700, Greg KH wrote:
> > 
> > I'm still confused as to why you are creating these "extra" kobjects.
> > What are they used for?
> It's for each idle state.

Where are these states in sysfs?  Is this the
/sys/devices/system/cpu/cpu0/cache/indexN directories?

thanks,

greg k-h
