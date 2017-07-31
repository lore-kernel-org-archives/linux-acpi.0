From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v2 0/5] ACPI: DMA ranges management
Date: Mon, 31 Jul 2017 15:16:10 -0700
Message-ID: <CAL85gmD1LCivX2VOpcy1y0=Ywp8SkQCORPovQLhRv+Bb2n4MxA@mail.gmail.com>
References: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37803 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdGaWQM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2017 18:16:12 -0400
Received: by mail-wm0-f44.google.com with SMTP id t201so2434956wmt.0
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2017 15:16:12 -0700 (PDT)
In-Reply-To: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nate Watterson <nwatters@codeaurora.org>

On Mon, Jul 31, 2017 at 8:23 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> This patch series is v2 of a previous posting:
>
> v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi@arm.com
>
> v1->v2:
>         - Reworked acpi_dma_get_range() flow and logs
>         - Added IORT named component address limits
>         - Renamed acpi_dev_get_resources() helper function
>         - Rebased against v4.13-rc3
>
> -- Original cover letter --
>
> As reported in:
>
> http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com
>
> the bus connecting devices to an IOMMU bus can be smaller in size than
> the IOMMU input address bits which results in devices DMA HW bugs in
> particular related to IOVA allocation (ie chopping of higher address
> bits owing to system bus HW capabilities mismatch with the IOMMU).
>
> Fortunately this problem can be solved through an already present but never
> used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define the DMA
> window for a specific bus in ACPI and therefore all upstream devices
> connected to it.
>
> This small patch series enables _DMA parsing in ACPI core code and
> use it in ACPI IORT code in order to detect DMA ranges for devices and
> update their data structures to make them work with their related DMA
> addressing restrictions.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Feng Kan <fkan@apm.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> Lorenzo Pieralisi (5):
>   ACPICA: resource_mgr: Allow _DMA method in walk resources
>   ACPI: Make acpi_dev_get_resources() method agnostic
>   ACPI: Introduce DMA ranges parsing
>   ACPI: Make acpi_dma_configure() DMA regions aware
>   ACPI/IORT: Add IORT named component memory address limits
>
>  drivers/acpi/acpica/rsxface.c |  7 ++--
>  drivers/acpi/arm64/iort.c     | 50 +++++++++++++++++++++++-
>  drivers/acpi/resource.c       | 82 ++++++++++++++++++++++++++++++---------
>  drivers/acpi/scan.c           | 90 +++++++++++++++++++++++++++++++++++++++----
>  include/acpi/acnames.h        |  1 +
>  include/acpi/acpi_bus.h       |  2 +
>  include/linux/acpi.h          |  8 ++++
>  include/linux/acpi_iort.h     |  5 ++-
>  8 files changed, 211 insertions(+), 34 deletions(-)
>
> --
> 2.10.0
>
Thanks, this was tested and works on the XGene system.
Tested-by: Feng Kan <fkan@apm.com>
