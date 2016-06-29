From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
Date: Wed, 29 Jun 2016 15:13:08 +0200
Message-ID: <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org> <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl, perex@perex.cz, tiwai@suse.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") omitted the initially assigned POSSIBLE penalty
> when the IRQ is active.

It would be good to say what can go wrong with that here.

> The original code would assign the POSSIBLE value divided by the number
> of possible IRQs during initialization.
>
> Later, if the IRQ is chosen as the active IRQ or if the IRQ is in use
> by ISA; additional penalties get added.

Thanks,
Rafael
