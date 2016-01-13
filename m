From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2 3/4] arm64, acpi, numa: NUMA support based on SRAT and
 SLIT
Date: Thu, 14 Jan 2016 00:04:00 +0100
Message-ID: <20160113230400.GB31343@rric.localdomain>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1447784733-10419-4-git-send-email-gkulkarni@caviumnetworks.com>
 <56580C4F.4050903@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32955 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcAMXEF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 18:04:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so39309072wmu.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2016 15:04:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56580C4F.4050903@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com, gpkulkarni@gmail.com

On 27.11.15 15:54:55, Shannon Zhao wrote:
> Hi,
> 
> On 2015/11/18 2:25, Ganapatrao Kulkarni wrote:
> > +/* Callback for Proximity Domain -> ACPI processor UID mapping */
> > +void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> > +{
> > +	int pxm, node;
> > +	u64 mpidr;
> > +	static int cpus_in_srat;
> > +
> > +	if (srat_disabled())
> > +		return;
> > +
> > +	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
> > +		bad_srat();
> > +		return;
> > +	}
> > +
> > +	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
> > +		return;
> > +
> > +	if (cpus_in_srat >= NR_CPUS) {
> > +		pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be able to use all cpus\n",
> > +			     NR_CPUS);
> > +		return;
> > +	}
> 
> arch/arm64/kernel/acpi_numa.c: In function 'acpi_numa_gicc_affinity_init':
> arch/arm64/kernel/acpi_numa.c:137:3: warning: format '%ld' expects
> argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
>    pr_warn_once("SRAT: cpu_to_node_map[%ld] is too small, may not be
> able to use all cpus\n",

Right, should be changed to:

 pr_warn_once("SRAT: cpu_to_node_map[%d] ...

-Robert
