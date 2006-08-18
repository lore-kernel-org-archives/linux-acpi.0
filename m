From: Matthew Johnson <matt@matthew.ath.cx>
Subject: Re: IRQ Mis-matches in 2.6.17.7
Date: Fri, 18 Aug 2006 09:58:36 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0608180957130.15208@illythia.matthew.ath.cx>
References: <Pine.LNX.4.63.0608110945510.15208@illythia.matthew.ath.cx>
 <200608111144.36751.len.brown@intel.com> <200608111005.59434.bjorn.helgaas@hp.com>
Reply-To: Matthew Johnson <matt@matthew.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:14726 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751303AbWHRI65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 04:58:57 -0400
In-Reply-To: <200608111005.59434.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Johnson <matt@matthew.ath.cx>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 11 Aug 2006, Bjorn Helgaas wrote:

> Is this problem new with 2.6.17.7?  On the face of it, it looks
> like every kernel should have this problem if you have other
> devices on IRQ 4.

It's a recent problem, certainly.

> Other devices (ehci_hcd:usb1  eth0  ohci1394) are already using
> IRQ 4.  lirc_serial doesn't request a shared IRQ unless you use
> the "share_irq" module parameter.  A request for exclusive use
> of IRQ 4 will fail if it's already in use.  So I suspect that if
> you use the "share_irq" parameter, it will work.

This stops the errors coming up, I just get no data afaict. I'll spend
some more time trying to diagnose the problem.

Thanks,

Matt

-- 
Matthew Johnson
http://www.matthew.ath.cx/
