From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Q] How to tell we're using the KMS (during suspend/resume) outside the graphics driver
Date: Wed, 10 Mar 2010 22:15:26 +0100
Message-ID: <201003102215.26232.rjw@sisk.pl>
References: <201003062236.09801.rjw@sisk.pl> <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com> <20100310205618.GA28628@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100310205618.GA28628@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pauli Nieminen <suokkos@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wednesday 10 March 2010, Matthew Garrett wrote:
> As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
> will give you something to work with.

Hmm.  Did you mean acpi_get_physical_device()?

Which acpi_device should I call that for?

> For the console-switching case, I think the most reasonable plan is probably
> to add a flag to the console drivers to indicate whether or not they support
> reprogramming the hardware themselves, and then walk all active console
> drivers. There'd need to be a way for fb drivers to tell fbcon that they can
> handle it.

Yes, that sounds reasonable.

Rafael
