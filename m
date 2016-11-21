From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
Date: Mon, 21 Nov 2016 07:58:16 -0600
Message-ID: <20161121135816.GK25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0h3ax4+UCm57VYqV3SVzOZ3A5Ajykks10J49rj1O4VkvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h3ax4+UCm57VYqV3SVzOZ3A5Ajykks10J49rj1O4VkvQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 19, 2016 at 12:02:24AM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 17, 2016 at 6:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Add a writeup about how PCI host bridges should be described in ACPI
> > using PNP0A03/PNP0A08 devices, PNP0C02 devices, and the MCFG table.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Looks great overall, but I have a few comments (below).

Thanks a lot for taking a look, Rafael!  I applied all your suggestions.

Bjorn
