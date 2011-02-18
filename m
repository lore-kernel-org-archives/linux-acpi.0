From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/5] x86: Minimize SRAT messages
Date: Fri, 18 Feb 2011 08:32:05 +0100
Message-ID: <20110218073205.GE11404@elte.hu>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
 <20110217185132.417819224@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35559 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab1BRHcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Feb 2011 02:32:17 -0500
Content-Disposition: inline
In-Reply-To: <20110217185132.417819224@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> Condense the SRAT: messages to show all APIC id's for the
> node on a single line.
> 
> v1: Added pertinent __init & __initdata specifiers.
> v2: updated to apply to x86-tip
> 
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>
> ---
>  arch/x86/mm/srat_64.c |   16 ++++++++++++----
>  drivers/acpi/numa.c   |    3 +++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> --- linux.orig/arch/x86/mm/srat_64.c
> +++ linux/arch/x86/mm/srat_64.c
> @@ -116,6 +116,7 @@ acpi_numa_x2apic_affinity_init(struct ac
>  {
>  	int pxm, node;
>  	int apic_id;
> +	static int __initdata last_node = -1, last_pxm = -1;

Please do not put global variables amongst local variables - put them into file 
scope.

> +	} else if (pxm != last_pxm) {
> +		pr_cont(" %u:%u", pxm, apic_id);
> +		last_pxm = pxm;
> +	} else
> +		pr_cont(" :%u", apic_id);

Curly braces should be balanced.

	Ingo
