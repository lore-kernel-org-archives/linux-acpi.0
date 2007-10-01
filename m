From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [Pcihpd-discuss] what is writing to /sys/bus/pci/slot/<slot_no>/power really supposed to do?
Date: Mon, 1 Oct 2007 11:39:37 -0700
Message-ID: <20071001183937.GB12905@us.ibm.com>
References: <20071001100858.06919a1e.kristen.c.accardi@intel.com> <20071001174340.GA10858@us.ibm.com> <20071001105007.a3637532.kristen.c.accardi@intel.com> <20071001183354.GA12905@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:59723 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbXJASkB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2007 14:40:01 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l91IdnOx019058
	for <linux-acpi@vger.kernel.org>; Mon, 1 Oct 2007 14:39:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l91Ideh5452426
	for <linux-acpi@vger.kernel.org>; Mon, 1 Oct 2007 12:39:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l91IddEf032418
	for <linux-acpi@vger.kernel.org>; Mon, 1 Oct 2007 12:39:39 -0600
Content-Disposition: inline
In-Reply-To: <20071001183354.GA12905@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, gregkh@suse.de, pcihpd-discuss@lists.sourceforge.net

On Mon, Oct 01, 2007 at 11:33:54AM -0700, Gary Hade wrote:
> On Mon, Oct 01, 2007 at 10:50:07AM -0700, Kristen Carlson Accardi wrote:
> > On Mon, 1 Oct 2007 10:43:41 -0700
> > Gary Hade <garyhade@us.ibm.com> wrote:
> > 
> > > On Mon, Oct 01, 2007 at 10:08:58AM -0700, Kristen Carlson Accardi wrote:
> > > > Hi,
> > > > I notice in acpiphp that the code path for powering down the slot
> > > > via sysfs does not execute the _EJ0 method, but instead simply
> > > > looks for _PS3 and of couse disables all the bridges and devices.  
> > > > I suppose this could be valid depending on your definition of what 
> > > > /sys/bus/pci/slots/<slot_no>/power should do.
> > > > 
> > > > Is it intended to just power down the adapter that's in the slot, 
> > > > or is it intended to make the adapter in the slot able to be removed?
> > > > If it's intended to make the adapter able to be removed, shouldn't
> > > > we be calling _EJ0?
> > > > 
> > > > As a comparison, in pciehp when the sysfs power file is written,
> > > > we do actually go out and send the commands to the hotplug controller
> > > > to physically power off the slot.
> > > 
> > > Kristen, This sounds a lot like the problem I was trying to address 
> > > with the "fix slot poweroff problem on systems without _PS3" patch 
> > > that I posted in June.
> > > http://sourceforge.net/mailarchive/forum.php?thread_name=20070604232736.GA3239%40us.ibm.com&forum_name=pcihpd-discuss
> > > It seems to be working fine on our systems.
> > > 
> > > Gary
> > 
> > ok - hum well, I seem to have not merged that patch for some reason, and
> > it also isn't anywhere in my inbox.  Can you resend it?  
> 
> Included below.
> 
> > Seems like we should get it in there.
> > 
> > BTW - people should copy me directly when they send their patches otherwise
> > they may get overlooked. (not that I'm saying this is what happened here,
> > it also happens sometimes that patches get buried in my inbox despite my
> > best efforts).
> 
> In this case, I did send it directly to you with 
> pcihpd-discuss@lists.sourceforge.net on gregkh@suse.de the

Oops, this line should read:
pcihpd-discuss@lists.sourceforge.net and gregkh@suse.de on the

> CC line.  You and Greg subsequently signed off on it and it 
> entered mainline at 2.6.23-rc1.
            ...

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc
