From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] ACPI: boot correctly with "nosmp" or "maxcpus=0"
Date: Thu, 16 Aug 2007 21:36:49 +0200
Message-ID: <20070816193649.GA16680@bingen.suse.de>
References: <200708160332.30732.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:35854 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbXHPSmr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 14:42:47 -0400
Content-Disposition: inline
In-Reply-To: <200708160332.30732.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> @@ -157,10 +162,13 @@ early_param("nosmp", nosmp);
>  static int __init maxcpus(char *str)
>  {
>  	get_option(&str, &max_cpus);
> -	return 1;
> +	if (max_cpus == 0)
> +		disable_ioapic_setup();

I must say I never liked that maxcpus=0 ... does disable the APIC
too. There can be situations where you want only a single CPU,
but still full APICs because modern systems don't boot without. 

It's the old traditional documented semantics though,
but on the other hand if it never worked with ACPI i guess people are
not relying on it.

So perhaps it would be better to change that? 
Or add a new option to limit CPUs without disabling ACPIC?

-Andi
