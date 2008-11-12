From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/7] ACPI, PCI: call _OSC support during root bridge discovery
Date: Wed, 12 Nov 2008 12:58:25 -0800
Message-ID: <200811121258.26696.jbarnes@virtuousgeek.org>
References: <20081110223035.30539.88942.stgit@bob.kio> <20081110223045.30539.6794.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081110223045.30539.6794.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

On Monday, November 10, 2008 2:30 pm Andrew Patterson wrote:
> ACPI, PCI: call _OSC support during root bridge discovery
>
> Added pci_acpi_osc_support() which is called when a PCI bridge is
> added, so individual PCI root bridge drivers do not have to call _OSC
> support for every root bridge in their probe functions.
>
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

Applied these first two, I'll be applying the rest shortly.

Thanks,
Jesse
