From: Greg KH <greg@kroah.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle kernel paging request at virtual address 6b6b6ceb -- EIP is at module_put+0x7/0x1f
Date: Thu, 22 Mar 2007 22:16:13 -0700
Message-ID: <20070323051613.GA9560@kroah.com>
References: <20070322095232.f992794a.akpm@linux-foundation.org> <1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:49189 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbXCWFmZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Mar 2007 01:42:25 -0400
Content-Disposition: inline
In-Reply-To: <1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Fri, Mar 23, 2007 at 10:04:26AM +0800, Shaohua Li wrote:
> On Fri, 2007-03-23 at 01:52 +0800, Andrew Morton wrote:
> > 
> > It looks like the cpuidle patches are doing incorrect things
> > with their kobject protocol.
> Looks the goal to force kobject to be allocated dynamically is to
> release the memory of the kobject. But in the cpuidle case, we don't
> want to free the memory as it might be used soon.

What do you mean "used soon"?  Is this a time critical thing?

> I saw a lot of similar staff too, like 'cpu_devices' in
> arch/i386/kernel/topology.c.

The point is that kobjects should be created dynamically as they can be
referenced by different threads at different times, so you need to let
it manage the reference counting logic for you.  Don't create them
statically, it's almost always wrong.

Note, one valid use of static kobject is in struct bus_type and in some
class definitions.

So this should probably be fixed.

thanks,

greg k-h
