From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: Do cpufreq clamping for throttling per
 package v2
Date: Mon, 6 Feb 2012 16:31:06 +0000
Message-ID: <20120206163106.GB32061@srcf.ucam.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
 <1328545032-21373-5-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47147 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2BFQbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2012 11:31:08 -0500
Content-Disposition: inline
In-Reply-To: <1328545032-21373-5-git-send-email-andi@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Mon, Feb 06, 2012 at 08:17:11AM -0800, Andi Kleen wrote:
> +#define reduction_pctg(cpu) \
> +	per_cpu(cpufreq_thermal_reduction_pctg, phys_package_first_cpu(cpu))

I don't like using percentages here - we end up with the potential for 
several percentages to end up mapping to the same P state. I've sent a 
patch that replaces the percentage code with just stepping through P 
states instead. But otherwise, yes, this seems sensible. An open 
question is whether we should be doing the same on _PPC notifications. 
There's some vague evidence that Windows does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
