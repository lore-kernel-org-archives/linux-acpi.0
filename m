From: Thomas Andrews <tandrews@grok.co.za>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Wed, 06 Dec 2006 08:54:49 +0200
Message-ID: <45766939.80303@grok.co.za>
References: <20061202150530.GA5159@grok.co.za> <200612041420.12741.bjorn.helgaas@hp.com> <20061205045050.GA14444@grok.co.za> <200612051058.19960.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.grok.org.za ([196.1.58.22]:4597 "EHLO mail.grok.org.za"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760469AbWLFKsH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Dec 2006 05:48:07 -0500
In-Reply-To: <200612051058.19960.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Monday 04 December 2006 21:50, Thomas Andrews wrote:
>> On Mon, Dec 04, 2006 at 02:20:12PM -0700, Bjorn Helgaas wrote:
>>> Can you post the entire dmesg log with and without "pci=routeirq"?
>> And here it is with "pci=routeirq":
> 
> I think this is a BIOS bug.  Are there any updates available?
> 
> My guess is that 0000:00:0a.0[A] is really connected to LNKC,
> and the BIOS writer forgot to tell us that.
> 
> Without "pci=routeirq", we leave LNKC disabled.  With
> "pci=routeirq", we enable LNKC at IRQ 10 for 0000:00:0e.0[A]
> even though you don't have a driver for the 0000:00:0e.0 device,
> and I think this makes the 0000:00:0a.0[A] interrupt work as
> a side-effect.
> 
> If you load a driver for the firewire device at 0000:00:0e.0,
> that should enable LNKC, and I bet that will make your qozap
> driver start working.

Compiling firewire support into the kernel does indeed make it start 
working, so your theory appears to be 100% correct. Is there any way to 
confirm the BIOS bug by looking at the DSDT code? I am in touch with the 
manufacturers of the board, so it would be very nice if I could just 
send them a patch. (The board is quite new and there are no updates.)

Thanks again for your assistance - this has been *really* helpful!
Thomas
