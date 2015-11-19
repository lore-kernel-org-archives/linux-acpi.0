From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: Fix logic OF logic in pci_dma_configure()
Date: Thu, 19 Nov 2015 09:23:43 +0100
Message-ID: <4205822.O3dsjd4r6S@wuerfel>
References: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, rjw@rjwysocki.net, bhelgaas@google.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 18 November 2015 16:49:52 Suravee Suthikulpanit wrote:
> -       if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -               if (bridge->parent)
> +       if (IS_ENABLED(CONFIG_OF) &&
> +               bridge->parent && bridge->parent->of_node) {
>                         of_dma_configure(&dev->dev, bridge->parent->of_node);
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was wondering for a bit whether we should warn about the case where there
is no of_node pointer, as that would mean we cannot do DMA on that PCI
device, but on second thought we have to do it exactly like you do, because
we would otherwise break machines that do not use DT.

	Arnd
