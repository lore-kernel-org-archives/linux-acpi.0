From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT][PATCH] PCI / ACPI: Do not require MSI support for PCIe native features
Date: Mon, 14 Mar 2011 21:02:11 +0100
Message-ID: <201103142102.11164.rjw@sisk.pl>
References: <201103052254.48515.rjw@sisk.pl> <20110314182636.GA4069@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110314182636.GA4069@xanatos>
Sender: linux-kernel-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, March 14, 2011, Sarah Sharp wrote:
> Hi Rafael,
> 
> I applied this patch, on top of this patch:
> PCI/ACPI: Report ASPM support to BIOS if not disabled from command line
> 
> Unfortunately, the Express Card still doesn't show up.  The trace looks
> slightly different, but the irq still gets disabled.  dmesg is attached.

Hmm.  It looks like, for some reason, the check against
pcie_aspm_support_enabled() returns false on your system.  Do you have
ASPM enabled in .config?

Rafael
