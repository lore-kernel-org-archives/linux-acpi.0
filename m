From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2] xen/acpi: upload _PSD info for non Dom0
 CPUs too
Date: Thu, 8 Mar 2018 17:33:56 -0500
Message-ID: <4f20689f-552f-b9eb-272d-0035ba2efdd6@oracle.com>
References: <20180308105751.8176-1-joao.m.martins@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308105751.8176-1-joao.m.martins@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joao Martins <joao.m.martins@oracle.com>, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, devel@acpica.org, Erik Schmauss <erik.schmauss@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 03/08/2018 05:57 AM, Joao Martins wrote:

> @@ -372,6 +376,15 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
>   
>   	pr_debug("ACPI CPU%u w/ PBLK:0x%lx\n", acpi_id, (unsigned long)pblk);
>   
> +	/* It has P-state dependencies */
> +	if (!acpi_processor_get_psd(handle, &acpi_psd[acpi_id])) {
> +		__set_bit(acpi_id, acpi_id_psd_present);
> +
> +		pr_debug("ACPI CPU%u w/ PST:coord_type = %llu domain = %llu\n",
> +			 acpi_id, acpi_psd[acpi_id].coord_type,
> +			 acpi_psd[acpi_id].domain);
> +	}


I should have noticed this earlier, but do you really need 
acpi_id_psd_present? Can you just go by acpi_psd[i] != NULL?

Sorry for missing it in the first patch.

-boris
