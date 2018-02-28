From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Remove obsolete
 ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define
Date: Wed, 28 Feb 2018 16:53:05 +0000
Message-ID: <20180228165305.GA14610@e107981-ln.cambridge.arm.com>
References: <20180228162424.13636-1-lorenzo.pieralisi@arm.com>
 <e6cbbf2a-738c-a77e-efa1-a38a5602ae1c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e6cbbf2a-738c-a77e-efa1-a38a5602ae1c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 28, 2018 at 04:35:17PM +0000, Robin Murphy wrote:
> Hi Lorenzo,
> 
> On 28/02/18 16:24, Lorenzo Pieralisi wrote:
> >To defeat ACPICA<->kernel merge order dependencies a preprocessor define
> >value was introduced in the IORT compilation unit according to IORT
> >revision C, IORT_SMMU_V3_CAVIUM_CN99XX, so that even if the value was
> >not defined in ACPICA headers the IORT kernel layer would still be able
> >to function and use it.
> >
> >Since commit 0c2021c047ba ("ACPICA: IORT: Update SMMU models for
> >revision C") finally added the define in ACPICA headers, as required by
> >ACPICA IORT support, the preprocessor definition in the IORT kernel
> >compilation unit has become obsolete and can be removed.
> 
> Can the version check around iort_get_id_mapping_index() go as well?

https://marc.info/?l=linux-acpi&m=151817852003174&w=2

Gone :) (just did two patches since they were part of different
changes), I will batch them up and send them in a pull request for
v4.17.

Thanks,
Lorenzo

> 
> Robin.
> 
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Hanjun Guo <hanjun.guo@linaro.org>
> >Cc: Sudeep Holla <sudeep.holla@arm.com>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Robin Murphy <robin.murphy@arm.com>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >---
> >  drivers/acpi/arm64/iort.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> >diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >index 95255ecfae7c..c87b17ea03b7 100644
> >--- a/drivers/acpi/arm64/iort.c
> >+++ b/drivers/acpi/arm64/iort.c
> >@@ -31,11 +31,6 @@
> >  #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
> >  				(1 << ACPI_IORT_NODE_SMMU_V3))
> >-/* Until ACPICA headers cover IORT rev. C */
> >-#ifndef ACPI_IORT_SMMU_V3_CAVIUM_CN99XX
> >-#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
> >-#endif
> >-
> >  struct iort_its_msi_chip {
> >  	struct list_head	list;
> >  	struct fwnode_handle	*fw_node;
> >
