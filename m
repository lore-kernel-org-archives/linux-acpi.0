From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Tue, 4 Oct 2016 19:54:42 +0200
Message-ID: <201610041954.45680.linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org> <CAJZ5v0gKFVEYFhyge8+_ZTSg_OK6uzBByivgbvEV-Up4Q3YSiw@mail.gmail.com> <dda55738-d52b-1cdd-8973-8dea3506a835@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <dda55738-d52b-1cdd-8973-8dea3506a835@codeaurora.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
List-Id: linux-acpi@vger.kernel.org

On Saturday 01 October 2016 19:49:17 Sinan Kaya wrote:
> On 9/30/2016 5:27 PM, Rafael J. Wysocki wrote:
> >>> >> What's the drawback, if any?
> >> >
> >> > I don't see any drawback to be honest.
> >
> > I'd go for it then, if Bjorn doesn't hate it.
>
> I posted a follow up patch a minute ago.
>
> [PATCH 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
> [PATCH 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
> [PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
>
> Can we have some testing coverage? and eventually have tested-by?

Fixes the problem on all 4 machines.
These patches also need to go into 4.7-stable and 4.8-stable.

Tested-by: Ondrej Zary <linux@rainbow-software.org>

-- 
Ondrej Zary
