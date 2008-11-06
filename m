From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 11/11] ACPI: call core init functions explicitly instead of using initcalls
Date: Thu, 6 Nov 2008 17:40:16 -0600
Message-ID: <200811061640.17180.bjorn.helgaas@hp.com>
References: <20081105231710.26131.3110.stgit@bob.kio> <20081105231828.26131.90839.stgit@bob.kio> <alpine.LFD.2.00.0811061654540.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:25327 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYKFXkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 18:40:20 -0500
In-Reply-To: <alpine.LFD.2.00.0811061654540.3106@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Thursday 06 November 2008 03:02:25 pm Len Brown wrote:
> 
> +++ b/drivers/acpi/acpi.h
> ...
> +/* Functions internal to the ACPI core */
> 
> 
> I like the patch, except for the creation of drivers/acpi.h
> For we've already got too many files called 'acpi.h'...
> and Bob is working on a header clean-up as we speak...
> 
> Maybe the existing acpi/acpi_drivers.h would be better for these 
> declarations?

Sure, I can do that.  I hesitate only slightly, because acpi_drivers.h
is for, well, drivers, and these are core functions and definitely not
related to drivers.

I created drivers/acpi/acpi.h following the example of drivers/pci/pci.h,
which contains things intended for the PCI core only.

Bjorn
