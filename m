From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Thu, 22 May 2014 12:52:42 +0200
Message-ID: <20140522105242.GG4383@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59726 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaEVKwo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 06:52:44 -0400
Content-Disposition: inline
In-Reply-To: <20140521235159.GB1644@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Wed, May 21, 2014 at 07:51:59PM -0400, Chen, Gong wrote:
> On Wed, May 21, 2014 at 01:05:21PM +0200, Borislav Petkov wrote:
> > > +const char *cper_mem_err_type_str(unsigned int etype)
> > >  {
> > > -	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > > -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> > > -	if (mem->validation_bits & CPER_MEM_VALID_PA)
> > > -		printk("%s""physical_address: 0x%016llx\n",
> > > -		       pfx, mem->physical_addr);
> > > -	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> > > -		printk("%s""physical_address_mask: 0x%016llx\n",
> > 
> > The physical address mask is still not part of the tracepoint as a u8 as
> > we talked.
> > 
> I thought out discussion is only for trace part. But it is OK to me to
> make whole style aligned.

No, I'm not talking about style - I'm talking about adding the physical address
mask to the tracepoint call:

+TRACE_EVENT(extlog_mem_event,
+       TP_PROTO(u32 etype,
+                const uuid_le *fru_id,
+                u64 error_count,

Btw, is that the error_count we're reporting?? You surely can't claim
that we'll ever report 2^64-1 errors, right?

I'd make that u32 and I'd call it

		u32 error_number;

as it is a counter we're incrementing.

+                u32 severity,

That severity can surely be u8 - we can't have 2^32-1 severities in any
normal case - I see only 5. I'm sure 256 is plenty.

And now that we slimmed some of those insanely-sized members, we can add

		u8 pa_mask_lsb

or something to that effect.

Makes sense?

+                char *dimm_info,
+                char *pa_info,
+                char *mem_loc,
+                char *fru_text),

+TRACE_EVENT(extlog_mem_event,


-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
