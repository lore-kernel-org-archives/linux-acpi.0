From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/14] x86, acpi, numa: split SLIT handling out
Date: Thu, 7 Mar 2013 22:46:40 -0800
Message-ID: <20130308064640.GL14556@mtj.dyndns.org>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
 <1362718720-27048-12-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54332 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3CHGqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Mar 2013 01:46:45 -0500
Content-Disposition: inline
In-Reply-To: <1362718720-27048-12-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Thu, Mar 07, 2013 at 08:58:37PM -0800, Yinghai Lu wrote:
> +void __init acpi_numa_init_only_slit(void)
> +{
> +	/* SLIT: System Locality Information Table */
> +	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
> +}
> +
> +static int __init __acpi_numa_init(bool with_slit)
>  {
>  	int cnt = 0;

Hmmm.... how about just having the following two functions

	acpi_numa_init_srat();
	acpi_numa_init_slit();

and update both x86 and ia64 to use the two functions?

-- 
tejun
