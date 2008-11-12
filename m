From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 7/7] PCI, ACPI: remove obsolete _OSC capability support functions
Date: Wed, 12 Nov 2008 13:15:31 -0800
Message-ID: <200811121315.32275.jbarnes@virtuousgeek.org>
References: <20081110223035.30539.88942.stgit@bob.kio> <20081110223110.30539.19970.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-158.bluehost.com ([67.222.39.38]:53669 "HELO
	outbound-mail-158.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750939AbYKLVPr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 16:15:47 -0500
In-Reply-To: <20081110223110.30539.19970.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

On Monday, November 10, 2008 2:31 pm Andrew Patterson wrote:
> PCI, ACPI: remove obsolete _OSC capability support functions
>
> The acpi_query_osc, __pci_osc_support_set, pci_osc_support_set, and
> pcie_osc_support_set functions have been obsoleted in favor of setting
> these capabilities during root bridge discovery with pci_acpi_osc_support.
> There are no longer any callers of these functions, so they are removed.
>
> Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>

Ok, applied the rest too.  I'll do a quick test before pushing out the updated 
linux-next branch.

Thanks,
Jesse
