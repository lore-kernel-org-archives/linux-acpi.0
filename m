From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Fri, 16 Jan 2009 10:10:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901161005130.2417-100000@iolanthe.rowland.org>
References: <1232087042.4902.0.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39682 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760153AbZAPPKY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 10:10:24 -0500
In-Reply-To: <1232087042.4902.0.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 16 Jan 2009, Zhao Yakui wrote:

> Hi, Alan
>     We do a test on the laptop based on intel ICH9 chipset. In the test
> the UHCI HCD driver is not loaded in the boot phase. A low-speed USB
> mouse is plugged. In such case the USB mouse is not detected. After the
> boot is finished, the uhci hcd driver is loaded manually. Then USB mouse
> is loaded and can work well.
>     Is this different with that EHCI driver is resumed before UHCI
> driver?

I don't understand your question.  Can you rephrase it more explicitly?

>     Do there exist the rediscovery and re-enumberation for the low-speed
> device if the EHCI driver resume is finished before the UHCI driver?

I still don't understand.  You said your test involved booting without
uhci-hcd, then plugging in a mouse, then loading uhci-hcd manually.  
The test did not involve suspending or resuming.  So why ask a question
about EHCI driver resume?  The question has nothing to do with the
test.

Alan Stern

