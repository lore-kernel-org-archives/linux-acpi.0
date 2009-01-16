From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci
	devices on bus 0
Date: Fri, 16 Jan 2009 14:24:02 +0800
Message-ID: <1232087042.4902.0.camel@yakui_zhao.sh.intel.com>
References: <Pine.LNX.4.44L0.0812232146040.8076-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33560 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbZAPGMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 01:12:50 -0500
In-Reply-To: <Pine.LNX.4.44L0.0812232146040.8076-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2008-12-24 at 10:47 +0800, Alan Stern wrote:
> On Wed, 24 Dec 2008, Zhang Rui wrote:
> 
> > Then I have a question, what if the uchi_hcd is not loaded?
> > the ehci host controller doesn't work in this case?
> 
> It does work.  But it handles only high-speed devices; low-speed and 
> full-speed devices will be ignored (unless they are connected through 
> a high-speed hub).
Hi, Alan
    We do a test on the laptop based on intel ICH9 chipset. In the test
the UHCI HCD driver is not loaded in the boot phase. A low-speed USB
mouse is plugged. In such case the USB mouse is not detected. After the
boot is finished, the uhci hcd driver is loaded manually. Then USB mouse
is loaded and can work well.
    Is this different with that EHCI driver is resumed before UHCI
driver?
    Do there exist the rediscovery and re-enumberation for the low-speed
device if the EHCI driver resume is finished before the UHCI driver?
    
thanks.
     
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

