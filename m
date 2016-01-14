From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT and
 SLIT
Date: Thu, 14 Jan 2016 11:48:02 +0800
Message-ID: <56971A72.3070409@linaro.org>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
 <56580C4F.4050903@huawei.com> <20160113230400.GB31343@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34532 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbcANDsL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 22:48:11 -0500
Received: by mail-pf0-f173.google.com with SMTP id q63so95011738pfb.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2016 19:48:11 -0800 (PST)
In-Reply-To: <20160113230400.GB31343@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <rric@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com, gpkulkarni@gmail.com

On 2016/1/14 7:04, Robert Richter wrote:
> On 27.11.15 15:54:55, Shannon Zhao wrote:
>> Hi,
>>
>> On 2015/11/18 2:25, Ganapatrao Kulkarni wrote:
>>> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
>>> +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
>>> +{
>>> +	int pxm, node;
>>> +	u64 mpidr;
>>> +	static int cpus_in_srat;
>>> +
>>> +	if (srat_disabled())
>>> +		return;
>>> +
>>> +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
>>> +		bad_srat();
>>> +		return;
>>> +	}
>>> +
>>> +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
>>> +		return;
>>> +
>>> +	if (cpus_in_srat >= NR_CPUS) {
>>> +		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
>>> +			     NR_CPUS);
>>> +		return;
>>> +	}
>>
>> arch/arm64/kernel/acpi_numa.c: In function 'acpi_numa_gicc_affinity_init':
>> arch/arm64/kernel/acpi_numa.c:137:3: warning: format '%ld' expects
>> argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
>>     pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be
>> able to use all cpus\n",
>
> Right, should be changed to:
>
>   pr_warn_once("SRAT: cpu_to_node_map[%d] ...

Thanks, I will update it in next version.

Hanjun
