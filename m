From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci
	devices on bus 0
Date: Sat, 17 Jan 2009 15:31:49 +0800
Message-ID: <1232177509.3971.18.camel@yakui_zhao.sh.intel.com>
References: <Pine.LNX.4.44L0.0901161005130.2417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38052 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbZAQHU2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jan 2009 02:20:28 -0500
In-Reply-To: <Pine.LNX.4.44L0.0901161005130.2417-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 2009-01-16 at 23:10 +0800, Alan Stern wrote:
> On Fri, 16 Jan 2009, Zhao Yakui wrote:
> 
> > Hi, Alan
> >     We do a test on the laptop based on intel ICH9 chipset. In the test
> > the UHCI HCD driver is not loaded in the boot phase. A low-speed USB
> > mouse is plugged. In such case the USB mouse is not detected. After the
> > boot is finished, the uhci hcd driver is loaded manually. Then USB mouse
> > is loaded and can work well.
> >     Is this different with that EHCI driver is resumed before UHCI
> > driver?
> 
> I don't understand your question.  Can you rephrase it more explicitly?
> 
> >     Do there exist the rediscovery and re-enumberation for the low-speed
> > device if the EHCI driver resume is finished before the UHCI driver?
> 
> I still don't understand.  You said your test involved booting without
> uhci-hcd, then plugging in a mouse, then loading uhci-hcd manually.  
> The test did not involve suspending or resuming.  So why ask a question
> about EHCI driver resume?  The question has nothing to do with the
> test.
The low-speed USB device is ignored by EHCI HCD, And when the uhci
driver is loaded after EHCI driver, the low-speed USB device can be
handler correctly.
So we hope to resume EHCI before UHCI and see whether the exists the
rediscovery and re-enumeration.
In fact there exists quite a lot of delay in UHCI/EHCI driver. We want
to use the parallel resume to reduce the resume time.

I also do another test, in which the EHCI hcd driver is resumed before
UHCI. This is based on Intel ICH9 chipset.
     >1a.0/1a.1/1a.2 is UHCI
     >1a.7 is EHCI 
     EHCI will be resumed before the corresponding UHCI.

    In my test there is no rediscovery and re-enumeration about
low-speed USB device. And after it is resumed, the two low-speed device
can still work well.
    
So my question is whether the EHCI can be resumed before UHCI. If we
can't, we want to do partial parallel. This means that the UHCI devices
will be resumed parallelly . After the UHCI resume is finished, the ECHI
will be resumed.  But we don't know whether the resume order of root HUB
should be considered.
If we can, it will be very simple.

Thanks for your comments and advice.
Best regards
Yakui
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

