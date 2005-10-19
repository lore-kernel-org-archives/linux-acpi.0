From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability to derive irq when doing a surpriseremoval of an adapter
Date: Wed, 19 Oct 2005 09:29:06 -0600
Message-ID: <200510190929.06728.bjorn.helgaas@hp.com>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406> <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751083AbVJSP3O@vger.kernel.org>
In-Reply-To: <1129679877.30588.5.camel@whizzy>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 18 October 2005 5:57 pm, Kristen Accardi wrote:
> For surprise hotplug removal, the interrupt pin must be guessed, as any
> attempts to read it would obviously be invalid.  This patch adds a new
> function to cycle through all possible pin values, and tries to either
> lookup or derive the right irq to disable.

I don't really like this because it adds a new path that's only
used for "surprise" removals.  So we have acpi_pci_irq_disable(),
which is used for normal removals, and acpi_pci_irq_disable_nodev()
for the surprise path.  That feels like a maintenance problem.

Other, non-ACPI, IRQ routing schemes should have the same problem
(needing to know the interrupt pin after the device has been removed),
so maybe the pin needs to be cached in the pci_dev?
