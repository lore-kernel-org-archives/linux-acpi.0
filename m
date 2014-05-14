From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/7] acpi, apei, ghes: Factor out ioremap virtual memory
 for IRQ and NMI context.
Date: Wed, 14 May 2014 19:13:21 +0200
Message-ID: <20140514171321.GG5231@pd.tnic>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
 <1397056476-9183-8-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397056476-9183-8-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@suse.de, m.chehab@samsung.com, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 09, 2014 at 05:14:35PM +0200, Tomasz Nowicki wrote:
> @@ -310,6 +310,8 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>  	u64 offset;
>  	u32 trunk;
>  
> +	BUG_ON(in_nmi && !IS_ENABLED(CONFIG_ACPI_APEI_NMI));
> +

That's a good idea but it should be in the NMI notifier
ghes_notify_nmi() instead and simpler:

	BUG_ON(!IS_ENABLED(CONFIG_ACPI_APEI_NMI));

>  	while (len > 0) {
>  		offset = paddr - (paddr & PAGE_MASK);
>  		if (in_nmi) {

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
