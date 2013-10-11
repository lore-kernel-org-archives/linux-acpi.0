From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/8] ACPI, CPER: Update cper info
Date: Fri, 11 Oct 2013 17:47:59 +0200
Message-ID: <20131011154759.GJ5925@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-3-git-send-email-gong.chen@linux.intel.com>
 <20131011090630.GB5925@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131011090630.GB5925@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 11:06:30AM +0200, Borislav Petkov wrote:
> > -	printk("%s""APEI generic hardware error status\n", pfx);
> > +	printk("%s""Generic Hardware Error Status\n", pfx);
> 
> Btw, what's the story with printk not using KERN_x levels in this file?
> Why are we falling back to default printk levels for all printks here
> and shouldn't we rather prioritize them by urgency into, say, KERN_ERR,
> KERN_INFO, etc?

Ignore that - checkpatch complained about it but I kinda missed that
we're handing down the prefix.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
