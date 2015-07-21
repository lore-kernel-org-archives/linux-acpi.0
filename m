From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Discrete Nvidia GPU shutdown with recent kernel / BIOS (on T440s
 laptop) - Should be automatic with runtime pm now ?
Date: Tue, 21 Jul 2015 13:18:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507211313560.3123-100000@netrider.rowland.org>
References: <CAHL+j0-Nf4rgCrUHbtZ0d2bpW3hX57Mz5jUwhckv8endScA29g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:56274 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932807AbbGURSi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jul 2015 13:18:38 -0400
In-Reply-To: <CAHL+j0-Nf4rgCrUHbtZ0d2bpW3hX57Mz5jUwhckv8endScA29g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sylvain Munaut <246tnt@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 21 Jul 2015, Sylvain Munaut wrote:

> Hi,
> 
> 
> tl;dr : Should device allowed to do runtime pm that have no driver go
> to D3 on their own ?

Quick answer: See the comments at the start of local_pci_probe() in 
drivers/pci/pci-driver.c.  PCI devices without a kernel driver are 
always left in D0, regardless of the runtime PM status.  This is 
because userspace may try to use the device, and the kernel wouldn't 
know to take the device out of D3 when that happens.

>  And should pci root bridge go to D3 when all the
> device on them are on D3 ?

I don't know the answer to that.  It's probably closely related to the 
issue of whether PCI bridges need to have a kernel driver.

Alan Stern

