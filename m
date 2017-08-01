From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 5/5] ACPI/IORT: Add IORT named component memory
 address limits
Date: Tue, 1 Aug 2017 12:21:11 +0100
Message-ID: <20170801112111.GA23348@red-moon>
References: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
 <20170731152323.32488-6-lorenzo.pieralisi@arm.com>
 <35b7d17a-7ab2-9b36-9482-33a7449691d2@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35b7d17a-7ab2-9b36-9482-33a7449691d2@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>, Robert Moore <robert.moore@intel.com>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 01, 2017 at 06:20:43PM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/7/31 23:23, Lorenzo Pieralisi wrote:
> >IORT named components provide firmware configuration describing
> >how many address bits a given device is capable of generating
> >to address memory.
> >
> >Add code to the kernel to retrieve memory address limits
> >configuration for IORT named components and configure DMA masks
> >accordingly.
> >
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Robin Murphy <robin.murphy@arm.com>
> >Cc: Nate Watterson <nwatters@codeaurora.org>
> >---
> >  drivers/acpi/arm64/iort.c | 40 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 10 deletions(-)
> >
> >diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >index 67b85ae..b85d19f 100644
> >--- a/drivers/acpi/arm64/iort.c
> >+++ b/drivers/acpi/arm64/iort.c
> >@@ -680,6 +680,24 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> >  	return ret ? NULL : ops;
> >  }
> >+static int nc_dma_get_range(struct device *dev, u64 *size)
> >+{
> >+	struct acpi_iort_node *node;
> >+	struct acpi_iort_named_component *ncomp;
> >+
> >+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> >+			      iort_match_node_callback, dev);
> >+	if (!node)
> >+		return -ENODEV;
> >+
> >+	ncomp = (struct acpi_iort_named_component *)node->node_data;
> >+
> >+	*size = ncomp->memory_address_limit >= 64 ? ~0ULL :
> >+			1ULL<<ncomp->memory_address_limit;
> 
> Just a question here, if the IORT table didn't configure this
> value properly, will the device working properly? I'm asking this
> because in the table of IORT of D05, this value is set to 0 so far
> (SAS and network), but I can boot D05 OK with your patch set, not
> sure if any further issues.

Then you wonder why I wrote it as a separate patch. Why is that
value set to 0 (is that because that's the insane default ?) ?
It is a firmware bug and if things work ok with this patch applied
either this patch contains a bug or drivers override the DMA masks
to cancel out this patch effects.

Please fix the firmware.

Thanks,
Lorenzo
