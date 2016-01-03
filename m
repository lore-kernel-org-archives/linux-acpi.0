From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V9 0/2] ACPI, PCI, irq: remove interrupt limitations
Date: Sun, 03 Jan 2016 01:35:41 +0100
Message-ID: <1494476.uEZlmlkaiB@vostro.rjw.lan>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51710 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbcACAFF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2016 19:05:05 -0500
In-Reply-To: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org

On Wednesday, December 09, 2015 11:18:26 AM Sinan Kaya wrote:
> Code currently supports 256 maximum interrupts at this moment. The patch is
> reconfiguring the penalty array as a dynamic list to remove this
> limitation.
> 
> The ACPI compiler uses the extended format when used interrupt numbers
> are greater than 15. The extended IRQ is 32 bits according to the ACPI
> spec. The code supports parsing the extended interrupt numbers. However,
> due to used data structure type; the code silently truncates interrupt
> numbers greater than 256.
> 
> Changes from V8: (https://lkml.org/lkml/2015/12/3/579)
> * split the patch into two as
> ** ACPI, PCI, irq: remove interrupt count restriction
> ** ACPI, PCI, irq: remove interrupt number restriction
> * add acpi_irq_add_penalty API to simplify code
> 
> Sinan Kaya (2):
>   ACPI, PCI, irq: remove interrupt count restriction
>   ACPI, PCI, irq: remove interrupt number restriction
> 
>  drivers/acpi/pci_link.c | 140 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 104 insertions(+), 36 deletions(-)

Both patches applied, thanks!

