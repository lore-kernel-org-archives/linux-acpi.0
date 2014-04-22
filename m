From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/5 v2] CPER: Adjust code flow of some functions
Date: Tue, 22 Apr 2014 15:54:22 +0200
Message-ID: <20140422135421.GE15882@pd.tnic>
References: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
 <1397716119-6164-3-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47797 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020AbaDVNy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2014 09:54:29 -0400
Content-Disposition: inline
In-Reply-To: <1397716119-6164-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Thu, Apr 17, 2014 at 02:28:36AM -0400, Chen, Gong wrote:
> Some codes can be reorganzied as a common function for
> other usages.
> 
> v2 -> v1: Use scnprintf to simplify codes.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/firmware/efi/cper.c | 116 +++++++++++++++++++++++++++++++-------------
>  include/linux/cper.h        |  12 +++++
>  2 files changed, 95 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 1491dd4..951049b 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -34,6 +34,10 @@
>  #include <linux/aer.h>
>  
>  #define INDENT_SP	" "
> +
> +static char mem_location[CPER_REC_LEN];
> +static char dimm_location[CPER_REC_LEN];
> +
>  /*
>   * CPER record ID need to be unique even after reboot, because record
>   * ID is used as index for ERST storage, while CPER records from
> @@ -57,11 +61,12 @@ static const char *cper_severity_strs[] = {
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
>  /*
>   * cper_print_bits - print strings for set bits
> @@ -196,55 +201,100 @@ static const char *cper_mem_err_type_strs[] = {
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

Btw, while you're at it, please fix those string arrays defitions to be

static const char * const

as they should be. This is cper_severity_strs, cper_mem_err_type_strs
and cper_pcie_port_type_strs. You can also drop the "cper_" prefix as
they're static.

> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
> +
> +void cper_mem_err_location(const struct cper_sec_mem_err *mem, char *msg)
> +{
> +	u32 n = 0, len;
> +
> +	if (!msg)
> +		return;
> +
> +	len = strlen(msg);
> +	memset(msg, 0, len);

Have you even tested this???

[    0.104006] ------------[ cut here ]------------
[    0.108012] WARNING: CPU: 0 PID: 1 at lib/vsprintf.c:1660 vsnprintf+0x551/0x560()
[    0.112006] Modules linked in:
[    0.114167] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc1+ #13
[    0.116006] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    0.120025]  0000000000000009 ffff88007bc4bd78 ffffffff815e3c68 0000000000000000
[    0.130251]  ffff88007bc4bdb0 ffffffff8104d10c 00000000ffffffff 0000000000000000
[    0.136006]  ffffffff82bd42c0 0000000000000000 0000000000000000 ffff88007bc4bdc0
[    0.140881] Call Trace:
[    0.142555]  [<ffffffff815e3c68>] dump_stack+0x4e/0x7a
[    0.144009]  [<ffffffff8104d10c>] warn_slowpath_common+0x8c/0xc0
[    0.148034]  [<ffffffff8104d1fa>] warn_slowpath_null+0x1a/0x20
[    0.152013]  [<ffffffff812be301>] vsnprintf+0x551/0x560
[    0.156013]  [<ffffffff812be31d>] vscnprintf+0xd/0x30
[    0.160012]  [<ffffffff812be379>] scnprintf+0x39/0x40
[    0.164009]  [<ffffffff815e4f92>] cper_mem_err_location.part.1+0x6a/0x253
[    0.168009]  [<ffffffff81496a11>] cper_print_mem+0x41/0x100
[    0.172018]  [<ffffffff815db7c0>] ? rest_init+0x140/0x140
[    0.176035]  [<ffffffff815db806>] kernel_init+0x46/0x120
[    0.180009]  [<ffffffff815ec8ec>] ret_from_fork+0x7c/0xb0
[    0.182780]  [<ffffffff815db7c0>] ? rest_init+0x140/0x140
[    0.184012] ---[ end trace d69126aad4cf21bf ]---

Think about what happens the first time you call this function and
strlen returns 0 because the string is empty.

I enforced the first call to that function in kvm just so that I can
test your stuff but I don't see why this won't happen on real hardware
either.

Gong, I would strongly urge you to spend more time
and care on your patches instead of rushing them out.
ea431643d6c38728195e2c456801c3ef66bb9991 shouldnt've happened if you
tested your stuff more thoroughly and it cost me a whole day to dig out
what exactly was happening and talking to bug reporters.

Please be more responsible when preparing your patches and think hard
about each change you're doing. I'm not in the mood to review your stuff
with a magnifying glass and look for landmines.

Please!

>  	if (mem->validation_bits & CPER_MEM_VALID_NODE)
> -		pr_debug("node: %d\n", mem->node);
> +		n += scnprintf(msg + n, len - n - 1, " node: %d", mem->node);
>  	if (mem->validation_bits & CPER_MEM_VALID_CARD)
> -		pr_debug("card: %d\n", mem->card);
> +		n += scnprintf(msg + n, len - n - 1, " card: %d", mem->card);
>  	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
> -		pr_debug("module: %d\n", mem->module);
> +		n += scnprintf(msg + n, len - n - 1, " module: %d",
> +			       mem->module);
>  	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
> -		pr_debug("rank: %d\n", mem->rank);
> +		n += scnprintf(msg + n, len - n - 1, " rank: %d", mem->rank);
>  	if (mem->validation_bits & CPER_MEM_VALID_BANK)
> -		pr_debug("bank: %d\n", mem->bank);
> +		n += scnprintf(msg + n, len - n - 1, " bank: %d", mem->bank);
>  	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
> -		pr_debug("device: %d\n", mem->device);
> +		n += scnprintf(msg + n, len - n - 1, " device: %d",
> +			       mem->device);
>  	if (mem->validation_bits & CPER_MEM_VALID_ROW)
> -		pr_debug("row: %d\n", mem->row);
> +		n += scnprintf(msg + n, len - n - 1, " row: %d", mem->row);
>  	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
> -		pr_debug("column: %d\n", mem->column);
> +		n += scnprintf(msg + n, len - n - 1, " column: %d",
> +			       mem->column);
>  	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> -		pr_debug("bit_position: %d\n", mem->bit_pos);
> +		n += scnprintf(msg + n, len - n - 1, " bit_position: %d",
> +			       mem->bit_pos);
>  	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
> -		pr_debug("requestor_id: 0x%016llx\n", mem->requestor_id);
> +		n += scnprintf(msg + n, len - n - 1,
> +			       " requestor_id: 0x%016llx", mem->requestor_id);
>  	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
> -		pr_debug("responder_id: 0x%016llx\n", mem->responder_id);
> +		n += scnprintf(msg + n, len - n - 1,
> +			       " responder_id: 0x%016llx", mem->responder_id);
>  	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
> -		pr_debug("target_id: 0x%016llx\n", mem->target_id);
> +		scnprintf(msg + n, len - n - 1, " target_id: 0x%016llx",
> +			  mem->target_id);
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err_location);
> +
> +void cper_dimm_err_location(const struct cper_sec_mem_err *mem, char *msg)
> +{
> +	const char *bank = NULL, *device = NULL;
> +	int len;
> +
> +	if (!msg)
> +		return;
> +
> +	len = strlen(msg);
> +	memset(msg, 0, len);
> +
> +	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
> +		return;
> +
> +	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> +	if (bank && device)
> +		snprintf(msg, len - 1, "DIMM location: %s %s", bank, device);
> +	else
> +		snprintf(msg, len - 1,
> +			 "DIMM location: not present. DMI handle: 0x%.4x",
> +			 mem->mem_dev_handle);
> +}
> +EXPORT_SYMBOL_GPL(cper_dimm_err_location);
> +
> +static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> +{
> +	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> +		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> +	if (mem->validation_bits & CPER_MEM_VALID_PA)
> +		printk("%s""physical_address: 0x%016llx\n",
> +		       pfx, mem->physical_addr);
> +	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		printk("%s""physical_address_mask: 0x%016llx\n",
> +		       pfx, mem->physical_addr_mask);
> +	cper_mem_err_location(mem, mem_location);
> +	pr_debug("%s", mem_location);
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
> +	cper_dimm_err_location(mem, dimm_location);
> +	printk("%s%s", pfx, dimm_location);

???

>  }
>  
>  static const char *cper_pcie_port_type_strs[] = {
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 2fc0ec3..038cc11 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -23,6 +23,8 @@
>  
>  #include <linux/uuid.h>
>  
> +extern struct raw_spinlock cper_loc_lock;
> +

Forgot to remove the spinlock.

See what I mean? Slow down for <deity>'s sake and *think* before sending
out!

>  /* CPER record signature and the size */
>  #define CPER_SIG_RECORD				"CPER"
>  #define CPER_SIG_SIZE				4
> @@ -36,6 +38,12 @@
>  #define CPER_RECORD_REV				0x0100
>  
>  /*
> + * CPER record length is variable depending on differnet error type.

s/differnet/different/

> + * By now it is mainly used for memory error type. 256 bytes should
> + * be enough. Increase this value once it is not enough.

How about this instead:

/*
 * CPER record length contains the CPER fields which are relevant for further
 * handling of a memory error in userspace (we don't carry all the fields
 * defined in the UEFI spec because some of them don't make any sense.
 * Currently, a length of 256 should be more than enough.
 */

> + */
> +#define CPER_REC_LEN				256
> +/*
>   * Severity difinition for error_severity in struct cper_record_header
>   * and section_severity in struct cper_section_descriptor
>   */
> @@ -395,7 +403,11 @@ struct cper_sec_pcie {
>  #pragma pack()
>  
>  u64 cper_next_record_id(void);
> +const char *cper_severity_str(unsigned int);
> +const char *cper_mem_err_type_str(unsigned int);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>  		     const char * const strs[], unsigned int strs_size);
> +void cper_mem_err_location(const struct cper_sec_mem_err *mem, char *msg);
> +void cper_dimm_err_location(const struct cper_sec_mem_err *mem, char *msg);


-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
