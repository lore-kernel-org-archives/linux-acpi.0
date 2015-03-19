From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 0/4] Unassigned resource fixes
Date: Thu, 19 Mar 2015 10:06:06 -0500
Message-ID: <20150319150606.GD26935@google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36814 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbCSPGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2015 11:06:09 -0400
Received: by obdfc2 with SMTP id fc2so56612318obd.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2015 08:06:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

On Thu, Mar 12, 2015 at 12:35:19PM -0500, Bjorn Helgaas wrote:
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

Applied with Rafael's ack to pci/resource for v4.1.
