From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Support address size limit for root complexes
Date: Mon, 23 Jul 2018 18:18:40 +0100
Message-ID: <6527d86a-2e05-f0ed-a1f6-077edf1638a2@arm.com>
References: <b52cdefb7a3f631340b98dcd38a274ae277bd561.1531239023.git.robin.murphy@arm.com>
 <20180716151051.GB19945@red-moon>
 <23accf9d-9886-c044-4bb5-1d176b086e9f@arm.com>
 <20180718163622.GA21924@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180718163622.GA21924@red-moon>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

[+Christoph]

On 18/07/18 17:36, Lorenzo Pieralisi wrote:
> [+Catalin, Will]
> 
> On Mon, Jul 16, 2018 at 04:34:51PM +0100, Robin Murphy wrote:
>> On 2018-07-16 4:10 PM, Lorenzo Pieralisi wrote:
>>> On Tue, Jul 10, 2018 at 05:13:45PM +0100, Robin Murphy wrote:
>>>> IORT revision D allows PCI root complex nodes to specify a memory
>>>> address size limit equivalently to named components, to help describe
>>>> straightforward integrations which don't really warrant a full-blown
>>>> _DMA method. Now that our headers are up-to-date, plumb it in.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>   drivers/acpi/arm64/iort.c | 25 +++++++++++++++++++++++--
>>>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index 7a3a541046ed..4a66896e2aa3 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -947,6 +947,24 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>>>>   	return 0;
>>>>   }
>>>> +static int rc_dma_get_range(struct device *dev, u64 *size)
>>>> +{
>>>> +	struct acpi_iort_node *node;
>>>> +	struct acpi_iort_root_complex *rc;
>>>> +
>>>> +	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>>>> +			      iort_match_node_callback, dev);
>>>> +	if (!node || node->revision < 1)
>>>> +		return -ENODEV;
>>>> +
>>>> +	rc = (struct acpi_iort_root_complex *)node->node_data;
>>>> +
>>>> +	*size = rc->memory_address_limit >= 64 ? U64_MAX :
>>>> +			1ULL<<rc->memory_address_limit;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>   /**
>>>>    * iort_dma_setup() - Set-up device DMA parameters.
>>>>    *
>>>> @@ -975,10 +993,13 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>>   	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>>> -	if (dev_is_pci(dev))
>>>> +	if (dev_is_pci(dev)) {
>>>>   		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>>>> -	else
>>>> +		if (ret == -ENODEV)
>>>> +			ret = rc_dma_get_range(dev, &size);
>>>
>>> Thank you for putting together the patch.
>>>
>>> The question is whether it is OK to ignore the IORT address limits
>>> when _DMA is actually specified. It is a sort of grey area that
>>> has to be clarified, maybe we can add a check to detect a size
>>> mismatch, I do not know if something should be added at IORT spec
>>> level to clarify its relation to the _DMA object, if present.
>>
>> Yeah, I'm assuming that _DMA would be used to describe conditions
>> more specific than the simple address size limit (i.e. bridge
>> windows), so even if both are present, the range inferred from _DMA
>> will always be less than or equal to that inferred from IORT, and
>> thus rather than explicitly calculating the intersection of the two
>> we can simply do this short-circuit.
>>
>> If IORT accurately reflects the total number of usable address bits,
>> then I can't see that it would ever make sense for _DMA to specify
>> an address range which exceeds that; I guess it comes down to how
>> much effort we want to spend verifying firmware instead of trusting
>> it.
> 
> I agree with this reasoning and the patch looks fine, I have not
> queued anything for this cycle for IORT so I would ask Will/Catalin
> to pick it up (if we still have time for v4.19):
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Cheers Lorenzo (and Hanjun). Given that my DMA mask series[1] is 
nominally based on top of this, it might make sense for Christoph to 
pick it up through the dma-mapping tree. Since I'm about to send a new 
version of that series I'll resend this one as part of that.

Thanks,
Robin.

[1] 
https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg24358.html
