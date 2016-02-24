From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
Date: Wed, 24 Feb 2016 15:03:14 +0000
Message-ID: <20160224150314.GD25385@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon>
 <20160203161834.GB26487@MBP.local>
 <20160224141832.GA26630@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44535 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517AbcBXPBF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Feb 2016 10:01:05 -0500
Content-Disposition: inline
In-Reply-To: <20160224141832.GA26630@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Loc Ho <lho@apm.com>, Itaru Kitayama <itaru.kitayama@riken.jp>

On Wed, Feb 24, 2016 at 02:18:32PM +0000, Lorenzo Pieralisi wrote:

[...]

>  static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  {
>  	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> @@ -107,7 +108,11 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  
>  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>  
> -	iounmap(mailbox);
> +	/*
> +	 * stash the mailbox address mapping to use it for checks
> +	 * in post boot method
> +	 */
> +	cpu_entry->mailbox = mailbox;

The mailbox VA entry should be stashed before setting up the mailbox
and sending the IPI, anyway, if Loc and Itaru can test it I will wrap
this change into the final version with appropriate log.

Lorenzo

>  
>  	return 0;
>  }
> @@ -116,32 +121,15 @@ static void acpi_parking_protocol_cpu_postboot(void)
>  {
>  	int cpu = smp_processor_id();
>  	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> -	struct parking_protocol_mailbox __iomem *mailbox;
> +	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
>  	__le64 entry_point;
>  
> -	/*
> -	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
> -	 * this deviates from the parking protocol specifications since
> -	 * the mailboxes are required to be mapped nGnRnE; the attribute
> -	 * discrepancy is harmless insofar as the protocol specification
> -	 * is concerned).
> -	 * If the mailbox is mistakenly allocated in the linear mapping
> -	 * by FW ioremap will fail since the mapping will be prevented
> -	 * by the kernel (it clashes with the linear mapping attributes
> -	 * specifications).
> -	 */
> -	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> -	if (!mailbox)
> -		return;
> -
>  	entry_point = readl_relaxed(&mailbox->entry_point);
>  	/*
>  	 * Check if firmware has cleared the entry_point as expected
>  	 * by the protocol specification.
>  	 */
>  	WARN_ON(entry_point);
> -
> -	iounmap(mailbox);
>  }
>  
>  const struct cpu_operations acpi_parking_protocol_ops = {
