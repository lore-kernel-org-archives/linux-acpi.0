From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Thu, 27 Aug 2009 15:59:54 +0800
Message-ID: <1251359994.3282.11.camel@minggr.sh.intel.com>
References: <20090812201034.GA2983@localdomain.by>
	 <1250498613.28336.68.camel@minggr.sh.intel.com>
	 <20090817113059.GA3245@localdomain.by>
	 <d3f22a0908170622x7dd9ce73m5c3ea86406cc9935@mail.gmail.com>
	 <20090818071359.GA3713@localdomain.by>
	 <1250579915.13743.8.camel@minggr.sh.intel.com>
	 <20090827075253.GB3536@localdomain.by>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35573 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbZH0IEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2009 04:04:10 -0400
In-Reply-To: <20090827075253.GB3536@localdomain.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2009-08-27 at 15:52 +0800, Sergey Senozhatsky wrote:
> On (08/18/09 15:18), Lin Ming wrote:
> 
> Hello Lin,
> 
> rc7-git5 (patched)
> 
> [    0.178628] ACPI: EC: Look up EC in DSDT
> [    0.196480] ACPI: Interpreter enabled
> [    0.196575] ACPI: (supports S0 S1 S3 S4 S5)
> [    0.197184] ACPI: Using IOAPIC for interrupt routing
> [    0.197352] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
> [    0.203511] ACPI Error (dswload-0790): [PCFG] Namespace lookup failure, AE_ALREADY_EXISTS
> [    0.203738] ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog 20090521 psloop-227
> [    0.203964] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.RBPE] (Node f7017678), AE_ALREADY_EXISTS
> [    0.204256] ACPI: Marking method RBPE as Serialized because of AE_ALREADY_EXISTS error
> [    0.204510] ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._L01] (Node f701d198), AE_ALREADY_EXISTS
> [    0.204803] ACPI: Marking method _L01 as Serialized because of AE_ALREADY_EXISTS error
> [    0.205063] ACPI Exception: AE_ALREADY_EXISTS, while evaluating GPE method [_L01] 20090521 evgpe-568

Do you mean rc7-git5 sometime boot fails even with the patch applied?

> 
> 
> [...]
> +		if (!(region_obj->region.node->flags & ANOBJ_TEMPORARY)) {
> +			acpi_ex_exit_interpreter();
> +		}
> [...]
> Does it explain successful boot with delay (vga=791, prink delay, etc.)?

Sorry, could you explain the question a bit more?

Lin Ming

> 
> 
> > And would you please test the region-debug.patch multiple times to
> > verify if it really fixes the bug?
> > 
> rc7-git5 (nopatch)
> + -
> 
> rc7-git5 (patched)
> 20+ reboots
> 
> 	Sergey

