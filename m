From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] aerdrv: Fix severity usage in aer trace event
Date: Sun, 8 Dec 2013 16:09:04 +0100
Message-ID: <20131208150904.GD4338@pd.tnic>
References: <1386476273-2418-1-git-send-email-rui.y.wang@intel.com>
 <20131208144312.GC4338@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131208144312.GC4338@pd.tnic>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rui Wang <ruiv.wang@gmail.com>, lance.ortiz@hp.com, lance_ortiz@hotmail.com, jiang.liu@intel.com, tony.luck@intel.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, gong.chen@linux.intel.com, m.chehab@samsung.com, Rui Wang <rui.y.wang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 08, 2013 at 03:43:12PM +0100, Borislav Petkov wrote:
> On Sun, Dec 08, 2013 at 12:17:53PM +0800, Rui Wang wrote:
> > There's inconsistency between dmesg and the trace event output.
> > When dmesg says "severity=Corrected", the trace event says
> > "severity=Fatal". What happens is that HW_EVENT_ERR_CORRECTED is
> > defined in edac.h:
> > 
> > enum hw_event_mc_err_type {
> >         HW_EVENT_ERR_CORRECTED,
> >         HW_EVENT_ERR_UNCORRECTED,
> >         HW_EVENT_ERR_FATAL,
> >         HW_EVENT_ERR_INFO,
> > };
> > 
> > while aer_print_error() uses aer_error_severity_string[] defined as:
> > 
> > static const char *aer_error_severity_string[] = {
> >         "Uncorrected (Non-Fatal)",
> >         "Uncorrected (Fatal)",
> >         "Corrected"
> > };
> > 
> > In this case dmesg is correct because info->severity is assigned in
> > aer_isr_one_error() using the definitions in include/linux/ras.h:
> > 
> > Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> 
> Applied, thanks.

I said "Applied" but this is Bjorn's area: Bjorn, wanna take this one or
are you fine with it going over the RAS tree?

Btw, I have a 2 trivial cleanups for aerdrv_errprint.c which are
following...

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
