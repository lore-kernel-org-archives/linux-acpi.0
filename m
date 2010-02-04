From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v2 0/3] pci_root: track downstream bus range for _CBA
Date: Thu, 4 Feb 2010 11:29:39 -0700
Message-ID: <201002041129.40116.bjorn.helgaas@hp.com>
References: <20091110170802.10645.91272.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:47796 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954Ab0BDS3m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2010 13:29:42 -0500
In-Reply-To: <20091110170802.10645.91272.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org

On Tuesday 10 November 2009 10:11:28 am Bjorn Helgaas wrote:
> The PCI Firmware Spec requires BIOS to use _CBA, not MCFG, to report
> MMCONFIG regions of hot-pluggable host bridges.  Therefore, if the
> hardware and firmware support host bridge hotplug, we will encounter
> _CBA even if Linux itself doesn't support hotplug.
> 
> These patches make the pci_root driver keep track of the downstream
> bus range and make it available so arch-specific code can register
> MMCONFIG regions if necessary.

I think these patches got forgotten, but I still think they're
worthwhile.  I'd be glad to refresh them if necessary.

Bjorn
