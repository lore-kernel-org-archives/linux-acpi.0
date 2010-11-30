From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 2/3] ACPI, APEI, Add APEI generic error status
 print support
Date: Tue, 30 Nov 2010 11:29:12 +0800
Message-ID: <1291087752.12648.95.camel@yhuang-dev>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
	 <1291085501-31494-3-git-send-email-ying.huang@intel.com>
	 <20101129190343.7d7cea12.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19396 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab0K3D3Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 22:29:16 -0500
In-Reply-To: <20101129190343.7d7cea12.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 2010-11-30 at 11:03 +0800, Andrew Morton wrote:
> On Tue, 30 Nov 2010 10:51:40 +0800 Huang Ying <ying.huang@intel.com> wrote:
> 
> > printk is one of the methods to report hardware errors to user space.
> > Hardware error information reported by firmware to Linux kernel is in
> > the format of APEI generic error status (struct
> > acpi_hes_generic_status).  This patch adds print support for the
> > format, so that the corresponding hardware error information can be
> > reported to user space via printk.
> > 
> > PCIe AER information print is not implemented yet.  Will refactor the
> > original PCIe AER information printing code to avoid code duplicating.
> > 
> > ...
> >  
> > +#define pr_pfx(pfx, fmt, ...)			\
> > +	printk("%s" fmt, pfx, ##__VA_ARGS__)
> 
> hm, why does so much code create little printk helper macros.  Isn't
> there something generic somewhere?

Sorry, I do not find the generic code for this helper. But I think this
macro may be helpful for others too, who need to determine the log level
only at runtime. Here corrected errors should have log level:
KERN_WARNING, while uncorrected errors should have log level: KERN_ERR.

Do you think it is a good idea to make this macro generic?

> >  /*
> >   * CPER record ID need to be unique even after reboot, because record
> >   * ID is used as index for ERST storage, while CPER records from
> > @@ -46,6 +49,302 @@ u64 cper_next_record_id(void)
> >  }
> >  EXPORT_SYMBOL_GPL(cper_next_record_id);
> >  
> > +static const char *cper_severity_strs[] = {
> > +	[CPER_SEV_RECOVERABLE]		= "recoverable",
> > +	[CPER_SEV_FATAL]		=  "fatal",
> > +	[CPER_SEV_CORRECTED]		= "corrected",
> > +	[CPER_SEV_INFORMATIONAL]	= "info",
> > +};
> > +
> > +static const char *cper_severity_str(unsigned int severity)
> > +{
> > +	return severity < ARRAY_SIZE(cper_severity_strs) ?
> > +		cper_severity_strs[severity] : "unknown";
> > +}
> 
> This code will explode nastily if CPER_SEV_RECOVERABLE .. 
> CPER_SEV_INFORMATIONAL do not exactly have the values 0, 1, 2 and 3. 
> They do have those values, but it would be a bit safer if they were
> enumerated types and not #defines..

OK. I will change this.

> > +static void cper_print_bits(const char *pfx, unsigned int bits,
> > +			    const char *strs[], unsigned int strs_size)
> > +{
> > +	int i, len = 0;
> > +	const char *str;
> > +
> > +	for (i = 0; i < strs_size; i++) {
> > +		if (!(bits & (1U << i)))
> > +			continue;
> > +		str = strs[i];
> > +		if (len && len + strlen(str) + 2 > 80) {
> > +			printk("\n");
> > +			len = 0;
> > +		}
> > +		if (!len)
> > +			len = pr_pfx(pfx, "%s", str);
> > +		else
> > +			len += printk(", %s", str);
> > +	}
> > +	if (len)
> > +		printk("\n");
> > +}
> 
> geeze, that's the sort of code you have to execute to find out what it
> does.  Or ask the author to document it.

OK. I will add comments for all necessary functions in the patch.

> This patchset appears to implement a new kernel->userspace interface. 
> But that interface isn't actually described anywhere, so reviewers must
> reverse-engineer the interface from the implementation to be able to
> review the interface.  Nobody bothers doing that so we end up with an
> unreviewed interface, which we must maintain for eternity.
> 
> Please fully document all proposed interfaces?

Sorry. I don't realize that printk-ing something means implementing a
new kernel->userspace interface. I think the messages resulted are
self-explaining for human. Is it sufficient just to add example messages
in patch description?

Best Regards,
Huang Ying


