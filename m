From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Mon, 14 Apr 2014 15:39:24 +0200
Message-ID: <20140414133924.GC3663@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34257 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbaDNNjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2014 09:39:39 -0400
Content-Disposition: inline
In-Reply-To: <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Fri, Mar 28, 2014 at 01:52:58AM -0400, Chen, Gong wrote:
> Some codes can be reorganzied as a common function for
> other usages. No functional changes.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/firmware/efi/cper.c | 134 +++++++++++++++++++++++++++++++++-----------
>  include/linux/cper.h        |   7 +++
>  2 files changed, 108 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 1491dd4..4e88885 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -34,6 +34,12 @@
>  #include <linux/aer.h>
>  
>  #define INDENT_SP	" "
> +DEFINE_RAW_SPINLOCK(cper_loc_lock);
> +EXPORT_SYMBOL_GPL(cper_loc_lock);

Definitely a bad idea to export a spinlock. If all you need is to sync
against multiple callers of cper_mem_err_location(), simply grab that
spinlock in the function itself, without exporting it.

> +
> +static char mem_location[CPER_REC_LEN];
> +static char dimm_location[CPER_REC_LEN];
> +
>  /*
>   * CPER record ID need to be unique even after reboot, because record
>   * ID is used as index for ERST storage, while CPER records from
> @@ -57,11 +63,12 @@ static const char *cper_severity_strs[] = {
>  	"info",
>  };
>  
> -static const char *cper_severity_str(unsigned int severity)
> +const char *cper_severity_str(unsigned int severity)
>  {
>  	return severity < ARRAY_SIZE(cper_severity_strs) ?
>  		cper_severity_strs[severity] : "unknown";
>  }
> +EXPORT_SYMBOL_GPL(cper_severity_str);
>
>   * cper_print_bits - print strings for set bits
> @@ -196,55 +203,116 @@ static const char *cper_mem_err_type_strs[] = {
>  	"physical memory map-out event",
>  };
>  
> -static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> +const char *cper_mem_err_type_str(unsigned int etype)
>  {
> -	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> -	if (mem->validation_bits & CPER_MEM_VALID_PA)
> -		printk("%s""physical_address: 0x%016llx\n",
> -		       pfx, mem->physical_addr);
> -	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		printk("%s""physical_address_mask: 0x%016llx\n",
> -		       pfx, mem->physical_addr_mask);
> +	return etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
> +		cper_mem_err_type_strs[etype] : "unknown";
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
> +
> +char *cper_mem_err_location(const struct cper_sec_mem_err *mem)
> +{
> +	char *p;
> +	u32 n = 0;
> +
> +	memset(mem_location, 0, CPER_REC_LEN);
> +	p = mem_location;
>  	if (mem->validation_bits & CPER_MEM_VALID_NODE)
> -		pr_debug("node: %d\n", mem->node);
> +		n += sprintf(p + n, " node: %d", mem->node);
> +	if (n >= CPER_REC_LEN)
> +		goto end;

	n += vscnprintf(p + n, CPER_REC_LEN - n - 1, "... ", ...);

and you can drop those

	if (n >= CPER_REC_LEN)

tests.

vscnprintf() because it returns the actual number of characters written
and not what snprintf does and return the chars count it would've
written. (Thx Richard for the hint!).

>  	if (mem->validation_bits & CPER_MEM_VALID_CARD)
> -		pr_debug("card: %d\n", mem->card);
> +		n += sprintf(p + n, " card: %d", mem->card);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
> -		pr_debug("module: %d\n", mem->module);
> +		n += sprintf(p + n, " module: %d", mem->module);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
> -		pr_debug("rank: %d\n", mem->rank);
> +		n += sprintf(p + n, " rank: %d", mem->rank);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_BANK)
> -		pr_debug("bank: %d\n", mem->bank);
> +		n += sprintf(p + n, " bank: %d", mem->bank);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
> -		pr_debug("device: %d\n", mem->device);
> +		n += sprintf(p + n, " device: %d", mem->device);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_ROW)
> -		pr_debug("row: %d\n", mem->row);
> +		n += sprintf(p + n, " row: %d", mem->row);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
> -		pr_debug("column: %d\n", mem->column);
> +		n += sprintf(p + n, " column: %d", mem->column);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> -		pr_debug("bit_position: %d\n", mem->bit_pos);
> +		n += sprintf(p + n, " bit_position: %d", mem->bit_pos);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
> -		pr_debug("requestor_id: 0x%016llx\n", mem->requestor_id);
> +		n += sprintf(p + n, " requestor_id: 0x%016llx",
> +				mem->requestor_id);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
> -		pr_debug("responder_id: 0x%016llx\n", mem->responder_id);
> +		n += sprintf(p + n, " responder_id: 0x%016llx",
> +				mem->responder_id);
> +	if (n >= CPER_REC_LEN)
> +		goto end;
>  	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
> -		pr_debug("target_id: 0x%016llx\n", mem->target_id);
> +		n += sprintf(p + n, " target_id: 0x%016llx", mem->target_id);
> +end:
> +	return mem_location;
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_location);
> +
> +char *cper_dimm_err_location(const struct cper_sec_mem_err *mem)
> +{
> +	const char *bank = NULL, *device = NULL;
> +
> +	memset(dimm_location, 0, CPER_REC_LEN);
> +	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
> +		goto end;

a goto label which is used only once?? What's wrong with

		return dimm_location;

?

> +
> +	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> +	if (bank != NULL && device != NULL)

	if (bank && device)

> +		snprintf(dimm_location, CPER_REC_LEN - 1,
> +			 "DIMM location: %s %s", bank, device);
> +	else
> +		snprintf(dimm_location, CPER_REC_LEN - 1, "DMI handle: 0x%.4x",

Why the DMI handle? Why not say: "unable to find location" or "location
not present in DMI" or something more user-friendly.

> +			 mem->mem_dev_handle);
> +end:
> +	return dimm_location;
> +}
> +EXPORT_SYMBOL_GPL(cper_dimm_err_location);
> +
> +static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> +{
> +	unsigned long flags;
> +
> +	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> +		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> +	if (mem->validation_bits & CPER_MEM_VALID_PA)
> +		printk("%s""physical_address: 0x%016llx\n",
> +		       pfx, mem->physical_addr);
> +	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		printk("%s""physical_address_mask: 0x%016llx\n",
> +		       pfx, mem->physical_addr_mask);
> +	raw_spin_lock_irqsave(&cper_loc_lock, flags);
> +	pr_debug("%s", cper_mem_err_location(mem));
> +	raw_spin_unlock_irqrestore(&cper_loc_lock, flags);
>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
>  		u8 etype = mem->error_type;
>  		printk("%s""error_type: %d, %s\n", pfx, etype,
> -		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
> -		       cper_mem_err_type_strs[etype] : "unknown");
> -	}
> -	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
> -		const char *bank = NULL, *device = NULL;
> -		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> -		if (bank != NULL && device != NULL)
> -			printk("%s""DIMM location: %s %s", pfx, bank, device);
> -		else
> -			printk("%s""DIMM DMI handle: 0x%.4x",
> -			       pfx, mem->mem_dev_handle);
> +		       cper_mem_err_type_str(etype));
>  	}
> +	raw_spin_lock_irqsave(&cper_loc_lock, flags);
> +	printk("%s%s", pfx, cper_dimm_err_location(mem));
> +	raw_spin_unlock_irqrestore(&cper_loc_lock, flags);
>  }
>  
>  static const char *cper_pcie_port_type_strs[] = {
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 2fc0ec3..55c10db 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -23,6 +23,8 @@
>  
>  #include <linux/uuid.h>
>  
> +extern struct raw_spinlock cper_loc_lock;
> +
>  /* CPER record signature and the size */
>  #define CPER_SIG_RECORD				"CPER"
>  #define CPER_SIG_SIZE				4
> @@ -35,6 +37,7 @@
>   */
>  #define CPER_RECORD_REV				0x0100
>  
> +#define CPER_REC_LEN				512

How did we come up with this? Some spec? 512 chars for an error record?
That's a bit too much in my book.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
