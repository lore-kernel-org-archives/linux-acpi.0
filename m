From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Wed, 28 Mar 2007 13:39:26 +0800
Message-ID: <1175060366.10661.13.camel@sli10-conroe.sh.intel.com>
References: <20070322095232.f992794a.akpm@linux-foundation.org>
	 <1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
	 <20070323051613.GA9560@kroah.com>
	 <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
	 <20070328041958.GA7669@kroah.com>
	 <20070327212719.68c7729f.akpm@linux-foundation.org>
	 <20070328045124.GA8156@kroah.com>
	 <1175058836.10661.6.camel@sli10-conroe.sh.intel.com>
	 <20070328052706.GA9459@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44388 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbXC1FmQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 01:42:16 -0400
In-Reply-To: <20070328052706.GA9459@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2007-03-27 at 22:27 -0700, Greg KH wrote:
> On Wed, Mar 28, 2007 at 01:13:56PM +0800, Shaohua Li wrote:
> > On Tue, 2007-03-27 at 21:51 -0700, Greg KH wrote:
> > > On Tue, Mar 27, 2007 at 09:27:19PM -0700, Andrew Morton wrote:
> > > > On Tue, 27 Mar 2007 21:19:58 -0700 Greg KH <greg@kroah.com> wrote:
> > > > 
> > > > > On Wed, Mar 28, 2007 at 11:52:33AM +0800, Shaohua Li wrote:
> > > > > > +static void cpuidle_state_sysfs_release(struct kobject *kobj)
> > > > > > +{
> > > > > > +	/* Nothing required to do here, just workaround kobject warning*/
> > > > > > +}
> > > > > 
> > > > > NO!!!
> > > > 
> > > > heh.  This happens rather a lot.
> > > >  
> > > > > Do people think that I add warnings to the kernel so that people can
> > > > > just work around them by passing empty functions to the driver core?
> > > > > 
> > > > > Sometimes I wonder why I even try...
> > > > > 
> > > > > Please fix this code, it is wrong.
> > > > > 
> > > > 
> > > > Is it documented anywhere?  I always forget the reasoning so I have to
> > > > cc you each time I see it happening.
> > > 
> > > The fact that the kernel itself spits out a message saying:
> > > 	"Device '%s' does not have a release() function, it is broken
> > > 	and must be fixed."
> > > 
> > > isn't enough?  What should I change it to, something like this:
> > > 
> > > 	"Device '%s' does not have a release() function, it is broken
> > > 	and must be fixed, and if you just provide an empty function to
> > > 	remove this warning, rabid echidnas will track you down and
> > > 	puncture your spleen."
> > > 
> > > 
> > > The reason for this is that the device is a reference counted object,
> > > and you have to free the memory in the release function, otherwise you
> > > can easily be accessing memory that is freed already.
> > > 
> > > Now note, this patch used a completion function to wait for the object
> > > to be destroyed, which isn't the nicest.  But if you are going to do
> > > this, do it in the release function, like the code did a bit earlier.
> > > 
> > > And if you are doing this because you have two kobjects in the same
> > > structure, well, your code is so messed up beyond belief that it needs
> > > to be fixed.  And yes scsi developers, I'm pointing at you...
> > The two kobjects will be removed in the maintime. As I wait for one
> > object to be destroyed (the two objects are in one structure, and one
> > object's release will free the memory), we haven't the 'using freed
> > memory' issue here. Do we still need a .release for the kobject you
> > pointed out?
> 
> Putting more than one kobject in the same structure is a broken design.
> How can you control the lifetime rules properly if there are two
> reference counts for the same structure?  It doesn't work.
> 
> If you really need something like this, then just use a pointer to a
> kobject for one of them instead of embedding it.  Why do you need two
> different kobjects here?
Our data structure is something like below:

struct foo {
	kobject kobja;
}

struct bar {
	struct foo foo[];
	kobject kobjb
}

kobjb's .release will free struct bar. kobjb is the parent of kobja. if
you have a reference on kobja, then kobjb can't be released too, right?
So we only kobjb provide a .release to free the memory, kobja's .release
isn't required.

Thanks,
Shaohua
