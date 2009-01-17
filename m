From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Sat, 17 Jan 2009 12:15:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901171146200.22014-100000@netrider.rowland.org>
References: <1232177509.3971.18.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2954 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761667AbZAQRPD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 12:15:03 -0500
In-Reply-To: <1232177509.3971.18.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sat, 17 Jan 2009, Zhao Yakui wrote:

> The low-speed USB device is ignored by EHCI HCD, And when the uhci
> driver is loaded after EHCI driver, the low-speed USB device can be
> handler correctly.
> So we hope to resume EHCI before UHCI and see whether the exists the
> rediscovery and re-enumeration.

Okay; go ahead.  The order in which the drivers are loaded doesn't make 
any difference.

> In fact there exists quite a lot of delay in UHCI/EHCI driver. We want
> to use the parallel resume to reduce the resume time.

Yes, that would be nice.

> I also do another test, in which the EHCI hcd driver is resumed before
> UHCI. This is based on Intel ICH9 chipset.
>      >1a.0/1a.1/1a.2 is UHCI
>      >1a.7 is EHCI 
>      EHCI will be resumed before the corresponding UHCI.
> 
>     In my test there is no rediscovery and re-enumeration about
> low-speed USB device. And after it is resumed, the two low-speed device
> can still work well.

First, are you testing suspend-to-ram or are you testing hibernation?  
A good test would be hibernation and unplugging/replugging the mouse
while the system is asleep.  An even better test would be 
unplugging/replugging the computer's power cord while it is asleep.

Second, can you provide the dmesg log showing what happens when you run
your test using a kernel with CONFIG_USB_DEBUG enabled?

> So my question is whether the EHCI can be resumed before UHCI.

I'll have to see the detailed log of your test.  I know that on my 
ICH4 system, similar tests in the past have caused rediscovery.

>  If we
> can't, we want to do partial parallel. This means that the UHCI devices
> will be resumed parallelly . After the UHCI resume is finished, the ECHI
> will be resumed.  But we don't know whether the resume order of root HUB
> should be considered.
> If we can, it will be very simple.

That would be okay.  If each UHCI and OHCI companion controller is
resumed before its partner EHCI controller, then the order of resuming
the root hubs doesn't matter.

Alan Stern

