From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Thu, 12 Jun 2014 09:28:08 -0400
Message-ID: <20140612092808.5f7bec5e@gandalf.local.home>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
	<1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:8116 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755897AbaFLN2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 09:28:11 -0400
In-Reply-To: <1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, 12 Jun 2014 02:11:57 -0400
"Chen, Gong" <gong.chen@linux.intel.com> wrote:


> +void cper_mem_err_pack(const struct cper_sec_mem_err *mem, void *data)
> +{
> +	struct cper_mem_err_compact *cmem = (struct cper_mem_err_compact *)data;
> +
> +	cmem->validation_bits = mem->validation_bits;
> +	cmem->node = mem->node;
> +	cmem->card = mem->card;
> +	cmem->module = mem->module;
> +	cmem->bank = mem->bank;
> +	cmem->device = mem->device;
> +	cmem->row = mem->row;
> +	cmem->column = mem->column;
> +	cmem->bit_pos = mem->bit_pos;
> +	cmem->requestor_id = mem->requestor_id;
> +	cmem->responder_id = mem->responder_id;
> +	cmem->target_id = mem->target_id;
> +	cmem->rank = mem->rank;
> +	cmem->mem_array_handle = mem->mem_array_handle;
> +	cmem->mem_dev_handle = mem->mem_dev_handle;
> +}
> +
> +const char *cper_mem_err_unpack(struct trace_seq *p, void *data)
> +{
> +	struct cper_mem_err_compact *cmem = (struct cper_mem_err_compact *)data;
> +	const char *ret = p->buffer + p->len;
> +
> +	if (cper_mem_err_location(cmem, rcd_decode_str))
> +		trace_seq_printf(p, "%s", rcd_decode_str);
> +	if (cper_dimm_err_location(cmem, rcd_decode_str))
> +		trace_seq_printf(p, "%s", rcd_decode_str);
> +	trace_seq_putc(p, '\0');
> +
> +	return ret;
> +}
> +
>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
>  {
> +	struct cper_mem_err_compact cmem;
> +
>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
>  		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
>  	if (mem->validation_bits & CPER_MEM_VALID_PA)
> @@ -281,14 +318,15 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
>  	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
>  		printk("%s""physical_address_mask: 0x%016llx\n",
>  		       pfx, mem->physical_addr_mask);
> -	if (cper_mem_err_location(mem, rcd_decode_str))
> +	cper_mem_err_pack(mem, &cmem);
> +	if (cper_mem_err_location(&cmem, rcd_decode_str))
>  		printk("%s%s\n", pfx, rcd_decode_str);
>  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
>  		u8 etype = mem->error_type;
>  		printk("%s""error_type: %d, %s\n", pfx, etype,
>  		       cper_mem_err_type_str(etype));
>  	}
> -	if (cper_dimm_err_location(mem, rcd_decode_str))
> +	if (cper_dimm_err_location(&cmem, rcd_decode_str))
>  		printk("%s%s\n", pfx, rcd_decode_str);
>  }
>  
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 4cac43a..da227a3 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -23,4 +23,5 @@ static int __init ras_init(void)
>  }
>  subsys_initcall(ras_init);
>  
> +EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index ed088b9..3548160 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -22,6 +22,7 @@
>  #define LINUX_CPER_H
>  
>  #include <linux/uuid.h>
> +#include <linux/trace_seq.h>
>  
>  /* CPER record signature and the size */
>  #define CPER_SIG_RECORD				"CPER"
> @@ -363,6 +364,24 @@ struct cper_sec_mem_err {
>  	__u16	mem_dev_handle;		/* module handle in UEFI 2.4 */
>  };
>  
> +struct cper_mem_err_compact {
> +	__u64	validation_bits;
> +	__u16	node;
> +	__u16	card;
> +	__u16	module;
> +	__u16	bank;
> +	__u16	device;
> +	__u16	row;
> +	__u16	column;
> +	__u16	bit_pos;
> +	__u64	requestor_id;
> +	__u64	responder_id;
> +	__u64	target_id;
> +	__u16	rank;
> +	__u16	mem_array_handle;
> +	__u16	mem_dev_handle;
> +};
> +
>  struct cper_sec_pcie {
>  	__u64		validation_bits;
>  	__u32		port_type;
> @@ -406,5 +425,7 @@ const char *cper_severity_str(unsigned int);
>  const char *cper_mem_err_type_str(unsigned int);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>  		     const char * const strs[], unsigned int strs_size);
> +void cper_mem_err_pack(const struct cper_sec_mem_err *, void *);
> +const char *cper_mem_err_unpack(struct trace_seq *, void *);
>  
>  #endif
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index acbcbb8..f66142b 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -9,6 +9,68 @@
>  #include <linux/edac.h>
>  #include <linux/ktime.h>
>  #include <linux/aer.h>
> +#include <linux/cper.h>
> +
> +/*
> + * MCE Extended Error Log trace event
> + *
> + * These events are generated when hardware detects a corrected or
> + * uncorrected event.
> + */
> +
> +/* memory trace event */
> +
> +TRACE_EVENT(extlog_mem_event,
> +	TP_PROTO(struct cper_sec_mem_err *mem,
> +		 u32 err_seq,
> +		 const uuid_le *fru_id,
> +		 const char *fru_text,
> +		 u8 sev),
> +
> +	TP_ARGS(mem, err_seq, fru_id, fru_text, sev),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, err_seq)
> +		__field(u8, etype)
> +		__field(u8, sev)
> +		__field(u64, pa)
> +		__field(u8, pa_mask_lsb)
> +		__array(u8, fru_id, sizeof(uuid_le))
> +		__string(fru_text, fru_text)
> +		__array(u8, data, sizeof(struct cper_mem_err_compact))

The above array works, but I'm wondering why you don't just use the
types themselves?

That is:

		__field(uuid_le, fru_id)
		__field(struct cper_mem_err_compact, data)

Then you don't need to use the memcpy for the fru_id, but just:

	__entry->fru_id = *fru_id;

Same with the data, you don't need to pass in void *, but the struct
itself into cper_mem_err_(un)pack(), and simplify those functions.

-- Steve


> +	),
> +
> +	TP_fast_assign(
> +		__entry->err_seq = err_seq;
> +		if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
> +			__entry->etype = mem->error_type;
> +		else
> +			__entry->etype = ~0;
> +		__entry->sev = sev;
> +		if (mem->validation_bits & CPER_MEM_VALID_PA)
> +			__entry->pa = mem->physical_addr;
> +		else
> +			__entry->pa = ~0ull;
> +
> +		if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> +			__entry->pa_mask_lsb = (u8)__ffs64(mem->physical_addr_mask);
> +		else
> +			__entry->pa_mask_lsb = ~0;
> +		memcpy(__entry->fru_id, fru_id, sizeof(uuid_le));
> +		__assign_str(fru_text, fru_text);
> +		cper_mem_err_pack(mem, __entry->data);
> +	),
> +
> +	TP_printk("{%d} %s error: %s physical addr: %016llx (mask lsb: %x) %sFRU: %pUl %.20s",
> +		  __entry->err_seq,
> +		  cper_severity_str(__entry->sev),
> +		  cper_mem_err_type_str(__entry->etype),
> +		  __entry->pa,
> +		  __entry->pa_mask_lsb,
> +		  cper_mem_err_unpack(p, __entry->data),
> +		  __entry->fru_id,
> +		  __get_str(fru_text))
> +);
>  
>  /*
>   * Hardware Events Report

