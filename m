From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/4] Unassigned resource fixes
Date: Thu, 12 Mar 2015 23:32:29 +0100
Message-ID: <12096280.cHMLsqHZdA@vostro.rjw.lan>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58446 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752737AbbCLWIm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 18:08:42 -0400
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, March 12, 2015 12:35:19 PM Bjorn Helgaas wrote:
> These are some minor resource fixes related to unassigned PCI BARs.  We
> should:
> 
>   - Mark BARS as unassigned when we can figure that out
>   - Not complain about "overlaps" with unassigned BARs
>   - Prevent pci_ioremap_bar() on unassigned BARs
>   - Give better error messages when pci_ioremap_bar() fails
> 
> I don't think these will actually fix any bugs, other than getting rid of
> some annoying messages and improving some others.
> 
> Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PNP: Don't check for overlaps with unassigned PCI BARs
>       PCI: Mark invalid BARs as unassigned
>       PCI: Show driver, BAR#, and resource on pci_ioremap_bar() failure
>       PCI: Fail pci_ioremap_bar() on unassigned resources
> 
> 
>  drivers/pci/pci.c       |    9 +++++----
>  drivers/pci/setup-res.c |    2 ++
>  drivers/pnp/quirks.c    |    9 ++++++---
>  3 files changed, 13 insertions(+), 7 deletions(-)

For the entire series:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
