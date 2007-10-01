From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] what is writing to
 /sys/bus/pci/slot/<slot_no>/power really supposed to do?
Date: Mon, 1 Oct 2007 10:50:07 -0700
Message-ID: <20071001105007.a3637532.kristen.c.accardi@intel.com>
References: <20071001100858.06919a1e.kristen.c.accardi@intel.com>
	<20071001174340.GA10858@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44423 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbXJARzV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 13:55:21 -0400
In-Reply-To: <20071001174340.GA10858@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, gregkh@suse.de

On Mon, 1 Oct 2007 10:43:41 -0700
Gary Hade <garyhade@us.ibm.com> wrote:

> On Mon, Oct 01, 2007 at 10:08:58AM -0700, Kristen Carlson Accardi wrote:
> > Hi,
> > I notice in acpiphp that the code path for powering down the slot
> > via sysfs does not execute the _EJ0 method, but instead simply
> > looks for _PS3 and of couse disables all the bridges and devices.  
> > I suppose this could be valid depending on your definition of what 
> > /sys/bus/pci/slots/<slot_no>/power should do.
> > 
> > Is it intended to just power down the adapter that's in the slot, 
> > or is it intended to make the adapter in the slot able to be removed?
> > If it's intended to make the adapter able to be removed, shouldn't
> > we be calling _EJ0?
> > 
> > As a comparison, in pciehp when the sysfs power file is written,
> > we do actually go out and send the commands to the hotplug controller
> > to physically power off the slot.
> 
> Kristen, This sounds a lot like the problem I was trying to address 
> with the "fix slot poweroff problem on systems without _PS3" patch 
> that I posted in June.
> http://sourceforge.net/mailarchive/forum.php?thread_name=20070604232736.GA3239%40us.ibm.com&forum_name=pcihpd-discuss
> It seems to be working fine on our systems.
> 
> Gary

ok - hum well, I seem to have not merged that patch for some reason, and
it also isn't anywhere in my inbox.  Can you resend it?  Seems like we
should get it in there.

BTW - people should copy me directly when they send their patches otherwise
they may get overlooked. (not that I'm saying this is what happened here,
it also happens sometimes that patches get buried in my inbox despite my
best efforts).

Thanks,
Kristen

> 
> -- 
> Gary Hade
> System x Enablement
> IBM Linux Technology Center
> 503-578-4503  IBM T/L: 775-4503
> garyhade@us.ibm.com
> http://www.ibm.com/linux/ltc
> 
