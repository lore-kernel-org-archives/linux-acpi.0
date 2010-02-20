From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: disabling "rfkill hotplug" on newer eeepc-laptop models
Date: Sat, 20 Feb 2010 15:44:15 +0000
Message-ID: <20100220154415.GA25161@srcf.ucam.org>
References: <4B7FDAAD.1040704@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57360 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591Ab0BTPoT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Feb 2010 10:44:19 -0500
Content-Disposition: inline
In-Reply-To: <4B7FDAAD.1040704@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Feb 20, 2010 at 12:50:53PM +0000, Alan Jenkins wrote:

> 1. checking PCI config space, to see whether the device is really absent  
> before we mark it as unplugged.
> 2. a generic mechanism which would replace the current eeepc-specific code.

The generic mechanism will become necessary with .34 anyway, as soon as 
the PCI runtime power management code lands. It'll be taking the 
notification handlers for these devices.

I think we effectively need to move some of the acpiphp code and make it 
generic. These shouldn't be exposed as hotplug slots, but if we receive 
a rescan notification and the device is no longer there then it's pretty 
obvious that we need to remove it...

On the other hand, your patch looks fine for the immediate issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
