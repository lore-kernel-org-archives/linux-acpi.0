From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
Date: Wed, 26 Jul 2017 17:55:17 +0800
Message-ID: <3677255d-d8c9-0e01-df60-8c194397e384@linaro.org>
References: <1500695652-27025-1-git-send-email-guohanjun@huawei.com>
 <91588872-441b-88c0-07e3-452c2998d173@arm.com>
 <f57a04ad-b686-9872-8b6a-bbacea29b3b0@linaro.org>
 <998a03b4-89b1-7407-45ea-83a3128d66ed@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34740 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdGZJzd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 05:55:33 -0400
Received: by mail-pf0-f174.google.com with SMTP id q85so69148155pfq.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2017 02:55:33 -0700 (PDT)
In-Reply-To: <998a03b4-89b1-7407-45ea-83a3128d66ed@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 2017/7/26 16:00, Marc Zyngier wrote:
> On 26/07/17 08:52, Hanjun Guo wrote:
>> On 2017/7/25 18:30, Marc Zyngier wrote:
>>> On 22/07/17 04:54, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> When running 4.13-rc1 on top of D05, I got the boot log:
>>>>
>>>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>>>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>>>> [    0.000000] SRAT: ITS affinity exceeding max count[4]
>>>>
>>>> This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
>>>>
>>>> So dynamically alloc the memory needed instead of using
>>>> its_srat_maps[MAX_NUMNODES], which count the number of
>>>> ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
>>>> then build the mapping of numa node to ITS ID. Of course,
>>>> its_srat_maps will be freed after ITS probing because
>>>> we don't need that after boot.
>>>>
>>>> After doing this, I got what I wanted:
>>>>
>>>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
>>>> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
>>>> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
>>>> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
>>>> [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
>>>> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
>>>> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
>>>>
>>>> Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>
>>>> v1->v2:
>>>>     - Add NULL check in acpi_get_its_numa_node() for no ITS affinity case;
>>>>     - Free the its_srat_maps after ITS probing.
>>>>
>>>>    drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 32 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 3ccdf76..1d692aa 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -1847,13 +1847,16 @@ struct its_srat_map {
>>>>    	u32	its_id;
>>>>    };
>>>>    
>>>> -static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
>>>> +static struct its_srat_map *its_srat_maps __initdata;
>>>>    static int its_in_srat __initdata;
>>>>    
>>>>    static int __init acpi_get_its_numa_node(u32 its_id)
>>>>    {
>>>>    	int i;
>>>>    
>>>> +	if (!its_srat_maps)
>>>> +		return NUMA_NO_NODE;
>>>> +
>>>>    	for (i = 0; i < its_in_srat; i++) {
>>>>    		if (its_id == its_srat_maps[i].its_id)
>>>>    			return its_srat_maps[i].numa_node;
>>>> @@ -1861,6 +1864,12 @@ static int __init acpi_get_its_numa_node(u32 its_id)
>>>>    	return NUMA_NO_NODE;
>>>>    }
>>>>    
>>>> +static int __init gic_acpi_match_srat_its(struct acpi_subtable_header *header,
>>>> +					  const unsigned long end)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
>>>>    			 const unsigned long end)
>>>>    {
>>>> @@ -1877,12 +1886,6 @@ static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
>>>>    		return -EINVAL;
>>>>    	}
>>>>    
>>>> -	if (its_in_srat >= MAX_NUMNODES) {
>>>> -		pr_err("SRAT: ITS affinity exceeding max count[%d]\n",
>>>> -				MAX_NUMNODES);
>>>> -		return -EINVAL;
>>>> -	}
>>>> -
>>>
>>> So you're getting rid of that message when overflowing the array...
>>
>> This overflowing will not happen, because I scan the SRAT
>> to count the entry(ies) of ITS affinity first to alloc the
>> array, and then parse the same SRAT again to setup the mapping
>> of NUMA node to ITS, so is it fine for us to just remove the
>> check here?
> 
> Removing that check is fine, as long as you make sure the allocation
> hasn't failed.

Sorry, just want to make sure I understand correctly. This function will
not be called if allocation failure, so do you mean we can keep the code
as it is?

Thanks
Hanjun
