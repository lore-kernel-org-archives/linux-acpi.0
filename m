From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Mon, 10 Mar 2014 07:04:35 -0300
Message-ID: <20140310070435.1981ddd5@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic> <20140310082241.GA873@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:54878 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaCJKEn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 06:04:43 -0400
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2700J4CTBT4450@usmailout4.samsung.com> for
 linux-acpi@vger.kernel.org; Mon, 10 Mar 2014 06:04:41 -0400 (EDT)
In-reply-to: <20140310082241.GA873@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

Em Mon, 10 Mar 2014 04:22:42 -0400
"Chen, Gong" <gong.chen@linux.intel.com> escreveu:

> On Fri, Mar 07, 2014 at 12:44:16PM +0100, Borislav Petkov wrote:
> [...]
> > > +static void mem_err_location(struct cper_sec_mem_err *mem)
> > > +{
> > > +	char *p;
> > > +	u32 n = 0;
> > > +
> > > +	memset(mem_location, 0, LOC_LEN);
> > > +	p = mem_location;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_NODE)
> > > +		n += sprintf(p + n, " node: %d", mem->node);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_CARD)
> > > +		n += sprintf(p + n, " card: %d", mem->card);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_MODULE)
> > > +		n += sprintf(p + n, " module: %d", mem->module);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
> > > +		n += sprintf(p + n, " rank: %d", mem->rank);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_BANK)
> > > +		n += sprintf(p + n, " bank: %d", mem->bank);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
> > > +		n += sprintf(p + n, " device: %d", mem->device);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_ROW)
> > > +		n += sprintf(p + n, " row: %d", mem->row);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
> > > +		n += sprintf(p + n, " column: %d", mem->column);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> > > +		n += sprintf(p + n, " bit_position: %d", mem->bit_pos);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_REQUESTOR_ID)
> > > +		n += sprintf(p + n, " requestor_id: 0x%016llx",
> > > +				mem->requestor_id);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_RESPONDER_ID)
> > > +		n += sprintf(p + n, " responder_id: 0x%016llx",
> > > +				mem->responder_id);
> > > +	if (n >= LOC_LEN)
> > > +		goto end;
> > > +	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
> > > +		n += sprintf(p + n, " target_id: 0x%016llx", mem->target_id);
> > > +end:
> > > +	return;
> > > +}
> > 
> > Looks like this wants to share with cper_print_mem() - definitely a lot
> > of duplication there.
> > 
> > > +
> > > +static void dimm_err_location(struct cper_sec_mem_err *mem)
> > > +{
> > > +	const char *bank = NULL, *device = NULL;
> > > +
> > > +	memset(dimm_location, 0, LOC_LEN);
> > > +	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
> > > +		return;
> > > +
> > > +	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> > > +	if (bank != NULL && device != NULL)
> > > +		snprintf(dimm_location, LOC_LEN - 1, "%s %s", bank, device);
> > > +	else
> > > +		snprintf(dimm_location, LOC_LEN - 1, "DMI handle: 0x%.4x",
> > > +			 mem->mem_dev_handle);
> > > +}
> > 
> > This one too.
> > 
> Not really. Firstly they service for different purpose. Secondly the
> format here can be changed/updated depending on further requirment.
> I can't assume they always keep the same format.

Changing the format breaks any userspace application that relies on
parsing them. That's an API breakage. Adding more data could be
fine, if we take enough care when doing it, and properly document
how userspace is supposed to parse it.

> > > +
> > > +static void trace_mem_error(const uuid_le *fru_id, char *fru_text,
> > > +			    u64 err_count, u32 severity,
> > > +			    struct cper_sec_mem_err *mem)
> > > +{
> > > +	u32 etype = ~0U;
> > > +	u64 phy_addr = ~0ull;
> > 
> > I'm assuming userspace knows that all 1s means field value is invalid?
> Yep, I suppose so.

Well, actually, EDAC drivers use 0 to indicate an unknown physical address.
The better is to use the same standard used there.

See the code at ghes_edac.c:

	/* Cleans the error report buffer */
	memset(e, 0, sizeof (*e));
	e->error_count = 1;
	strcpy(e->label, "unknown label");
	e->msg = pvt->msg;
	e->other_detail = pvt->other_detail;
	e->top_layer = -1;
	e->mid_layer = -1;
	e->low_layer = -1;
	*pvt->other_detail = '\0';
	*pvt->msg = '\0';

> 
> > 
> > > +	unsigned long flags;
> > > +
> > > +	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
> > > +		etype = mem->error_type;
> > 
> > newline.
> Sure.
> 
> [...]
> > We probably need a mechanism to disable printking to dmesg once
> > userspace has opened the tracepoint.
> Do we really need to do that? IMHO, I think they are used for two different
> usages, just like dmesg & mcelog.
> 
> [...]
> > >  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> > >  {
> > >  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > > @@ -233,8 +241,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem)
> > >  	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
> > >  		u8 etype = mem->error_type;
> > >  		printk("%s""error_type: %d, %s\n", pfx, etype,
> > > -		       etype < ARRAY_SIZE(cper_mem_err_type_strs) ?
> > > -		       cper_mem_err_type_strs[etype] : "unknown");
> > > +			cper_mem_err_type_str(etype));
> > >  	}
> > >  	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
> > >  		const char *bank = NULL, *device = NULL;
> > 
> > Ditto.
> I know you hope the print function in CPER & trace for cpi_extlog can be
> merged into one. I just have one concern about it. Can we ensure these
> two functions keeping align all the time? IOW, merge them for now until
> change happens one day?

IMHO, that's the best.

> [...]
> > > +#define LOC_LEN		512
> > > +
> > > +TRACE_EVENT(extlog_mem_event,
> > 
> > So this is a mem thing so we're defining a tracepoint for memory events,
> > specifically.
> > 
> > However, if extlog carries all kinds of errors outside, not only DRAM
> > errors, we should do a TRACE_EVENT_CLASS which contains the shared args
> > to every error type and then make a mem event ontop of it.
> I agree.

-- 

Regards,
Mauro
