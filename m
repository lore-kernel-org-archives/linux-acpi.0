From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Wed, 21 May 2014 13:05:21 +0200
Message-ID: <20140521110521.GF21205@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54315 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbaEULFo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 07:05:44 -0400
Content-Disposition: inline
In-Reply-To: <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, May 15, 2014 at 04:30:42AM -0400, Chen, Gong wrote:
> +const char *cper_mem_err_type_str(unsigned int etype)
>  {
> -	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> -	if (mem->validation_bits & CPER_MEM_VALID_PA)
> -		printk("%s""physical_address: 0x%016llx\n",
> -		       pfx, mem->physical_addr);
> -	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		printk("%s""physical_address_mask: 0x%016llx\n",

The physical address mask is still not part of the tracepoint as a u8 as
we talked.

> -		       pfx, mem->physical_addr_mask);
> +	return etype < ARRAY_SIZE(mem_err_type_strs) ?
> +		mem_err_type_strs[etype] : "unknown";
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_type_str);

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
