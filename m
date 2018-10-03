From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
Date: Wed, 3 Oct 2018 11:37:07 +0100
Message-ID: <2b4a53bc-7839-6826-44ed-6099c732a31a@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com
Cc: will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

On 21/09/18 16:08, Shameer Kolothum wrote:
[...]
> +
> +	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> +					       &smmu_pmu->node);

In theory a hotplug event could happen as soon as the instance is 
registered...

> +	if (err) {
> +		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> +			err, &res_0->start);
> +		return err;
> +	}
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	smmu_pmu->on_cpu = get_cpu();

...so this looks too late, i.e. a race here can result in a bogus call 
to perf_pmu_migrate_context() with an uninitialised pmu.

Robin.

> +	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> +
> +	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
> +	if (err) {
> +		dev_err(dev, "Error %d registering PMU @%pa\n",
> +			err, &res_0->start);
> +		goto out_unregister;
> +	}
> +
> +	put_cpu();
