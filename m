From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
 kernel paging request at virtual address 6b6b6ceb -- EIP is at
 module_put+0x7/0x1f
Date: Tue, 27 Mar 2007 21:27:19 -0700
Message-ID: <20070327212719.68c7729f.akpm@linux-foundation.org>
References: <20070322095232.f992794a.akpm@linux-foundation.org>
	<1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
	<20070323051613.GA9560@kroah.com>
	<1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
	<20070328041958.GA7669@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:52992 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbXC1E1W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 00:27:22 -0400
In-Reply-To: <20070328041958.GA7669@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Tue, 27 Mar 2007 21:19:58 -0700 Greg KH <greg@kroah.com> wrote:

> On Wed, Mar 28, 2007 at 11:52:33AM +0800, Shaohua Li wrote:
> > +static void cpuidle_state_sysfs_release(struct kobject *kobj)
> > +{
> > +	/* Nothing required to do here, just workaround kobject warning*/
> > +}
> 
> NO!!!

heh.  This happens rather a lot.
 
> Do people think that I add warnings to the kernel so that people can
> just work around them by passing empty functions to the driver core?
> 
> Sometimes I wonder why I even try...
> 
> Please fix this code, it is wrong.
> 

Is it documented anywhere?  I always forget the reasoning so I have to
cc you each time I see it happening.
