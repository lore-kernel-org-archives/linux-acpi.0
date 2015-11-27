From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
Date: Fri, 27 Nov 2015 15:54:55 +0800
Message-ID: <56580C4F.4050903@huawei.com>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com> <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:7598 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbK0H53 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2015 02:57:29 -0500
In-Reply-To: <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com
Cc: gpkulkarni@gmail.com

Hi,

On 2015/11/18 2:25, Ganapatrao Kulkarni wrote:
> +/* Callback for Proximity Domain -> ACPI processor UID mapping */
> +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> +{
> +	int pxm, node;
> +	u64 mpidr;
> +	static int cpus_in_srat;
> +
> +	if (srat_disabled())
> +		return;
> +
> +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
> +		bad_srat();
> +		return;
> +	}
> +
> +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
> +		return;
> +
> +	if (cpus_in_srat >= NR_CPUS) {
> +		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
> +			     NR_CPUS);
> +		return;
> +	}

arch/arm64/kernel/acpi_numa.c: In function 'acpi_numa_gicc_affinity_init':
arch/arm64/kernel/acpi_numa.c:137:3: warning: format '%ld' expects
argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
   pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be
able to use all cpus\n",

-- 
Shannon

