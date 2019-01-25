From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 3/4] perf/smmuv3: Add MSI irq support
Date: Fri, 25 Jan 2019 16:12:50 +0000
Message-ID: <232c64b8-f445-7420-275c-6f47bb13690b@arm.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-4-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130154751.28580-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com
Cc: jean-philippe.brucker@arm.com, will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

On 30/11/2018 15:47, Shameer Kolothum wrote:
> This adds support for MSI-based counter overflow interrupt.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index fb9dcd8..71d10a0 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -68,6 +68,7 @@
>   #define SMMU_PMCG_OVSSET0               0xCC0
>   #define SMMU_PMCG_CFGR                  0xE00
>   #define SMMU_PMCG_CFGR_RELOC_CTRS       BIT(20)
> +#define SMMU_PMCG_CFGR_MSI              BIT(21)
>   #define SMMU_PMCG_CFGR_SID_FILTER_TYPE  BIT(23)

Nit: Ah, clearly I missed the genesis in patch #2, but it would be nice 
to have these guys in the usual descending order.

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   #define SMMU_PMCG_CFGR_SIZE_MASK        GENMASK(13, 8)
>   #define SMMU_PMCG_CFGR_NCTR_MASK        GENMASK(5, 0)
> @@ -78,6 +79,12 @@
>   #define SMMU_PMCG_IRQ_CTRL              0xE50
>   #define SMMU_PMCG_IRQ_CTRL_IRQEN        BIT(0)
>   #define SMMU_PMCG_IRQ_CFG0              0xE58
> +#define SMMU_PMCG_IRQ_CFG1              0xE60
> +#define SMMU_PMCG_IRQ_CFG2              0xE64
> +
> +/* MSI config fields */
> +#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
> +#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
>   
>   #define SMMU_DEFAULT_FILTER_SPAN        1
>   #define SMMU_DEFAULT_FILTER_STREAM_ID   GENMASK(31, 0)
> @@ -587,11 +594,62 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static void smmu_pmu_free_msis(void *data)
> +{
> +	struct device *dev = data;
> +
> +	platform_msi_domain_free_irqs(dev);
> +}
> +
> +static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	phys_addr_t doorbell;
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct smmu_pmu *pmu = dev_get_drvdata(dev);
> +
> +	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
> +	doorbell &= MSI_CFG0_ADDR_MASK;
> +
> +	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
> +	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
> +	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
> +		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
> +}
> +
> +static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
> +{
> +	struct msi_desc *desc;
> +	struct device *dev = pmu->dev;
> +	int ret;
> +
> +	/* Clear MSI address reg */
> +	writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
> +
> +	/* MSI supported or not */
> +	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
> +		return;
> +
> +	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
> +	if (ret) {
> +		dev_warn(dev, "failed to allocate MSIs\n");
> +		return;
> +	}
> +
> +	desc = first_msi_entry(dev);
> +	if (desc)
> +		pmu->irq = desc->irq;
> +
> +	/* Add callback to free MSIs on teardown */
> +	devm_add_action(dev, smmu_pmu_free_msis, dev);
> +}
> +
>   static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
>   {
>   	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
>   	int irq, ret = -ENXIO;
>   
> +	smmu_pmu_setup_msi(pmu);
> +
>   	irq = pmu->irq;
>   	if (irq)
>   		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> 
