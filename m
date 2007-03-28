From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Wed, 28 Mar 2007 14:49:12 +0800
Message-ID: <1175064552.10661.17.camel@sli10-conroe.sh.intel.com>
References: <20070322095232.f992794a.akpm@linux-foundation.org>
	 <1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
	 <20070323051613.GA9560@kroah.com>
	 <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
	 <20070328041958.GA7669@kroah.com>
	 <20070327212719.68c7729f.akpm@linux-foundation.org>
	 <20070328045124.GA8156@kroah.com>
	 <1175058836.10661.6.camel@sli10-conroe.sh.intel.com>
	 <20070328052706.GA9459@kroah.com>
	 <1175060366.10661.13.camel@sli10-conroe.sh.intel.com>
	 <20070328055825.GA10064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4002 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964813AbXC1GwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 02:52:03 -0400
In-Reply-To: <20070328055825.GA10064@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-03-27 at 22:58 -0700, Greg KH wrote:
> On Wed, Mar 28, 2007 at 01:39:26PM +0800, Shaohua Li wrote:
> > On Tue, 2007-03-27 at 22:27 -0700, Greg KH wrote:
> > > 
> > > Putting more than one kobject in the same structure is a broken design.
> > > How can you control the lifetime rules properly if there are two
> > > reference counts for the same structure?  It doesn't work.
> > > 
> > > If you really need something like this, then just use a pointer to a
> > > kobject for one of them instead of embedding it.  Why do you need two
> > > different kobjects here?
> > Our data structure is something like below:
> > 
> > struct foo {
> > 	kobject kobja;
> > }
> > 
> > struct bar {
> > 	struct foo foo[];
> 
> Ick, don't do that...
why?
> > 	kobject kobjb
> > }
> > 
> > kobjb's .release will free struct bar. kobjb is the parent of kobja. if
> > you have a reference on kobja, then kobjb can't be released too, right?
> > So we only kobjb provide a .release to free the memory, kobja's .release
> > isn't required.
> 
> Why not just use the "normal" parent/child relationship with the
> kobjects like the rest of the kernel does?
I still didn't get the reason why we couldn't do this in the way of my
patch. As I said, there isn't risk to use 'freed memory'. I can make the
'struct foo' a pointer, but this will mess the cpuidle driver.

Thanks,
Shaohua
