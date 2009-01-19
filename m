From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci
	devices on bus 0
Date: Mon, 19 Jan 2009 09:10:07 +0800
Message-ID: <1232327407.3971.23.camel@yakui_zhao.sh.intel.com>
References: <Pine.LNX.4.44L0.0901171146200.22014-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1285 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbZASA6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 19:58:37 -0500
In-Reply-To: <Pine.LNX.4.44L0.0901171146200.22014-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun, 2009-01-18 at 01:15 +0800, Alan Stern wrote:
> On Sat, 17 Jan 2009, Zhao Yakui wrote:
> 
> > The low-speed USB device is ignored by EHCI HCD, And when the uhci
> > driver is loaded after EHCI driver, the low-speed USB device can be
> > handler correctly.
> > So we hope to resume EHCI before UHCI and see whether the exists the
> > rediscovery and re-enumeration.
> 
> Okay; go ahead.  The order in which the drivers are loaded doesn't make 
> any difference.
> 
> > In fact there exists quite a lot of delay in UHCI/EHCI driver. We want
> > to use the parallel resume to reduce the resume time.
> 
> Yes, that would be nice.
> 
> > I also do another test, in which the EHCI hcd driver is resumed before
> > UHCI. This is based on Intel ICH9 chipset.
> >      >1a.0/1a.1/1a.2 is UHCI
> >      >1a.7 is EHCI 
> >      EHCI will be resumed before the corresponding UHCI.
> > 
> >     In my test there is no rediscovery and re-enumeration about
> > low-speed USB device. And after it is resumed, the two low-speed device
> > can still work well.
> 
> First, are you testing suspend-to-ram or are you testing hibernation?  
> A good test would be hibernation and unplugging/replugging the mouse
> while the system is asleep.  An even better test would be 
> unplugging/replugging the computer's power cord while it is asleep.
> 
> Second, can you provide the dmesg log showing what happens when you run
> your test using a kernel with CONFIG_USB_DEBUG enabled?
Thanks for the detailed explanation.
I test it by using suspend to ram. In such case there is no rediscovery.
Of course I will do the hibernation test and then send the detailed log
to you.
Thanks.
> 
> > So my question is whether the EHCI can be resumed before UHCI.
> 
> I'll have to see the detailed log of your test.  I know that on my 
> ICH4 system, similar tests in the past have caused rediscovery.
> 
> >  If we
> > can't, we want to do partial parallel. This means that the UHCI devices
> > will be resumed parallelly . After the UHCI resume is finished, the ECHI
> > will be resumed.  But we don't know whether the resume order of root HUB
> > should be considered.
> > If we can, it will be very simple.
> 
> That would be okay.  If each UHCI and OHCI companion controller is
> resumed before its partner EHCI controller, then the order of resuming
> the root hubs doesn't matter.
> 
> Alan Stern
> 

