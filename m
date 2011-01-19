From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] intel_idle: disable HW auto-demotion
Date: Wed, 19 Jan 2011 14:41:52 +0000
Message-ID: <20110119144152.GA23020@srcf.ucam.org>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35565 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1ASOmB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jan 2011 09:42:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1101182150400.14668@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org

On Tue, Jan 18, 2011 at 09:52:26PM -0500, Len Brown wrote:
> + * Disable HW auto demotion on tick-less idle kernels
> + */
> +static unsigned int has_nhm_snb_hw_auto_demotion;
> +#ifdef CONFIG_NO_HZ
> +static unsigned int auto_demotion;
> +#else
> +static unsigned int auto_demotion = 1;
> +#endif

What if someone boots with nohz=off?

Just so I'm clear on this - this is unrelated to the auto-popup on DMA, 
right?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
