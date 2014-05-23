From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Fri, 23 May 2014 11:37:03 +0200
Message-ID: <20140523093703.GB21332@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54818 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaEWJhI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 May 2014 05:37:08 -0400
Content-Disposition: inline
In-Reply-To: <20140523014910.GB16945@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, May 22, 2014 at 09:49:10PM -0400, Chen, Gong wrote:
> If so, it has been there already. Maybe you should check patch
> 5/7. I merge pa/pa_mask into pa_info as a whole to avoid too much
> calculation/logic in trace.

My bad, how did I miss that:

> +static void __trace_mem_error(const uuid_le *fru_id, char *fru_text,
> +                              u64 err_count, u32 severity,
> +                              struct cper_sec_mem_err *mem)
> +{
> +       u32 etype = ~0U;
> +       char pa_info[64];
> +       u8 n = 0;
> +
> +       if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
> +               etype = mem->error_type;

More SNAFU: mem->error_type is u8 and you're saving it into a u32. What
possible reason can you have for that?

> +
> +       memset(pa_info, 0, 64);
> +       if (mem->validation_bits & CPER_MEM_VALID_PA)
> +               n = snprintf(pa_info, 63, "physical addr: 0x%016llx ",
> +                            mem->physical_addr);
> +
> +       if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> +               snprintf(pa_info + n, 63 - n, "addr LSB: 0x%x ",
> +                        (u8)__ffs64(mem->physical_addr_mask));

So pa_info is 64 bytes!!! For what, a u64 and a u8? That's 9 bytes.

You don't seem to get the idea that we cannot allow ourselves to waste
bytes in an error record like that. How hard it is to comprehend? Am I
telling it wrong or do you need someone else to explain it to you?

Ok, here's how the tracepoint should look like:

	TP_PROTO(u32 error_number,
		 u8 etype,
		 u8 severity,
		 u64 pa,
		 u8 pa_mask_lsb,
		 const uuid_le *fru_id,
		 char *dimm_info,
		 char *mem_loc,
		 char *fru_text)

Now if you have valid technical reasons why it shouldn't be done
that way, do tell. Otherwise do it exactly this way without changing
anything.

Or if you don't wanna, I can do it instead - it'll be much easier for me
than reviewing it again.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
